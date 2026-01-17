<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Platform Analytics</title>
    <%@ include file="../common/admin_styles.jsp" %>
        <style>
            .stat-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 16px;
                margin: 20px 0;
            }

            .stat-box {
                padding: 20px;
                border-radius: 12px;
                text-align: center;
            }

            .stat-value {
                font-size: 32px;
                font-weight: 700;
                color: var(--dark);
                margin-bottom: 8px;
            }

            .stat-label {
                font-size: 14px;
                color: var(--text);
            }

            .chart-placeholder {
                height: 250px;
                background: linear-gradient(180deg, rgba(0, 179, 199, 0.08), rgba(0, 179, 199, 0.02));
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--text);
                font-size: 14px;
                border: 1px dashed var(--border);
                margin: 20px 0;
            }
        </style>
</head>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<body>
    <% request.setAttribute("activePage", "analytics" ); %>
        <div class="app-shell">
            <%@ include file="../common/admin_sidebar.jsp" %>

                <main class="dashboard">
                    <div class="top-bar">
                        <div class="welcome">
                            <p>Platform Insights & Metrics</p>
                            <h1>Platform Analytics</h1>
                        </div>
                        <select
                            style="padding: 10px 16px; border-radius: 10px; border: 1px solid var(--border); font-size: 14px;">
                            <option>Last 7 Days</option>
                            <option>Last 30 Days</option>
                            <option>Last 90 Days</option>
                            <option>All Time</option>
                        </select>
                    </div>

                    <div class="stat-grid">
                        <div class="stat-box"
                            style="background: linear-gradient(135deg, rgba(0, 179, 199, 0.1), rgba(0, 179, 199, 0.05));">
                            <div class="stat-value">${totalUsers}</div>
                            <div class="stat-label">Total Users</div>
                        </div>
                        <div class="stat-box"
                            style="background: linear-gradient(135deg, rgba(139, 92, 246, 0.1), rgba(139, 92, 246, 0.05));">
                            <div class="stat-value">${activeUsers}</div>
                            <div class="stat-label">Active Today</div>
                        </div>
                        <div class="stat-box"
                            style="background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.05));">
                            <div class="stat-value">${modulesCompleted}</div>
                            <div class="stat-label">Modules Completed</div>
                        </div>
                        <div class="stat-box"
                            style="background: linear-gradient(135deg, rgba(245, 158, 11, 0.1), rgba(245, 158, 11, 0.05));">
                            <div class="stat-value">${forumPosts}</div>
                            <div class="stat-label">Forum Posts</div>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 20px;">
                        <h2>User Engagement Trends</h2>
                        <div style="height: 300px; width: 100%;">
                            <canvas id="userActivityChart"></canvas>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 20px;">
                        <h2>Module Completion Rates</h2>
                        <div style="height: 300px; width: 100%;">
                            <canvas id="moduleCompletionChart"></canvas>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 20px;">
                        <h2>Top Performing Content</h2>
                        <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                            <thead>
                                <tr style="background: var(--bg); border-bottom: 2px solid var(--border);">
                                    <th style="padding: 12px; text-align: left;">Module/Content</th>
                                    <th style="padding: 12px; text-align: left;">Completions</th>
                                    <th style="padding: 12px; text-align: left;">Avg. Rating</th>
                                    <th style="padding: 12px; text-align: left;">Engagement</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr style="border-bottom: 1px solid var(--border);">
                                    <td style="padding: 12px;"><strong>Stress Management</strong></td>
                                    <td style="padding: 12px;">234</td>
                                    <td style="padding: 12px;">4.8/5.0</td>
                                    <td style="padding: 12px;"><span style="color: var(--admin-success);">High</span>
                                    </td>
                                </tr>
                                <tr style="border-bottom: 1px solid var(--border);">
                                    <td style="padding: 12px;"><strong>Mindfulness Basics</strong></td>
                                    <td style="padding: 12px;">189</td>
                                    <td style="padding: 12px;">4.6/5.0</td>
                                    <td style="padding: 12px;"><span style="color: var(--admin-success);">High</span>
                                    </td>
                                </tr>
                                <tr style="border-bottom: 1px solid var(--border);">
                                    <td style="padding: 12px;"><strong>Anxiety Coping Skills</strong></td>
                                    <td style="padding: 12px;">156</td>
                                    <td style="padding: 12px;">4.7/5.0</td>
                                    <td style="padding: 12px;"><span style="color: var(--admin-warning);">Medium</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </main>
        </div>
</body>

<script>
    // User Activity Chart
    const ctxActivity = document.getElementById('userActivityChart').getContext('2d');
    new Chart(ctxActivity, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                label: 'Active Users',
                data: [150, 230, 220, 320, 290, 140, 310],
                borderColor: '#00b3c7',
                backgroundColor: 'rgba(0, 179, 199, 0.1)',
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: '#e5ebf4'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });

    // Module Completion Chart
    const ctxModule = document.getElementById('moduleCompletionChart').getContext('2d');
    new Chart(ctxModule, {
        type: 'bar',
        data: {
            labels: ['Stress', 'Anxiety', 'Depression', 'Mindfulness'],
            datasets: [{
                label: 'Completions',
                data: [65, 59, 80, 81],
                backgroundColor: [
                    'rgba(0, 179, 199, 0.6)',
                    'rgba(139, 92, 246, 0.6)',
                    'rgba(16, 185, 129, 0.6)',
                    'rgba(245, 158, 11, 0.6)'
                ],
                borderColor: [
                    'rgba(0, 179, 199, 1)',
                    'rgba(139, 92, 246, 1)',
                    'rgba(16, 185, 129, 1)',
                    'rgba(245, 158, 11, 1)'
                ],
                borderWidth: 1,
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: '#e5ebf4'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
</script>

</html>