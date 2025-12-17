<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Patient Monitoring</title>
            <style>
                <%@ include file="professional-styles.jsp" %>
            </style>
        </head>

        <body>
            <div class="app-shell">
                <%@ include file="professional-sidebar.jsp" %>

                    <main class="dashboard">
                        <div class="page-header">
                            <div>
                                <h1 class="page-title">Patient Monitoring</h1>
                                <p class="page-subtitle">Track student progress and mental health trends</p>
                            </div>
                            <div style="display:flex; gap:12px;">
                                <button class="btn" style="background:#fff; border:1px solid var(--border);">Export
                                    Data</button>
                                <button class="btn btn-primary">Generate Report</button>
                            </div>
                        </div>

                        <!-- Overview Stats -->
                        <div style="display:grid; grid-template-columns: repeat(4, 1fr); gap:16px; margin-bottom:24px;">
                            <div class="stat-card">
                                <div class="stat-label">Students Monitored</div>
                                <div class="stat-value">24</div>
                                <div class="stat-trend"><span>↑</span> 2 this week</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Avg. Mood Score</div>
                                <div class="stat-value">7.2</div>
                                <div class="stat-trend"><span>↑</span> 0.5 improvement</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Module Completion</div>
                                <div class="stat-value">68%</div>
                                <div class="stat-trend"><span>↑</span> 12% increase</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">At-Risk Students</div>
                                <div class="stat-value" style="color:#ef4444;">5</div>
                                <div class="stat-trend" style="color:#ef4444;">Needs attention</div>
                            </div>
                        </div>

                        <div style="display:grid; grid-template-columns: 2fr 1fr; gap:24px;">
                            <!-- Mood Trends Chart -->
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Mood Trends (Last 30 Days)</h2>
                                    <select
                                        style="padding:6px 12px; border:1px solid var(--border); border-radius:8px; font-size:13px;">
                                        <option>All Students</option>
                                        <option>High Risk Only</option>
                                        <option>Individual Student</option>
                                    </select>
                                </div>
                                <div class="card-body">
                                    <div
                                        style="height:300px; background:linear-gradient(180deg, #f0fdfa 0%, white 100%); border-radius:12px; display:flex; align-items:center; justify-content:center; border:2px dashed var(--border);">
                                        <div style="text-align:center; color:#64748b;">
                                            <div style="font-size:48px; margin-bottom:12px;">📊</div>
                                            <div style="font-weight:600;">Mood Trend Chart</div>
                                            <div style="font-size:13px; margin-top:4px;">Interactive chart showing mood
                                                patterns</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- AI Insights -->
                            <div>
                                <div class="card"
                                    style="background:linear-gradient(135deg, #1e293b, #0f172a); color:white;">
                                    <div class="card-body">
                                        <div
                                            style="font-size:12px; text-transform:uppercase; letter-spacing:1px; opacity:0.7; margin-bottom:8px;">
                                            AI Insights</div>
                                        <h3 style="margin:0 0 12px; font-size:18px;">5 students showing improvement</h3>
                                        <p style="font-size:14px; opacity:0.8; line-height:1.5; margin-bottom:16px;">
                                            Stress levels decreased by 15% average after implementing mindfulness
                                            modules.
                                        </p>
                                        <button class="btn"
                                            style="background:rgba(255,255,255,0.1); color:#fff; width:100%;">View
                                            Details</button>
                                    </div>
                                </div>

                                <div class="card">
                                    <div class="card-header">
                                        <h2 class="card-title">Recent Activity</h2>
                                    </div>
                                    <div class="card-body" style="padding-top:0;">
                                        <div style="display:flex; flex-direction:column; gap:16px;">
                                            <div style="padding-bottom:16px; border-bottom:1px solid var(--border);">
                                                <div
                                                    style="font-weight:600; font-size:13px; color:var(--dark); margin-bottom:4px;">
                                                    Ahmad Ali</div>
                                                <div style="font-size:12px; color:#64748b;">Completed "Stress
                                                    Management" module</div>
                                                <div style="font-size:11px; color:#64748b; margin-top:4px;">2 hours ago
                                                </div>
                                            </div>
                                            <div style="padding-bottom:16px; border-bottom:1px solid var(--border);">
                                                <div
                                                    style="font-weight:600; font-size:13px; color:var(--dark); margin-bottom:4px;">
                                                    Sarah Tan</div>
                                                <div style="font-size:12px; color:#64748b;">Logged mood check-in: 8/10
                                                </div>
                                                <div style="font-size:11px; color:#64748b; margin-top:4px;">5 hours ago
                                                </div>
                                            </div>
                                            <div>
                                                <div
                                                    style="font-weight:600; font-size:13px; color:var(--dark); margin-bottom:4px;">
                                                    Mei Ling</div>
                                                <div style="font-size:12px; color:#64748b;">Attended telehealth session
                                                </div>
                                                <div style="font-size:11px; color:#64748b; margin-top:4px;">1 day ago
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Module Completion Table -->
                        <div class="card" style="margin-top:24px;">
                            <div class="card-header">
                                <h2 class="card-title">Module Completion Progress</h2>
                            </div>
                            <div class="card-body" style="padding-top:0;">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Student</th>
                                            <th>Stress Management</th>
                                            <th>Anxiety Relief</th>
                                            <th>Mindfulness</th>
                                            <th>Sleep Hygiene</th>
                                            <th>Overall Progress</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${assignedStudents}" end="4">
                                            <tr>
                                                <td style="font-weight:600;">${student[1]}</td>
                                                <td><span style="color:#15803d;">✓ Complete</span></td>
                                                <td><span style="color:#b45309;">⏳ In Progress</span></td>
                                                <td><span style="color:#15803d;">✓ Complete</span></td>
                                                <td><span style="color:#64748b;">○ Not Started</span></td>
                                                <td><span style="font-weight:600; color:var(--teal);">65%</span></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>
            </div>
        </body>

        </html>