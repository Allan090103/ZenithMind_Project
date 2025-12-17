<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String roleParam = request.getParameter("role");
    if (roleParam == null || roleParam.trim().isEmpty()) {
        roleParam = "student";
    }
    roleParam = roleParam.toLowerCase();

    String name = "Ali";
    String email = "ali@student.edu";
    String roleTitle = "Student";
    String department = "Computer Science Department";
    int wellnessScore = 72;

    if ("faculty".equals(roleParam)) {
        name = "Aiman";
        email = "aiman@faculty.edu";
        roleTitle = "Faculty Member";
        department = "Psychology Department";
        wellnessScore = 86;
    } else if ("professional".equals(roleParam)) {
        name = "Aisyah";
        email = "aisyah@wellness.org";
        roleTitle = "Mental Health Professional";
        department = "Counseling Services";
        wellnessScore = 91;
    } else if ("admin".equals(roleParam)) {
        name = "Ain";
        email = "ain@admin.edu";
        roleTitle = "Administrator";
        department = "System Administration";
        wellnessScore = 78;
    }

    String avatarInitial = name.substring(0, 1).toUpperCase();

    String selectedCategory = request.getParameter("category");
    if (selectedCategory == null || selectedCategory.isBlank()) {
        selectedCategory = "stress";
    }

    String[][] categories = {
        {"stress", "Stress Assessment", "Evaluate your current stress levels", "😰"},
        {"anxiety", "Anxiety Screening", "Assess anxiety symptoms", "😟"},
        {"depression", "Depression Screening", "Check for depression indicators", "😞"}
    };

    String[] questionPrompts = {
            "Felt nervous or stressed?",
            "Unable to control important things?",
            "Felt confident handling problems?",
            "Felt things were going your way?",
            "Felt difficulties piling up?"
    };

    String[] answerOptions = {"Not at all", "Several days", "Often", "Nearly daily"};

    String roleSuffix = "role=" + roleParam;
    String dashboardLink = "dashboard?" + roleSuffix;
    String modulesLink = "modules?" + roleSuffix;
    String selfAssessmentLink = "self-assessment?" + roleSuffix;
    String moodLink = "mood?" + roleSuffix;
    String supportLink = "support?" + roleSuffix;
    String communityLink = "modules?section=community&" + roleSuffix;
    String draftKey = "assessment_draft_" + roleParam + "_" + selectedCategory;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Self Assessment</title>
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
            background: linear-gradient(135deg, rgba(0,179,199,0.08), rgba(80,157,255,0.1));
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
            background: rgba(255,255,255,0.4);
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
            margin: 4px 0 0;
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
            background: rgba(0,179,199,0.15);
            color: var(--dark);
            font-weight: 600;
            font-size: 14px;
        }

        .assessment-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin: 24px 0;
        }

        .assessment-card {
            background: var(--card);
            border-radius: 18px;
            padding: 18px;
            border: 2px solid transparent;
            display: flex;
            flex-direction: column;
            gap: 6px;
            text-decoration: none;
            color: var(--dark);
        }

        .assessment-card.active {
            border-color: #04c0cb;
            box-shadow: 0 12px 50px rgba(4, 160, 180, 0.18);
        }

        .assessment-card span {
            font-size: 34px;
        }

        .assessment-card h3 {
            margin: 0;
            font-size: 17px;
        }

        .assessment-card p {
            margin: 0;
            font-size: 13px;
            color: #5c6f82;
        }

        .assessment-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        .question-card {
            background: var(--card);
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 12px 40px rgba(12, 36, 64, 0.08);
        }

        .question-card h2 {
            margin: 0 0 6px;
        }

        .question-card p {
            margin: 0 0 16px;
            color: #6c7b91;
        }

        .question-block {
            margin-bottom: 18px;
        }

        .question-block h4 {
            margin: 0 0 10px;
            color: var(--dark);
        }

        .option-row {
            display: grid;
            grid-template-columns: repeat(2, minmax(150px, 1fr));
            gap: 12px;
        }

        .radio-option {
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 10px 14px;
            text-align: center;
            font-weight: 600;
            cursor: pointer;
            background: #f8fafc;
        }

        .radio-option input {
            display: none;
        }

        .radio-option.selected {
            border-color: var(--dark);
            background: #e3e9f4;
        }

        .cta-row {
            margin-top: 22px;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .cta-row button {
            border: none;
            border-radius: 12px;
            padding: 12px 20px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-secondary {
            background: #f1f5f9;
            color: #4a5568;
        }

        .btn-primary {
            background: var(--dark);
            color: #fff;
        }

        .message {
            margin-top: 12px;
            padding: 12px 16px;
            border-radius: 12px;
            font-weight: 600;
            background: #f1f5f9;
            color: #1e293b;
        }

        .message.info {
            background: rgba(59,130,246,0.15);
            color: #1d4ed8;
        }

        .message.warning {
            background: rgba(251,191,36,0.25);
            color: #92400e;
        }

        .message.success {
            background: rgba(16,185,129,0.2);
            color: #047857;
        }

        .message.hidden {
            display: none;
        }

        .info-card {
            background: var(--card);
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 12px 40px rgba(12, 36, 64, 0.08);
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .info-card h3 {
            margin: 0;
        }

        .info-card p {
            margin: 0;
            font-size: 14px;
            color: #6c7b91;
        }

        .info-card button {
            border: none;
            border-radius: 12px;
            padding: 12px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-crisis {
            background: #ef4444;
            color: #fff;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--border);
            color: var(--dark);
        }

        @media (max-width: 1080px) {
            .app-shell {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
            }
            .assessment-layout {
                grid-template-columns: 1fr;
            }
            .option-row {
                grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
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
                    <linearGradient id="sidebarGrad" x1="8" y1="6" x2="56" y2="58" gradientUnits="userSpaceOnUse">
                        <stop offset="0" stop-color="#7de3ff"/>
                        <stop offset="1" stop-color="#0095b0"/>
                    </linearGradient>
                </defs>
                <path d="M32 7c-9 0-17 7-17 15-8 2-12 7-12 14 0 7 4 12 12 14 2 6 7 10 17 10 10 0 15-4 17-10 8-2 12-7 12-14s-4-12-12-14c0-8-8-15-17-15z"
                      fill="url(#sidebarGrad)"
                      stroke="#0f7596"
                      stroke-width="2"
                      stroke-linejoin="round"/>
                <path d="M16 42l10-13 9 11 9-12 12 16"
                      fill="none"
                      stroke="#e3fbff"
                      stroke-width="4"
                      stroke-linecap="round"
                      stroke-linejoin="round"/>
            </svg>
            <div class="brand-title">
                ZenithMind<br>
                <small style="font-size:12px;font-weight:500;color:#5a6a7f;">Mental Health Hub</small>
            </div>
        </div>

        <div class="user-card">
            <div class="avatar"><%= avatarInitial %></div>
            <div class="name"><%= name %></div>
            <div class="email"><%= email %></div>
            <div class="dept"><%= department %></div>
            <span class="badge"><%= roleTitle %></span>
        </div>

        <nav>
            <a href="<%= dashboardLink %>"><span class="icon">D</span>Dashboard</a>
            <a href="<%= modulesLink %>"><span class="icon">LM</span>Learning Modules</a>
            <a class="active" href="<%= selfAssessmentLink %>"><span class="icon">SA</span>Self Assessment</a>
            <a href="<%= moodLink %>"><span class="icon">MT</span>Mood Tracker</a>
            <a href="<%= supportLink %>"><span class="icon">VS</span>Virtual Support</a>
            <a href="<%= communityLink %>"><span class="icon">CF</span>Community Forum</a>
            <a href="#"><span class="icon">PS</span>Profile Settings</a>
        </nav>
    </aside>

    <main class="content">
        <div class="top-bar">
            <div>
                <p style="margin:0;font-size:14px;color:#7c8b9e;">Take confidential screenings to understand your mental health</p>
                <h1>Self Assessment 🧾</h1>
            </div>
            <div class="search">
                <input type="text" placeholder="Search for modules, resources, or support...">
                <div class="score-pill">Wellness Score: <strong><%= wellnessScore %> / 100</strong></div>
            </div>
        </div>

        <div class="assessment-cards">
            <% for (String[] category : categories) {
                boolean active = category[0].equals(selectedCategory);
            %>
            <a class="assessment-card <%= active ? "active" : "" %>"
               href="self-assessment?category=<%= category[0] %>&<%= roleSuffix %>">
                <span><%= category[3] %></span>
                <h3><%= category[1] %></h3>
                <p><%= category[2] %></p>
            </a>
            <% } %>
        </div>

        <div class="assessment-layout">
            <section class="question-card">
                <form id="assessmentForm" data-draft-key="<%= draftKey %>" data-question-count="<%= questionPrompts.length %>">
                <h2>Stress Assessment</h2>
                <p>Over the last 2 weeks, how often have you experienced the following:</p>

                <% for (int i = 0; i < questionPrompts.length; i++) {
                    String qLabel = questionPrompts[i];
                %>
                <div class="question-block">
                    <h4><%= (i + 1) %>. <%= qLabel %></h4>
                    <div class="option-row">
                        <% for (String option : answerOptions) {
                            String inputId = "q" + i + "-" + option.replaceAll("\\s+", "").toLowerCase();
                        %>
                        <label class="radio-option" for="<%= inputId %>">
                            <input type="radio" id="<%= inputId %>" name="question-<%= i %>" value="<%= option %>">
                            <%= option %>
                        </label>
                        <% } %>
                    </div>
                </div>
                <% } %>

                <div class="cta-row">
                    <button type="button" class="btn-secondary" id="saveDraftBtn">Save draft</button>
                    <button type="button" class="btn-primary" id="submitAssessmentBtn">Submit assessment</button>
                </div>
                <div id="assessmentMessage" class="message hidden" aria-live="polite"></div>
                <div id="assessmentSummary" class="message hidden"></div>
                </form>
            </section>

            <aside class="info-card">
                <div>
                    <h3>About These Assessments</h3>
                    <p><strong>Confidentiality</strong><br>
                        Your responses are private and secure. Results are for personal insight only.</p>
                    <p><strong>Not a Diagnosis</strong><br>
                        These screenings are educational tools. Consult a professional for medical guidance.</p>
                    <p><strong>When to Seek Help</strong><br>
                        Experiencing distress or symptoms that interfere with life? Reach out to support services.</p>
                </div>
                <div>
                    <p style="font-weight:600;margin-bottom:8px;">Need help now?</p>
                    <button class="btn-crisis">Call 988 - Crisis Line</button>
                    <button class="btn-outline">Contact Counseling Services</button>
                </div>
            </aside>
</div>
</main>
</div>

<script>
(function () {
const form = document.getElementById('assessmentForm');
if (!form) {
    return;
}

const messageBox = document.getElementById('assessmentMessage');
const summaryBox = document.getElementById('assessmentSummary');
const draftKey = form.dataset.draftKey;
const totalQuestions = parseInt(form.dataset.questionCount, 10);

form.addEventListener('change', event => {
    const target = event.target;
    if (target.matches('input[type="radio"]')) {
        highlightGroup(target.name);
        hideSummary();
    }
});

function highlightGroup(name) {
    const radios = form.querySelectorAll(`input[name="${name}"]`);
    radios.forEach(radio => {
        if (radio.parentElement) {
            radio.parentElement.classList.toggle('selected', radio.checked);
        }
    });
}

function collectResponses() {
    const result = {};
    form.querySelectorAll('input[type="radio"]:checked').forEach(input => {
        result[input.name] = input.value;
    });
    return result;
}

function showMessage(text, type) {
    if (!messageBox) {
        return;
    }
    messageBox.textContent = text;
    messageBox.className = 'message ' + type;
}

function showSummary(responses, statusText) {
    if (!summaryBox) {
        return;
    }
    const listItems = Object.keys(responses).map(name => {
        const questionIndex = parseInt(name.split('-')[1], 10);
        const label = form.querySelectorAll('.question-block h4')[questionIndex]?.textContent || `Question ${questionIndex + 1}`;
        return `<li><strong>${label}</strong>: ${responses[name]}</li>`;
    }).join('');
    summaryBox.innerHTML = `<p><strong>Result:</strong> ${statusText}</p><ul>${listItems}</ul>`;
    summaryBox.classList.remove('hidden');
}

function hideSummary() {
    if (summaryBox) {
        summaryBox.classList.add('hidden');
    }
}

function saveDraft() {
    const responses = collectResponses();
    localStorage.setItem(draftKey, JSON.stringify(responses));
    showMessage('Draft saved. You can revisit anytime.', 'info');
    hideSummary();
}

    function restoreDraft() {
        const saved = localStorage.getItem(draftKey);
        if (!saved) {
            return;
        }
        try {
            const parsed = JSON.parse(saved);
            Object.keys(parsed).forEach(name => {
                const value = parsed[name];
                const input = form.querySelector(`input[name="${name}"][value="${value}"]`);
                if (input) {
                    input.checked = true;
                    highlightGroup(name);
                }
            });
            showMessage('Draft loaded from your previous session.', 'info');
            } catch (err) {
            console.warn('Unable to parse draft data', err);
        }
    }

function submitAssessment() {
    const responses = collectResponses();
    if (Object.keys(responses).length !== totalQuestions) {
        showMessage('Please answer each question before submitting.', 'warning');
        hideSummary();
        return;
    }

    const scoreMap = {
        'Not at all': 0,
        'Several days': 1,
        'Often': 2,
        'Nearly daily': 3
    };
    let sum = 0;
    Object.values(responses).forEach(value => {
        sum += scoreMap[value] || 0;
    });
    const avg = sum / totalQuestions;
    let status = 'Low stress';
    if (avg >= 2.5) {
        status = 'High stress';
    } else if (avg >= 1.5) {
        status = 'Moderate stress';
    }
    localStorage.removeItem(draftKey);
    showMessage('Assessment submitted. Result: ' + status + '.', 'success');
    showSummary(responses, status);
}

    document.getElementById('saveDraftBtn').addEventListener('click', saveDraft);
    document.getElementById('submitAssessmentBtn').addEventListener('click', submitAssessment);

    restoreDraft();
})();
</script>
</body>
</html>
