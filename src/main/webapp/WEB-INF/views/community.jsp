<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Community Forum</title>
            <style>
                :root {
                    --teal: #00b3c7;
                    --dark: #0a2540;
                    --text: #4c5d70;
                    --bg: #f5f7fb;
                    --card: #ffffff;
                    --border: #e5ebf4;
                    /* Synced with Dashboard */
                    --purple: #8b5cf6;
                    --blue: #3b82f6;
                    --green: #22c55e;
                    --yellow: #eab308;
                    --red: #ef4444;
                }

                * {
                    box-sizing: border-box;
                }

                body {
                    margin: 0;
                    font-family: "Segoe UI", Tahoma, sans-serif;
                    background: var(--bg);
                    color: var(--text);
                }

                /* Layout from Dashboard */
                .app-shell {
                    display: flex;
                    min-height: 100vh;
                }

                .sidebar {
                    width: 260px;
                    background: #ffffff;
                    border-right: 1px solid var(--border);
                    padding: 32px 26px;
                    display: flex;
                    flex-direction: column;
                    gap: 24px;
                    flex-shrink: 0;
                }

                .brand {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                }

                .brand svg {
                    width: 42px;
                    height: 42px;
                }

                .brand-title {
                    font-size: 20px;
                    font-weight: 600;
                    color: var(--dark);
                    line-height: 1.2;
                }

                /* User Card (simplified from dashboard) */
                .user-card {
                    background: linear-gradient(135deg, rgba(0, 179, 199, 0.08), rgba(80, 157, 255, 0.1));
                    border-radius: 18px;
                    padding: 20px;
                }

                .user-card .avatar {
                    width: 54px;
                    height: 54px;
                    border-radius: 50%;
                    background: #dbefff;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 24px;
                    font-weight: 600;
                    color: #3c74f6;
                    margin-bottom: 10px;
                }

                .user-card .name {
                    font-size: 18px;
                    font-weight: 600;
                    color: var(--dark);
                }

                .user-card .email {
                    font-size: 13px;
                    margin-bottom: 4px;
                    display: block;
                }

                .user-card .dept {
                    font-size: 13px;
                    margin-bottom: 10px;
                    color: #627189;
                }

                .role-badge {
                    display: inline-flex;
                    padding: 4px 12px;
                    border-radius: 12px;
                    background: #2563eb;
                    color: #fff;
                    font-size: 12px;
                    font-weight: 600;
                }

                nav {
                    display: flex;
                    flex-direction: column;
                    gap: 6px;
                }

                nav a {
                    text-decoration: none;
                    color: var(--text);
                    padding: 12px 14px;
                    border-radius: 12px;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    font-weight: 600;
                    transition: all 0.2s;
                }

                nav a:hover {
                    background: rgba(0, 178, 199, 0.08);
                }

                nav a.active {
                    background: #00c2c7;
                    color: #fff;
                }

                nav a.active .icon {
                    background: #fff;
                    color: var(--teal);
                }

                .icon {
                    width: 22px;
                    height: 22px;
                    border-radius: 6px;
                    background: rgba(255, 255, 255, 0.4);
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 11px;
                    font-weight: 700;
                    color: inherit;
                }

                /* Main Content */
                .main-content {
                    flex: 1;
                    padding: 32px 48px;
                    max-width: 1200px;
                    margin: 0 auto;
                    width: 100%;
                }

                /* Header */
                .top-bar {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 28px;
                    gap: 18px;
                }

                .top-bar h1 {
                    margin: 0 0 4px 0;
                    font-size: 28px;
                    color: var(--dark);
                }

                .top-bar p {
                    margin: 0;
                    color: #64748b;
                    font-size: 14px;
                }

                .btn {
                    padding: 12px 20px;
                    border-radius: 12px;
                    font-weight: 600;
                    cursor: pointer;
                    border: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    font-size: 14px;
                    text-decoration: none;
                    transition: all 0.2s;
                }

                .btn-primary {
                    background: linear-gradient(120deg, #00b3c7, #01a0f9);
                    /* Consistent gradient */
                    color: #fff;
                }

                .btn-primary:hover {
                    opacity: 0.9;
                    box-shadow: 0 4px 12px rgba(1, 160, 249, 0.3);
                }

                .btn-outline {
                    background: transparent;
                    border: 1px solid var(--border);
                    color: var(--dark);
                }

                .btn-ghost {
                    background: transparent;
                    color: #64748b;
                    padding: 6px 12px;
                }

                .btn-ghost:hover {
                    background: #f1f5f9;
                    color: var(--dark);
                }

                .btn-sm {
                    padding: 6px 12px;
                    font-size: 13px;
                }

                /* Stats Grid */
                .stats-grid {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 18px;
                    margin-bottom: 24px;
                }

                .card {
                    background: var(--card);
                    border-radius: 20px;
                    /* Removed border */
                    padding: 24px;
                    box-shadow: 0 8px 30px rgba(15, 37, 64, 0.08);
                    /* Elevated shadow */
                }

                .stat-label {
                    font-size: 14px;
                    color: #64748b;
                    margin-bottom: 4px;
                }

                .stat-value {
                    font-size: 24px;
                    font-weight: 700;
                    color: var(--dark);
                }

                .stat-icon {
                    float: right;
                    width: 32px;
                    height: 32px;
                    border-radius: 8px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                /* Filters & Search */
                .controls {
                    display: flex;
                    gap: 16px;
                    margin-bottom: 24px;
                    flex-wrap: wrap;
                }

                .search-box {
                    position: relative;
                    flex: 1;
                    min-width: 200px;
                }

                .search-box input {
                    width: 100%;
                    padding: 12px 16px 12px 44px;
                    border-radius: 24px;
                    /* Pill shape */
                    border: 1px solid var(--border);
                    font-size: 14px;
                    background: #ffffff;
                }

                .search-icon {
                    position: absolute;
                    left: 12px;
                    top: 10px;
                    opacity: 0.4;
                }

                .tabs {
                    display: flex;
                    background: #f1f5f9;
                    padding: 4px;
                    border-radius: 8px;
                    gap: 2px;
                    flex-wrap: wrap;
                }

                .tab {
                    padding: 6px 12px;
                    border-radius: 6px;
                    font-size: 13px;
                    font-weight: 500;
                    color: #64748b;
                    text-decoration: none;
                    cursor: pointer;
                }

                .tab.active {
                    background: #fff;
                    color: var(--dark);
                    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                }

                .tab:hover:not(.active) {
                    color: var(--dark);
                }

                /* Posts List */
                .posts-list {
                    display: flex;
                    flex-direction: column;
                    gap: 16px;
                }

                .post-card {
                    display: flex;
                    gap: 16px;
                    align-items: flex-start;
                    transition: transform 0.2s, box-shadow 0.2s;
                }

                .post-card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 12px 40px rgba(15, 37, 64, 0.12);
                }

                .avatar {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    background: #e0e7ff;
                    color: #4f46e5;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: 600;
                    font-size: 16px;
                    flex-shrink: 0;
                }

                .post-content {
                    flex: 1;
                }

                .post-meta {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    margin-bottom: 4px;
                    font-size: 13px;
                    color: #64748b;
                }

                .post-author {
                    font-weight: 600;
                    color: var(--dark);
                }

                .badge {
                    padding: 2px 8px;
                    border-radius: 12px;
                    font-size: 11px;
                    font-weight: 500;
                    border: 1px solid var(--border);
                }

                .post-title {
                    margin: 0 0 6px 0;
                    font-size: 18px;
                    font-weight: 600;
                    color: var(--dark);
                }

                .post-body {
                    margin: 0 0 12px 0;
                    color: #475569;
                    font-size: 15px;
                    line-height: 1.5;
                }

                .post-actions {
                    display: flex;
                    gap: 16px;
                }

                .flag-btn {
                    color: #dc2626;
                }

                .flagged-badge {
                    background: #fef2f2;
                    color: #dc2626;
                    border-color: #fecaca;
                    padding: 4px 12px;
                    border-radius: 12px;
                    font-size: 12px;
                    display: inline-flex;
                    align-items: center;
                    gap: 4px;
                    margin-left: auto;
                }

                /* Modal */
                .modal-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: rgba(0, 0, 0, 0.5);
                    display: none;
                    align-items: center;
                    justify-content: center;
                    z-index: 1000;
                }

                .modal {
                    background: #fff;
                    width: 600px;
                    max-width: 90%;
                    border-radius: 12px;
                    padding: 24px;
                    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
                }

                .modal-header {
                    margin-bottom: 20px;
                }

                .modal-title {
                    margin: 0;
                    font-size: 20px;
                    font-weight: 600;
                }

                .form-group {
                    margin-bottom: 16px;
                }

                .form-label {
                    display: block;
                    font-size: 14px;
                    font-weight: 500;
                    margin-bottom: 6px;
                }

                .form-input,
                .form-select,
                .form-textarea {
                    width: 100%;
                    padding: 10px;
                    border: 1px solid var(--border);
                    border-radius: 6px;
                    font-family: inherit;
                    font-size: 14px;
                }

                .form-textarea {
                    resize: vertical;
                    min-height: 100px;
                }

                .checkbox-group {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                }

                .modal-actions {
                    display: flex;
                    gap: 12px;
                    margin-top: 24px;
                }

                .modal-actions .btn {
                    flex: 1;
                    justify-content: center;
                }

                @media (max-width: 1024px) {
                    .app-shell {
                        flex-direction: column;
                    }

                    .sidebar {
                        width: 100%;
                        border-right: none;
                        border-bottom: 1px solid var(--border);
                    }

                    .stats-grid {
                        grid-template-columns: repeat(2, 1fr);
                    }

                    .controls {
                        flex-direction: column;
                    }

                    .tabs {
                        overflow-x: auto;
                    }
                }

                /* Adjusted for Faculty/Professional roles */
                <c:if test="${user.role.equalsIgnoreCase('faculty') || user.role.equalsIgnoreCase('admin')}">nav {
                    gap: 12px;
                }

                .user-card {
                    padding: 24px;
                }

                .user-card .avatar {
                    width: 64px;
                    height: 64px;
                    font-size: 28px;
                    margin-bottom: 16px;
                }

                .user-card .name {
                    font-size: 20px;
                    font-weight: 700;
                }

                .user-card .email,
                .user-card .dept {
                    font-size: 14px;
                }

                .role-badge {
                    width: 100%;
                    display: block;
                    text-align: center;
                    padding: 10px 16px;
                }

                </c:if>
            </style>
            <script>
                function openModal() { document.getElementById('newPostModal').style.display = 'flex'; }
                function closeModal() { document.getElementById('newPostModal').style.display = 'none'; }

                // Close modal on click outside
                window.onclick = function (event) {
                    var modal = document.getElementById('newPostModal');
                    if (event.target == modal) {
                        closeModal();
                    }
                }

                function toggleComments(postId) {
                    var section = document.getElementById('comments-' + postId);
                    if (section.style.display === 'none') {
                        section.style.display = 'block';
                    } else {
                        section.style.display = 'none';
                    }
                }
            </script>
        </head>

        <body>
            <div class="app-shell">
                <!-- Sidebar (Duplicated from Dashboard for consistency) -->
                <aside class="sidebar">
                    <div class="brand">
                        <svg viewBox="0 0 64 64" role="img" aria-label="ZenithMind">
                            <defs>
                                <linearGradient id="sidebarGrad" x1="8" y1="6" x2="56" y2="58"
                                    gradientUnits="userSpaceOnUse">
                                    <stop offset="0" stop-color="#7de3ff" />
                                    <stop offset="1" stop-color="#0095b0" />
                                </linearGradient>
                            </defs>
                            <path
                                d="M32 7c-9 0-17 7-17 15-8 2-12 7-12 14 0 7 4 12 12 14 2 6 7 10 17 10 10 0 15-4 17-10 8-2 12-7 12-14s-4-12-12-14c0-8-8-15-17-15z"
                                fill="url(#sidebarGrad)" stroke="#0f7596" stroke-width="2" stroke-linejoin="round" />
                            <path d="M16 42l10-13 9 11 9-12 12 16" fill="none" stroke="#e3fbff" stroke-width="4"
                                stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                        <div class="brand-title">ZenithMind<br><small
                                style="font-size:12px;font-weight:500;color:#5a6a7f;">Mental
                                Health Hub</small></div>
                    </div>

                    <div class="user-card">
                        <div class="avatar">
                            ${avatarInitial}
                        </div>
                        <div class="name">
                            ${name}
                        </div>
                        <div class="email">
                            ${email}
                        </div>
                        <div class="dept">
                            ${department}
                        </div>
                        <span class="role-badge">
                            ${roleTitle}
                        </span>
                    </div>

                    <nav>
                        <a href="${dashboardLink}"><span class="icon">D</span>Dashboard</a>
                        <c:choose>
                            <c:when test="${user.role.equalsIgnoreCase('faculty')}">
                                <a href="${trainingLink}"><span class="icon">TR</span>Training Modules</a>
                                <a href="${guidesLink}"><span class="icon">QG</span>Quick Guides</a>
                                <a href="${reportLink}"><span class="icon">CR</span>Report Concern</a>
                                <a class="active" href="${communityLink}"><span class="icon">CF</span>Community</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${modulesLink}"><span class="icon">LM</span>Learning Modules</a>
                                <a href="${selfAssessmentLink}"><span class="icon">SA</span>Self Assessment</a>
                                <a href="${moodLink}"><span class="icon">MT</span>Mood Tracker</a>
                                <a href="${supportLink}"><span class="icon">VS</span>Virtual Support</a>
                                <a class="active" href="${communityLink}"><span class="icon">CF</span>Community
                                    Forum</a>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${!user.role.equalsIgnoreCase('faculty')}">
                            <a href="${profileSettingsLink}"><span class="icon">PS</span>Profile Settings</a>
                        </c:if>
                    </nav>
                </aside>

                <main class="main-content">
                    <div class="top-bar">
                        <div>
                            <p style="margin:0;font-size:14px;color:#7c8b9e;">Connect with peers, share experiences, and
                                support each other</p>
                            <h1>Community Forum</h1>
                        </div>
                        <c:if test="${!user.role.equalsIgnoreCase('faculty')}">
                            <button class="btn btn-primary" onclick="openModal()">
                                <span style="font-size:18px;">+</span> New Post
                            </button>
                        </c:if>
                    </div>

                    <!-- Stats -->
                    <div class="stats-grid">
                        <div class="card">
                            <div class="stat-icon" style="background:#f3e8ff;color:var(--purple);">💬</div>
                            <div class="stat-label">Total Posts</div>
                            <div class="stat-value">${totalPosts}</div>
                        </div>
                        <div class="card">
                            <div class="stat-icon" style="background:#dbeafe;color:var(--blue);">👥</div>
                            <div class="stat-label">Active Members</div>
                            <div class="stat-value">${activeMembers}</div>
                        </div>
                        <div class="card">
                            <div class="stat-icon" style="background:#dcfce7;color:var(--green);">👍</div>
                            <div class="stat-label">Helpful Replies</div>
                            <div class="stat-value">${helpfulReplies}</div>
                        </div>
                        <div class="card">
                            <div class="stat-icon" style="background:#fef9c3;color:var(--yellow);">🏆</div>
                            <div class="stat-label">Your Points</div>
                            <div class="stat-value">${user.points}</div>
                        </div>
                    </div>

                    <!-- Controls -->
                    <div class="card" style="padding: 16px;">
                        <div class="controls" style="margin:0;">
                            <form action="${pageContext.request.contextPath}/forum" method="get"
                                style="display:contents;">
                                <input type="hidden" name="category" value="${selectedCategory}">
                                <div class="search-box">
                                    <span class="search-icon">🔍</span>
                                    <input type="text" name="search" placeholder="Search posts..."
                                        value="${searchQuery}">
                                </div>
                            </form>

                            <div class="tabs">
                                <c:set var="categories"
                                    value="all,anxiety,depression,stress,student-life,success-stories,general" />
                                <c:forTokens items="${categories}" delims="," var="cat">
                                    <a href="${pageContext.request.contextPath}/forum?category=${cat}&search=${searchQuery}"
                                        class="tab ${selectedCategory == cat ? 'active' : ''}">
                                        ${cat == 'all' ? 'All Topics' : cat.toUpperCase().replace('-', ' ')}
                                    </a>
                                </c:forTokens>
                            </div>
                        </div>
                    </div>

                    <c:if test="${empty posts}">
                        <div class="card" style="text-align:center; padding: 48px; color: #64748b; margin-top:24px;">
                            No posts found. Be the first to start a discussion!
                        </div>
                    </c:if>

                    <div class="posts-list" style="margin-top:24px;">
                        <c:forEach var="post" items="${posts}">
                            <div class="card post-card">
                                <div class="avatar" style="${post.anonymous ? 'background:#f1f5f9;color:#64748b' : ''}">
                                    ${post.anonymous ? '?' : post.author.substring(0,1)}
                                </div>
                                <div class="post-content">
                                    <div class="post-meta">
                                        <span class="post-author">${post.author}</span>
                                        <span class="badge">${post.category.replace('-', ' ')}</span>
                                        <span>• ${post.timeAgo}</span>

                                        <c:if test="${post.flagged && !user.role.equalsIgnoreCase('admin')}">
                                            <span class="flagged-badge">⚠️ Flagged for Review</span>
                                        </c:if>
                                    </div>

                                    <h3 class="post-title">${post.title}</h3>
                                    <p class="post-body">${post.content}</p>

                                    <div class="post-actions">
                                        <a href="${pageContext.request.contextPath}/forum/like?id=${post.id}"
                                            class="btn btn-ghost btn-sm ${post.isLikedBy(user.name) ? 'liked' : ''}"
                                            style="${post.isLikedBy(user.name) ? 'color:#ef4444;background:#fef2f2;' : ''}">
                                            ${post.isLikedBy(user.name) ? '❤️' : '🤍'} <span
                                                style="margin-left:4px;">${post.likes}</span>
                                        </a>
                                        <button class="btn btn-ghost btn-sm" onclick="toggleComments(${post.id})">
                                            💬 <span style="margin-left:4px;">${post.replies} replies</span>
                                        </button>

                                        <c:if
                                            test="${user.role.equalsIgnoreCase('admin') || user.role.equalsIgnoreCase('faculty')}">
                                            <a href="${pageContext.request.contextPath}/forum/flag?id=${post.id}"
                                                class="btn btn-ghost btn-sm ${post.flagged ? 'flag-btn' : ''}"
                                                style="margin-left:auto;">
                                                ${post.flagged ? '⚠️ Unflag' : '🚩 Flag'}
                                            </a>
                                        </c:if>
                                    </div>

                                    <!-- Comment Section -->
                                    <div id="comments-${post.id}"
                                        style="display:none; margin-top:16px; padding-top:16px; border-top:1px solid var(--border);">
                                        <div style="margin-bottom:12px;">
                                            <c:forEach var="comment" items="${post.comments}">
                                                <div
                                                    style="background:#f8fafc; padding:10px; border-radius:8px; margin-bottom:8px;">
                                                    <div
                                                        style="display:flex; justify-content:space-between; font-size:12px; color:#64748b; margin-bottom:4px;">
                                                        <strong>${comment.author}</strong>
                                                        <span>${comment.timeAgo}</span>
                                                    </div>
                                                    <div style="font-size:14px; color:#334155;">${comment.content}</div>
                                                </div>
                                            </c:forEach>
                                            <c:if test="${empty post.comments}">
                                                <p style="font-size:13px; color:#94a3b8; font-style:italic;">No comments
                                                    yet.</p>
                                            </c:if>
                                        </div>

                                        <form action="${pageContext.request.contextPath}/forum/comment" method="post"
                                            style="display:flex; gap:8px;">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="postId" value="${post.id}">
                                            <input type="text" name="content" placeholder="Write a reply..."
                                                class="form-input" style="flex:1; padding:8px;" required>
                                            <button type="submit" class="btn btn-primary btn-sm">Reply</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Guideline Card -->
                    <div class="card" style="background:#faf5ff; border-color:#e9d5ff; margin-top:24px;">
                        <h4 style="margin:0 0 8px 0; color:#6b21a8;">Community Guidelines</h4>
                        <ul style="margin:0; padding-left:20px; color:#6b21a8; font-size:14px; line-height:1.6;">
                            <li>Be respectful and supportive of all members</li>
                            <li>No sharing of personal identifying information</li>
                            <li>Content is moderated for safety and appropriateness</li>
                        </ul>
                    </div>
                </main>
            </div>

            <!-- Create Post Modal -->
            <div id="newPostModal" class="modal-overlay">
                <div class="modal">
                    <div class="modal-header">
                        <h2 class="modal-title">Create a New Post</h2>
                        <p style="margin:4px 0 0 0; color:#64748b; font-size:14px;">Share your thoughts, experiences, or
                            questions with the community</p>
                    </div>
                    <form action="${pageContext.request.contextPath}/forum/create" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div class="form-group">
                            <label class="form-label">Title</label>
                            <input type="text" name="title" class="form-input"
                                placeholder="Give your post a descriptive title" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Category</label>
                            <select name="category" class="form-select">
                                <option value="general">General Discussion</option>
                                <option value="anxiety">Anxiety Support</option>
                                <option value="depression">Depression Support</option>
                                <option value="stress">Stress Management</option>
                                <option value="student-life">Student Life</option>
                                <option value="success-stories">Success Stories</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Content</label>
                            <textarea name="content" class="form-textarea"
                                placeholder="Share your story, ask a question, or offer support..." required></textarea>
                        </div>

                        <div class="checkbox-group">
                            <input type="checkbox" name="anonymous" id="anonCheck" checked>
                            <label for="anonCheck" style="font-size:14px;user-select:none;cursor:pointer;">Post
                                anonymously</label>
                        </div>

                        <div class="modal-actions">
                            <button type="button" class="btn btn-outline" onclick="closeModal()">Cancel</button>
                            <button type="submit" class="btn btn-primary">Create Post</button>
                        </div>
                    </form>
                </div>
            </div>
        </body>

        </html>