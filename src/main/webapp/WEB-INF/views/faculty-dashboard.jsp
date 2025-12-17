<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Faculty Dashboard</title>
            <style>
                <%@ include file="professional-styles.jsp" %>
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
                        <div class="brand-title">ZenithMind<br><small
                                style="font-size:12px;font-weight:500;color:#5a6a7f;">Mental Health Hub</small></div>
                    </div>

                    <div class="user-card">
                        <div class="avatar">${avatarInitial}</div>
                        <div class="name">${name}</div>
                        <div class="email">${email}</div>
                        <div class="dept">${department}</div>
                        <span class="badge">${roleTitle}</span>
                    </div>

                    <nav>
                        <a href="${dashboardLink}" class="active"><span class="icon">D</span>Dashboard</a>
                        <a href="/faculty/training?role=faculty"><span class="icon">TR</span>Training Modules</a>
                        <a href="/faculty/guides?role=faculty"><span class="icon">QG</span>Quick Guides</a>
                        <a href="/faculty/report?role=faculty"><span class="icon">CR</span>Report Concern</a>
                        <a href="${communityLink}"><span class="icon">CF</span>Community</a>
                    </nav>

                    <div style="margin-top:auto; padding-top:20px; border-top:1px solid var(--border);">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost"
                            style="width:100%; justify-content:flex-start; color:#ef4444;">
                            <span class="icon" style="background:rgba(239, 68, 68, 0.1); color:#ef4444;">🚪</span>
                            Logout
                        </a>
                    </div>
                </aside>

                <main class="dashboard">
                    <div class="page-header">
                        <div>
                            <h1 class="page-title">Faculty Dashboard</h1>
                            <p class="page-subtitle">Supporting student mental health through awareness and action</p>
                        </div>
                    </div>

                    <!-- Quick Stats -->
                    <div style="display:grid; grid-template-columns: repeat(3, 1fr); gap:24px; margin-bottom:24px;">
                        <div class="stat-card">
                            <div class="stat-label">Training Completed</div>
                            <div class="stat-value">2/4</div>
                            <div class="stat-trend"><span>↑</span> 50% complete</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">Concerns Reported</div>
                            <div class="stat-value">3</div>
                            <div class="stat-trend">This semester</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">Resources Accessed</div>
                            <div class="stat-value">12</div>
                            <div class="stat-trend"><span>↑</span> 4 this week</div>
                        </div>
                    </div>

                    <div style="display:grid; grid-template-columns: 2fr 1fr; gap:24px;">
                        <!-- Training Progress -->
                        <div>
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Training & Awareness Modules</h2>
                                    <a href="/faculty/training?role=faculty"
                                        style="font-size:13px; font-weight:600; color:var(--teal); text-decoration:none;">View
                                        All</a>
                                </div>
                                <div class="card-body">
                                    <div style="display:flex; flex-direction:column; gap:16px;">
                                        <div style="padding:16px; border:1px solid var(--border); border-radius:12px;">
                                            <div
                                                style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
                                                <div>
                                                    <div style="font-weight:600; color:var(--dark); margin-bottom:4px;">
                                                        Mental Health Literacy</div>
                                                    <div style="font-size:13px; color:#64748b;">45 min • Understanding
                                                        common conditions</div>
                                                </div>
                                                <span
                                                    style="padding:4px 12px; background:#dcfce7; color:#15803d; border-radius:12px; font-size:12px; font-weight:600;">✓
                                                    Completed</span>
                                            </div>
                                            <div style="width:100%; height:6px; background:#e5e7eb; border-radius:3px;">
                                                <div
                                                    style="width:100%; height:100%; background:#15803d; border-radius:3px;">
                                                </div>
                                            </div>
                                        </div>

                                        <div style="padding:16px; border:1px solid var(--border); border-radius:12px;">
                                            <div
                                                style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
                                                <div>
                                                    <div style="font-weight:600; color:var(--dark); margin-bottom:4px;">
                                                        Classroom Support Strategies</div>
                                                    <div style="font-size:13px; color:#64748b;">60 min • Creating
                                                        supportive environments</div>
                                                </div>
                                                <span
                                                    style="padding:4px 12px; background:#fef3c7; color:#b45309; border-radius:12px; font-size:12px; font-weight:600;">⏳
                                                    In Progress</span>
                                            </div>
                                            <div style="width:100%; height:6px; background:#e5e7eb; border-radius:3px;">
                                                <div
                                                    style="width:65%; height:100%; background:#f59e0b; border-radius:3px;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Reference -->
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Quick Reference Guides</h2>
                                    <a href="/faculty/guides?role=faculty"
                                        style="font-size:13px; font-weight:600; color:var(--teal); text-decoration:none;">View
                                        All</a>
                                </div>
                                <div class="card-body">
                                    <div style="display:grid; grid-template-columns: repeat(2, 1fr); gap:16px;">
                                        <div style="padding:16px; border:1px solid var(--border); border-radius:12px; cursor:pointer; transition:all 0.2s;"
                                            onmouseover="this.style.background='#f8fafc'"
                                            onmouseout="this.style.background='white'">
                                            <div style="font-size:32px; margin-bottom:8px;">⚠️</div>
                                            <div style="font-weight:600; font-size:14px; color:var(--dark);">What to Do
                                                If a Student is At Risk</div>
                                        </div>
                                        <div style="padding:16px; border:1px solid var(--border); border-radius:12px; cursor:pointer; transition:all 0.2s;"
                                            onmouseover="this.style.background='#f8fafc'"
                                            onmouseout="this.style.background='white'">
                                            <div style="font-size:32px; margin-bottom:8px;">✅</div>
                                            <div style="font-weight:600; font-size:14px; color:var(--dark);">Do's and
                                                Don'ts of Student Support</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Sidebar -->
                        <div>
                            <!-- Report Concern CTA -->
                            <div class="card"
                                style="background:linear-gradient(135deg, #ef4444, #dc2626); color:white;">
                                <div class="card-body">
                                    <div
                                        style="font-size:12px; text-transform:uppercase; letter-spacing:1px; opacity:0.9; margin-bottom:8px;">
                                        Need Help?</div>
                                    <h3 style="margin:0 0 12px; font-size:18px;">Report a Student Concern</h3>
                                    <p style="font-size:14px; opacity:0.9; line-height:1.5; margin-bottom:16px;">
                                        Confidentially refer students who may need professional support.
                                    </p>
                                    <a href="/faculty/report?role=faculty" class="btn"
                                        style="background:rgba(255,255,255,0.2); color:white; width:100%; border:1px solid rgba(255,255,255,0.3);">Submit
                                        Report</a>
                                </div>
                            </div>

                            <!-- Important Notice -->
                            <div class="card" style="background:#fffbeb; border:2px solid #fbbf24;">
                                <div class="card-body">
                                    <div
                                        style="font-weight:700; color:#b45309; margin-bottom:8px; display:flex; align-items:center; gap:8px;">
                                        <span style="font-size:20px;">ℹ️</span>
                                        Confidentiality Notice
                                    </div>
                                    <p style="font-size:13px; color:#78350f; line-height:1.5; margin:0;">
                                        You do not have access to student personal records. All reports are securely
                                        forwarded to mental health professionals.
                                    </p>
                                </div>
                            </div>

                            <!-- Recent Activity -->
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Recent Activity</h2>
                                </div>
                                <div class="card-body" style="padding-top:0;">
                                    <div style="display:flex; flex-direction:column; gap:16px;">
                                        <div style="padding-bottom:16px; border-bottom:1px solid var(--border);">
                                            <div
                                                style="font-weight:600; font-size:13px; color:var(--dark); margin-bottom:4px;">
                                                Completed Training</div>
                                            <div style="font-size:12px; color:#64748b;">Mental Health Literacy</div>
                                            <div style="font-size:11px; color:#64748b; margin-top:4px;">2 days ago</div>
                                        </div>
                                        <div>
                                            <div
                                                style="font-weight:600; font-size:13px; color:var(--dark); margin-bottom:4px;">
                                                Accessed Guide</div>
                                            <div style="font-size:12px; color:#64748b;">Crisis Response Protocol</div>
                                            <div style="font-size:11px; color:#64748b; margin-top:4px;">5 days ago</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </body>

        </html>