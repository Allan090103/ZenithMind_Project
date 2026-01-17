package com.zenithmind.model;

import javax.persistence.*;

@Entity
@Table(name = "posts")
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String content;
    private String category;
    private String author;
    private boolean anonymous;
    private int likes;
    private boolean flagged;
    private String timeAgo;

    private String authorId;
    private int replies;
    private long timestamp; // Storing as long for easier sorting/comparison

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "post_id")
    private java.util.List<Comment> comments = new java.util.ArrayList<>();

    @ElementCollection
    private java.util.Set<String> likedByUsers = new java.util.HashSet<>();

    public Post() {
        this.timestamp = System.currentTimeMillis();
        this.timeAgo = "Just now";
    }

    public Post(Long id, String title, String content, String category, String author, String authorId,
            boolean anonymous, int likes, int replies, long timestamp, boolean flagged) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.category = category;
        this.author = author;
        this.authorId = authorId;
        this.anonymous = anonymous;
        this.likes = likes;
        this.replies = replies;
        this.timestamp = timestamp;
        this.flagged = flagged;
        this.timeAgo = calculateTimeAgo(timestamp);
    }

    // Helper to calc time ago from timestamp
    public static String calculateTimeAgo(long timestamp) {
        long now = System.currentTimeMillis();
        long diff = now - timestamp;
        long seconds = diff / 1000;

        if (seconds < 60)
            return "just now";
        if (seconds < 3600)
            return (seconds / 60) + " min ago";
        if (seconds < 86400)
            return (seconds / 3600) + " hours ago";
        return (seconds / 86400) + " days ago";
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getAuthorId() {
        return authorId;
    }

    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }

    public boolean isAnonymous() {
        return anonymous;
    }

    public void setAnonymous(boolean anonymous) {
        this.anonymous = anonymous;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getReplies() {
        return replies;
    }

    public void setReplies(int replies) {
        this.replies = replies;
    }

    public boolean isFlagged() {
        return flagged;
    }

    public void setFlagged(boolean flagged) {
        this.flagged = flagged;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
        this.timeAgo = calculateTimeAgo(timestamp);
    }

    public String getTimeAgo() {
        return calculateTimeAgo(timestamp);
    }

    public void setTimeAgo(String timeAgo) {
        this.timeAgo = timeAgo;
    }

    public java.util.List<Comment> getComments() {
        return comments;
    }

    public void addComment(Comment comment) {
        this.comments.add(comment);
        this.replies = this.comments.size();
    }

    public java.util.Set<String> getLikedByUsers() {
        return likedByUsers;
    }

    public boolean isLikedBy(String userId) {
        return likedByUsers.contains(userId);
    }

    public void addLike(String userId) {
        if (likedByUsers.add(userId)) {
            this.likes++;
        }
    }

    public void removeLike(String userId) {
        if (likedByUsers.remove(userId)) {
            this.likes--;
        }
    }
}
