<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Choose a Role</title>
    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, sans-serif;
            background: linear-gradient(180deg, #f3f7ff 0%, #ffffff 70%);
            color: #1c1c1c;
        }

        .page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .card {
            width: 100%;
            max-width: 520px;
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 25px 80px rgba(9, 36, 65, 0.12);
            padding: 48px 40px 28px;
            text-align: center;
        }

        .logo-wrap {
            width: 108px;
            height: 108px;
            border-radius: 32px;
            margin: 0 auto 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at 30% 20%, #e9fbff 0%, #d6f3ff 60%, #bee5ff 100%);
        }

        .logo-wrap svg {
            width: 78px;
            height: 78px;
        }

        h1 {
            font-size: 32px;
            margin: 4px 0 8px;
            color: #0a2540;
        }

        .subtitle {
            margin-bottom: 32px;
            font-size: 16px;
            color: #5c6f82;
            line-height: 1.6;
        }

        .instruction {
            margin-bottom: 18px;
            font-weight: 600;
            color: #0a2540;
        }

        .role-card {
            display: flex;
            align-items: center;
            text-decoration: none;
            padding: 16px 18px;
            border-radius: 16px;
            color: #fff;
            margin-bottom: 14px;
            box-shadow: 0 15px 45px rgba(10, 37, 64, 0.13);
            transition: transform 0.12s ease, box-shadow 0.12s ease;
        }

        .role-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 55px rgba(10, 37, 64, 0.18);
        }

        .role-card:last-of-type {
            margin-bottom: 26px;
        }

        .role-avatar {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin-right: 16px;
        }

        .role-meta {
            text-align: left;
        }

        .role-name {
            font-size: 18px;
            font-weight: 600;
        }

        .role-desc {
            font-size: 14px;
            margin-top: 2px;
            opacity: 0.9;
        }

        .card-footer {
            font-size: 12px;
            color: #8796a9;
            letter-spacing: 0.5px;
        }

        .student { background: linear-gradient(90deg, #2d8bff, #2462f7); }
        .faculty { background: linear-gradient(90deg, #c04bff, #9335d8); }
        .professional { background: linear-gradient(90deg, #00bfa5, #00a589); }
        .admin { background: linear-gradient(90deg, #ff7a18, #ff5b24); }

        @media (max-width: 520px) {
            .card {
                padding: 36px 24px 20px;
            }
        }
    </style>
</head>
<body>
<main class="page">
    <section class="card">
        <div class="logo-wrap">
            <svg class="brand-mark" viewBox="0 0 120 120" role="img" aria-labelledby="logoTitle">
                <title id="logoTitle">ZenithMind Logo</title>
                <defs>
                    <linearGradient id="brainFill" x1="20" y1="15" x2="100" y2="110" gradientUnits="userSpaceOnUse">
                        <stop offset="0" stop-color="#7ad7ff"/>
                        <stop offset="1" stop-color="#0095b0"/>
                    </linearGradient>
                    <linearGradient id="accentStroke" x1="40" y1="45" x2="98" y2="94" gradientUnits="userSpaceOnUse">
                        <stop offset="0" stop-color="#7de3ff"/>
                        <stop offset="1" stop-color="#0a7cc0"/>
                    </linearGradient>
                </defs>
                <circle cx="60" cy="20" r="12" fill="#c1f5ff" opacity="0.9"/>
                <g stroke="#9eeaff" stroke-width="3" stroke-linecap="round">
                    <line x1="60" y1="4" x2="60" y2="12"/>
                    <line x1="46" y1="8" x2="50" y2="15"/>
                    <line x1="74" y1="8" x2="70" y2="15"/>
                    <line x1="38" y1="20" x2="45" y2="22"/>
                    <line x1="82" y1="20" x2="75" y2="22"/>
                </g>
                <path d="M60 12
                         A27 27 0 0 0 33 37
                         A23 23 0 0 0 10 60
                         A23 23 0 0 0 33 83
                         A24 24 0 0 0 57 107
                         A24 24 0 0 0 82 92
                         A22 22 0 0 0 107 70
                         A18 18 0 0 0 94 45
                         A27 27 0 0 0 60 12 Z"
                      fill="url(#brainFill)"
                      stroke="#0f7596"
                      stroke-width="4"
                      stroke-linejoin="round"/>
                <path d="M38 73 L53 52 65 70 76 55 94 83"
                      fill="none"
                      stroke="url(#accentStroke)"
                      stroke-width="5"
                      stroke-linecap="round"
                      stroke-linejoin="round"/>
                <path d="M54 80 Q44 80 44 88 Q44 98 56 98 Q64 98 68 94"
                      fill="none"
                      stroke="#0c718f"
                      stroke-width="4"
                      stroke-linecap="round"
                      stroke-linejoin="round"/>
            </svg>
        </div>
        <h1>ZenithMind</h1>
        <p class="subtitle">Digital Mental Health Literacy Hub for Higher Education</p>
        <p class="instruction">Select a user role to explore the platform</p>

        <a class="role-card student" href="dashboard?role=student">
            <div class="role-avatar">S</div>
            <div class="role-meta">
                <div class="role-name">Ali - Student</div>
                <div class="role-desc">Computer Science Department</div>
            </div>
        </a>

        <a class="role-card faculty" href="dashboard?role=faculty">
            <div class="role-avatar">F</div>
            <div class="role-meta">
                <div class="role-name">Aiman - Faculty Member</div>
                <div class="role-desc">Psychology Department</div>
            </div>
        </a>

        <a class="role-card professional" href="dashboard?role=professional">
            <div class="role-avatar">P</div>
            <div class="role-meta">
                <div class="role-name">Aisyah - Mental Health Professional</div>
                <div class="role-desc">Counseling Services</div>
            </div>
        </a>

        <a class="role-card admin" href="dashboard?role=admin">
            <div class="role-avatar">A</div>
            <div class="role-meta">
                <div class="role-name">Ain - Administrator</div>
                <div class="role-desc">System Administration</div>
            </div>
        </a>

        <div class="card-footer">GDPR &amp; HIPAA Compliant • Secure &amp; Confidential</div>
    </section>
</main>
</body>
</html>
