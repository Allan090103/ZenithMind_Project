<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Training Modules</title>
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
                        <a href="/faculty/training?role=faculty" class="active"><span class="icon">TR</span>Training
                            Modules</a>
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
                            <h1 class="page-title">Training & Awareness Modules</h1>
                            <p class="page-subtitle">Build your mental health literacy and support skills</p>
                        </div>
                    </div>

                    <!-- Progress Overview -->
                    <div class="card"
                        style="background:linear-gradient(135deg, #00b3c7, #01a0f9); color:white; margin-bottom:24px;">
                        <div class="card-body">
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                                <div>
                                    <div style="font-size:14px; opacity:0.9; margin-bottom:8px;">Your Progress</div>
                                    <div style="font-size:32px; font-weight:700;">2 of 4 Completed</div>
                                </div>
                                <div
                                    style="width:120px; height:120px; border-radius:50%; background:rgba(255,255,255,0.2); display:flex; align-items:center; justify-content:center; font-size:36px; font-weight:700;">
                                    50%
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Training Modules -->
                    <div class="card">
                        <div class="card-header">
                            <h2 class="card-title">Available Training Modules</h2>
                        </div>
                        <div class="card-body">
                            <div style="display:flex; flex-direction:column; gap:20px;">
                                <c:forEach var="module" items="${trainingModules}">
                                    <div style="padding:24px; border:1px solid var(--border); border-radius:12px;">
                                        <div
                                            style="display:flex; justify-content:space-between; align-items:start; margin-bottom:16px;">
                                            <div style="flex:1;">
                                                <h3 style="margin:0 0 8px; font-size:18px; color:var(--dark);">
                                                    ${module[0]}</h3>
                                                <p style="margin:0 0 12px; color:#64748b; line-height:1.6;">${module[1]}
                                                </p>
                                                <div style="display:flex; gap:16px; font-size:13px; color:#64748b;">
                                                    <span>⏱️ ${module[2]}</span>
                                                </div>
                                            </div>
                                            <c:choose>
                                                <c:when test="${module[3] == 'Completed'}">
                                                    <span
                                                        style="padding:8px 16px; background:#dcfce7; color:#15803d; border-radius:12px; font-size:13px; font-weight:600;">✓
                                                        Completed</span>
                                                </c:when>
                                                <c:when test="${module[3] == 'In Progress'}">
                                                    <button class="btn btn-primary"
                                                        style="padding:8px 24px;">Continue</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn"
                                                        style="padding:8px 24px; background:#fff; border:1px solid var(--border);">Start
                                                        Module</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <c:if test="${module[3] == 'In Progress'}">
                                            <div
                                                style="width:100%; height:8px; background:#e5e7eb; border-radius:4px; margin-top:12px;">
                                                <div
                                                    style="width:65%; height:100%; background:var(--teal); border-radius:4px;">
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Certification -->
                    <div class="card" style="background:#f0fdf4; border:2px solid #22c55e;">
                        <div class="card-body">
                            <div style="display:flex; gap:20px; align-items:center;">
                                <div style="font-size:48px;">🏆</div>
                                <div style="flex:1;">
                                    <h3 style="margin:0 0 8px; color:#15803d; font-size:18px;">Earn Your Certificate
                                    </h3>
                                    <p style="margin:0; color:#166534; line-height:1.6;">Complete all 4 training modules
                                        to receive your Mental Health Awareness Certificate.</p>
                                </div>
                                <div style="font-size:24px; font-weight:700; color:#15803d;">50%</div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </body>

        </html>