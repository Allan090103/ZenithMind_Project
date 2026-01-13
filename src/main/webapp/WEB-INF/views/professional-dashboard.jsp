<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Professional Dashboard</title>
            <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <style>
                /* Base Dashboard Styles (Unified) */
                :root {
                    --teal: #00b3c7;
                    --dark: #0a2540;
                    --text: #4c5d70;
                    --bg: #f5f7fb;
                    --card: #ffffff;
                    --border: #e5ebf4;
                    --red-soft: #fef2f2;
                    --red-text: #b91c1c;
                    --yellow-soft: #fffbeb;
                    --yellow-text: #b45309;
                    --green-soft: #f0fdf4;
                    --green-text: #15803d;
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
                    position: fixed;
                    height: 100vh;
                }

                .dashboard {
                    flex: 1;
                    margin-left: 260px;
                    padding: 32px 48px;
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
                    padding: 24px;
                    text-align: left;
                }

                .user-card .avatar {
                    width: 64px;
                    height: 64px;
                    border-radius: 50%;
                    background: #dbefff;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 28px;
                    font-weight: 600;
                    color: #3c74f6;
                    margin-bottom: 16px;
                }

                .user-card .name {
                    font-size: 20px;
                    font-weight: 700;
                    color: var(--dark);
                    margin-bottom: 4px;
                }

                .user-card .email {
                    font-size: 14px;
                    color: #4c5d70;
                    margin-bottom: 4px;
                }

                .user-card .dept {
                    font-size: 14px;
                    color: #64748b;
                    margin-bottom: 16px;
                }

                .badge {
                    display: inline-block;
                    width: 100%;
                    padding: 10px 16px;
                    border-radius: 12px;
                    background: #2563eb;
                    color: #fff;
                    font-size: 14px;
                    font-weight: 600;
                    text-align: center;
                    border: none;
                }

                nav {
                    display: flex;
                    flex-direction: column;
                    gap: 12px;
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

                nav a.active .icon {
                    background: #fff;
                    color: var(--teal);
                }

                nav a:hover:not(.active) {
                    background: rgba(0, 178, 199, 0.08);
                }

                .icon {
                    width: 24px;
                    height: 24px;
                    border-radius: 8px;
                    background: rgba(255, 255, 255, 0.4);
                    color: inherit;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 11px;
                    font-weight: 700;
                }

                .btn {
                    display: inline-flex;
                    justify-content: center;
                    align-items: center;
                    padding: 10px 16px;
                    border-radius: 8px;
                    font-weight: 600;
                    cursor: pointer;
                    border: none;
                    font-size: 14px;
                    transition: all 0.2s;
                    text-decoration: none;
                }

                .btn-primary {
                    background: var(--teal);
                    color: #fff;
                }

                .btn-primary:hover {
                    opacity: 0.9;
                }

                .btn-ghost {
                    background: transparent;
                    color: var(--text);
                }

                .btn-ghost:hover {
                    background: rgba(0, 0, 0, 0.05);
                }

                /* Professional Dashboard Grid */
                .dash-grid {
                    display: grid;
                    grid-template-columns: 2fr 1fr;
                    gap: 24px;
                }

                .page-header {
                    margin-bottom: 32px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .page-title {
                    font-size: 28px;
                    font-weight: 700;
                    margin: 0;
                    color: var(--dark);
                }

                .page-subtitle {
                    color: var(--text);
                    margin-top: 4px;
                }

                .card {
                    background: #fff;
                    border-radius: 16px;
                    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
                    overflow: hidden;
                    margin-bottom: 24px;
                }

                .card-header {
                    padding: 20px 24px;
                    border-bottom: 1px solid var(--border);
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .card-title {
                    font-size: 16px;
                    font-weight: 700;
                    color: var(--dark);
                    margin: 0;
                }

                .card-body {
                    padding: 24px;
                }

                /* Tables */
                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                th {
                    text-align: left;
                    padding: 12px 0;
                    color: #64748b;
                    font-size: 12px;
                    font-weight: 600;
                    text-transform: uppercase;
                    border-bottom: 1px solid var(--border);
                }

                td {
                    padding: 16px 0;
                    border-bottom: 1px solid var(--border);
                    font-size: 14px;
                }

                tr:last-child td {
                    border-bottom: none;
                }

                .status-pill {
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 12px;
                    font-weight: 600;
                }

                .status-High {
                    background: var(--red-soft);
                    color: var(--red-text);
                }

                .status-Moderate {
                    background: var(--yellow-soft);
                    color: var(--yellow-text);
                }

                .status-Low {
                    background: var(--green-soft);
                    color: var(--green-text);
                }

                /* Appointment List */
                .appt-item {
                    display: flex;
                    gap: 16px;
                    padding: 16px 0;
                    border-bottom: 1px solid var(--border);
                    align-items: center;
                }

                .appt-item:last-child {
                    border-bottom: none;
                }

                .appt-time {
                    font-weight: 700;
                    color: var(--dark);
                    width: 80px;
                }

                .appt-info {
                    flex: 1;
                }

                .appt-name {
                    font-weight: 600;
                    color: var(--dark);
                    display: block;
                }

                .appt-type {
                    font-size: 12px;
                    color: var(--text);
                }

                /* Stat Cards */
                .stats-row {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 24px;
                    margin-bottom: 24px;
                }

                .stat-card {
                    background: #fff;
                    padding: 24px;
                    border-radius: 16px;
                }

                .stat-label {
                    font-size: 14px;
                    color: var(--text);
                    margin-bottom: 8px;
                }

                .stat-value {
                    font-size: 32px;
                    font-weight: 700;
                    color: var(--dark);
                }

                .stat-trend {
                    font-size: 12px;
                    color: #15803d;
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    gap: 4px;
                }
            </style>
        </head>

        <body>
            <div class="app-shell">

                <!-- Sidebar -->
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
                                fill="url(#sidebarGrad)" />
                            <path d="M16 42l10-13 9 11 9-12 12 16" fill="none" stroke="#e3fbff" stroke-width="4"
                                stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                        <div class="brand-title">ZenithMind<br><small
                                style="font-size:12px;font-weight:500;color:#5a6a7f;">Mental Health Hub</small></div>
                    </div>

                    <div class="user-card">
                        <div class="avatar">${avatarInitial}</div>
                        <div class="name">${name}</div>
                        <div class="email">${email}</div>
                        <div class="dept">${department}</div>
                        <span class="badge">Mental Health Professional</span>
                    </div>

                    <nav>
                        <a href="/dashboard?role=professional" class="active"><span class="icon">D</span>Dashboard</a>
                        <a href="/professional/cases?role=professional"><span class="icon">CM</span>Case
                            Management</a>
                        <a href="/professional/telehealth?role=professional"><span class="icon">TH</span>Telehealth</a>
                        <a href="/professional/monitoring?role=professional"><span class="icon">PM</span>Patient
                            Monitoring</a>
                        <a href="/professional/resources?role=professional"><span class="icon">RM</span>Resources</a>
                        <a href="/forum"><span class="icon">CF</span>Community</a>
                    </nav>

                    <div style="margin-top:auto; padding-top:20px; border-top:1px solid var(--border);">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost"
                            style="width:100%; justify-content:flex-start; color:#ef4444;">
                            <span class="icon"
                                style="background:rgba(239, 68, 68, 0.1); color:#ef4444;">&#128682;</span>
                            Logout
                        </a>
                    </div>
                </aside>

                <main class="dashboard">
                    <div class="page-header">
                        <div>
                            <h1 class="page-title">Professional Overview</h1>
                            <p class="page-subtitle">Welcome back, ${name}. You have 4 upcoming sessions today.</p>
                        </div>
                        <div style="display:flex; gap:12px;">
                            <button class="btn" style="background:#fff; border:1px solid var(--border);">Upload
                                Resource</button>
                            <button class="btn btn-primary">+ New Session</button>
                        </div>
                    </div>

                    <!-- Quick Stats -->
                    <div class="stats-row">
                        <div class="stat-card">
                            <div class="stat-label">Total Assigned Students</div>
                            <div class="stat-value">24</div>
                            <div class="stat-trend"><span>↑</span> 2 new this week</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">High Risk Cases</div>
                            <div class="stat-value" style="color:#ef4444;">5</div>
                            <div class="stat-trend" style="color:#ef4444;">Needs attention</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">Sessions Completed</div>
                            <div class="stat-value">128</div>
                            <div class="stat-trend"><span>↑</span> 12 this month</div>
                        </div>
                    </div>

                    <div class="dash-grid">
                        <!-- Left Column -->
                        <div class="col-main">
                            <!-- Case Management -->
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Student Case Management</h2>
                                    <a href="#"
                                        style="font-size:13px; font-weight:600; color:var(--teal); text-decoration:none;">View
                                        All</a>
                                </div>
                                <div class="card-body" style="padding-top:0;">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Student Name</th>
                                                <th>Risk Level</th>
                                                <th>Status</th>
                                                <th>Notes</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="student" items="${assignedStudents}">
                                                <tr>
                                                    <td>#${student[0]}</td>
                                                    <td><span
                                                            style="font-weight:600; color:var(--dark);">${student[1]}</span>
                                                    </td>
                                                    <td><span
                                                            class="status-pill status-${student[2]}">${student[2]}</span>
                                                    </td>
                                                    <td style="color:var(--text);">${student[3]}</td>
                                                    <td style="font-size:13px; color:#64748b;">${student[4]}</td>
                                                    <td>
                                                        <a href="#" class="btn btn-ghost"
                                                            style="padding:4px 8px;">View</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Resource Management -->
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Resource Library</h2>
                                </div>
                                <div class="card-body">
                                    <div style="display:grid; grid-template-columns: repeat(3, 1fr); gap:16px;">
                                        <c:forEach var="res" items="${resources}">
                                            <div
                                                style="border:1px solid var(--border); padding:16px; border-radius:12px;">
                                                <div style="font-weight:600; margin-bottom:4px;">${res[0]}</div>
                                                <div style="font-size:12px; color:#64748b; margin-bottom:12px;">
                                                    ${res[1]} • ${res[2]}</div>
                                                <button class="btn btn-ghost"
                                                    style="width:100%; font-size:12px; background:#f8fafc;">Assign</button>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column -->
                        <div class="col-side">
                            <!-- Telehealth -->
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Upcoming Appointments</h2>
                                </div>
                                <div class="card-body" style="padding-top:0;">
                                    <c:forEach var="appt" items="${appointments}">
                                        <div class="appt-item">
                                            <div class="appt-time">${appt[0]}</div>
                                            <div class="appt-info">
                                                <span class="appt-name">${appt[1]}</span>
                                                <span class="appt-type">${appt[2]} • ${appt[3]}</span>
                                            </div>
                                            <button class="btn btn-primary"
                                                style="padding:6px 12px; font-size:12px;">Join</button>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- AI Suggestions -->
                            <div class="card"
                                style="background: linear-gradient(135deg, #1e293b, #0f172a); color:#fff;">
                                <div class="card-body">
                                    <div
                                        style="font-size:12px; text-transform:uppercase; letter-spacing:1px; opacity:0.7; margin-bottom:8px;">
                                        AI Insight</div>
                                    <h3 style="margin:0 0 12px; font-size:18px;">Student #1004 showed spike in stress
                                        markers.</h3>
                                    <p style="font-size:14px; opacity:0.8; line-height:1.5; margin-bottom:16px;">
                                        Based on recent self-assessments, recommend assigning the "Advanced Stress
                                        Management" module.
                                    </p>
                                    <button class="btn"
                                        style="background:rgba(255,255,255,0.1); color:#fff; width:100%;">Review
                                        Case</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </body>

        </html>