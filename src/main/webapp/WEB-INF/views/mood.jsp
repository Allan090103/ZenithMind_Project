<%@ page contentType="text/html; charset=UTF-8" import="java.util.List, java.util.Map" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="_csrf" content="${_csrf.token}" />
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <title>ZenithMind | Mood Tracker</title>
        <style>
            :root {
                --teal: #00b3c7;
                --dark: #0a2540;
                --text: #4c5d70;
                --bg: #f5f7fb;
                --card: #ffffff;
                --border: #e5ebf4;
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: "Segoe UI", Tahoma, sans-serif;
                background: var(--bg);
                color: var(--text);
            }

            .app-shell {
                display: flex;
                min-height: 100vh;
            }

            .sidebar {
                width: 260px;
                background: #ffffff;
                border-right: 1px solid var(--border);
                padding: 32px 26px;
                display: flex;
                flex-direction: column;
                gap: 24px;
            }

            .brand {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .brand svg {
                width: 42px;
                height: 42px;
            }

            .brand-title {
                font-size: 20px;
                font-weight: 600;
                color: var(--dark);
                line-height: 1.2;
            }

            .user-card {
                background: linear-gradient(135deg, rgba(0, 179, 199, 0.08), rgba(80, 157, 255, 0.1));
                border-radius: 18px;
                padding: 20px;
            }

            .user-card .avatar {
                width: 54px;
                height: 54px;
                border-radius: 50%;
                background: #dbefff;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                font-weight: 600;
                color: #3c74f6;
                margin-bottom: 10px;
            }

            .user-card .name {
                font-size: 18px;
                font-weight: 600;
                color: var(--dark);
            }

            .user-card .email {
                font-size: 13px;
                margin-bottom: 4px;
            }

            .user-card .dept {
                font-size: 13px;
                margin-bottom: 10px;
                color: #627189;
            }

            .badge {
                display: inline-flex;
                padding: 4px 12px;
                border-radius: 12px;
                background: #2563eb;
                color: #fff;
                font-size: 12px;
                font-weight: 600;
            }

            nav {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            nav a {
                text-decoration: none;
                color: var(--text);
                padding: 12px 14px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                gap: 10px;
                font-weight: 600;
            }

            nav a.active {
                background: #00c2c7;
                color: #fff;
            }

            nav a:hover:not(.active) {
                background: rgba(0, 178, 199, 0.08);
            }

            .icon {
                width: 22px;
                height: 22px;
                border-radius: 6px;
                background: rgba(255, 255, 255, 0.4);
                color: inherit;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 11px;
                font-weight: 700;
            }

            .content {
                flex: 1;
                padding: 32px 48px;
            }

            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 26px;
                gap: 18px;
            }

            .top-bar h1 {
                margin: 4px 0;
                font-size: 28px;
                color: var(--dark);
            }

            .search {
                display: flex;
                align-items: center;
                gap: 16px;
            }

            .search input {
                width: 320px;
                padding: 12px 16px;
                border-radius: 24px;
                border: 1px solid var(--border);
                font-size: 14px;
                background: #fff;
            }

            .score-pill {
                padding: 10px 16px;
                border-radius: 18px;
                background: rgba(0, 179, 199, 0.15);
                color: var(--dark);
                font-weight: 600;
                font-size: 14px;
            }

            .stat-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 18px;
                margin-bottom: 24px;
            }

            .stat-card {
                background: var(--card);
                border-radius: 18px;
                padding: 20px;
                text-align: center;
                box-shadow: 0 8px 30px rgba(15, 37, 64, 0.08);
            }

            .stat-value {
                font-size: 30px;
                font-weight: 700;
                color: var(--dark);
            }

            .stat-label {
                margin-top: 4px;
                color: #6c7b91;
            }

            .reminder-card {
                background: #e9fbff;
                border-radius: 18px;
                padding: 24px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
            }

            .reminder-button {
                border: none;
                padding: 12px 18px;
                border-radius: 14px;
                background: linear-gradient(120deg, #00b3c7, #01a0f9);
                color: #fff;
                font-weight: 600;
                cursor: pointer;
            }

            .cards-grid {
                display: grid;
                grid-template-columns: 1.2fr 1fr;
                gap: 20px;
            }

            .card {
                background: var(--card);
                border-radius: 18px;
                padding: 24px;
                box-shadow: 0 12px 40px rgba(12, 36, 64, 0.08);
            }

            .mood-options,
            .activity-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                margin: 16px 0;
            }

            .mood-option {
                flex: 1;
                min-width: 90px;
                border-radius: 16px;
                padding: 12px;
                text-align: center;
                border: 1px solid var(--border);
                cursor: pointer;
                background: #f9fbfe;
            }

            .mood-option.active {
                border-color: var(--dark);
                background: #eef2ff;
            }

            .activity-tag {
                border-radius: 20px;
                padding: 8px 16px;
                border: 1px solid var(--border);
                cursor: pointer;
                background: #f1f5f9;
            }

            .activity-tag.active {
                border-color: #2563eb;
                background: rgba(37, 99, 235, 0.15);
                color: #1d4ed8;
            }

            .textarea {
                width: 100%;
                resize: none;
                border-radius: 12px;
                border: 1px solid var(--border);
                padding: 12px;
                font-family: inherit;
            }

            .log-button {
                width: 100%;
                margin-top: 18px;
                border: none;
                padding: 14px;
                border-radius: 12px;
                font-weight: 600;
                background: var(--teal);
                color: #fff;
                cursor: pointer;
            }

            .trend-chart {
                display: flex;
                align-items: flex-end;
                gap: 12px;
                height: 180px;
                margin-top: 16px;
            }

            .trend-bar {
                flex: 1;
                border-radius: 12px 12px 4px 4px;
                background: linear-gradient(180deg, #00b3c7, #01a0f9);
                position: relative;
                min-height: 8px;
            }

            .trend-bar span {
                position: absolute;
                bottom: -26px;
                left: 50%;
                transform: translateX(-50%);
                font-size: 12px;
                color: #6c7b91;
            }

            .log-list {
                margin-top: 12px;
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .log-item {
                border-radius: 14px;
                border: 1px solid var(--border);
                padding: 12px 16px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .message {
                margin-top: 12px;
                padding: 12px 16px;
                border-radius: 12px;
                font-weight: 600;
                background: rgba(16, 185, 129, 0.2);
                color: #047857;
            }

            .message.hidden {
                display: none;
            }

            @media (max-width: 1100px) {
                .app-shell {
                    flex-direction: column;
                }

                .sidebar {
                    width: 100%;
                }

                .cards-grid {
                    grid-template-columns: 1fr;
                }

                .search {
                    flex-direction: column;
                    align-items: flex-start;
                    width: 100%;
                }

                .search input {
                    width: 100%;
                }
            }
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
                    <div class="brand-title">
                        ZenithMind<br>
                        <small style="font-size:12px;font-weight:500;color:#5a6a7f;">Mental Health Hub</small>
                    </div>
                </div>

                <div class="user-card">
                    <div class="avatar">${avatarInitial}</div>
                    <div class="name">${name}</div>
                    <div class="email">${email}</div>
                    <div class="dept">${department}</div>
                    <span class="badge">${roleTitle}</span>
                </div>

                <nav>
                    <a href="${dashboardLink}"><span class="icon">D</span>Dashboard</a>
                    <a href="${modulesLink}"><span class="icon">LM</span>Learning Modules</a>
                    <a href="${selfAssessmentLink}"><span class="icon">SA</span>Self Assessment</a>
                    <a class="active" href="${moodLink}"><span class="icon">MT</span>Mood Tracker</a>
                    <a href="${supportLink}"><span class="icon">VS</span>Virtual Support</a>
                    <a href="${communityLink}"><span class="icon">CF</span>Community Forum</a>
                    <a href="#"><span class="icon">PS</span>Profile Settings</a>
                </nav>
            </aside>

            <main class="content">
                <div class="top-bar">
                    <div>
                        <p style="margin:0;font-size:14px;color:#7c8b9e;">Track your daily emotions and spot patterns in
                            your wellbeing</p>
                        <h1>Mood Tracker ☁️</h1>
                    </div>
                    <div class="search">
                        <input type="text" placeholder="Search for modules, resources, or support...">
                        <div class="score-pill">Wellness Score: <strong>${wellnessPercent} / 100</strong></div>
                    </div>
                </div>

                <div class="stat-grid">
                    <div class="stat-card">
                        <div class="stat-value" id="averageMoodValue">0</div>
                        <div class="stat-label">Average Mood</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value" id="dayStreakValue">0</div>
                        <div class="stat-label">Day Streak</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value" id="totalLogsValue">0</div>
                        <div class="stat-label">Total Logs</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value" id="activeRemindersValue">0</div>
                        <div class="stat-label">Active Reminders</div>
                    </div>
                </div>

                <div class="reminder-card">
                    <div>
                        <h3 style="margin:0;color:var(--dark);">✨ Smart Activity Reminders</h3>
                        <p style="margin:6px 0 0;color:#5c6f82;">AI-powered suggestions based on your mood and activity
                            patterns</p>
                        <ul id="reminderList" style="margin:12px 0 0;padding-left:18px;color:#4a5568;"></ul>
                    </div>
                    <button class="reminder-button" id="generateRemindersBtn">Generate Reminders</button>
                </div>

                <div class="cards-grid">
                    <section class="card" id="moodFormCard">
                        <h2 style="margin:0;">How are you feeling today?</h2>
                        <p style="margin-bottom:12px;color:#6c7b91;">Select your current mood and tell us what
                            influenced it.</p>

                        <div class="mood-options" id="moodOptions"></div>

                        <h4 style="margin-bottom:6px;color:#4a5568;">What did you do today?</h4>
                        <div class="activity-tags" id="activityTags"></div>

                        <h4 style="margin-bottom:6px;color:#4a5568;">Add a note (optional)</h4>
                        <textarea id="moodNote" rows="3"
                            placeholder="How's your day going? Any thoughts you'd like to share..."></textarea>

                        <button class="log-button" id="logMoodBtn">Log Mood</button>
                        <div id="moodMessage" class="message hidden" aria-live="polite"></div>
                    </section>

                    <section class="card" id="recentLogsCard">
                        <h2 style="margin-top:0;">Recent Mood Logs</h2>
                        <div class="log-list" id="logList"></div>
                    </section>
                </div>

                <section class="card" style="margin-top:24px;">
                    <div style="display:flex;justify-content:space-between;align-items:center;">
                        <div>
                            <h2 style="margin:0;">7-Day Mood Trend</h2>
                            <p style="margin:6px 0 0;color:#6c7b91;">Daily overview of how you're feeling</p>
                        </div>
                    </div>
                    <div class="trend-chart" id="trendChart"></div>
                </section>
            </main>
        </div>

        <script>
            (function () {
                const moodOptions = [
                    { id: 'great', label: 'Great', emoji: '😄', score: 5 },
                    { id: 'good', label: 'Good', emoji: '😊', score: 4 },
                    { id: 'okay', label: 'Okay', emoji: '🙂', score: 3 },
                    { id: 'not-good', label: 'Not Good', emoji: '😕', score: 2 },
                    { id: 'bad', label: 'Bad', emoji: '😣', score: 1 }
                ];

                const activityOptions = ['Exercise', 'Meditation', 'Social', 'Work', 'Hobbies', 'Rest'];

                const reminderKey = 'mood_reminders_${param.role}';

                // Server-side data from database
                let serverMoodLogs = [];
                let serverMoodStats = { totalLogs: 0, averageMood: 0, dayStreak: 0 };

                <%
                    List < Map < String, Object >> moodLogs = (List < Map < String, Object >>) request.getAttribute("moodLogs");
                Map < String, Object > moodStats = (Map < String, Object >) request.getAttribute("moodStats");
                if (moodLogs != null && !moodLogs.isEmpty()) {
                %>
                        serverMoodLogs =[
                    <% for (int i = 0; i < moodLogs.size(); i++) {
                        Map < String, Object > log = moodLogs.get(i);
                        String moodId = (String) log.get("mood");
                        Integer moodScore = (Integer) log.get("mood_score");
                        String activities = log.get("activities") != null ? (String) log.get("activities") : "";
                        String note = log.get("note") != null ? ((String) log.get("note")).replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ") : "";
                        java.sql.Timestamp createdAt = (java.sql.Timestamp) log.get("created_at");
                    %>
                            { mood: '<%= moodId %>', moodScore: <%= moodScore %>, activities: '<%= activities %>', note: '<%= note %>', timestamp: <%= createdAt != null ? createdAt.getTime() : 0 %> }<%= i < moodLogs.size() - 1 ? "," : "" %>
                    <% } %>
                ];
                <% } 
                    if (moodStats != null) {
                        Object totalLogs = moodStats.get("totalLogs");
                        Object averageMood = moodStats.get("averageMood");
                        Object dayStreak = moodStats.get("dayStreak");
                %>
                    serverMoodStats = {
                    totalLogs: <%= totalLogs != null ? totalLogs : 0 %>,
                        averageMood: <%= averageMood != null ? averageMood : 0 %>,
                            dayStreak: <%= dayStreak != null ? dayStreak : 0 %> 
                };
                <% } %>

                // Pre-process logs to add date property
                serverMoodLogs.forEach(log => {
                    log.date = new Date(log.timestamp).toISOString().split('T')[0];
                });

            const moodOptionsContainer = document.getElementById('moodOptions');
            const activityTagsContainer = document.getElementById('activityTags');
            const noteField = document.getElementById('moodNote');
            const logButton = document.getElementById('logMoodBtn');
            const messageBox = document.getElementById('moodMessage');
            const logList = document.getElementById('logList');
            const trendChart = document.getElementById('trendChart');
            const reminderList = document.getElementById('reminderList');

            const averageMoodValue = document.getElementById('averageMoodValue');
            const dayStreakValue = document.getElementById('dayStreakValue');
            const totalLogsValue = document.getElementById('totalLogsValue');
            const activeRemindersValue = document.getElementById('activeRemindersValue');

            const generateRemindersBtn = document.getElementById('generateRemindersBtn');

            let selectedMood = null;
            const selectedActivities = new Set();

            function renderMoodOptions() {
                moodOptionsContainer.innerHTML = '';
                moodOptions.forEach(option => {
                    const button = document.createElement('button');
                    button.type = 'button';
                    button.className = 'mood-option';
                    button.dataset.id = option.id;
                    button.dataset.score = option.score;
                    button.innerHTML = `<div style="font-size:26px;">\${option.emoji}</div><div style="margin-top:6px;font-weight:600;">\${option.label}</div>`;
                    button.addEventListener('click', () => {
                        selectedMood = option;
                        document.querySelectorAll('.mood-option').forEach(btn => btn.classList.remove('active'));
                        button.classList.add('active');
                        hideMessage();
                    });
                    moodOptionsContainer.appendChild(button);
                });
            }

            function renderActivityTags() {
                activityTagsContainer.innerHTML = '';
                activityOptions.forEach(label => {
                    const tag = document.createElement('button');
                    tag.type = 'button';
                    tag.className = 'activity-tag';
                    tag.textContent = label;
                    tag.addEventListener('click', () => {
                        if (selectedActivities.has(label)) {
                            selectedActivities.delete(label);
                            tag.classList.remove('active');
                        } else {
                            selectedActivities.add(label);
                            tag.classList.add('active');
                        }
                    });
                    activityTagsContainer.appendChild(tag);
                });
            }

            function getStoredLogs() {
                const value = localStorage.getItem(storageKey);
                if (!value) {
                    return [];
                }
                try {
                    return JSON.parse(value);
                } catch (err) {
                    console.warn('Unable to parse mood logs', err);
                    return [];
                }
            }

            function setStoredLogs(logs) {
                localStorage.setItem(storageKey, JSON.stringify(logs));
            }

            function getStoredReminders() {
                const value = localStorage.getItem(reminderKey);
                if (!value) {
                    return [];
                }
                try {
                    return JSON.parse(value);
                } catch (err) {
                    console.warn('Unable to parse reminders', err);
                    return [];
                }
            }

            function setStoredReminders(reminders) {
                localStorage.setItem(reminderKey, JSON.stringify(reminders));
            }

            function renderReminders() {
                const reminders = getStoredReminders();
                reminderList.innerHTML = '';
                if (reminders.length === 0) {
                    reminderList.innerHTML = '<li>No reminders yet. Click "Generate Reminders" to create personalized suggestions.</li>';
                } else {
                    reminders.forEach(text => {
                        const li = document.createElement('li');
                        li.textContent = text;
                        reminderList.appendChild(li);
                    });
                }
                activeRemindersValue.textContent = reminders.length;
            }

            function showMessage(text, type) {
                messageBox.textContent = text;
                messageBox.className = 'message';
                if (type === 'error') {
                    messageBox.style.background = 'rgba(248,113,113,0.2)';
                    messageBox.style.color = '#b91c1c';
                } else {
                    messageBox.style.background = 'rgba(16,185,129,0.2)';
                    messageBox.style.color = '#047857';
                }
            }

            function hideMessage() {
                messageBox.classList.add('hidden');
            }

            function logMood() {
                if (!selectedMood) {
                    showMessage('Please select a mood before logging.', 'error');
                    return;
                }

                // Send to backend to save to database
                const formData = new URLSearchParams();
                formData.append('role', '${param.role}' || 'student');
                formData.append('mood', selectedMood.id);
                formData.append('activities', Array.from(selectedActivities).join(','));
                formData.append('note', noteField.value.trim());

                // Get CSRF token
                const csrfToken = document.querySelector('meta[name="_csrf"]');
                const csrfHeader = document.querySelector('meta[name="_csrf_header"]');

                fetch('${pageContext.request.contextPath}/mood/log', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        ...(csrfToken && csrfHeader ? { [csrfHeader.content]: csrfToken.content } : {})
                    },
                    body: formData.toString()
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            showMessage(data.message, 'success');
                            // Update wellness score display
                            const scorePill = document.querySelector('.score-pill strong');
                            if (scorePill) {
                                scorePill.textContent = data.wellnessPercent + ' / 100';
                            }
                            // Update stats from server response
                            if (data.moodStats) {
                                serverMoodStats = data.moodStats;
                                totalLogsValue.textContent = serverMoodStats.totalLogs || 0;
                                averageMoodValue.textContent = serverMoodStats.averageMood || 0;
                                dayStreakValue.textContent = serverMoodStats.dayStreak || 0;
                            }
                            // Refresh the page to show updated logs from database
                            setTimeout(() => window.location.reload(), 1000);
                        } else {
                            showMessage(data.message || 'Failed to log mood', 'error');
                        }
                    })
                    .catch(error => {
                        console.error('Error logging mood:', error);
                        showMessage('Failed to save mood. Please try again.', 'error');
                    });

                // Reset form
                noteField.value = '';
                selectedActivities.clear();
                document.querySelectorAll('.activity-tag').forEach(tag => tag.classList.remove('active'));
            }

            function calculateStats(logs) {
                if (logs.length === 0) {
                    return { averageMood: 0, dayStreak: 0 };
                }

                // Fix: mood is a string ID, moodScore is the number
                const totalScore = logs.reduce((sum, entry) => sum + (entry.moodScore || 0), 0);
                const averageScore = totalScore / logs.length;
                const averageMood = averageScore.toFixed(1);

                // Fix: derive date from timestamp
                const uniqueDates = Array.from(new Set(logs.map(entry => {
                    return entry.date || new Date(entry.timestamp).toISOString().split('T')[0];
                }))).sort((a, b) => b.localeCompare(a));

                let streak = 0;
                const today = new Date();
                const todayKey = today.toISOString().split('T')[0];

                // Allow streak to start from today or yesterday
                let current = new Date(today);

                // Check up to 365 days back? Just iterate uniqueDates.
                // But uniqueDates is sorted desc.
                // 2026-01-13, 2026-01-12, ...

                let checkDate = new Date(today);
                for (let i = 0; i < uniqueDates.length; i++) {
                    const dateKey = uniqueDates[i];
                    const checkKey = checkDate.toISOString().split('T')[0];

                    if (dateKey === checkKey) {
                        streak++;
                        checkDate.setDate(checkDate.getDate() - 1);
                    } else if (i === 0 && dateKey !== checkKey) {
                        // Maybe today wasn't logged yet, set checkDate to yesterday
                        checkDate.setDate(checkDate.getDate() - 1);
                        const yesterdayKey = checkDate.toISOString().split('T')[0];
                        if (dateKey === yesterdayKey) {
                            streak++;
                            checkDate.setDate(checkDate.getDate() - 1);
                        } else {
                            // Streak broken
                            break;
                        }
                    } else {
                        break;
                    }
                }

                return { averageMood, dayStreak: streak };
            }

            function renderTrend(logs) {
                trendChart.innerHTML = '';
                const today = new Date();
                for (let i = 6; i >= 0; i--) {
                    const date = new Date(today);
                    date.setDate(today.getDate() - i);
                    const dateKey = date.toISOString().split('T')[0];

                    const entries = logs.filter(entry => {
                        const entryDate = entry.date || new Date(entry.timestamp).toISOString().split('T')[0];
                        return entryDate === dateKey;
                    });

                    let heightPercent = 5;
                    if (entries.length > 0) {
                        const avg = entries.reduce((sum, entry) => sum + (entry.moodScore || 0), 0) / entries.length;
                        heightPercent = (avg / 5) * 100;
                    }
                    const bar = document.createElement('div');
                    bar.className = 'trend-bar';
                    bar.style.height = Math.max(heightPercent, 8) + '%';
                    bar.innerHTML = `<span>\${date.toLocaleDateString(undefined, { weekday: 'short' })}</span>`;
                    trendChart.appendChild(bar);
                }
            }

            function renderLogs(logs) {
                logList.innerHTML = '';
                if (logs.length === 0) {
                    logList.innerHTML = '<p style="color:#6c7b91;">Log your first mood to see it listed here.</p>';
                    return;
                }
                // Get the 4 most recent logs (already sorted by server)
                const recent = logs.slice(0, 4);
                recent.forEach(entry => {
                    const div = document.createElement('div');
                    div.className = 'log-item';
                    // Find mood details from moodOptions
                    const moodId = entry.mood || entry.mood_id;
                    const moodDetails = moodOptions.find(m => m.id === moodId) || { emoji: '🙂', label: moodId, score: entry.moodScore || 3 };
                    const activities = entry.activities || '';
                    const note = entry.note ? entry.note.replace(/</g, "&lt;").replace(/>/g, "&gt;") : '';
                    const timestamp = entry.timestamp || Date.now();
                    div.innerHTML = `
                <div>
                    <strong>\${moodDetails.emoji} \${moodDetails.label}</strong>
                    <p style="margin:2px 0 0;color:#6c7b91;font-size:13px;">\${new Date(timestamp).toLocaleString()}</p>
                    <p style="margin:4px 0 0;font-size:13px;color:#4a5568;">\${activities || 'No activity logged'}</p>
                    \${note ? `< p style = "margin:6px 0 0;color:#334155;" >\${ note }</p > ` : ''}
                </div>
                <span style="font-weight:600;color:#6c7b91;">Score \${moodDetails.score}</span>
            `;
                    logList.appendChild(div);
                });
            }

            function updateDashboard() {
                // Use server-side data from database
                totalLogsValue.textContent = serverMoodStats.totalLogs || 0;
                averageMoodValue.textContent = serverMoodStats.averageMood || 0;
                dayStreakValue.textContent = serverMoodStats.dayStreak || 0;
                renderLogs(serverMoodLogs);
                renderTrend(serverMoodLogs);
            }

            function generateReminders() {
                const reminders = [
                    'Take a 10-minute mindful break when mood dips below “Okay”.',
                    'Schedule an evening walk to maintain your positive streak.',
                    'Reach out to your support buddy after two “Not Good” logs.'
                ];
                setStoredReminders(reminders);
                renderReminders();
            }

            renderMoodOptions();
            renderActivityTags();
            renderReminders();
            updateDashboard();

            logButton.addEventListener('click', logMood);
            generateRemindersBtn.addEventListener('click', generateReminders);
            }) ();
        </script>
    </body>

    </html>