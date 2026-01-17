package com.zenithmind.controller;

import com.zenithmind.model.Post;
import com.zenithmind.model.User;
import com.zenithmind.service.ForumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/forum")
public class ForumController {

    @Autowired
    private ForumService forumService;

    @Autowired
    private com.zenithmind.service.UserService userService;

    @GetMapping
    public String viewForum(@RequestParam(required = false, defaultValue = "all") String category,
            @RequestParam(required = false) String search,
            Model model, HttpSession session, java.security.Principal principal) {
        User user = (User) session.getAttribute("user");
        String role = "student";
        if (user != null) {
            role = user.getRole();
        }

        // Restrict forum access to students and faculty only
        if (!"student".equalsIgnoreCase(role) && !"faculty".equalsIgnoreCase(role)) {
            // Redirect others (like admin or professional) if they try to access student
            // forum directly
            // unless we want to allow them too. User specifically asked for faculty.
            return "redirect:/dashboard?role=" + role;
        }

        String username = principal != null ? principal.getName() : "guest";
        java.util.Map<String, Object> userData = userService.getUserDataByUsername(username, role);
        model.addAllAttributes(userData);

        if (user == null) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        // Links for sidebar
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "/dashboard?" + roleSuffix);
        model.addAttribute("profileSettingsLink", "/profile-settings?" + roleSuffix);
        model.addAttribute("communityLink", "/forum");

        if ("faculty".equalsIgnoreCase(role)) {
            model.addAttribute("trainingLink", "/faculty/training?" + roleSuffix);
            model.addAttribute("guidesLink", "/faculty/guides?" + roleSuffix);
            model.addAttribute("reportLink", "/faculty/report?" + roleSuffix);
        } else {
            model.addAttribute("modulesLink", "/modules?" + roleSuffix);
            model.addAttribute("modulesAssessmentLink", "/modules?section=assessment&" + roleSuffix);
            model.addAttribute("selfAssessmentLink", "/self-assessment?" + roleSuffix);
            model.addAttribute("moodLink", "/mood?" + roleSuffix);
            model.addAttribute("supportLink", "/support?" + roleSuffix);
        }

        List<Post> posts = forumService.getFilteredPosts(category, search);

        model.addAttribute("posts", posts);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("searchQuery", search);

        // Stats
        model.addAttribute("totalPosts", forumService.getTotalPosts());
        model.addAttribute("activeMembers", forumService.getActiveMembers());
        model.addAttribute("helpfulReplies", forumService.getHelpfulReplies());

        return "community";
    }

    @PostMapping("/create")
    public String createPost(Post post, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"student".equalsIgnoreCase(user.getRole())) {
            return "redirect:/dashboard?role=" + (user != null ? user.getRole() : "student");
        }

        if (post.isAnonymous()) {
            post.setAuthor("Anonymous");
        } else {
            post.setAuthor(user.getName());
        }

        forumService.save(post);
        return "redirect:/forum";
    }

    @GetMapping("/like")
    public String like(@RequestParam Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"student".equalsIgnoreCase(user.getRole())) {
            return "redirect:/dashboard?role=" + (user != null ? user.getRole() : "student");
        }
        String userId = user.getName();
        forumService.likePost(id, userId);
        return "redirect:/forum";
    }

    @PostMapping("/comment")
    public String addComment(@RequestParam Long postId, @RequestParam String content, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"student".equalsIgnoreCase(user.getRole())) {
            return "redirect:/dashboard?role=" + (user != null ? user.getRole() : "student");
        }
        String author = user.getName();

        com.zenithmind.model.Comment comment = new com.zenithmind.model.Comment();
        comment.setAuthor(author);
        comment.setContent(content);
        comment.setTimestamp(System.currentTimeMillis());
        comment.setTimeAgo(com.zenithmind.model.Post.calculateTimeAgo(comment.getTimestamp()));
        forumService.addComment(postId, comment);
        return "redirect:/forum";
    }

    @GetMapping("/flag")
    public String flag(@RequestParam Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null
                || (!"admin".equalsIgnoreCase(user.getRole()) && !"faculty".equalsIgnoreCase(user.getRole()))) {
            return "redirect:/dashboard?role=" + (user != null ? user.getRole() : "student");
        }
        forumService.toggleFlag(id);
        return "redirect:/forum";
    }
}
