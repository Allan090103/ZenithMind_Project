<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Quick Reference Guides</title>
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
                        <a href="${dashboardLink}"><span class="icon">D</span>Dashboard</a>
                        <a href="/faculty/training?role=faculty"><span class="icon">TR</span>Training Modules</a>
                        <a href="/faculty/guides?role=faculty" class="active"><span class="icon">QG</span>Quick
                            Guides</a>
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
                            <h1 class="page-title">Quick Reference Guides</h1>
                            <p class="page-subtitle">Essential resources for supporting student mental health</p>
                        </div>
                        <button class="btn" style="background:#fff; border:1px solid var(--border);">Download All
                            (PDF)</button>
                    </div>

                    <!-- Guide Cards -->
                    <div style="display:grid; grid-template-columns: repeat(2, 1fr); gap:24px;">
                        <c:forEach var="guide" items="${quickGuides}">
                            <div class="card" style="cursor:pointer; transition:all 0.2s;"
                                onmouseover="this.style.transform='translateY(-4px)'; this.style.boxShadow='0 12px 24px rgba(0,0,0,0.1)'"
                                onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 6px -1px rgba(0,0,0,0.05)'">
                                <div class="card-header" style="background:linear-gradient(135deg, #f0fdfa, #ecfeff);">
                                    <h2 class="card-title" style="color:var(--teal);">${guide[0]}</h2>
                                </div>
                                <div class="card-body">
                                    <p style="color:#64748b; line-height:1.6; margin-bottom:20px;">${guide[1]}</p>
                                    <button class="btn btn-primary" style="width:100%;">View Guide</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Detailed Guide Example -->
                    <div class="card" style="margin-top:24px;">
                        <div class="card-header" style="background:#fef2f2;">
                            <h2 class="card-title" style="color:#dc2626;">⚠️ What to Do If a Student is At Risk</h2>
                        </div>
                        <div class="card-body">
                            <div style="display:flex; flex-direction:column; gap:20px;">
                                <div>
                                    <h3 style="margin:0 0 12px; font-size:16px; color:var(--dark);">Immediate Steps</h3>
                                    <ol style="margin:0; padding-left:24px; line-height:1.8; color:#64748b;">
                                        <li><strong style="color:var(--dark);">Stay Calm</strong> - Maintain a composed
                                            demeanor to provide reassurance</li>
                                        <li><strong style="color:var(--dark);">Listen Actively</strong> - Give the
                                            student your full attention without judgment</li>
                                        <li><strong style="color:var(--dark);">Express Concern</strong> - Let them know
                                            you care about their wellbeing</li>
                                        <li><strong style="color:var(--dark);">Do Not Promise Confidentiality</strong> -
                                            Explain you may need to involve professionals</li>
                                        <li><strong style="color:var(--dark);">Report Immediately</strong> - Use the
                                            secure reporting system to notify mental health professionals</li>
                                    </ol>
                                </div>

                                <div
                                    style="padding:16px; background:#fef3c7; border-left:4px solid #f59e0b; border-radius:8px;">
                                    <h4 style="margin:0 0 8px; color:#b45309; font-size:14px;">⚡ In Case of Emergency
                                    </h4>
                                    <p style="margin:0; color:#78350f; font-size:13px; line-height:1.6;">
                                        If a student is in immediate danger, call campus security (ext. 911) or
                                        emergency services (911). Stay with the student until help arrives.
                                    </p>
                                </div>

                                <div>
                                    <h3 style="margin:0 0 12px; font-size:16px; color:var(--dark);">Warning Signs to
                                        Watch For</h3>
                                    <div style="display:grid; grid-template-columns: repeat(2, 1fr); gap:12px;">
                                        <div style="padding:12px; background:#f8fafc; border-radius:8px;">
                                            <div style="font-weight:600; color:var(--dark); margin-bottom:4px;">
                                                Behavioral Changes</div>
                                            <ul style="margin:0; padding-left:20px; font-size:13px; color:#64748b;">
                                                <li>Withdrawal from activities</li>
                                                <li>Declining academic performance</li>
                                                <li>Increased absences</li>
                                            </ul>
                                        </div>
                                        <div style="padding:12px; background:#f8fafc; border-radius:8px;">
                                            <div style="font-weight:600; color:var(--dark); margin-bottom:4px;">
                                                Emotional Indicators</div>
                                            <ul style="margin:0; padding-left:20px; font-size:13px; color:#64748b;">
                                                <li>Expressions of hopelessness</li>
                                                <li>Extreme mood swings</li>
                                                <li>Talking about self-harm</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Do's and Don'ts -->
                    <div style="display:grid; grid-template-columns: repeat(2, 1fr); gap:24px; margin-top:24px;">
                        <div class="card" style="background:#f0fdf4; border:2px solid #22c55e;">
                            <div class="card-header" style="background:transparent; border-bottom:1px solid #bbf7d0;">
                                <h2 class="card-title" style="color:#15803d;">✅ Do's</h2>
                            </div>
                            <div class="card-body">
                                <ul style="margin:0; padding-left:20px; line-height:2; color:#166534;">
                                    <li>Take all concerns seriously</li>
                                    <li>Maintain appropriate boundaries</li>
                                    <li>Document observations objectively</li>
                                    <li>Follow up after making a referral</li>
                                    <li>Seek support for yourself if needed</li>
                                </ul>
                            </div>
                        </div>

                        <div class="card" style="background:#fef2f2; border:2px solid #ef4444;">
                            <div class="card-header" style="background:transparent; border-bottom:1px solid #fecaca;">
                                <h2 class="card-title" style="color:#dc2626;">❌ Don'ts</h2>
                            </div>
                            <div class="card-body">
                                <ul style="margin:0; padding-left:20px; line-height:2; color:#991b1b;">
                                    <li>Don't try to be a therapist</li>
                                    <li>Don't promise to keep secrets</li>
                                    <li>Don't minimize their feelings</li>
                                    <li>Don't share student information publicly</li>
                                    <li>Don't wait if you're concerned</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </body>

        </html>