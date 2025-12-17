<%@ page contentType="text/html; charset=UTF-8" import="java.util.*" %>
<%!
    public static class ModuleContent {
        String slug;
        String title;
        String description;
        String duration;
        int points;
        int progress;
        String status;
        String buttonLabel;
        String icon;
        String[] sections;
        int currentSection;

        ModuleContent(String slug, String title, String description, String duration,
                      int points, int progress, String status, String buttonLabel,
                      String icon, String[] sections, int currentSection) {
            this.slug = slug;
            this.title = title;
            this.description = description;
            this.duration = duration;
            this.points = points;
            this.progress = progress;
            this.status = status;
            this.buttonLabel = buttonLabel;
            this.icon = icon;
            this.sections = sections;
            this.currentSection = Math.max(1, Math.min(currentSection, sections.length));
        }
    }
%>
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

    List<ModuleContent> modules = new ArrayList<>();
    modules.add(new ModuleContent(
            "stress-management",
            "Stress Management",
            "Learn techniques to manage daily stress and build healthy routines.",
            "15 min",
            50,
            100,
            "done",
            "Review",
            "✅",
            new String[]{"Introduction to Stress", "Identifying Triggers", "Coping Strategies", "Daily Routine Reset", "Knowledge Check"},
            5
    ));
    modules.add(new ModuleContent(
            "understanding-anxiety",
            "Understanding Anxiety",
            "Learn about anxiety, its causes, symptoms, and effective coping strategies.",
            "20 min",
            75,
            60,
            "progress",
            "Continue",
            "📘",
            new String[]{"Introduction to Anxiety", "Types of Anxiety Disorders", "Symptoms and Signs", "Coping Strategies", "Quiz"},
            1
    ));
    modules.add(new ModuleContent(
            "depression-awareness",
            "Depression Awareness",
            "Recognize signs, risk factors, and when to seek help.",
            "25 min",
            100,
            0,
            "start",
            "Start",
            "💡",
            new String[]{"Understanding Depression", "Impact on Life", "Support Systems", "Treatment Options", "Self-Reflection"},
            1
    ));
    modules.add(new ModuleContent(
            "mindfulness-meditation",
            "Mindfulness & Meditation",
            "Practice staying present and calm with guided exercises.",
            "30 min",
            80,
            0,
            "start",
            "Start",
            "🧘",
            new String[]{"Mindfulness Basics", "Guided Meditation", "Breathing Practices", "Mindful Journaling", "Wrap-up"},
            1
    ));
    modules.add(new ModuleContent(
            "building-resilience",
            "Building Resilience",
            "Develop mental toughness and adaptability.",
            "25 min",
            90,
            0,
            "start",
            "Start",
            "💪",
            new String[]{"Resilience Mindset", "Managing Setbacks", "Growth Tools", "Case Studies", "Reflection Quiz"},
            1
    ));
    modules.add(new ModuleContent(
            "healthy-sleep",
            "Healthy Sleep",
            "Improve sleep habits for better wellbeing.",
            "20 min",
            60,
            0,
            "start",
            "Start",
            "😴",
            new String[]{"Sleep Foundations", "Routine Reset", "Relaxation Tools", "Sleep Myths", "Goal Setting"},
            1
    ));

    int completedCount = 0;
    int inProgressCount = 0;
    for (ModuleContent module : modules) {
        if ("done".equals(module.status)) {
            completedCount++;
        } else if ("progress".equals(module.status)) {
            inProgressCount++;
        }
    }

    String moduleSlug = request.getParameter("module");
    ModuleContent activeModule = null;
    if (moduleSlug != null) {
        for (ModuleContent module : modules) {
            if (module.slug.equals(moduleSlug)) {
                activeModule = module;
                break;
            }
        }
    }
    boolean showDetail = activeModule != null;

    String roleSuffix = "role=" + roleParam;
    String dashboardLink = "dashboard?" + roleSuffix;
    String modulesLink = "modules?" + roleSuffix;
    String selfAssessmentLink = "self-assessment?" + roleSuffix;
    String communityLink = "modules?section=community&" + roleSuffix;
    String moodLink = "mood?" + roleSuffix;
    String supportLink = "support?" + roleSuffix;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Learning Modules</title>
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
            background: rgba(0,179,199,0.15);
            color: var(--dark);
            font-weight: 600;
            font-size: 14px;
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
        }

        .summary-card {
            background: var(--card);
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 8px 25px rgba(12, 36, 64, 0.08);
            text-align: center;
        }

        .summary-card .value {
            font-size: 30px;
            font-weight: 700;
            color: var(--dark);
        }

        .summary-card .label {
            font-size: 14px;
            color: #6c7b91;
        }

        .modules-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 32px 0 14px;
        }

        .modules-heading h2 {
            margin: 0;
            color: var(--dark);
            font-size: 22px;
        }

        .modules-search input {
            width: 280px;
            padding: 10px 14px;
            border-radius: 14px;
            border: 1px solid var(--border);
            font-size: 14px;
        }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 18px;
        }

        .module-card {
            background: var(--card);
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 10px 25px rgba(15, 37, 64, 0.08);
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .module-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .module-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            background: rgba(0,179,199,0.12);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        .module-title {
            font-size: 17px;
            font-weight: 600;
            color: var(--dark);
        }

        .module-desc {
            font-size: 14px;
            color: #5c6f82;
            margin-top: 4px;
        }

        .status-pill {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .status-done { background: rgba(52,211,153,0.2); color: #047857; }
        .status-progress { background: rgba(251,191,36,0.2); color: #92400e; }
        .status-start { background: rgba(0,195,189,0.18); color: #047481; }

        .module-meta {
            display: flex;
            gap: 18px;
            font-size: 13px;
            color: #5c6f82;
        }

        .progress-track {
            width: 100%;
            height: 8px;
            border-radius: 6px;
            background: #e3ecf4;
            position: relative;
        }

        .progress-fill {
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            border-radius: 6px;
            background: var(--teal);
        }

        .module-action {
            display: inline-block;
            text-align: center;
            text-decoration: none;
            padding: 12px 0;
            border-radius: 12px;
            background: linear-gradient(120deg, #00b3c7, #01a0f9);
            color: #fff;
            font-weight: 600;
        }

        .back-link {
            text-decoration: none;
            color: var(--dark);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 12px;
        }

        .duration-pill {
            display: inline-flex;
            padding: 6px 14px;
            border-radius: 18px;
            background: rgba(149,128,255,0.18);
            color: #6d3df6;
            font-size: 13px;
            font-weight: 600;
        }

        .detail-progress {
            margin: 18px 0;
            background: var(--card);
            border-radius: 14px;
            padding: 14px 18px;
            box-shadow: inset 0 0 0 1px var(--border);
        }

        .detail-progress-bar {
            height: 8px;
            border-radius: 8px;
            background: #e3ecf4;
            margin-top: 12px;
            position: relative;
        }

        .detail-progress-bar span {
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            border-radius: 8px;
            background: #1f2937;
        }

        .section-tabs {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin: 18px 0;
        }

        .section-tab {
            border: none;
            padding: 8px 14px;
            border-radius: 20px;
            background: #e8ecf2;
            color: #4a5568;
            font-weight: 600;
            cursor: pointer;
        }

        .section-tab.active {
            background: var(--dark);
            color: #fff;
        }

        .detail-card {
            background: var(--card);
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 10px 40px rgba(12, 36, 64, 0.08);
        }

        .video-placeholder {
            margin-top: 16px;
            border: 2px dashed #cdd7e4;
            border-radius: 18px;
            height: 260px;
            background: #f8fafc;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #8a99ad;
            font-weight: 600;
        }

        .detail-actions {
            margin-top: 18px;
            display: flex;
            justify-content: space-between;
        }

        .detail-actions button {
            min-width: 110px;
            padding: 12px 20px;
            border-radius: 12px;
            border: none;
            font-weight: 600;
            cursor: pointer;
        }

        .detail-actions .prev {
            background: #f0f2f7;
            color: #4a5568;
        }

        .detail-actions .next {
            background: var(--dark);
            color: #fff;
        }

        @media (max-width: 1080px) {
            .app-shell {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
            }
            .summary {
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            }
            .modules-heading {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            .modules-search input,
            .search input {
                width: 100%;
            }
            .top-bar {
                flex-direction: column;
                align-items: flex-start;
            }
            .search {
                width: 100%;
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<div class="app-shell">
    <%@ include file="common/sidebar.jsp" %>

    <main class="content">
        <div class="top-bar">
            <div style="width:100%;">
                <% if (showDetail) { %>
                <a class="back-link" href="<%= modulesLink %>">← Back to Modules</a>
                <h1><%= activeModule.title %></h1>
                <p style="margin:0;color:#7c8b9e;"><%= activeModule.description %></p>
                <% } else { %>
                <p style="margin:0;font-size:14px;color:#7c8b9e;">Expand your knowledge with interactive lessons</p>
                <h1>Learning Modules 📚</h1>
                <% } %>
            </div>
            <div class="search">
                <input type="text" placeholder="Search for modules, resources, or support...">
                <div class="score-pill">Wellness Score: <strong><%= wellnessScore %> / 100</strong></div>
            </div>
        </div>

        <% if (showDetail) { %>
        <span class="duration-pill"><%= activeModule.duration %></span>
        <div class="detail-progress">
            <div style="display:flex;justify-content:space-between;font-size:13px;font-weight:600;">
                <span>Module Progress</span>
                <span>Section <%= activeModule.currentSection %> of <%= activeModule.sections.length %></span>
            </div>
            <div class="detail-progress-bar">
                <span style="width:<%= activeModule.progress %>%"></span>
            </div>
        </div>

        <div class="section-tabs">
            <% for (int i = 0; i < activeModule.sections.length; i++) { %>
            <button class="section-tab <%= (i + 1 == activeModule.currentSection) ? "active" : "" %>">
                <%= activeModule.sections[i] %>
            </button>
            <% } %>
        </div>

        <div class="detail-card">
            <h3 style="margin:0;color:var(--dark);"><%= activeModule.sections[activeModule.currentSection - 1] %></h3>
            <div class="video-placeholder">
                <div style="font-size:36px;margin-bottom:10px;">▶</div>
                <div>Video Player</div>
                <div style="font-size:13px;font-weight:400;">Video content would play here</div>
            </div>
            <div class="detail-actions">
                <button class="prev" <%= activeModule.currentSection == 1 ? "disabled" : "" %>>Previous</button>
                <button class="next"><%= activeModule.currentSection == activeModule.sections.length ? "Finish" : "Next" %></button>
            </div>
        </div>
        <% } else { %>
        <div class="summary">
            <div class="summary-card">
                <div class="value"><%= modules.size() %></div>
                <div class="label">Total Modules</div>
            </div>
            <div class="summary-card">
                <div class="value"><%= completedCount %></div>
                <div class="label">Completed</div>
            </div>
            <div class="summary-card">
                <div class="value"><%= inProgressCount %></div>
                <div class="label">In Progress</div>
            </div>
        </div>

        <div class="modules-heading">
            <h2>Browse Modules</h2>
            <div class="modules-search">
                <input type="text" placeholder="Search modules by title or topic...">
            </div>
        </div>

        <div class="modules-grid">
            <% for (ModuleContent module : modules) {
                String pillClass = "status-start";
                String pillLabel = "Start";
                if ("done".equals(module.status)) {
                    pillClass = "status-done";
                    pillLabel = "Done";
                } else if ("progress".equals(module.status)) {
                    pillClass = "status-progress";
                    pillLabel = "In Progress";
                }
            %>
            <div class="module-card">
                <div class="module-header">
                    <div class="module-icon"><%= module.icon %></div>
                    <span class="status-pill <%= pillClass %>"><%= pillLabel %></span>
                </div>
                <div>
                    <div class="module-title"><%= module.title %></div>
                    <div class="module-desc"><%= module.description %></div>
                </div>
                <div class="module-meta">
                    <span><%= module.duration %></span>
                    <span><%= module.points %> pts</span>
                </div>
                <div class="progress-track">
                    <div class="progress-fill" style="width:<%= module.progress %>%"></div>
                </div>
                <a class="module-action" href="modules?module=<%= module.slug %>&<%= roleSuffix %>">
                    <%= module.buttonLabel %>
                </a>
            </div>
            <% } %>
        </div>
        <% } %>
    </main>
</div>
</body>
</html>
