package com.zenithmind.service;

import com.zenithmind.model.Post;
import com.zenithmind.model.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Service
public class ForumService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private UserService userService;

    public List<Post> getAllPosts() {
        return getFilteredPosts("all", null);
    }

    public List<Post> getFilteredPosts(String category, String search) {
        StringBuilder sql = new StringBuilder("SELECT * FROM posts WHERE 1=1 ");
        java.util.List<Object> params = new java.util.ArrayList<>();

        if (category != null && !category.isEmpty() && !"all".equalsIgnoreCase(category)) {
            sql.append("AND category = ? ");
            params.add(category);
        }

        if (search != null && !search.isEmpty()) {
            sql.append("AND (title LIKE ? OR content LIKE ?) ");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }

        sql.append("ORDER BY timestamp DESC");

        List<Post> posts = jdbcTemplate.query(sql.toString(), params.toArray(), this::mapRowToPost);
        for (Post post : posts) {
            post.getComments().addAll(getCommentsForPost(post.getId()));
        }
        return posts;
    }

    private List<Comment> getCommentsForPost(Long postId) {
        String sql = "SELECT * FROM comments WHERE post_id = ? ORDER BY timestamp ASC";
        return jdbcTemplate.query(sql, new Object[] { postId }, (rs, rowNum) -> {
            Comment comment = new Comment();
            comment.setId(rs.getLong("id"));
            comment.setAuthor(rs.getString("author"));
            comment.setContent(rs.getString("content"));
            comment.setTimestamp(rs.getLong("timestamp"));
            comment.setTimeAgo(rs.getString("time_ago"));
            return comment;
        });
    }

    public void save(Post post) {
        if (post.getTimestamp() == 0) {
            post.setTimestamp(System.currentTimeMillis());
        }
        if (post.getTimeAgo() == null) {
            post.setTimeAgo(Post.calculateTimeAgo(post.getTimestamp()));
        }

        String sql = "INSERT INTO posts (title, content, category, author, author_id, anonymous, likes, replies, timestamp, time_ago, flagged) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                post.getTitle(),
                post.getContent(),
                post.getCategory(),
                post.getAuthor(),
                post.getAuthorId(),
                post.isAnonymous(),
                post.getLikes(),
                post.getReplies(),
                post.getTimestamp(),
                post.getTimeAgo(),
                post.isFlagged());
    }

    public void likePost(Long id, String userId) {
        // Simple implementation: increment likes in DB
        // In a real app, we'd check the liked_by_users table
        String sql = "UPDATE posts SET likes = likes + 1 WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    public void addComment(Long postId, Comment comment) {
        String sql = "INSERT INTO comments (post_id, author, content, timestamp, time_ago) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, postId, comment.getAuthor(), comment.getContent(), comment.getTimestamp(),
                comment.getTimeAgo());

        // Update replies count in posts table
        String updatePostSql = "UPDATE posts SET replies = (SELECT COUNT(*) FROM comments WHERE post_id = ?) WHERE id = ?";
        jdbcTemplate.update(updatePostSql, postId, postId);
    }

    public void toggleFlag(Long id) {
        String sql = "UPDATE posts SET flagged = NOT flagged WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    private Post mapRowToPost(ResultSet rs, int rowNum) throws SQLException {
        Post post = new Post();
        post.setId(rs.getLong("id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setCategory(rs.getString("category"));
        post.setAuthor(rs.getString("author"));
        post.setAuthorId(rs.getString("author_id"));
        post.setAnonymous(rs.getBoolean("anonymous"));
        post.setLikes(rs.getInt("likes"));
        post.setReplies(rs.getInt("replies"));
        post.setTimestamp(rs.getLong("timestamp"));
        post.setFlagged(rs.getBoolean("flagged"));
        post.setTimeAgo(rs.getString("time_ago"));
        return post;
    }

    // Stats helpers
    public int getTotalPosts() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM posts", Integer.class);
        return count != null ? count : 0;
    }

    public int getActiveMembers() {
        return userService.getTotalUserCount();
    }

    public int getHelpfulReplies() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM comments", Integer.class);
        return count != null ? count : 0;
    }
}
