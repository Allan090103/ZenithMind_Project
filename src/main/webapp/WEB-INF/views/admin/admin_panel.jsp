<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Admin Panel</title>
    <%@ include file="../common/admin_styles.jsp" %>
</head>

<body>
    <% request.setAttribute("activePage", "panel" ); %>
        <div class="app-shell">
            <%@ include file="../common/admin_sidebar.jsp" %>

                <main class="dashboard">
                    <div class="top-bar">
                        <div class="welcome">
                            <p>Admin Control Panel</p>
                            <h1>System Overview</h1>
                        </div>
                    </div>

                    <div class="card">
                        <h2>Admin Panel</h2>
                        <p>Centralized control center for managing the ZenithMind platform.</p>

                        <div
                            style="margin-top: 30px; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px;">
                            <div
                                style="padding: 20px; background: rgba(0, 179, 199, 0.08); border-radius: 12px; border-left: 4px solid var(--teal);">
                                <h3 style="margin-top: 0; font-size: 16px;">Quick Actions</h3>
                                <ul style="padding-left: 20px; line-height: 2;">
                                    <li>View system logs</li>
                                    <li>Manage configurations</li>
                                    <li>System backups</li>
                                    <li>Database management</li>
                                </ul>
                            </div>

                            <div
                                style="padding: 20px; background: rgba(16, 185, 129, 0.08); border-radius: 12px; border-left: 4px solid var(--admin-success);">
                                <h3 style="margin-top: 0; font-size: 16px;">System Status</h3>
                                <p style="margin: 10px 0;"><strong>Status:</strong> <span
                                        style="color: var(--admin-success);">● Online</span></p>
                                <p style="margin: 10px 0;"><strong>Uptime:</strong> 99.9%</p>
                                <p style="margin: 10px 0;"><strong>Server Load:</strong> 23%</p>
                                <p style="margin: 10px 0;"><strong>Memory:</strong> 4.2GB / 16GB</p>
                            </div>

                            <div
                                style="padding: 20px; background: rgba(245, 158, 11, 0.08); border-radius: 12px; border-left: 4px solid var(--admin-warning);">
                                <h3 style="margin-top: 0; font-size: 16px;">Pending Tasks</h3>
                                <p style="margin: 10px 0;">• 3 flagged posts to review</p>
                                <p style="margin: 10px 0;">• 2 user verification requests</p>
                                <p style="margin: 10px 0;">• 5 system notifications</p>
                                <p style="margin: 10px 0;">• 1 analytics report ready</p>
                            </div>
                        </div>

                        <div style="margin-top: 30px; display: flex; gap: 12px; flex-wrap: wrap;">
                            <button class="btn btn-primary">System Settings</button>
                            <button class="btn btn-primary">View Logs</button>
                            <button class="btn btn-primary">Database Console</button>
                            <button class="btn btn-primary">Backup Now</button>
                        </div>
                    </div>
                </main>
        </div>
</body>

</html>