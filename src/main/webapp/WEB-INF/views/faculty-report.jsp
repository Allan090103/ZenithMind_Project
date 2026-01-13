<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Report Concern</title>
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
                        <span class="badge">Faculty Member</span>
                    </div>

                    <nav>
                        <a href="${dashboardLink}"><span class="icon">D</span>Dashboard</a>
                        <a href="/faculty/training?role=faculty"><span class="icon">TR</span>Training Modules</a>
                        <a href="/faculty/guides?role=faculty"><span class="icon">QG</span>Quick Guides</a>
                        <a href="/faculty/report?role=faculty" class="active"><span class="icon">CR</span>Report
                            Concern</a>
                        <a href="${communityLink}"><span class="icon">CF</span>Community</a>
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
                    <c:choose>
                        <c:when test="${submitted}">
                            <!-- Confirmation View -->
                            <div style="max-width:600px; margin:80px auto; text-align:center;">
                                <div
                                    style="width:80px; height:80px; background:#dcfce7; border-radius:50%; display:flex; align-items:center; justify-content:center; margin:0 auto 24px; font-size:40px;">
                                    ✓</div>
                                <h1 style="font-size:32px; color:var(--dark); margin:0 0 16px;">Report Submitted
                                    Successfully</h1>
                                <p style="font-size:16px; color:#64748b; margin-bottom:24px;">Your concern has been
                                    securely forwarded to mental health professionals.</p>

                                <div class="card" style="text-align:left; margin-bottom:24px;">
                                    <div class="card-body">
                                        <div style="margin-bottom:16px;">
                                            <div style="font-size:13px; color:#64748b; margin-bottom:4px;">Reference
                                                Number</div>
                                            <div
                                                style="font-size:20px; font-weight:700; color:var(--teal); font-family:monospace;">
                                                ${confirmationId}</div>
                                        </div>
                                        <div
                                            style="padding:16px; background:#fffbeb; border-radius:8px; font-size:14px; color:#78350f; line-height:1.6;">
                                            <strong>What happens next:</strong><br>
                                            A mental health professional will review your report within 24 hours and
                                            take appropriate action. You will not receive updates about the student's
                                            case to maintain confidentiality.
                                        </div>
                                    </div>
                                </div>

                                <div style="display:flex; gap:12px; justify-content:center;">
                                    <a href="/faculty/report?role=faculty" class="btn btn-outline">Submit Another
                                        Report</a>
                                    <a href="${dashboardLink}" class="btn btn-primary">Return to Dashboard</a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Report Form -->
                            <div class="page-header">
                                <div>
                                    <h1 class="page-title">Report a Student Concern</h1>
                                    <p class="page-subtitle">Confidentially refer students who may need professional
                                        support</p>
                                </div>
                            </div>

                            <!-- Important Notice -->
                            <div class="card" style="background:#fef2f2; border:2px solid #fca5a5; margin-bottom:24px;">
                                <div class="card-body">
                                    <div style="display:flex; gap:16px; align-items:start;">
                                        <div style="font-size:32px;">🔒</div>
                                        <div>
                                            <h3 style="margin:0 0 8px; color:#dc2626; font-size:16px;">Confidentiality &
                                                Privacy</h3>
                                            <p style="margin:0; color:#991b1b; font-size:14px; line-height:1.6;">
                                                This report is confidential and will only be shared with authorized
                                                mental health professionals. You do not have access to student personal
                                                records. All information provided will be handled according to privacy
                                                regulations.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div style="display:grid; grid-template-columns: 2fr 1fr; gap:24px;">
                                <!-- Report Form -->
                                <div class="card">
                                    <div class="card-header">
                                        <h2 class="card-title">Concern Details</h2>
                                    </div>
                                    <div class="card-body">
                                        <form action="${pageContext.request.contextPath}/faculty/report/submit"
                                            method="post">
                                            <input type="hidden" name="role" value="faculty">

                                            <div style="margin-bottom:20px;">
                                                <label
                                                    style="display:block; font-weight:600; margin-bottom:8px; color:var(--dark);">Student
                                                    Name (Optional)</label>
                                                <input type="text" name="studentName"
                                                    placeholder="Enter student name or leave blank for anonymous report"
                                                    style="width:100%; padding:12px; border:1px solid var(--border); border-radius:8px; font-size:14px;">
                                                <div style="font-size:12px; color:#64748b; margin-top:4px;">If you don't
                                                    know the student's name, provide a description in the concern
                                                    details below.</div>
                                            </div>

                                            <div style="margin-bottom:20px;">
                                                <label
                                                    style="display:block; font-weight:600; margin-bottom:8px; color:var(--dark);">Type
                                                    of Concern *</label>
                                                <select name="concernType" required
                                                    style="width:100%; padding:12px; border:1px solid var(--border); border-radius:8px; font-size:14px;">
                                                    <option value="">Select concern type...</option>
                                                    <option value="mental-health">Mental Health / Emotional Distress
                                                    </option>
                                                    <option value="self-harm">Self-Harm or Suicidal Ideation</option>
                                                    <option value="substance">Substance Abuse</option>
                                                    <option value="behavioral">Concerning Behavioral Changes</option>
                                                    <option value="academic">Academic Decline</option>
                                                    <option value="other">Other</option>
                                                </select>
                                            </div>

                                            <div style="margin-bottom:20px;">
                                                <label
                                                    style="display:block; font-weight:600; margin-bottom:8px; color:var(--dark);">Urgency
                                                    Level *</label>
                                                <div
                                                    style="display:grid; grid-template-columns: repeat(3, 1fr); gap:12px;">
                                                    <label
                                                        style="padding:12px; border:2px solid var(--border); border-radius:8px; cursor:pointer; text-align:center; transition:all 0.2s;"
                                                        onmouseover="this.style.borderColor='#22c55e'"
                                                        onmouseout="this.style.borderColor='var(--border)'">
                                                        <input type="radio" name="urgency" value="low" required
                                                            style="margin-right:8px;">
                                                        <span style="font-weight:600; color:#15803d;">Low</span>
                                                    </label>
                                                    <label
                                                        style="padding:12px; border:2px solid var(--border); border-radius:8px; cursor:pointer; text-align:center; transition:all 0.2s;"
                                                        onmouseover="this.style.borderColor='#f59e0b'"
                                                        onmouseout="this.style.borderColor='var(--border)'">
                                                        <input type="radio" name="urgency" value="medium" required
                                                            style="margin-right:8px;">
                                                        <span style="font-weight:600; color:#b45309;">Medium</span>
                                                    </label>
                                                    <label
                                                        style="padding:12px; border:2px solid var(--border); border-radius:8px; cursor:pointer; text-align:center; transition:all 0.2s;"
                                                        onmouseover="this.style.borderColor='#ef4444'"
                                                        onmouseout="this.style.borderColor='var(--border)'">
                                                        <input type="radio" name="urgency" value="high" required
                                                            style="margin-right:8px;">
                                                        <span style="font-weight:600; color:#dc2626;">High</span>
                                                    </label>
                                                </div>
                                            </div>

                                            <div style="margin-bottom:24px;">
                                                <label
                                                    style="display:block; font-weight:600; margin-bottom:8px; color:var(--dark);">Describe
                                                    Your Concern *</label>
                                                <textarea name="description" required rows="8"
                                                    placeholder="Please provide specific observations, behaviors, or statements that concern you. Include dates and context if possible."
                                                    style="width:100%; padding:12px; border:1px solid var(--border); border-radius:8px; font-size:14px; font-family:inherit; resize:vertical;"></textarea>
                                                <div style="font-size:12px; color:#64748b; margin-top:4px;">Be as
                                                    specific as possible while maintaining objectivity.</div>
                                            </div>

                                            <button type="submit" class="btn btn-primary"
                                                style="width:100%; padding:14px;">Submit Confidential Report</button>
                                        </form>
                                    </div>
                                </div>

                                <!-- Sidebar Info -->
                                <div>
                                    <div class="card" style="background:#fffbeb; border:2px solid #fbbf24;">
                                        <div class="card-body">
                                            <h3 style="margin:0 0 12px; color:#b45309; font-size:16px;">📋 Reporting
                                                Guidelines</h3>
                                            <ul
                                                style="margin:0; padding-left:20px; font-size:13px; color:#78350f; line-height:1.8;">
                                                <li>Report any student who may be at risk</li>
                                                <li>Trust your instincts - it's better to report</li>
                                                <li>Provide factual observations, not diagnoses</li>
                                                <li>Include specific examples when possible</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="card" style="background:#dcfce7; border:2px solid #22c55e;">
                                        <div class="card-body">
                                            <h3 style="margin:0 0 12px; color:#15803d; font-size:16px;">✅ You're Doing
                                                the Right Thing</h3>
                                            <p style="margin:0; font-size:13px; color:#166534; line-height:1.6;">
                                                By reporting your concern, you're helping ensure students get the
                                                support they need. Thank you for caring about student wellbeing.
                                            </p>
                                        </div>
                                    </div>

                                    <div class="card" style="background:#fef2f2; border:2px solid #ef4444;">
                                        <div class="card-body">
                                            <h3 style="margin:0 0 12px; color:#dc2626; font-size:16px;">🚨 Emergency?
                                            </h3>
                                            <p style="margin:0 0 12px; font-size:13px; color:#991b1b; line-height:1.6;">
                                                If a student is in immediate danger:
                                            </p>
                                            <button class="btn"
                                                style="width:100%; background:#dc2626; color:white; margin-bottom:8px;">Call
                                                Campus Security: ext. 911</button>
                                            <button class="btn"
                                                style="width:100%; background:#dc2626; color:white;">Call Emergency:
                                                911</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </main>
            </div>
        </body>

        </html>