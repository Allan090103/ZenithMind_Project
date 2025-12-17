<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Admin Dashboard</title>
    <style>
        :root {
            --teal: #00b3c7;
            --dark: #0a2540;
            --text: #4c5d70;
            --bg: #f5f7fb;
            --card: #ffffff;
            --border: #e5ebf4;
            --admin-accent: #f59e0b;
            --admin-success: #10b981;
            --admin-warning: #f59e0b;
            --admin-danger: #ef4444;
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
        }

        .user-card .dept {
            font-size: 13px;
            margin-bottom: 10px;
            color: #627189;
        }

        .badge {
            display: inline-flex;
            padding: 4px 12px;
            border-radius: 12px;
            background: linear-gradient(135deg, #f59e0b, #d97706);
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
            transition: all 0.2s ease;
        }

        nav a.active {
            background: #00c2c7;
            color: #fff;
        }

        nav a:hover:not(.active) {
            background: rgba(0, 178, 199, 0.08);
        }

        .icon {
            width: 22px;
            height: 22px;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.4);
            color: inherit;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 700;
        }

        html {
            scroll-behavior: smooth;
        }

        .dashboard {
            flex: 1;
            padding: 32px 48px;
        }

        .section-divider {
            margin: 40px 0;
            border-bottom: 2px solid var(--border);
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
            gap: 18px;
        }

        .welcome h1 {
            margin: 0;
            font-size: 28px;
            color: var(--dark);
        }

        .welcome p {
            margin: 0;
            font-size: 14px;
            color: #7c8b9e;
        }

        .search {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .search input {
            width: 340px;
            padding: 12px 16px;
            border-radius: 24px;
            border: 1px solid var(--border);
            font-size: 14px;
            background: #fff;
        }

        .search input::placeholder {
            color: var(--text);
        }

        .admin-badge {
            padding: 10px 16px;
            border-radius: 18px;
            background: linear-gradient(135deg, rgba(245, 158, 11, 0.15), rgba(251, 146, 60, 0.15));
            border: 1px solid rgba(245, 158, 11, 0.3);
            color: var(--dark);
            font-weight: 600;
            font-size: 14px;
        }

        .grid {
            display: grid;
            gap: 18px;
        }

        .metrics {
            grid-template-columns: repeat(4, 1fr);
        }

        .card {
            background: var(--card);
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 8px 30px rgba(15, 37, 64, 0.08);
        }

        .stat-card {
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, rgba(0, 179, 199, 0.05), transparent);
            border-radius: 50%;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 14px;
            color: var(--text);
        }

        .stat-change {
            font-size: 12px;
            margin-top: 8px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .stat-change.positive {
            color: var(--admin-success);
        }

        .stat-change.negative {
            color: var(--admin-danger);
        }

        .highlight-blue {
            background: linear-gradient(120deg, #00b3c7, #01a0f9);
            color: #fff;
        }

        .highlight-purple {
            background: linear-gradient(135deg, #a78bfa, #8b5cf6);
            color: #fff;
        }

        .highlight-green {
            background: linear-gradient(135deg, #10b981, #059669);
            color: #fff;
        }

        .highlight-orange {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: #fff;
        }

        .two-col {
            grid-template-columns: 2fr 1fr;
            margin-top: 22px;
        }

        .three-col {
            grid-template-columns: repeat(3, 1fr);
            margin-top: 22px;
        }

        .card h3 {
            margin: 0 0 18px 0;
            font-size: 18px;
            color: var(--dark);
            font-weight: 600;
        }

        .user-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .user-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px;
            background: rgba(0, 179, 199, 0.04);
            border-radius: 12px;
            border: 1px solid var(--border);
        }

        .user-item .role-badge {
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 11px;
            font-weight: 600;
        }

        .user-item .role-badge.student {
            background: rgba(59, 130, 246, 0.2);
            color: #60a5fa;
        }

        .user-item .role-badge.faculty {
            background: rgba(139, 92, 246, 0.2);
            color: #a78bfa;
        }

        .user-item .role-badge.professional {
            background: rgba(16, 185, 129, 0.2);
            color: #34d399;
        }

        .activity-log {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .activity-item {
            display: flex;
            gap: 12px;
            font-size: 14px;
        }

        .activity-icon {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            background: linear-gradient(135deg, rgba(0, 179, 199, 0.15), rgba(59, 130, 246, 0.15));
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 12px;
            color: var(--teal);
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-content strong {
            color: var(--dark);
        }

        .activity-time {
            font-size: 12px;
            color: var(--text);
            opacity: 0.7;
        }

        .moderation-item {
            padding: 14px;
            background: rgba(239, 68, 68, 0.05);
            border-radius: 12px;
            border-left: 4px solid var(--admin-danger);
            margin-bottom: 12px;
        }

        .moderation-item p {
            margin: 0 0 8px 0;
            font-size: 14px;
            color: var(--text);
        }

        .moderation-actions {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 8px;
            border: none;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-approve {
            background: var(--admin-success);
            color: #fff;
        }

        .btn-remove {
            background: var(--admin-danger);
            color: #fff;
        }

        .btn-view {
            background: #00b3c7;
            color: #fff;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .chart-placeholder {
            height: 200px;
            background: linear-gradient(180deg, rgba(0, 179, 199, 0.08), rgba(0, 179, 199, 0.02));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text);
            font-size: 14px;
            border: 1px dashed var(--border);
        }

        .sidebar-footer {
            margin-top: auto;
            display: flex;
            justify-content: center;
        }

        .logout-btn {
            display: inline-block;
            padding: 10px 14px;
            border-radius: 10px;
            background: #f3f4f6;
            color: var(--text);
            text-decoration: none;
            font-weight: 700;
            border: 1px solid rgba(0, 0, 0, 0.04);
            transition: all 0.2s ease;
        }

        .logout-btn:hover {
            background: #ffecec;
            color: #b91c1c;
        }

        @media (max-width: 1080px) {
            .app-shell {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
            }

            .metrics {
                grid-template-columns: repeat(2, 1fr);
            }

            .two-col {
                grid-template-columns: 1fr;
            }

            .three-col {
                grid-template-columns: 1fr;
            }

            .search {
                flex-direction: column;
                align-items: flex-start;
            }

            .search input {
                width: 100%;
            }
        }
    </style>
</head>

<body>

    <div class="app-shell">
        <aside class="sidebar">
            <div class="brand">
                <svg viewBox="0 0 64 64" role="img" aria-label="ZenithMind">
                    <defs>
                        <linearGradient id="sidebarGrad" x1="8" y1="6" x2="56" y2="58" gradientUnits="userSpaceOnUse">
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
                <div class="brand-title">
                    ZenithMind<br>
                    <small style="font-size:12px;font-weight:500;color:#5a6a7f;">Mental Health Hub</small>
                </div>
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
                <span class="badge">
                    ${roleTitle}
                </span>
            </div>

            <nav>
                <a class="active" href="${dashboardLink}"><span class="icon">D</span>Dashboard</a>
                <a href="/admin/panel"><span class="icon">AP</span>Admin Panel</a>
                <a href="/admin/users"><span class="icon">UM</span>User Management</a>
                <a href="/admin/analytics"><span class="icon">PA</span>Platform Analytics</a>
                <a href="/admin/moderation"><span class="icon">CM</span>Content Moderation</a>
                <a href="/admin/settings"><span class="icon">PS</span>Profile Settings</a>
            </nav>

            <div class="sidebar-footer">
                <a class="logout-btn" href="/">← Logout</a>
            </div>
        </aside>

        <main class="dashboard">
            <!-- Admin Panel Section -->
            <div id="admin-panel">
                <div class="top-bar">
                    <div class="welcome">
                        <p>Admin Control Center</p>
                        <h1>Welcome back, ${name}!</h1>
                    </div>
                    <div class="search">
                        <input type="text" placeholder="Search users, content, or system logs...">
                        <div class="admin-badge"><strong>Admin Access</strong></div>
                    </div>
                </div>

                <div class="grid metrics">
                    <div class="card stat-card highlight-blue">
                        <div class="stat-value">1,247</div>
                        <div class="stat-label">Total Users</div>
                        <div class="stat-change positive">↑ 12% this week</div>
                    </div>
                    <div class="card stat-card highlight-purple">
                        <div class="stat-value">342</div>
                        <div class="stat-label">Active Today</div>
                        <div class="stat-change positive">↑ 8% from yesterday</div>
                    </div>
                    <div class="card stat-card highlight-green">
                        <div class="stat-value">89%</div>
                        <div class="stat-label">System Health</div>
                        <div class="stat-change positive">All services operational</div>
                    </div>
                    <div class="card stat-card highlight-orange">
                        <div class="stat-value">3</div>
                        <div class="stat-label">Flagged Content</div>
                        <div class="stat-change negative">Requires review</div>
                    </div>
                </div>
            </div>

            <div class="section-divider"></div>

            <!-- Platform Analytics Section -->
            <div id="platform-analytics">
                <div class="card">
                    <h3>Platform Analytics</h3>
                    <div class="chart-placeholder">
                        📈 User Engagement Chart<br>
                        <small>(Visualization placeholder)</small>
                    </div>
                    <div style="margin-top: 16px; display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px;">
                        <div style="text-align: center;">
                            <div style="font-size: 20px; font-weight: 700; color: var(--teal);">456</div>
                            <div style="font-size: 12px; color: var(--text);">Modules Completed</div>
                        </div>
                        <div style="text-align: center;">
                            <div style="font-size: 20px; font-weight: 700; color: var(--admin-success);">2,134</div>
                            <div style="font-size: 12px; color: var(--text);">Forum Posts</div>
                        </div>
                        <div style="text-align: center;">
                            <div style="font-size: 20px; font-weight: 700; color: var(--admin-warning);">178</div>
                            <div style="font-size: 12px; color: var(--text);">Support Sessions</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="section-divider"></div>

            <!-- User Management Section -->
            <div id="user-management">
                <div class="grid two-col">
                    <div class="card">
                        <h3>User Management</h3>
                        <div class="user-list">
                            <div class="user-item">
                                <div>
                                    <strong style="color: var(--dark);">Students</strong>
                                    <div style="font-size: 12px; color: var(--text);">Active users</div>
                                </div>
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <span style="font-size: 20px; font-weight: 700; color: var(--teal);">847</span>
                                    <span class="role-badge student">Student</span>
                                </div>
                            </div>
                            <div class="user-item">
                                <div>
                                    <strong style="color: var(--dark);">Faculty</strong>
                                    <div style="font-size: 12px; color: var(--text);">Active users</div>
                                </div>
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <span style="font-size: 20px; font-weight: 700; color: #a78bfa;">234</span>
                                    <span class="role-badge faculty">Faculty</span>
                                </div>
                            </div>
                            <div class="user-item">
                                <div>
                                    <strong style="color: var(--dark);">Professionals</strong>
                                    <div style="font-size: 12px; color: var(--text);">Active users</div>
                                </div>
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <span style="font-size: 20px; font-weight: 700; color: #34d399;">166</span>
                                    <span class="role-badge professional">Professional</span>
                                </div>
                            </div>
                        </div>
                        <button class="btn btn-view" style="width: 100%; margin-top: 12px;">View All Users →</button>
                    </div>
                </div>
            </div>

            <div class="section-divider"></div>

            <!-- Content Moderation Section -->
            <div id="content-moderation">
                <div class="grid three-col">
                    <div class="card">
                        <h3>Content Moderation</h3>
                        <div class="moderation-item">
                            <p><strong>Flagged Post #247</strong></p>
                            <p style="font-size: 13px;">"Inappropriate language detected in community forum..."</p>
                            <div class="moderation-actions">
                                <button class="btn btn-approve">Approve</button>
                                <button class="btn btn-remove">Remove</button>
                                <button class="btn btn-view">View</button>
                            </div>
                        </div>
                        <div class="moderation-item">
                            <p><strong>Flagged Post #246</strong></p>
                            <p style="font-size: 13px;">"Multiple reports on anxiety support thread..."</p>
                            <div class="moderation-actions">
                                <button class="btn btn-approve">Approve</button>
                                <button class="btn btn-remove">Remove</button>
                                <button class="btn btn-view">View</button>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <h3>Recent System Activities</h3>
                        <div class="activity-log">
                            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                                <c:forEach var="activity" items="${activities}">
                                    <div class="activity-item">
                                        <div class="activity-icon">⚙️</div>
                                        <div class="activity-content">
                                            <div><strong>${activity[0]}</strong></div>
                                            <div class="activity-time">${activity[1]}</div>
                                        </div>
                                    </div>
                                </c:forEach>
                        </div>
                    </div>

                    <div class="card">
                        <h3>Weekly Goal</h3>
                        <p style="color: var(--text);">
                            ${goalDescription}
                        </p>
                        <div
                            style="margin: 16px 0; height: 8px; background: rgba(0, 179, 199, 0.1); border-radius: 8px; position: relative;">
                            <span
                                style="position: absolute; left: 0; top: 0; height: 100%; width: ${goalPercent}%; background: linear-gradient(90deg, #00b3c7, #01a0f9); border-radius: 8px;"></span>
                        </div>
                        <small style="color: var(--text);">
                            ${goalNote}
                        </small>
                        <div
                            style="margin-top: 16px; padding: 12px; background: rgba(16, 185, 129, 0.1); border-radius: 8px; border-left: 4px solid var(--admin-success);">
                            <div style="font-size: 13px; color: var(--text);">Admin Performance</div>
                            <div style="font-size: 18px; font-weight: 700; color: var(--dark); margin-top: 4px;">
                                ${dayStreak} days active streak
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="section-divider"></div>

            <!-- Profile Settings Section -->
            <div id="profile-settings">
                <div class="card">
                    <h3>⚙️ Profile Settings</h3>
                    <p>Manage your admin account settings, preferences, and security options.</p>
                    <div style="margin-top: 20px;">
                        <div
                            style="padding: 16px; background: rgba(0, 179, 199, 0.05); border-radius: 12px; border-left: 4px solid var(--teal);">
                            <div style="font-size: 14px; color: var(--dark); font-weight: 600; margin-bottom: 8px;">
                                Account Information</div>
                            <div style="font-size: 13px; color: var(--text); line-height: 1.8;">
                                <strong>Name:</strong> ${name}<br>
                                <strong>Email:</strong> ${email}<br>
                                <strong>Department:</strong> ${department}<br>
                                <strong>Role:</strong> ${roleTitle}
                            </div>
                        </div>
                        <div style="margin-top: 16px; display: flex; gap: 12px;">
                            <button class="btn btn-view">Edit Profile</button>
                            <button class="btn btn-view">Change Password</button>
                            <button class="btn btn-view">Security Settings</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>

</html>