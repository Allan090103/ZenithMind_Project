<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Case Management</title>
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
                                <h1 class="page-title">Student Case Management</h1>
                                <p class="page-subtitle">Manage and monitor student cases with comprehensive tracking
                                </p>
                            </div>
                            <div style="display:flex; gap:12px;">
                                <button class="btn" style="background:#fff; border:1px solid var(--border);">Export
                                    Report</button>
                                <button class="btn btn-primary">+ Add New Case</button>
                            </div>
                        </div>

                        <!-- Filter Bar -->
                        <div class="card" style="margin-bottom:24px;">
                            <div class="card-body" style="padding:16px 24px;">
                                <div style="display:flex; gap:16px; align-items:center;">
                                    <div style="flex:1;">
                                        <input type="text" placeholder="Search students..."
                                            style="width:100%; padding:10px 16px; border:1px solid var(--border); border-radius:8px; font-size:14px;">
                                    </div>
                                    <select
                                        style="padding:10px 16px; border:1px solid var(--border); border-radius:8px; font-size:14px;">
                                        <option>All Risk Levels</option>
                                        <option>High Risk</option>
                                        <option>Moderate Risk</option>
                                        <option>Low Risk</option>
                                    </select>
                                    <select
                                        style="padding:10px 16px; border:1px solid var(--border); border-radius:8px; font-size:14px;">
                                        <option>All Status</option>
                                        <option>Active</option>
                                        <option>Monitoring</option>
                                        <option>Critical</option>
                                        <option>Stable</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Case List -->
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Active Cases (${assignedStudents.length})</h2>
                            </div>
                            <div class="card-body" style="padding-top:0;">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Student Name</th>
                                            <th>Risk Level</th>
                                            <th>Status</th>
                                            <th>Last Session</th>
                                            <th>Next Appointment</th>
                                            <th>Notes</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${assignedStudents}">
                                            <tr>
                                                <td>#${student[0]}</td>
                                                <td>
                                                    <div style="display:flex; align-items:center; gap:12px;">
                                                        <div
                                                            style="width:36px; height:36px; border-radius:50%; background:#e0f2fe; display:flex; align-items:center; justify-content:center; font-weight:700; color:#0284c7;">
                                                            ${student[1].substring(0,1)}
                                                        </div>
                                                        <span
                                                            style="font-weight:600; color:var(--dark);">${student[1]}</span>
                                                    </div>
                                                </td>
                                                <td><span class="status-pill status-${student[2]}">${student[2]}</span>
                                                </td>
                                                <td style="color:var(--text);">${student[3]}</td>
                                                <td style="font-size:13px; color:#64748b;">Dec 15, 2025</td>
                                                <td style="font-size:13px; color:#64748b;">Dec 20, 2025</td>
                                                <td
                                                    style="font-size:13px; color:#64748b; max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                                                    ${student[4]}</td>
                                                <td>
                                                    <div style="display:flex; gap:8px;">
                                                        <a href="#" class="btn btn-ghost"
                                                            style="padding:6px 12px; font-size:12px;">View</a>
                                                        <a href="#" class="btn btn-ghost"
                                                            style="padding:6px 12px; font-size:12px;">Notes</a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Quick Stats -->
                        <div style="display:grid; grid-template-columns: repeat(4, 1fr); gap:16px; margin-top:24px;">
                            <div class="stat-card">
                                <div class="stat-label">Total Cases</div>
                                <div class="stat-value">24</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">High Risk</div>
                                <div class="stat-value" style="color:#ef4444;">5</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Active Sessions</div>
                                <div class="stat-value">12</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Resolved This Month</div>
                                <div class="stat-value" style="color:#15803d;">8</div>
                            </div>
                        </div>
                    </main>
            </div>
        </body>

        </html>