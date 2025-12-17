<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>ZenithMind | Virtual Support</title>
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
                margin-bottom: 24px;
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

            .crisis-banner {
                background: #fee2e2;
                border: 1px solid #fecaca;
                border-radius: 18px;
                padding: 16px 24px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 18px;
            }

            .crisis-banner button {
                border: none;
                border-radius: 999px;
                padding: 10px 18px;
                font-weight: 600;
                color: #fff;
                cursor: pointer;
            }

            .crisis-call {
                background: #dc2626;
            }

            .crisis-text {
                background: #334155;
            }

            .tab-bar {
                border-radius: 999px;
                background: #e7e9f3;
                padding: 6px;
                display: inline-flex;
                gap: 6px;
                margin-bottom: 24px;
            }

            .tab {
                border: none;
                background: transparent;
                padding: 8px 20px;
                border-radius: 999px;
                font-weight: 600;
                cursor: pointer;
            }

            .tab.active {
                background: #fff;
                box-shadow: 0 4px 16px rgba(15, 37, 64, 0.1);
            }

            .layout {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 20px;
            }

            .card {
                background: var(--card);
                border-radius: 18px;
                box-shadow: 0 12px 40px rgba(12, 36, 64, 0.08);
                padding: 24px;
            }

            .chat-card {
                display: flex;
                flex-direction: column;
                height: 460px;
            }

            .chat-messages {
                flex: 1;
                overflow-y: auto;
                margin: 16px 0;
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .message {
                display: inline-flex;
                align-self: flex-start;
                background: #f1f5f9;
                padding: 12px 16px;
                border-radius: 18px;
                color: #0f172a;
            }

            .message.user {
                align-self: flex-end;
                background: #00b3c7;
                color: #fff;
            }

            .chat-input {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .chat-input input {
                flex: 1;
                border-radius: 12px;
                border: 1px solid var(--border);
                padding: 12px;
                font-family: inherit;
            }

            .chat-input button {
                border: none;
                border-radius: 12px;
                padding: 12px 16px;
                background: var(--teal);
                color: #fff;
                font-weight: 600;
                cursor: pointer;
            }

            .quick-actions {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .quick-actions button {
                border-radius: 12px;
                border: 1px solid var(--border);
                padding: 10px 12px;
                background: #f8fafc;
                text-align: left;
                cursor: pointer;
                font-weight: 600;
                color: #334155;
            }

            .session-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 16px;
            }

            .session-card {
                border: 1px solid var(--border);
                border-radius: 18px;
                padding: 18px;
                text-align: center;
            }

            .session-card button {
                width: 100%;
                border: none;
                border-radius: 12px;
                padding: 10px;
                font-weight: 600;
                color: #fff;
                background: var(--teal);
                cursor: pointer;
                margin-top: 12px;
            }

            .status-pill {
                display: inline-flex;
                padding: 4px 10px;
                border-radius: 999px;
                font-size: 12px;
                font-weight: 600;
                background: rgba(16, 185, 129, 0.15);
                color: #047857;
            }

            .session-list {
                display: flex;
                flex-direction: column;
                gap: 16px;
            }

            .session-item {
                border: 1px solid var(--border);
                border-radius: 18px;
                padding: 16px 20px;
            }

            .session-item footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 10px;
            }

            .session-item button {
                border: 1px solid var(--border);
                border-radius: 999px;
                padding: 8px 14px;
                background: transparent;
                font-weight: 600;
                cursor: pointer;
            }

            @media (max-width: 1080px) {
                .app-shell {
                    flex-direction: column;
                }

                .sidebar {
                    width: 100%;
                }

                .layout {
                    grid-template-columns: 1fr;
                }

                .chat-card {
                    height: auto;
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
                    <a href="${moodLink}"><span class="icon">MT</span>Mood Tracker</a>
                    <a class="active" href="${supportLink}"><span class="icon">VS</span>Virtual Support</a>
                    <a href="${communityLink}"><span class="icon">CF</span>Community Forum</a>
                    <a href="#"><span class="icon">PS</span>Profile Settings</a>
                </nav>
            </aside>

            <main class="content">
                <div class="top-bar">
                    <div>
                        <p style="margin:0;font-size:14px;color:#7c8b9e;">Chat with our AI assistant, book counselling
                            sessions, and manage appointments</p>
                        <h1>Virtual Support 🤖</h1>
                    </div>
                    <div class="search">
                        <input type="text" placeholder="Search for modules, resources, or support...">
                        <div class="score-pill">Wellness Score: <strong>${wellnessScore} / 100</strong></div>
                    </div>
                </div>

                <div class="crisis-banner">
                    <div>
                        <strong style="color:#991b1b;display:block;">⚠️ Crisis Resources Available 24/7</strong>
                        <span>If you’re experiencing a mental health emergency, please reach out immediately:</span>
                    </div>
                    <button class="crisis-call">📞 Call 988 · Suicide &amp; Crisis Lifeline</button>
                    <button class="crisis-text">💬 Text HOME to 741741</button>
                </div>

                <div class="tab-bar">
                    <button class="tab active" data-tab="chatbot">💬 AI Chatbot</button>
                    <button class="tab" data-tab="book">📅 Book Session</button>
                    <button class="tab" data-tab="sessions">🕒 My Sessions</button>
                </div>

                <section class="tab-panel" data-panel="chatbot">
                    <div class="layout">
                        <div class="card chat-card">
                            <header>
                                <div style="display:flex;align-items:center;gap:12px;">
                                    <div
                                        style="width:46px;height:46px;border-radius:15px;background:#00c2c7;color:#fff;display:flex;align-items:center;justify-content:center;font-weight:700;">
                                        AI</div>
                                    <div>
                                        <strong>Mental Health Assistant</strong>
                                        <p style="margin:2px 0 0;font-size:13px;color:#6c7b91;">Available 24/7 for
                                            guidance</p>
                                    </div>
                                </div>
                                <span class="status-pill" style="float:right;">Online</span>
                            </header>
                            <div class="chat-messages" id="chatMessages"></div>
                            <div class="chat-input">
                                <input type="text" id="chatInput" placeholder="Type your message...">
                                <button id="chatSendBtn">Send</button>
                            </div>
                        </div>
                        <div class="card">
                            <h3 style="margin-top:0;">Quick Actions</h3>
                            <div class="quick-actions">
                                <button data-quick="I’m feeling anxious. Can you help me calm down?">Feeling
                                    anxious</button>
                                <button
                                    data-quick="I’m feeling stressed. What coping strategies do you suggest?">Feeling
                                    stressed</button>
                                <button data-quick="I need coping strategies for tough days.">Need coping
                                    strategies</button>
                                <button data-quick="How can I start counseling sessions?">About counseling</button>
                                <button data-quick="Show me available support resources.">Show resources</button>
                            </div>
                            <div style="margin-top:22px;">
                                <h4 style="margin-bottom:6px;">Support Hours</h4>
                                <p style="margin:0;">AI Assistant — 24/7<br>Counselors — Mon-Fri, 9AM-5PM<br>Emergency —
                                    24/7 Call 988</p>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="tab-panel" data-panel="book" hidden>
                    <div class="card">
                        <h2 style="margin-top:0;">Book a Counselling Session</h2>
                        <p>Select a counsellor and schedule your appointment.</p>
                        <div class="session-grid" id="counselorGrid"></div>
                    </div>
                </section>

                <section class="tab-panel" data-panel="sessions" hidden>
                    <div class="card">
                        <h2 style="margin-top:0;">Upcoming Sessions</h2>
                        <p>Your scheduled counselling appointments</p>
                        <div class="session-list" id="upcomingSessions"></div>
                    </div>
                    <div class="card" style="margin-top:20px;">
                        <h2 style="margin-top:0;">Completed Sessions</h2>
                        <p>Your past counselling sessions</p>
                        <div class="session-list" id="completedSessions"></div>
                    </div>
                </section>
            </main>
        </div>

        <script>
            (function () {
                const chatMessagesEl = document.getElementById('chatMessages');
                const chatInput = document.getElementById('chatInput');
                const chatSendBtn = document.getElementById('chatSendBtn');
                const quickActionButtons = document.querySelectorAll('.quick-actions button');

                const counselorGrid = document.getElementById('counselorGrid');
                const upcomingSessionsEl = document.getElementById('upcomingSessions');
                const completedSessionsEl = document.getElementById('completedSessions');

                const tabButtons = document.querySelectorAll('.tab');
                const tabPanels = document.querySelectorAll('.tab-panel');

                const counselors = [
                    {
                        initials: 'SJ',
                        name: 'Dr. Sarah Johnson',
                        specialty: 'Anxiety & Stress Management',
                        rating: 4.9,
                        availability: ['Mon 9AM-5PM', 'Wed 9AM-5PM', 'Fri 9AM-5PM']
                    },
                    {
                        initials: 'MC',
                        name: 'Dr. Michael Chen',
                        specialty: 'Depression & Mood Disorders',
                        rating: 4.8,
                        availability: ['Tue 10AM-4PM', 'Thu 10AM-4PM']
                    },
                    {
                        initials: 'ER',
                        name: 'Dr. Emily Rodriguez',
                        specialty: 'Student Life & Academic Stress',
                        rating: 4.9,
                        availability: ['Mon 1PM-5PM', 'Tue 9AM-3PM', 'Wed 1PM-5PM', 'Fri 9AM-3PM']
                    }
                ];

                let upcomingSessions = [
                    { counselor: 'Dr. Sarah Johnson', date: '2025-11-10', time: '10:00 AM', status: 'Confirmed' }
                ];

                let completedSessions = [
                    { counselor: 'Dr. Michael Chen', date: '2025-10-28', time: '2:00 PM', status: 'Completed' }
                ];

                const initialMessages = [
                    { sender: 'assistant', text: 'Hi! I’m your mental health assistant. How can I help you today?' }
                ];

                function renderChat(messages) {
                    chatMessagesEl.innerHTML = '';
                    messages.forEach(msg => {
                        const bubble = document.createElement('div');
                        bubble.className = 'message ' + (msg.sender === 'user' ? 'user' : '');
                        bubble.textContent = msg.text;
                        chatMessagesEl.appendChild(bubble);
                    });
                    chatMessagesEl.scrollTop = chatMessagesEl.scrollHeight;
                }

                let chatHistory = [...initialMessages];
                renderChat(chatHistory);

                function sendMessage(text) {
                    chatHistory.push({ sender: 'user', text });
                    renderChat(chatHistory);
                    chatInput.value = '';
                    setTimeout(() => {
                        chatHistory.push({ sender: 'assistant', text: generateAssistantResponse(text) });
                        renderChat(chatHistory);
                    }, 800);
                }

                function generateAssistantResponse(userText) {
                    const lowered = userText.toLowerCase();
                    if (lowered.includes('anxious')) {
                        return 'Deep, slow breaths can help. Would you like a guided breathing exercise?';
                    }
                    if (lowered.includes('stressed')) {
                        return 'I hear you. Taking a short break or journaling your thoughts may help ease stress.';
                    }
                    if (lowered.includes('counseling')) {
                        return 'You can book a counselling session under the “Book Session” tab. Would you like me to highlight a counselor for you?';
                    }
                    if (lowered.includes('resources')) {
                        return 'Here are curated resources: mindful meditation, coping toolkits, and peer support groups.';
                    }
                    return 'Thanks for sharing. I’m here to listen. Tell me more about what’s on your mind.';
                }

                chatSendBtn.addEventListener('click', () => {
                    const text = chatInput.value.trim();
                    if (text.length > 0) {
                        sendMessage(text);
                    }
                });

                chatInput.addEventListener('keypress', event => {
                    if (event.key === 'Enter') {
                        event.preventDefault();
                        chatSendBtn.click();
                    }
                });

                quickActionButtons.forEach(button => {
                    button.addEventListener('click', () => sendMessage(button.dataset.quick));
                });

                function switchTab(tab) {
                    tabButtons.forEach(btn => btn.classList.toggle('active', btn === tab));
                    tabPanels.forEach(panel => panel.hidden = panel.dataset.panel !== tab.dataset.tab);
                }

                tabButtons.forEach(button => {
                    button.addEventListener('click', () => switchTab(button));
                });

                function renderCounselors() {
                    counselorGrid.innerHTML = '';
                    counselors.forEach(counselor => {
                        const card = document.createElement('div');
                        card.className = 'session-card';
                        card.innerHTML = `
                <div style="width:54px;height:54px;border-radius:18px;background:#00c2c7;color:#fff;margin:0 auto 12px;display:flex;align-items:center;justify-content:center;font-weight:700;">\${counselor.initials}</div>
                <h3 style="margin:0;">\${counselor.name}</h3>
                <p style="margin:4px 0 0;color:#6c7b91;">\${counselor.specialty}</p>
                <p style="margin:6px 0 0;">⭐ \${counselor.rating}</p>
                <p style="margin:8px 0 0;font-size:13px;color:#4a5568;">\${counselor.availability.join('<br>')}</p>
            `;
                        const button = document.createElement('button');
                        button.textContent = 'Book Session';
                        button.addEventListener('click', () => bookSession(counselor));
                        card.appendChild(button);
                        counselorGrid.appendChild(card);
                    });
                }

                function bookSession(counselor) {
                    const date = prompt(`Select a date for \${counselor.name} (YYYY-MM-DD):`, new Date().toISOString().split('T')[0]);
                    if (!date) {
                        return;
                    }
                    const time = prompt('Preferred time (e.g., 2:00 PM):', '2:00 PM');
                    if (!time) {
                        return;
                    }
                    upcomingSessions.push({ counselor: counselor.name, date, time, status: 'Pending' });
                    alert('Session requested. We will confirm shortly!');
                    renderSessions();
                    switchTab(document.querySelector('[data-tab="sessions"]'));
                }

                function renderSessions() {
                    upcomingSessionsEl.innerHTML = '';
                    if (upcomingSessions.length === 0) {
                        upcomingSessionsEl.innerHTML = '<p style="color:#6c7b91;">No upcoming sessions. Book one to get started!</p>';
                    } else {
                        upcomingSessions.forEach(session => {
                            const card = document.createElement('div');
                            card.className = 'session-item';
                            card.innerHTML = `
                    <strong>\${session.counselor}</strong>
                    <p style="margin:6px 0 0;color:#4a5568;">\${new Date(session.date).toLocaleDateString()} · \${session.time}</p>
                    <footer>
                        <span class="status-pill">\${session.status}</span>
                        <button>Reschedule</button>
                    </footer>
                `;
                            upcomingSessionsEl.appendChild(card);
                        });
                    }

                    completedSessionsEl.innerHTML = '';
                    if (completedSessions.length === 0) {
                        completedSessionsEl.innerHTML = '<p style="color:#6c7b91;">No completed sessions yet.</p>';
                    } else {
                        completedSessions.forEach(session => {
                            const card = document.createElement('div');
                            card.className = 'session-item';
                            card.innerHTML = `
                    <strong>\${session.counselor}</strong>
                    <p style="margin:6px 0 0;color:#4a5568;">\${new Date(session.date).toLocaleDateString()} · \${session.time}</p>
                    <footer>
                        <span class="status-pill" style="background:rgba(37,99,235,0.15);color:#1d4ed8;">\${session.status}</span>
                        <button>Give Feedback</button>
                    </footer>
                `;
                            completedSessionsEl.appendChild(card);
                        });
                    }
                }

                renderCounselors();
                renderSessions();
            })();
        </script>
    </body>

    </html>