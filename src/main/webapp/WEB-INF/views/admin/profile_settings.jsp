<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Profile Settings</title>
    <%@ include file="../common/admin_styles.jsp" %>
        <style>
            .settings-section {
                padding: 20px;
                background: var(--bg);
                border-radius: 12px;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 16px;
            }

            .form-group label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: var(--dark);
                font-size: 14px;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 10px 14px;
                border-radius: 10px;
                border: 1px solid var(--border);
                font-size: 14px;
            }
        </style>
</head>

<body>
    <% request.setAttribute("activePage", "settings" ); %>
        <div class="app-shell">
            <%@ include file="../common/admin_sidebar.jsp" %>

                <main class="dashboard">
                    <div class="top-bar">
                        <div class="welcome">
                            <p>Manage Your Account</p>
                            <h1>Profile Settings</h1>
                        </div>
                    </div>

                    <div class="card">
                        <h2>Account Information</h2>
                        <div class="settings-section">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" value="${name}" placeholder="Enter your name">
                            </div>
                            <div class="form-group">
                                <label>Email Address</label>
                                <input type="email" value="${email}" placeholder="Enter your email">
                            </div>
                            <div class="form-group">
                                <label>Department</label>
                                <input type="text" value="${department}" placeholder="Enter your department">
                            </div>
                            <div class="form-group">
                                <label>Role</label>
                                <input type="text" value="${roleTitle}" disabled style="background: #f3f4f6;">
                            </div>
                            <button class="btn btn-primary">Save Changes</button>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 20px;">
                        <h2>Security Settings</h2>
                        <div class="settings-section">
                            <div class="form-group">
                                <label>Current Password</label>
                                <input type="password" placeholder="Enter current password">
                            </div>
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" placeholder="Enter new password">
                            </div>
                            <div class="form-group">
                                <label>Confirm New Password</label>
                                <input type="password" placeholder="Confirm new password">
                            </div>
                            <button class="btn btn-primary">Update Password</button>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 20px;">
                        <h2>Notification Preferences</h2>
                        <div class="settings-section">
                            <div style="margin-bottom: 16px;">
                                <label style="display: flex; align-items: center; gap: 10px; cursor: pointer;">
                                    <input type="checkbox" checked>
                                    <span>Email notifications for flagged content</span>
                                </label>
                            </div>
                            <div style="margin-bottom: 16px;">
                                <label style="display: flex; align-items: center; gap: 10px; cursor: pointer;">
                                    <input type="checkbox" checked>
                                    <span>System alerts and updates</span>
                                </label>
                            </div>
                            <div style="margin-bottom: 16px;">
                                <label style="display: flex; align-items: center; gap: 10px; cursor: pointer;">
                                    <input type="checkbox">
                                    <span>Weekly analytics reports</span>
                                </label>
                            </div>
                            <div style="margin-bottom: 16px;">
                                <label style="display: flex; align-items: center; gap: 10px; cursor: pointer;">
                                    <input type="checkbox" checked>
                                    <span>User registration notifications</span>
                                </label>
                            </div>
                            <button class="btn btn-primary">Save Preferences</button>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 20px;">
                        <h2>Profile Picture</h2>
                        <div class="settings-section">
                            <div style="display: flex; align-items: center; gap: 20px;">
                                <div
                                    style="width: 80px; height: 80px; border-radius: 50%; background: #dbefff; display: flex; align-items: center; justify-content: center; font-size: 32px; font-weight: 600; color: #3c74f6;">
                                    ${avatarInitial}
                                </div>
                                <div>
                                    <button class="btn btn-primary">Upload New Photo</button>
                                    <p style="font-size: 12px; color: var(--text); margin-top: 8px;">JPG, PNG or GIF.
                                        Max size 2MB.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
        </div>
</body>

</html>