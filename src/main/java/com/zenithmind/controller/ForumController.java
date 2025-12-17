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

    @GetMapping
    public String viewForum(@RequestParam(required = false, defaultValue = "all") String category,
            @RequestParam(required = false) String search,
            Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User("Ali", "student", 150);
            session.setAttribute("user", user);
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
    public String like(@RequestParam Long id) {
        forumService.likePost(id);
        return "redirect:/forum";
    }

    @GetMapping("/flag")
    public String flag(@RequestParam Long id) {
        forumService.toggleFlag(id);
        return "redirect:/forum";
    }
}
