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
            Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        String role = "student";
        if (user != null) {
            role = user.getRole();
        }

        java.util.Map<String, Object> userData = userService.getUserData(role);
        model.addAllAttributes(userData);

        if (user == null) {
            user = new User((String) userData.get("name"), role, 150);
            session.setAttribute("user", user);
        }

        // Links for sidebar
        String roleSuffix = "role=" + role;
        model.addAttribute("dashboardLink", "dashboard?" + roleSuffix);
        model.addAttribute("modulesLink", "modules?" + roleSuffix);
        model.addAttribute("modulesAssessmentLink", "modules?section=assessment&" + roleSuffix);
        model.addAttribute("selfAssessmentLink", "self-assessment?" + roleSuffix);
        model.addAttribute("communityLink", "forum");
        model.addAttribute("moodLink", "mood?" + roleSuffix);
        model.addAttribute("supportLink", "support?" + roleSuffix);

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
        if (user == null) {
            return "redirect:/forum"; // Or login
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
        String userId = (user != null) ? user.getName() : "anonymous"; // Simple ID fallback
        forumService.likePost(id, userId);
        return "redirect:/forum";
    }

    @PostMapping("/comment")
    public String addComment(@RequestParam Long postId, @RequestParam String content, HttpSession session) {
        User user = (User) session.getAttribute("user");
        String author = (user != null) ? user.getName() : "Anonymous";

        com.zenithmind.model.Comment comment = new com.zenithmind.model.Comment(
                System.currentTimeMillis(), author, content, System.currentTimeMillis());
        forumService.addComment(postId, comment);
        return "redirect:/forum";
    }

    @GetMapping("/flag")
    public String flag(@RequestParam Long id) {
        forumService.toggleFlag(id);
        return "redirect:/forum";
    }
}
