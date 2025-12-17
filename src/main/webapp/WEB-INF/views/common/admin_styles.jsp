<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <style>
        :root {
            --teal: #00b3c7;
            --dark: #0a2540;
            --text: #4c5d70;
            --bg: #f5f7fb;
            --card: #ffffff;
            --border: #e5ebf4;
            --admin-accent: #f59e0b;
            --admin-success: #10b981;
            --admin-warning: #f59e0b;
            --admin-danger: #ef4444;
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
            background: linear-gradient(135deg, #f59e0b, #d97706);
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
            transition: all 0.2s ease;
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

        .dashboard {
            flex: 1;
            padding: 32px 48px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
            gap: 18px;
        }

        .welcome h1 {
            margin: 0;
            font-size: 28px;
            color: var(--dark);
        }

        .welcome p {
            margin: 0;
            font-size: 14px;
            color: #7c8b9e;
        }

        .card {
            background: var(--card);
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 8px 30px rgba(15, 37, 64, 0.08);
        }

        .card h2,
        .card h3 {
            margin-top: 0;
            color: var(--dark);
        }

        .btn {
            padding: 10px 18px;
            border-radius: 10px;
            border: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: var(--teal);
            color: #fff;
        }

        .btn-primary:hover {
            background: #00a0b0;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 179, 199, 0.3);
        }

        .sidebar-footer {
            margin-top: auto;
            display: flex;
            justify-content: center;
        }

        .logout-btn {
            display: inline-block;
            padding: 10px 14px;
            border-radius: 10px;
            background: #f3f4f6;
            color: var(--text);
            text-decoration: none;
            font-weight: 700;
            border: 1px solid rgba(0, 0, 0, 0.04);
            transition: all 0.2s ease;
        }

        .logout-btn:hover {
            background: #ffecec;
            color: #b91c1c;
        }

        @media (max-width: 1080px) {
            .app-shell {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
            }
        }
    </style>