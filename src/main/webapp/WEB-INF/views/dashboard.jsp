<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>ZenithMind | Student Dashboard</title>
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

            .score-pill {
                padding: 10px 16px;
                border-radius: 18px;
                background: rgba(0, 179, 199, 0.15);
                color: var(--dark);
                font-weight: 600;
                font-size: 14px;
            }

            .grid {
                display: grid;
                gap: 18px;
            }

            .metrics {
                grid-template-columns: 2fr 1fr 1fr;
            }

            .card {
                background: var(--card);
                border-radius: 20px;
                padding: 24px;
                box-shadow: 0 8px 30px rgba(15, 37, 64, 0.08);
            }

            .highlight {
                background: linear-gradient(120deg, #00b3c7, #01a0f9);
                color: #fff;
            }

            .highlight h2 {
                margin: 18px 0 6px;
                font-size: 36px;
            }

            .highlight small {
                font-size: 14px;
                opacity: 0.9;
            }

            .metric-value {
                font-size: 32px;
                font-weight: 700;
                color: var(--dark);
            }

            .metric-label {
                font-size: 14px;
                color: var(--text);
            }

            .quick-actions {
                grid-template-columns: repeat(4, 1fr);
                margin-top: 22px;
            }

            .action {
                display: block;
                text-decoration: none;
                color: var(--dark);
                text-align: center;
                padding: 20px;
                border-radius: 18px;
                font-weight: 600;
            }

            .action strong {
                display: block;
                margin-bottom: 6px;
                font-size: 16px;
            }

            .action span {
                display: block;
                font-size: 14px;
                color: var(--text);
                font-weight: 400;
            }

            .action.assessment {
                background: rgba(57, 130, 255, 0.14);
            }

            .action.mood {
                background: rgba(255, 102, 196, 0.16);
            }

            .action.learn {
                background: rgba(163, 134, 255, 0.16);
            }

            .action.support {
                background: rgba(0, 191, 165, 0.16);
            }

            .lower-grid {
                grid-template-columns: repeat(3, 1fr);
                margin-top: 24px;
            }

            .progress-bar {
                width: 100%;
                height: 8px;
                border-radius: 6px;
                background: #e3ecf4;
                margin: 12px 0;
                position: relative;
            }

            .progress-bar span {
                position: absolute;
                height: 100%;
                left: 0;
                top: 0;
                border-radius: 6px;
                background: #f39c12;
            }

            .list {
                display: flex;
                flex-direction: column;
                gap: 14px;
            }

            .list-item {
                display: flex;
                justify-content: space-between;
                font-size: 14px;
            }

            .badge-list {
                display: flex;
                gap: 12px;
                flex-wrap: wrap;
            }

            .badge-pill {
                padding: 12px 16px;
                border-radius: 16px;
                font-weight: 600;
            }

            .badge-pill.blue {
                background: rgba(99, 102, 241, 0.16);
                color: #3730a3;
            }

            .badge-pill.orange {
                background: rgba(255, 115, 0, 0.18);
                color: #c05621;
            }

            .badge-pill.gold {
                background: rgba(255, 214, 102, 0.3);
                color: #b7791f;
            }

            .sidebar-footer {
                margin-top: 12px;
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

                .quick-actions {
                    grid-template-columns: repeat(2, 1fr);
                }

                .metrics {
                    grid-template-columns: repeat(2, 1fr);
                }

                .lower-grid {
                    grid-template-columns: repeat(1, 1fr);
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
                    <a href="${modulesLink}"><span class="icon">LM</span>Learning Modules</a>
                    <a href="${selfAssessmentLink}"><span class="icon">SA</span>Self Assessment</a>
                    <a href="${moodLink}"><span class="icon">MT</span>Mood Tracker</a>
                    <a href="${supportLink}"><span class="icon">VS</span>Virtual Support</a>
                    <a href="${communityLink}"><span class="icon">CF</span>Community Forum</a>
                    <a href="#"><span class="icon">PS</span>Profile Settings</a>
                </nav>
                <div style="margin-top:auto; padding-top:20px; border-top:1px solid var(--border);">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost"
                        style="width:100%; justify-content:flex-start; color:#ef4444;">
                        <span class="icon" style="background:rgba(239, 68, 68, 0.1); color:#ef4444;">&#128682;</span>
                        Logout
                    </a>
                </div>
            </aside>

            <main class="dashboard">
                <div class="top-bar">
                    <div class="welcome">
                        <p style="margin:0;font-size:14px;color:#7c8b9e;">Here is your mental health journey
                            overview</p>
                        <h1>Welcome back, ${name}!</h1>
                    </div>
                    <div class="search">
                        <input type="text" placeholder="Search for modules, resources, or support...">
                        <div class="score-pill">Wellness Score: <strong>
                                ${score} / 100
                            </strong></div>
                    </div>
                </div>

                <div class="grid metrics">
                    <div class="card highlight">
                        <small>Your Wellness Score</small>
                        <h2>
                            ${score} / 100
                        </h2>
                        <p style="margin:8px 0 14px;">
                            ${improvementNote}
                        </p>
                        <div style="height:6px;border-radius:4px;background:rgba(255,255,255,0.4);position:relative;">
                            <span
                                style="position:absolute;left:0;top:0;height:100%;width:${wellnessPercent}%;background:#fff;border-radius:4px;"></span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="metric-value">
                            ${modulesCompleted}
                        </div>
                        <div class="metric-label">Modules Completed</div>
                    </div>
                    <div class="card">
                        <div class="metric-value">
                            ${dayStreak}
                        </div>
                        <div class="metric-label">Day Streak</div>
                    </div>
                </div>

                <div class="grid quick-actions">
                    <a class="card action assessment" href="${modulesAssessmentLink}">
                        <strong>Take Assessment</strong>
                        <span>Update your self-check</span>
                    </a>
                    <a class="card action mood" href="${moodLink}">
                        <strong>Log Mood</strong>
                        <span>Record today's feeling</span>
                    </a>
                    <a class="card action learn" href="${modulesLink}">
                        <strong>Learn</strong>
                        <span>Browse recommended modules</span>
                    </a>
                    <a class="card action support" href="${supportLink}">
                        <strong>Get Support</strong>
                        <span>Connect with a counselor</span>
                    </a>
                </div>

                <div class="grid lower-grid">
                    <div class="card">
                        <h3 style="margin-top:0;color:var(--dark);">Weekly Goal</h3>
                        <p>
                            ${goalDescription}
                        </p>
                        <div class="progress-bar"><span style="width:${goalPercent}%"></span></div>
                        <small>
                            ${goalNote}
                        </small>
                    </div>
                    <div class="card">
                        <h3 style="margin-top:0;color:var(--dark);">Recent Activity</h3>
                        <div class="list">
                            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                                <c:forEach var="activity" items="${activities}">
                                    <div class="list-item">
                                        <span>
                                            ${activity[0]}
                                        </span>
                                        <strong>
                                            ${activity[1]}
                                        </strong>
                                    </div>
                                </c:forEach>
                        </div>
                    </div>
                    <div class="card">
                        <h3 style="margin-top:0;color:var(--dark);">Recent Badges</h3>
                        <div class="badge-list">
                            <c:forEach var="badgeData" items="${badges}">
                                <div class="badge-pill ${badgeData[1]}">
                                    ${badgeData[0]}
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>

    </html>