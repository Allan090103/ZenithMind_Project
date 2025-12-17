<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>ZenithMind | User Management</title>
    <%@ include file="../common/admin_styles.jsp" %>
        <style>
            .user-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .user-table th {
                background: var(--bg);
                padding: 12px;
                text-align: left;
                font-weight: 600;
                color: var(--dark);
                border-bottom: 2px solid var(--border);
            }

            .user-table td {
                padding: 12px;
                border-bottom: 1px solid var(--border);
            }

            .user-table tr:hover {
                background: rgba(0, 179, 199, 0.03);
            }

            .role-badge {
                padding: 4px 10px;
                border-radius: 8px;
                font-size: 11px;
                font-weight: 600;
            }

            .role-badge.student {
                background: rgba(59, 130, 246, 0.2);
                color: #2563eb;
            }

            .role-badge.faculty {
                background: rgba(139, 92, 246, 0.2);
                color: #7c3aed;
            }

            .role-badge.professional {
                background: rgba(16, 185, 129, 0.2);
                color: #059669;
            }

            .role-badge.admin {
                background: rgba(245, 158, 11, 0.2);
                color: #d97706;
            }

            .btn-small {
                padding: 6px 12px;
                font-size: 12px;
            }
        </style>
</head>

<body>
    <% request.setAttribute("activePage", "users" ); %>
        <div class="app-shell">
            <%@ include file="../common/admin_sidebar.jsp" %>

                <main class="dashboard">
                    <div class="top-bar">
                        <div class="welcome">
                            <p>Manage Platform Users</p>
                            <h1>User Management</h1>
                        </div>
                        <button class="btn btn-primary">+ Add New User</button>
                    </div>

                    <div class="card">
                        <h2>All Users</h2>
                        <p>Manage user accounts, roles, and permissions.</p>

                        <div style="margin: 20px 0; display: flex; gap: 12px; align-items: center;">
                            <input type="text" placeholder="Search users..."
                                style="flex: 1; padding: 10px 16px; border-radius: 10px; border: 1px solid var(--border); font-size: 14px;">
                            <select
                                style="padding: 10px 16px; border-radius: 10px; border: 1px solid var(--border); font-size: 14px;">
                                <option>All Roles</option>
                                <option>Students</option>
                                <option>Faculty</option>
                                <option>Professionals</option>
                                <option>Admins</option>
                            </select>
                        </div>

                        <table class="user-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Department</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Ali Ahmad</strong></td>
                                    <td>ali@student.edu</td>
                                    <td><span class="role-badge student">Student</span></td>
                                    <td>Computer Science</td>
                                    <td><span style="color: var(--admin-success);">● Active</span></td>
                                    <td>
                                        <button class="btn btn-primary btn-small">Edit</button>
                                        <button class="btn btn-small"
                                            style="background: #f3f4f6; color: var(--text);">View</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Aiman Hassan</strong></td>
                                    <td>aiman@faculty.edu</td>
                                    <td><span class="role-badge faculty">Faculty</span></td>
                                    <td>Psychology</td>
                                    <td><span style="color: var(--admin-success);">● Active</span></td>
                                    <td>
                                        <button class="btn btn-primary btn-small">Edit</button>
                                        <button class="btn btn-small"
                                            style="background: #f3f4f6; color: var(--text);">View</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Aisyah Rahman</strong></td>
                                    <td>aisyah@wellness.org</td>
                                    <td><span class="role-badge professional">Professional</span></td>
                                    <td>Counseling Services</td>
                                    <td><span style="color: var(--admin-success);">● Active</span></td>
                                    <td>
                                        <button class="btn btn-primary btn-small">Edit</button>
                                        <button class="btn btn-small"
                                            style="background: #f3f4f6; color: var(--text);">View</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Ain Ibrahim</strong></td>
                                    <td>ain@admin.edu</td>
                                    <td><span class="role-badge admin">Admin</span></td>
                                    <td>System Administration</td>
                                    <td><span style="color: var(--admin-success);">● Active</span></td>
                                    <td>
                                        <button class="btn btn-primary btn-small">Edit</button>
                                        <button class="btn btn-small"
                                            style="background: #f3f4f6; color: var(--text);">View</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Sarah Lee</strong></td>
                                    <td>sarah@student.edu</td>
                                    <td><span class="role-badge student">Student</span></td>
                                    <td>Engineering</td>
                                    <td><span style="color: var(--text);">● Inactive</span></td>
                                    <td>
                                        <button class="btn btn-primary btn-small">Edit</button>
                                        <button class="btn btn-small"
                                            style="background: #f3f4f6; color: var(--text);">View</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <div
                            style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center;">
                            <div style="font-size: 14px; color: var(--text);">Showing 5 of 1,247 users</div>
                            <div style="display: flex; gap: 8px;">
                                <button class="btn btn-small"
                                    style="background: #f3f4f6; color: var(--text);">Previous</button>
                                <button class="btn btn-primary btn-small">Next</button>
                            </div>
                        </div>
                    </div>
                </main>
        </div>
</body>

</html>