package com.zenithmind.service;

import com.zenithmind.model.Post;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class ForumService {

    private final List<Post> posts = new ArrayList<>();
    private final AtomicLong counter = new AtomicLong();

    public ForumService() {
        long now = System.currentTimeMillis();
        // Sample data matching the React component
        save(new Post(null, "Dealing with exam anxiety - tips that helped me",
                "I wanted to share some techniques that really helped me manage my exam anxiety this semester. Deep breathing before exams, regular study breaks, and talking to friends made a huge difference.",
                "anxiety", "Anonymous", "anon1", true, 24, 8, now - (2 * 60 * 60 * 1000), false));

        save(new Post(null, "How do you balance work, study, and self-care?",
                "I'm struggling to find time for everything. Between part-time work, classes, and trying to maintain my mental health, I feel overwhelmed. Any advice?",
                "stress", "Student_247", "user2", false, 15, 12, now - (5 * 60 * 60 * 1000), false));

        save(new Post(null, "6 months of therapy - worth it!",
                "Just wanted to share that after 6 months of counseling through the campus center, I'm in such a better place. Don't hesitate to reach out for professional help!",
                "success-stories", "Anonymous", "anon3", true, 45, 18, now - (24 * 60 * 60 * 1000), false));
    }

    public List<Post> getAllPosts() {
        return posts;
    }

    public List<Post> getFilteredPosts(String category, String search) {
        return posts.stream()
                .filter(p -> category == null || category.isEmpty() || "all".equals(category)
                        || p.getCategory().equals(category))
                .filter(p -> search == null || search.isEmpty()
                        || p.getTitle().toLowerCase().contains(search.toLowerCase())
                        || p.getContent().toLowerCase().contains(search.toLowerCase()))
                .sorted((p1, p2) -> Long.compare(p2.getTimestamp(), p1.getTimestamp())) // Newest first
                .collect(java.util.stream.Collectors.toList());
    }

    public void save(Post post) {
        if (post.getId() == null) {
            post.setId(counter.incrementAndGet());
        }
        if (post.getTimestamp() == 0) {
            post.setTimestamp(System.currentTimeMillis());
        }
        if (post.getTimeAgo() == null) {
            post.setTimeAgo(Post.calculateTimeAgo(post.getTimestamp()));
        }
        // If sorting by timestamp in getAll, we can just add.
        // But for main list maintenance, simple add is fine.
        posts.add(post);
    }

    public void likePost(Long id) {
        posts.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .ifPresent(p -> p.setLikes(p.getLikes() + 1));
    }

    public void toggleFlag(Long id) {
        posts.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .ifPresent(p -> p.setFlagged(!p.isFlagged()));
    }

    // Stats helpers
    public int getTotalPosts() {
        return posts.size();
    }

    public int getActiveMembers() {
        return 847;
    } // Mocked

    public int getHelpfulReplies() {
        return 1200;
    } // Mocked
}
