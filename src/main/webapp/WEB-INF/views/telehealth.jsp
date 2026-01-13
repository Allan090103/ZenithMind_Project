<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Telehealth</title>
            <style>
                <%@ include file="professional-styles.jsp" %>.appt-item {
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
            </style>
        </head>

        <body>
            <div class="app-shell">
                <%@ include file="professional-sidebar.jsp" %>

                    <main class="dashboard">
                        <div class="page-header">
                            <div>
                                <h1 class="page-title">Telehealth & Appointments</h1>
                                <p class="page-subtitle">Manage virtual sessions and secure messaging</p>
                            </div>
                            <div style="display:flex; gap:12px;">
                                <button class="btn" style="background:#fff; border:1px solid var(--border);">View
                                    Calendar</button>
                                <button class="btn btn-primary">+ Schedule Session</button>
                            </div>
                        </div>

                        <div style="display:grid; grid-template-columns: 2fr 1fr; gap:24px;">
                            <!-- Today's Appointments -->
                            <div>
                                <div class="card">
                                    <div class="card-header">
                                        <h2 class="card-title">Active Appointments</h2>
                                        <span style="font-size:13px; color:var(--text);">
                                            <%= new java.text.SimpleDateFormat("MMMM dd, yyyy").format(new
                                                java.util.Date()) %>
                                        </span>
                                    </div>
                                    <div class="card-body" style="padding-top:0;">
                                        <c:forEach var="appt" items="${appointments}">
                                            <div class="appt-item">
                                                <div class="appt-time">
                                                    <div>${appt[4]}</div>
                                                    <div style="font-size:12px;color:#64748b;">${appt[0]}</div>
                                                </div>
                                                <div class="appt-info">
                                                    <span class="appt-name">${appt[1]}</span>
                                                    <span class="appt-type">${appt[2]} • ${appt[3]}</span>
                                                </div>
                                                <button class="btn btn-primary"
                                                    style="padding:8px 16px; font-size:13px;">Join Call</button>
                                                <button class="btn btn-ghost"
                                                    style="padding:8px 16px; font-size:13px;">Reschedule</button>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Secure Messaging -->
                                <div class="card">
                                    <div class="card-header">
                                        <h2 class="card-title">Secure Messages</h2>
                                        <span style="font-size:13px; color:var(--teal); font-weight:600;">3
                                            Unread</span>
                                    </div>
                                    <div class="card-body" style="padding-top:0;">
                                        <div style="display:flex; flex-direction:column; gap:16px;">
                                            <div style="padding:16px; border:1px solid var(--border); border-radius:12px; cursor:pointer; transition:all 0.2s;"
                                                onmouseover="this.style.background='#f8fafc'"
                                                onmouseout="this.style.background='white'">
                                                <div
                                                    style="display:flex; justify-content:space-between; margin-bottom:8px;">
                                                    <span style="font-weight:600; color:var(--dark);">Ahmad Ali</span>
                                                    <span style="font-size:12px; color:#64748b;">10 min ago</span>
                                                </div>
                                                <p
                                                    style="margin:0; font-size:14px; color:var(--text); line-height:1.5;">
                                                    Need to discuss my recent anxiety levels...</p>
                                                <span
                                                    style="display:inline-block; margin-top:8px; padding:4px 8px; background:var(--teal); color:white; border-radius:12px; font-size:11px; font-weight:600;">NEW</span>
                                            </div>
                                            <div style="padding:16px; border:1px solid var(--border); border-radius:12px; cursor:pointer; transition:all 0.2s;"
                                                onmouseover="this.style.background='#f8fafc'"
                                                onmouseout="this.style.background='white'">
                                                <div
                                                    style="display:flex; justify-content:space-between; margin-bottom:8px;">
                                                    <span style="font-weight:600; color:var(--dark);">Sarah Tan</span>
                                                    <span style="font-size:12px; color:#64748b;">2 hours ago</span>
                                                </div>
                                                <p
                                                    style="margin:0; font-size:14px; color:var(--text); line-height:1.5;">
                                                    Thank you for the resources you shared...</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Sidebar -->
                            <div>
                                <!-- Quick Actions -->
                                <div class="card"
                                    style="background:linear-gradient(135deg, #00b3c7, #01a0f9); color:white;">
                                    <div class="card-body">
                                        <h3 style="margin:0 0 16px; font-size:18px;">Quick Actions</h3>
                                        <div style="display:flex; flex-direction:column; gap:12px;">
                                            <button class="btn"
                                                style="background:rgba(255,255,255,0.2); color:white; width:100%; border:1px solid rgba(255,255,255,0.3);">Start
                                                Video Call</button>
                                            <button class="btn"
                                                style="background:rgba(255,255,255,0.2); color:white; width:100%; border:1px solid rgba(255,255,255,0.3);">Send
                                                Message</button>
                                            <button class="btn"
                                                style="background:rgba(255,255,255,0.2); color:white; width:100%; border:1px solid rgba(255,255,255,0.3);">View
                                                Calendar</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Session Stats -->
                                <div class="card">
                                    <div class="card-header">
                                        <h2 class="card-title">This Week</h2>
                                    </div>
                                    <div class="card-body">
                                        <div style="margin-bottom:16px;">
                                            <div style="font-size:13px; color:var(--text); margin-bottom:4px;">Sessions
                                                Completed</div>
                                            <div style="font-size:24px; font-weight:700; color:var(--dark);">12</div>
                                        </div>
                                        <div style="margin-bottom:16px;">
                                            <div style="font-size:13px; color:var(--text); margin-bottom:4px;">Upcoming
                                            </div>
                                            <div style="font-size:24px; font-weight:700; color:var(--dark);">8</div>
                                        </div>
                                        <div>
                                            <div style="font-size:13px; color:var(--text); margin-bottom:4px;">Average
                                                Duration</div>
                                            <div style="font-size:24px; font-weight:700; color:var(--dark);">45 min
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