<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Self Assessment</title>
            <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <style>
                /* Base Dashboard Styles */
                :root {
                    --teal: #00b3c7;
                    --dark: #0a2540;
                    --text: #4c5d70;
                    --bg: #f5f7fb;
                    --card: #ffffff;
                    --border: #e5ebf4;

                    /* Assessment Specific Colors (Tailwind-like) */
                    --teal-50: #f0fdfa;
                    --teal-100: #ccfbf1;
                    --teal-500: #14b8a6;
                    --teal-600: #0d9488;
                    --cyan-50: #ecfeff;
                    --gray-50: #f9fafb;
                    --gray-100: #f3f4f6;
                    --gray-200: #e5e7eb;
                    --gray-600: #4b5563;
                    --gray-900: #111827;
                    --green-500: #22c55e;
                    --yellow-500: #eab308;
                    --orange-500: #f97316;
                    --red-500: #ef4444;
                }

                * {
                    box-sizing: border-box;
                }

                body {
                    margin: 0;
                    font-family: "Segoe UI", Tahoma, sans-serif;
                    /* Matching Dashboard Font */
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

                /* Assessment Specific Styles (Merged) */
                .page-header {
                    margin-bottom: 32px;
                }

                .page-title {
                    font-size: 28px;
                    font-weight: 700;
                    margin: 0 0 8px;
                    color: var(--dark);
                }

                .page-desc {
                    color: var(--gray-600);
                }

                .grid-types {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 16px;
                    margin-bottom: 24px;
                }

                .type-card {
                    background: #fff;
                    border: 2px solid var(--gray-200);
                    border-radius: 12px;
                    padding: 24px;
                    text-align: center;
                    cursor: pointer;
                    transition: all 0.2s;
                    text-decoration: none;
                    color: inherit;
                    display: block;
                }

                .type-card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                }

                .type-card.active {
                    border-color: var(--teal-500);
                    background-color: var(--teal-50);
                }

                .type-icon {
                    font-size: 36px;
                    margin-bottom: 12px;
                    display: block;
                }

                .type-title {
                    font-weight: 600;
                    display: block;
                    margin-bottom: 4px;
                }

                .type-desc {
                    font-size: 12px;
                    color: var(--gray-600);
                    display: block;
                }

                .content-grid {
                    display: grid;
                    grid-template-columns: 2fr 1fr;
                    gap: 24px;
                }

                .card {
                    background: #fff;
                    border-radius: 12px;
                    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                    margin-bottom: 24px;
                }

                .card-header {
                    padding: 24px;
                    border-bottom: 1px solid var(--gray-100);
                }

                .card-title {
                    font-size: 18px;
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    margin: 0;
                }

                .card-desc {
                    color: var(--gray-600);
                    font-size: 14px;
                    margin-top: 4px;
                }

                .card-content {
                    padding: 24px;
                }

                .question-item {
                    margin-bottom: 24px;
                    padding-bottom: 24px;
                    border-bottom: 1px solid var(--gray-100);
                }

                .question-item:last-child {
                    border-bottom: none;
                    margin-bottom: 0;
                    padding-bottom: 0;
                }

                .question-text {
                    font-weight: 500;
                    margin-bottom: 12px;
                }

                .radio-grid {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 12px;
                }

                .radio-label {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    padding: 12px;
                    border: 1px solid var(--gray-200);
                    border-radius: 8px;
                    cursor: pointer;
                    font-size: 14px;
                    transition: background 0.1s;
                }

                .radio-label:hover {
                    background: var(--gray-50);
                }

                input[type="radio"] {
                    margin: 0;
                }

                .btn {
                    display: inline-flex;
                    justify-content: center;
                    align-items: center;
                    padding: 12px 24px;
                    border-radius: 8px;
                    font-weight: 500;
                    cursor: pointer;
                    border: none;
                    font-size: 14px;
                    transition: all 0.2s;
                    text-decoration: none;
                }

                .btn-primary {
                    background: var(--teal-500);
                    color: #fff;
                    width: 100%;
                }

                .btn-primary:hover {
                    background: var(--teal-600);
                }

                .btn-outline {
                    background: transparent;
                    border: 1px solid var(--gray-200);
                    color: var(--gray-900);
                    width: 100%;
                }

                .btn-outline:hover {
                    background: var(--gray-50);
                }

                .btn.disabled {
                    opacity: 0.5;
                    pointer-events: none;
                }

                .result-score {
                    font-size: 60px;
                    font-weight: 700;
                    color: var(--teal-600);
                    margin-bottom: 8px;
                }

                .result-badge {
                    display: inline-block;
                    padding: 6px 16px;
                    border-radius: 20px;
                    color: #fff;
                    font-size: 14px;
                    font-weight: 600;
                    margin-bottom: 24px;
                }

                .bg-green-500 {
                    background-color: var(--green-500);
                }

                .bg-yellow-500 {
                    background-color: var(--yellow-500);
                }

                .bg-orange-500 {
                    background-color: var(--orange-500);
                }

                .bg-red-500 {
                    background-color: var(--red-500);
                }

                .recommendation {
                    display: flex;
                    gap: 12px;
                    align-items: flex-start;
                    margin-bottom: 12px;
                    font-size: 14px;
                }

                .dot {
                    width: 8px;
                    height: 8px;
                    border-radius: 50%;
                    margin-top: 6px;
                    flex-shrink: 0;
                }
            </style>
        </head>

        <body>
            <div class="app-shell">

                <!-- Unified Sidebar -->
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
                        <a href="${selfAssessmentLink}" class="active"><span class="icon">SA</span>Self Assessment</a>
                        <a href="${moodLink}"><span class="icon">MT</span>Mood Tracker</a>
                        <a href="${supportLink}"><span class="icon">VS</span>Virtual Support</a>
                        <a href="${communityLink}"><span class="icon">CF</span>Community Forum</a>
                        <a href="#"><span class="icon">PS</span>Profile Settings</a>
                    </nav>

                    <div style="margin-top:auto; padding-top:20px; border-top:1px solid var(--border);">
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost"
                            style="width:100%; justify-content:flex-start; color:#ef4444; background:none;">
                            <span class="icon"
                                style="background:rgba(239, 68, 68, 0.1); color:#ef4444;">&#128682;</span>
                            Logout
                        </a>
                    </div>
                </aside>

                <main class="dashboard">
                    <div class="page-header">
                        <h1 class="page-title">Self Assessment 📋</h1>
                        <p class="page-desc">Take confidential screenings to understand your mental health</p>
                    </div>

                    <!-- Type Selection -->
                    <div class="grid-types">
                        <c:forEach var="entry" items="${assessmentTypes}">
                            <a href="?role=${param.role}&type=${entry.key}"
                                class="type-card ${selectedType == entry.key ? 'active' : ''}">
                                <span class="type-icon">${entry.value.icon}</span>
                                <span class="type-title">${entry.value.title}</span>
                                <span class="type-desc">${entry.value.description}</span>
                            </a>
                        </c:forEach>
                    </div>

                    <div class="content-grid">
                        <div class="main-col">
                            <c:choose>
                                <c:when test="${submitted}">
                                    <!-- Result View -->
                                    <div class="card"
                                        style="background: linear-gradient(135deg, #f0fdfa 0%, #ecfeff 100%); border:none;">
                                        <div class="card-header" style="border-bottom-color:rgba(0,0,0,0.05);">
                                            <h2 class="card-title" style="color:#0f766e;">✅ Assessment Complete</h2>
                                        </div>
                                        <div class="card-content" style="text-align:center;">
                                            <div class="result-score">${score}%</div>
                                            <span class="result-badge ${severityColor}">${severityLevel} Level</span>
                                            <div
                                                style="height:8px; background:#e2e8f0; border-radius:4px; overflow:hidden; margin-bottom:24px;">
                                                <div style="width:${score}%; height:100%; background:currentColor;"
                                                    class="${severityUnsafeColor}-500"></div>
                                            </div>
                                            <div
                                                style="background:#fff; padding:20px; border-radius:12px; text-align:left; color:#334155; line-height:1.6;">
                                                ${severityDesc}
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Recommendations -->
                                    <div class="card">
                                        <div class="card-header">
                                            <h2 class="card-title">💡 Recommendations</h2>
                                        </div>
                                        <div class="card-content">
                                            <div class="recommendation">
                                                <div class="dot" style="background:var(--teal-500);"></div>
                                                <div>Practice daily mindfulness and meditation exercises</div>
                                            </div>
                                            <div class="recommendation">
                                                <div class="dot" style="background:var(--teal-500);"></div>
                                                <div>Maintain regular sleep schedule (7-9 hours per night)</div>
                                            </div>
                                            <div class="recommendation">
                                                <div class="dot" style="background:var(--teal-500);"></div>
                                                <div>Stay physically active with regular exercise</div>
                                            </div>

                                            <c:if test="${score >= 50}">
                                                <div class="recommendation">
                                                    <div class="dot" style="background:var(--orange-500);"></div>
                                                    <div>Consider reaching out to a counselor or therapist</div>
                                                </div>
                                            </c:if>

                                            <c:if test="${score >= 75}">
                                                <div class="recommendation">
                                                    <div class="dot" style="background:var(--red-500);"></div>
                                                    <div style="font-weight:600; color:var(--red-500);">Contact mental
                                                        health services immediately</div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div style="display:flex; gap:16px;">
                                        <a href="?role=${param.role}&type=${selectedType}" class="btn btn-outline">Take
                                            Another Assessment</a>
                                        <a href="${supportLink}" class="btn btn-primary">Get Support</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Form View -->
                                    <form action="${pageContext.request.contextPath}/self-assessment/submit"
                                        method="post">
                                        <input type="hidden" name="role" value="${param.role}" />
                                        <input type="hidden" name="type" value="${selectedType}" />

                                        <div class="card">
                                            <div class="card-header">
                                                <h2 class="card-title">📝 ${currentAssessment.title}</h2>
                                                <div class="card-desc">Over the last 2 weeks, how often have you
                                                    experienced the following:</div>
                                            </div>
                                            <div class="card-content">
                                                <c:forEach var="question" items="${currentAssessment.questions}"
                                                    varStatus="loop">
                                                    <div class="question-item">
                                                        <div class="question-text">${loop.index + 1}. ${question}?</div>
                                                        <div class="radio-grid">
                                                            <label class="radio-label">
                                                                <input type="radio" name="q${loop.index}" value="0"
                                                                    required>
                                                                Not at all
                                                            </label>
                                                            <label class="radio-label">
                                                                <input type="radio" name="q${loop.index}" value="1">
                                                                Several days
                                                            </label>
                                                            <label class="radio-label">
                                                                <input type="radio" name="q${loop.index}" value="2">
                                                                Often
                                                            </label>
                                                            <label class="radio-label">
                                                                <input type="radio" name="q${loop.index}" value="3">
                                                                Nearly daily
                                                            </label>
                                                        </div>
                                                    </div>
                                                </c:forEach>

                                                <button type="submit" class="btn btn-primary"
                                                    style="margin-top:12px;">Submit Assessment</button>
                                            </div>
                                        </div>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Side Info -->
                        <div class="side-col">
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">About These Assessments</h2>
                                </div>
                                <div class="card-content" style="font-size:14px; color:var(--gray-600);">
                                    <div style="margin-bottom:16px;">
                                        <strong style="color:var(--gray-900);">Confidentiality</strong><br>
                                        Your responses are private and secure using HIPAA-compliant standards.
                                    </div>
                                    <div style="margin-bottom:16px;">
                                        <strong style="color:var(--gray-900);">Not a Diagnosis</strong><br>
                                        These screenings are educational tools, not medical diagnoses.
                                    </div>
                                    <div
                                        style="border-top:1px solid var(--gray-200); padding-top:16px; margin-top:16px;">
                                        <strong style="color:var(--gray-900);">Need Help Now?</strong>
                                        <button class="btn"
                                            style="width:100%; background:#fee2e2; color:#ef4444; margin-top:8px;">Call
                                            988 - Crisis Line</button>
                                        <a href="${supportLink}" class="btn btn-outline" style="margin-top:8px;">Contact
                                            Counseling</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </body>

        </html>