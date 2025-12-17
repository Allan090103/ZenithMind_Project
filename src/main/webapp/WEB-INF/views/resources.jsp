<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>ZenithMind | Resources</title>
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
                                <h1 class="page-title">Resource Management</h1>
                                <p class="page-subtitle">Upload, manage, and assign mental health resources</p>
                            </div>
                            <div style="display:flex; gap:12px;">
                                <button class="btn" style="background:#fff; border:1px solid var(--border);">Import
                                    Resources</button>
                                <button class="btn btn-primary">+ Upload New Resource</button>
                            </div>
                        </div>

                        <!-- Resource Stats -->
                        <div style="display:grid; grid-template-columns: repeat(4, 1fr); gap:16px; margin-bottom:24px;">
                            <div class="stat-card">
                                <div class="stat-label">Total Resources</div>
                                <div class="stat-value">48</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Downloads This Month</div>
                                <div class="stat-value">342</div>
                                <div class="stat-trend"><span>↑</span> 28% increase</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Most Popular</div>
                                <div class="stat-value" style="font-size:16px;">Stress Guide</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Avg. Rating</div>
                                <div class="stat-value">4.7</div>
                                <div style="color:#f59e0b; font-size:14px;">★★★★★</div>
                            </div>
                        </div>

                        <!-- Resource Library -->
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Resource Library</h2>
                                <div style="display:flex; gap:12px;">
                                    <select
                                        style="padding:8px 12px; border:1px solid var(--border); border-radius:8px; font-size:13px;">
                                        <option>All Types</option>
                                        <option>PDF Documents</option>
                                        <option>Videos</option>
                                        <option>Articles</option>
                                        <option>Worksheets</option>
                                    </select>
                                    <input type="text" placeholder="Search resources..."
                                        style="padding:8px 16px; border:1px solid var(--border); border-radius:8px; font-size:13px; width:250px;">
                                </div>
                            </div>
                            <div class="card-body">
                                <div style="display:grid; grid-template-columns: repeat(3, 1fr); gap:20px;">
                                    <c:forEach var="res" items="${resources}">
                                        <div style="border:1px solid var(--border); padding:20px; border-radius:12px; transition:all 0.2s; cursor:pointer;"
                                            onmouseover="this.style.boxShadow='0 4px 12px rgba(0,0,0,0.1)'"
                                            onmouseout="this.style.boxShadow='none'">
                                            <div
                                                style="width:100%; height:120px; background:linear-gradient(135deg, #e0f2fe, #dbeafe); border-radius:8px; display:flex; align-items:center; justify-content:center; margin-bottom:16px;">
                                                <span style="font-size:48px;">📄</span>
                                            </div>
                                            <div
                                                style="font-weight:600; font-size:15px; margin-bottom:8px; color:var(--dark);">
                                                ${res[0]}</div>
                                            <div style="font-size:12px; color:#64748b; margin-bottom:12px;">${res[1]} •
                                                ${res[2]}</div>
                                            <div style="font-size:12px; color:#64748b; margin-bottom:16px;">
                                                <span style="color:var(--teal); font-weight:600;">${res[3]}</span>
                                            </div>
                                            <div style="display:flex; gap:8px;">
                                                <button class="btn btn-primary"
                                                    style="flex:1; padding:8px; font-size:12px;">Assign</button>
                                                <button class="btn btn-ghost"
                                                    style="padding:8px 12px; font-size:12px;">Edit</button>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <!-- Add more sample resources -->
                                    <div style="border:1px solid var(--border); padding:20px; border-radius:12px; transition:all 0.2s; cursor:pointer;"
                                        onmouseover="this.style.boxShadow='0 4px 12px rgba(0,0,0,0.1)'"
                                        onmouseout="this.style.boxShadow='none'">
                                        <div
                                            style="width:100%; height:120px; background:linear-gradient(135deg, #fef3c7, #fde68a); border-radius:8px; display:flex; align-items:center; justify-content:center; margin-bottom:16px;">
                                            <span style="font-size:48px;">🎥</span>
                                        </div>
                                        <div
                                            style="font-weight:600; font-size:15px; margin-bottom:8px; color:var(--dark);">
                                            Breathing Exercises</div>
                                        <div style="font-size:12px; color:#64748b; margin-bottom:12px;">Video • 10 mins
                                        </div>
                                        <div style="font-size:12px; color:#64748b; margin-bottom:16px;">
                                            <span style="color:var(--teal); font-weight:600;">156 Views</span>
                                        </div>
                                        <div style="display:flex; gap:8px;">
                                            <button class="btn btn-primary"
                                                style="flex:1; padding:8px; font-size:12px;">Assign</button>
                                            <button class="btn btn-ghost"
                                                style="padding:8px 12px; font-size:12px;">Edit</button>
                                        </div>
                                    </div>

                                    <div style="border:1px solid var(--border); padding:20px; border-radius:12px; transition:all 0.2s; cursor:pointer;"
                                        onmouseover="this.style.boxShadow='0 4px 12px rgba(0,0,0,0.1)'"
                                        onmouseout="this.style.boxShadow='none'">
                                        <div
                                            style="width:100%; height:120px; background:linear-gradient(135deg, #fce7f3, #fbcfe8); border-radius:8px; display:flex; align-items:center; justify-content:center; margin-bottom:16px;">
                                            <span style="font-size:48px;">📝</span>
                                        </div>
                                        <div
                                            style="font-weight:600; font-size:15px; margin-bottom:8px; color:var(--dark);">
                                            Anxiety Worksheet</div>
                                        <div style="font-size:12px; color:#64748b; margin-bottom:12px;">PDF • 2 pages
                                        </div>
                                        <div style="font-size:12px; color:#64748b; margin-bottom:16px;">
                                            <span style="color:var(--teal); font-weight:600;">89 Downloads</span>
                                        </div>
                                        <div style="display:flex; gap:8px;">
                                            <button class="btn btn-primary"
                                                style="flex:1; padding:8px; font-size:12px;">Assign</button>
                                            <button class="btn btn-ghost"
                                                style="padding:8px 12px; font-size:12px;">Edit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Recently Assigned -->
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Recently Assigned Resources</h2>
                            </div>
                            <div class="card-body" style="padding-top:0;">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Resource</th>
                                            <th>Assigned To</th>
                                            <th>Date Assigned</th>
                                            <th>Status</th>
                                            <th>Completion</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="font-weight:600;">Coping with Exam Stress</td>
                                            <td>Ahmad Ali</td>
                                            <td style="font-size:13px; color:#64748b;">Dec 15, 2025</td>
                                            <td><span style="color:#15803d;">✓ Completed</span></td>
                                            <td><span style="font-weight:600; color:var(--teal);">100%</span></td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight:600;">Mindfulness Guide</td>
                                            <td>Sarah Tan</td>
                                            <td style="font-size:13px; color:#64748b;">Dec 16, 2025</td>
                                            <td><span style="color:#b45309;">⏳ In Progress</span></td>
                                            <td><span style="font-weight:600; color:var(--teal);">45%</span></td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight:600;">Sleep Hygiene 101</td>
                                            <td>Mei Ling</td>
                                            <td style="font-size:13px; color:#64748b;">Dec 17, 2025</td>
                                            <td><span style="color:#64748b;">○ Not Started</span></td>
                                            <td><span style="font-weight:600; color:#64748b;">0%</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </main>
            </div>
        </body>

        </html>