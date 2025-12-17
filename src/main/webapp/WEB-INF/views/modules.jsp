<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Learning Modules</title>
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

                .modules-page {
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

                .back-link {
                    text-decoration: none;
                    color: var(--teal);
                    font-weight: 600;
                    font-size: 14px;
                    margin-bottom: 8px;
                    display: inline-block;
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

                .summary {
                    display: flex;
                    gap: 20px;
                    margin-bottom: 32px;
                }

                .summary-card {
                    background: #fff;
                    padding: 20px 24px;
                    border-radius: 16px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
                    display: flex;
                    align-items: center;
                    gap: 16px;
                    flex: 1;
                }

                .summary-card .value {
                    font-size: 32px;
                    font-weight: 700;
                    color: var(--dark);
                }

                .summary-card .label {
                    font-size: 14px;
                    color: var(--text);
                }

                .modules-heading {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 24px;
                }

                .modules-heading h2 {
                    margin: 0;
                    color: var(--dark);
                }

                .modules-grid {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 24px;
                }

                .module-card {
                    background: #fff;
                    border-radius: 20px;
                    padding: 24px;
                    display: flex;
                    flex-direction: column;
                    gap: 16px;
                    transition: transform 0.2s, box-shadow 0.2s;
                    border: 1px solid transparent;
                }

                .module-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.06);
                    border-color: rgba(0, 179, 199, 0.3);
                }

                .module-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                }

                .module-icon {
                    width: 48px;
                    height: 48px;
                    background: #f0fdf4;
                    border-radius: 12px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 24px;
                }

                .status-pill {
                    padding: 6px 12px;
                    border-radius: 20px;
                    font-size: 11px;
                    font-weight: 700;
                    text-transform: uppercase;
                }

                .status-done {
                    background: #dcfce7;
                    color: #166534;
                }

                .status-progress {
                    background: #dbeafe;
                    color: #1e40af;
                }

                .status-start {
                    background: #f3f4f6;
                    color: #374151;
                }

                .module-title {
                    font-size: 18px;
                    font-weight: 700;
                    color: var(--dark);
                    margin-bottom: 6px;
                }

                .module-desc {
                    font-size: 14px;
                    color: #64748b;
                    line-height: 1.5;
                }

                .module-meta {
                    display: flex;
                    gap: 16px;
                    font-size: 13px;
                    font-weight: 500;
                    color: #94a3b8;
                }

                .progress-track {
                    height: 6px;
                    background: #f1f5f9;
                    border-radius: 3px;
                    overflow: hidden;
                }

                .progress-fill {
                    height: 100%;
                    background: #00b3c7;
                    border-radius: 3px;
                }

                .module-action {
                    text-decoration: none;
                    display: block;
                    text-align: center;
                    padding: 12px;
                    background: #0f172a;
                    color: #fff;
                    border-radius: 12px;
                    font-weight: 600;
                    font-size: 14px;
                    transition: background 0.2s;
                }

                .module-action:hover {
                    background: #1e293b;
                }

                /* Detail View Styles */
                .detail-progress {
                    background: #fff;
                    padding: 20px;
                    border-radius: 16px;
                    margin-bottom: 24px;
                }

                .detail-progress-bar {
                    height: 10px;
                    background: #f1f5f9;
                    border-radius: 5px;
                    margin-top: 10px;
                    overflow: hidden;
                }

                .detail-progress-bar span {
                    display: block;
                    height: 100%;
                    background: #00b3c7;
                }

                .section-tabs {
                    display: flex;
                    gap: 12px;
                    overflow-x: auto;
                    padding-bottom: 12px;
                    margin-bottom: 24px;
                }

                .section-tab {
                    background: #fff;
                    border: 1px solid #e2e8f0;
                    border-radius: 12px;
                    padding: 12px 20px;
                    font-weight: 600;
                    color: #64748b;
                    cursor: pointer;
                    white-space: nowrap;
                }

                .section-tab.active {
                    background: #00b3c7;
                    color: #fff;
                    border-color: #00b3c7;
                }

                .detail-card {
                    background: #fff;
                    padding: 32px;
                    border-radius: 20px;
                }

                .video-placeholder {
                    aspect-ratio: 16/9;
                    background: #0f172a;
                    border-radius: 16px;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    color: #fff;
                    margin: 24px 0;
                }

                .detail-actions {
                    display: flex;
                    justify-content: space-between;
                    margin-top: 24px;
                }

                .detail-actions button {
                    padding: 12px 24px;
                    border-radius: 12px;
                    border: none;
                    font-weight: 600;
                    cursor: pointer;
                }

                .detail-actions .prev {
                    background: #f1f5f9;
                    color: #475569;
                }

                .detail-actions .next {
                    background: #00b3c7;
                    color: #fff;
                }

                @media (max-width: 1080px) {
                    .app-shell {
                        flex-direction: column;
                    }

                    .sidebar {
                        width: 100%;
                    }

                    .modules-grid {
                        grid-template-columns: 1fr;
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
                        <div class="avatar">${avatarInitial}</div>
                        <div class="name">${name}</div>
                        <div class="email">${email}</div>
                        <div class="dept">${department}</div>
                        <span class="badge">${roleTitle}</span>
                    </div>

                    <nav>
                        <a href="${dashboardLink}"><span class="icon">D</span>Dashboard</a>
                        <a class="active" href="${modulesLink}"><span class="icon">LM</span>Learning Modules</a>
                        <a href="${selfAssessmentLink}"><span class="icon">SA</span>Self Assessment</a>
                        <a href="${moodLink}"><span class="icon">MT</span>Mood Tracker</a>
                        <a href="${supportLink}"><span class="icon">VS</span>Virtual Support</a>
                        <a href="${communityLink}"><span class="icon">CF</span>Community Forum</a>
                        <a href="#"><span class="icon">PS</span>Profile Settings</a>
                    </nav>
                </aside>

                <main class="modules-page">
                    <div class="top-bar">
                        <div style="width:100%;">
                            <c:choose>
                                <c:when test="${showDetail}">
                                    <a class="back-link" href="${modulesLink}">← Back to Modules</a>
                                    <h1>${activeModule.title}</h1>
                                    <p style="margin:0;color:#7c8b9e;">${activeModule.description}</p>
                                </c:when>
                                <c:otherwise>
                                    <p style="margin:0;font-size:14px;color:#7c8b9e;">Expand your knowledge with
                                        interactive lessons</p>
                                    <h1>Learning Modules 📚</h1>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="search">
                            <input type="text" placeholder="Search for modules, resources, or support...">
                            <div class="score-pill">Wellness Score: <strong>${score} / 100</strong></div>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${showDetail}">
                            <span class="duration-pill">${activeModule.duration}</span>
                            <div class="detail-progress">
                                <div style="display:flex;justify-content:space-between;font-size:13px;font-weight:600;">
                                    <span>Module Progress</span>
                                    <span>Section ${activeModule.currentSection} of
                                        ${activeModule.sections.length}</span>
                                </div>
                                <div class="detail-progress-bar">
                                    <span style="width:${activeModule.progress}%"></span>
                                </div>
                            </div>

                            <div class="section-tabs">
                                <c:forEach var="sectionTitle" items="${activeModule.sections}" varStatus="loop">
                                    <button
                                        class="section-tab ${loop.index + 1 == activeModule.currentSection ? 'active' : ''}">
                                        ${sectionTitle}
                                    </button>
                                </c:forEach>
                            </div>

                            <div class="detail-card">
                                <h3 style="margin:0;color:var(--dark);">
                                    ${activeModule.sections[activeModule.currentSection - 1]}</h3>
                                <div class="video-placeholder">
                                    <div style="font-size:36px;margin-bottom:10px;">▶</div>
                                    <div>Video Player</div>
                                    <div style="font-size:13px;font-weight:400;">Video content would play here</div>
                                </div>
                                <div class="detail-actions">
                                    <button class="prev" ${activeModule.currentSection==1 ? 'disabled' : ''
                                        }>Previous</button>
                                    <button class="next">${activeModule.currentSection == activeModule.sections.length ?
                                        'Finish' : 'Next'}</button>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="summary">
                                <div class="summary-card">
                                    <div class="value">${modules.size()}</div>
                                    <div class="label">Total Modules</div>
                                </div>
                                <div class="summary-card">
                                    <div class="value">${completedCount}</div>
                                    <div class="label">Completed</div>
                                </div>
                                <div class="summary-card">
                                    <div class="value">${inProgressCount}</div>
                                    <div class="label">In Progress</div>
                                </div>
                            </div>

                            <div class="modules-heading">
                                <h2>Browse Modules</h2>
                                <div class="modules-search">
                                    <input type="text" placeholder="Search modules by title or topic...">
                                </div>
                            </div>

                            <div class="modules-grid">
                                <c:forEach var="module" items="${modules}">
                                    <c:set var="pillClass" value="status-start" />
                                    <c:set var="pillLabel" value="Start" />
                                    <c:if test="${module.status == 'done'}">
                                        <c:set var="pillClass" value="status-done" />
                                        <c:set var="pillLabel" value="Done" />
                                    </c:if>
                                    <c:if test="${module.status == 'progress'}">
                                        <c:set var="pillClass" value="status-progress" />
                                        <c:set var="pillLabel" value="In Progress" />
                                    </c:if>

                                    <div class="module-card">
                                        <div class="module-header">
                                            <div class="module-icon">${module.icon}</div>
                                            <span class="status-pill ${pillClass}">${pillLabel}</span>
                                        </div>
                                        <div>
                                            <div class="module-title">${module.title}</div>
                                            <div class="module-desc">${module.description}</div>
                                        </div>
                                        <div class="module-meta">
                                            <span>${module.duration}</span>
                                            <span>${module.points} pts</span>
                                        </div>
                                        <div class="progress-track">
                                            <div class="progress-fill" style="width:${module.progress}%"></div>
                                        </div>
                                        <a class="module-action"
                                            href="modules?module=${module.slug}&role=${param.role}">
                                            ${module.buttonLabel}
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </main>
            </div>
        </body>

        </html>