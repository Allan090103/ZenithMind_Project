<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Content Moderation</title>
    <%@ include file="../common/admin_styles.jsp" %>
        <style>
            .moderation-item {
                padding: 16px;
                background: rgba(239, 68, 68, 0.03);
                border-radius: 12px;
                border-left: 4px solid var(--admin-danger);
                margin-bottom: 16px;
            }

            .moderation-item.approved {
                background: rgba(16, 185, 129, 0.03);
                border-left-color: var(--admin-success);
            }

            .moderation-actions {
                display: flex;
                gap: 8px;
                margin-top: 12px;
            }

            .btn-approve {
                background: var(--admin-success);
                color: #fff;
            }

            .btn-remove {
                background: var(--admin-danger);
                color: #fff;
            }

            .status-badge {
                padding: 4px 10px;
                border-radius: 8px;
                font-size: 11px;
                font-weight: 600;
            }

            .status-pending {
                background: rgba(245, 158, 11, 0.2);
                color: #d97706;
            }

            .status-approved {
                background: rgba(16, 185, 129, 0.2);
                color: #059669;
            }
        </style>
</head>

<body>
    <% request.setAttribute("activePage", "moderation" ); %>
        <div class="app-shell">
            <%@ include file="../common/admin_sidebar.jsp" %>

                <main class="dashboard">
                    <div class="top-bar">
                        <div class="welcome">
                            <p>Review Flagged Content</p>
                            <h1>Content Moderation</h1>
                        </div>
                        <div style="display: flex; gap: 12px;">
                            <span class="status-badge status-pending">3 Pending Review</span>
                        </div>
                    </div>

                    <div class="card">
                        <h2>Flagged Posts</h2>
                        <p>Review and moderate flagged community content.</p>

                        <div style="margin: 20px 0;">
                            <div class="moderation-item">
                                <div style="display: flex; justify-content: space-between; align-items: start;">
                                    <div>
                                        <strong style="color: var(--dark);">Flagged Post #247</strong>
                                        <span class="status-badge status-pending"
                                            style="margin-left: 10px;">Pending</span>
                                    </div>
                                    <div style="font-size: 12px; color: var(--text);">Reported 2 hours ago</div>
                                </div>
                                <p style="margin: 12px 0; color: var(--text);">
                                    "Inappropriate language detected in community forum discussion about stress
                                    management..."
                                </p>
                                <div style="font-size: 12px; color: var(--text); margin-bottom: 8px;">
                                    <strong>Reported by:</strong> 3 users | <strong>Category:</strong> Inappropriate
                                    Content
                                </div>
                                <div class="moderation-actions">
                                    <button class="btn btn-approve btn-small">Approve</button>
                                    <button class="btn btn-remove btn-small">Remove</button>
                                    <button class="btn btn-primary btn-small">View Full Post</button>
                                </div>
                            </div>

                            <div class="moderation-item">
                                <div style="display: flex; justify-content: space-between; align-items: start;">
                                    <div>
                                        <strong style="color: var(--dark);">Flagged Post #246</strong>
                                        <span class="status-badge status-pending"
                                            style="margin-left: 10px;">Pending</span>
                                    </div>
                                    <div style="font-size: 12px; color: var(--text);">Reported 5 hours ago</div>
                                </div>
                                <p style="margin: 12px 0; color: var(--text);">
                                    "Multiple reports on anxiety support thread containing potentially harmful
                                    advice..."
                                </p>
                                <div style="font-size: 12px; color: var(--text); margin-bottom: 8px;">
                                    <strong>Reported by:</strong> 5 users | <strong>Category:</strong> Harmful Content
                                </div>
                                <div class="moderation-actions">
                                    <button class="btn btn-approve btn-small">Approve</button>
                                    <button class="btn btn-remove btn-small">Remove</button>
                                    <button class="btn btn-primary btn-small">View Full Post</button>
                                </div>
                            </div>

                            <div class="moderation-item">
                                <div style="display: flex; justify-content: space-between; align-items: start;">
                                    <div>
                                        <strong style="color: var(--dark);">Flagged Post #245</strong>
                                        <span class="status-badge status-pending"
                                            style="margin-left: 10px;">Pending</span>
                                    </div>
                                    <div style="font-size: 12px; color: var(--text);">Reported 1 day ago</div>
                                </div>
                                <p style="margin: 12px 0; color: var(--text);">
                                    "Spam content promoting external services in mental health discussion..."
                                </p>
                                <div style="font-size: 12px; color: var(--text); margin-bottom: 8px;">
                                    <strong>Reported by:</strong> 2 users | <strong>Category:</strong> Spam
                                </div>
                                <div class="moderation-actions">
                                    <button class="btn btn-approve btn-small">Approve</button>
                                    <button class="btn btn-remove btn-small">Remove</button>
                                    <button class="btn btn-primary btn-small">View Full Post</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 20px;">
                        <h2>Recently Reviewed</h2>
                        <div style="margin-top: 20px;">
                            <div class="moderation-item approved">
                                <div style="display: flex; justify-content: space-between; align-items: start;">
                                    <div>
                                        <strong style="color: var(--dark);">Post #244</strong>
                                        <span class="status-badge status-approved"
                                            style="margin-left: 10px;">Approved</span>
                                    </div>
                                    <div style="font-size: 12px; color: var(--text);">Reviewed 2 days ago</div>
                                </div>
                                <p style="margin: 12px 0; color: var(--text);">
                                    "Content was reviewed and approved. No policy violations found."
                                </p>
                            </div>
                        </div>
                    </div>
                </main>
        </div>
</body>

</html>