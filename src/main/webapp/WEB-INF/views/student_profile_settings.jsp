<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>ZenithMind | Profile Settings</title>
        <style>
            :root {
                --teal: #00b3c7;
                --dark: #0a2540;
                --text: #4c5d70;
                --bg: #f5f7fb;
                --card: #ffffff;
                --border: #e5ebf4;
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

            .dashboard {
                flex: 1;
                padding: 32px 48px;
            }

            .top-bar {
                margin-bottom: 28px;
            }

            .welcome h1 {
                margin: 0;
                font-size: 28px;
                color: var(--dark);
            }

            .card {
                background: var(--card);
                border-radius: 20px;
                padding: 24px;
                box-shadow: 0 8px 30px rgba(15, 37, 64, 0.08);
                margin-bottom: 24px;
            }

            .settings-section {
                padding: 20px;
                background: #f8fafc;
                border-radius: 12px;
                margin-top: 16px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: var(--dark);
                font-size: 14px;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 12px 16px;
                border-radius: 12px;
                border: 1px solid var(--border);
                font-size: 14px;
                background: #fff;
            }

            .btn {
                padding: 12px 24px;
                border-radius: 12px;
                font-weight: 600;
                cursor: pointer;
                border: none;
                transition: all 0.2s;
            }

            .btn-primary {
                background: var(--teal);
                color: #fff;
            }

            .btn-primary:hover {
                background: #009ba9;
            }

            .card h2 {
                margin-top: 0;
                font-size: 20px;
                color: var(--dark);
            }
        </style>
    </head>

    <body>
        <div class="app-shell">
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
                    <div class="brand-title">
                        ZenithMind<br>
                        <small style="font-size:12px;font-weight:500;color:#5a6a7f;">Mental Health Hub</small>
                    </div>
                </div>

                <div class="user-card">
                    <div class="avatar">${avatarInitial}</div>
                    <div class="name">${name}</div>
                    <div class="email">${email}</div>
                    <div class="dept">${department}</div>
                    <span class="badge">${roleTitle}</span>
                </div>

                <nav>
                    <a href="${dashboardLink}"><span class="icon">D</span>Dashboard</a>
                    <a href="${modulesLink}"><span class="icon">LM</span>Learning Modules</a>
                    <a href="${selfAssessmentLink}"><span class="icon">SA</span>Self Assessment</a>
                    <a href="${moodLink}"><span class="icon">MT</span>Mood Tracker</a>
                    <a href="${supportLink}"><span class="icon">VS</span>Virtual Support</a>
                    <a href="${communityLink}"><span class="icon">CF</span>Community Forum</a>
                    <a class="active" href="#"><span class="icon">PS</span>Profile Settings</a>
                </nav>

                <div style="margin-top:auto; padding-top:20px; border-top:1px solid var(--border);">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost"
                        style="width:100%; justify-content:flex-start; color:#ef4444; text-decoration: none; display: flex; align-items: center; gap: 10px;">
                        <span class="icon" style="background:rgba(239, 68, 68, 0.1); color:#ef4444;">&#128682;</span>
                        Logout
                    </a>
                </div>
            </aside>

            <main class="dashboard">
                <div class="top-bar">
                    <div class="welcome">
                        <p style="margin:0;font-size:14px;color:#7c8b9e;">Manage Your Account</p>
                        <h1>Profile Settings</h1>
                    </div>
                </div>

                <div class="card">
                    <h2>Account Information</h2>
                    <div class="settings-section">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" value="${name}" placeholder="Enter your name">
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" value="${email}" placeholder="Enter your email">
                        </div>
                        <div class="form-group">
                            <label>Department / Major</label>
                            <input type="text" value="${department}" placeholder="Enter your department or major">
                        </div>
                        <div class="form-group">
                            <label>Role</label>
                            <input type="text" value="${roleTitle}" disabled style="background: #f3f4f6;">
                        </div>
                        <button class="btn btn-primary">Save Changes</button>
                    </div>
                </div>

                <div class="card">
                    <h2>Security Settings</h2>
                    <div class="settings-section">
                        <div class="form-group">
                            <label>Current Password</label>
                            <input type="password" placeholder="Enter current password">
                        </div>
                        <div class="form-group">
                            <label>New Password</label>
                            <input type="password" placeholder="Enter new password">
                        </div>
                        <div class="form-group">
                            <label>Confirm New Password</label>
                            <input type="password" placeholder="Confirm new password">
                        </div>
                        <button class="btn btn-primary">Update Password</button>
                    </div>
                </div>

                <div class="card">
                    <h2>Profile Picture</h2>
                    <div class="settings-section">
                        <div style="display: flex; align-items: center; gap: 24px;">
                            <div
                                style="width: 80px; height: 80px; border-radius: 50%; background: #dbefff; display: flex; align-items: center; justify-content: center; font-size: 32px; font-weight: 600; color: #3c74f6;">
                                ${avatarInitial}
                            </div>
                            <div>
                                <button class="btn btn-primary">Upload New Photo</button>
                                <p style="font-size: 13px; color: var(--text); margin-top: 10px;">JPG, PNG or GIF. Max
                                    size 2MB.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>

    </html>