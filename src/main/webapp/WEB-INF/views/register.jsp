<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>ZenithMind | Student Registration</title>
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
            max-width: 480px;
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 25px 80px rgba(9, 36, 65, 0.12);
            padding: 48px 40px 38px;
            text-align: center;
        }

        .logo-wrap {
            width: 88px;
            height: 88px;
            border-radius: 24px;
            margin: 0 auto 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: radial-gradient(circle at 30% 20%, #e9fbff 0%, #d6f3ff 60%, #bee5ff 100%);
        }

        .logo-wrap svg {
            width: 62px;
            height: 62px;
        }

        h1 {
            font-size: 28px;
            margin: 4px 0 8px;
            color: #0a2540;
        }

        .subtitle {
            margin-bottom: 32px;
            font-size: 14px;
            color: #5c6f82;
            line-height: 1.6;
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 600;
            color: #4f5b66;
        }

        .form-group input {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #e0e6ed;
            border-radius: 12px;
            font-size: 16px;
            color: #1a1f36;
            background: #ffffff;
            transition: border-color 0.2s, box-shadow 0.2s;
            box-sizing: border-box;
        }

        .form-group input:focus {
            outline: none;
            border-color: #2d8bff;
            box-shadow: 0 0 0 4px rgba(45, 139, 255, 0.15);
        }

        .btn-register {
            width: 100%;
            padding: 14px;
            background: linear-gradient(90deg, #2d8bff, #2462f7);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.12s ease, box-shadow 0.12s ease;
            margin-top: 10px;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(36, 98, 247, 0.25);
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .error-msg {
            background: #fff0f0;
            color: #d12424;
            padding: 12px;
            border-radius: 12px;
            font-size: 14px;
            margin-bottom: 24px;
            border: 1px solid #ffdada;
            text-align: left;
        }

        .success-msg {
            background: #f0fff4;
            color: #059669;
            padding: 12px;
            border-radius: 12px;
            font-size: 14px;
            margin-bottom: 24px;
            border: 1px solid #d1fae5;
        }

        .back-link {
            margin-top: 24px;
            font-size: 14px;
            color: #5c6f82;
        }

        .back-link a {
            color: #2d8bff;
            text-decoration: none;
            font-weight: 600;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        .card-footer {
            margin-top: 32px;
            font-size: 12px;
            color: #8796a9;
            letter-spacing: 0.5px;
        }

        .password-hint {
            font-size: 12px;
            color: #6b7280;
            margin-top: 4px;
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
                            <stop offset="0" stop-color="#7ad7ff" />
                            <stop offset="1" stop-color="#0095b0" />
                        </linearGradient>
                        <linearGradient id="accentStroke" x1="40" y1="45" x2="98" y2="94"
                            gradientUnits="userSpaceOnUse">
                            <stop offset="0" stop-color="#7de3ff" />
                            <stop offset="1" stop-color="#0a7cc0" />
                        </linearGradient>
                    </defs>
                    <circle cx="60" cy="20" r="12" fill="#c1f5ff" opacity="0.9" />
                    <path
                        d="M60 12 A27 27 0 0 0 33 37 A23 23 0 0 0 10 60 A23 23 0 0 0 33 83 A24 24 0 0 0 57 107 A24 24 0 0 0 82 92 A22 22 0 0 0 107 70 A18 18 0 0 0 94 45 A27 27 0 0 0 60 12 Z"
                        fill="url(#brainFill)" stroke="#0f7596" stroke-width="4" stroke-linejoin="round" />
                    <path d="M38 73 L53 52 65 70 76 55 94 83" fill="none" stroke="url(#accentStroke)" stroke-width="5"
                        stroke-linecap="round" stroke-linejoin="round" />
                </svg>
            </div>
            <h1>Create Student Account</h1>
            <p class="subtitle">Join ZenithMind to access mental health resources</p>

            <% if (request.getAttribute("error") !=null) { %>
                <div class="error-msg">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                    <% if (request.getAttribute("success") !=null) { %>
                        <div class="success-msg">
                            <%= request.getAttribute("success") %>
                        </div>
                        <% } %>

                            <form action="${pageContext.request.contextPath}/register" method="post"
                                onsubmit="return validateForm()">
                                <div class="form-group">
                                    <label for="username">Username *</label>
                                    <input type="text" id="username" name="username" placeholder="Choose a username"
                                        required autofocus>
                                </div>

                                <div class="form-group">
                                    <label for="name">Full Name *</label>
                                    <input type="text" id="name" name="name" placeholder="Enter your full name"
                                        required>
                                </div>

                                <div class="form-group">
                                    <label for="email">Email (Optional)</label>
                                    <input type="email" id="email" name="email" placeholder="your.email@student.edu">
                                </div>

                                <div class="form-group">
                                    <label for="password">Password *</label>
                                    <input type="password" id="password" name="password" placeholder="Create a password"
                                        required>
                                    <div class="password-hint">At least 6 characters</div>
                                </div>

                                <div class="form-group">
                                    <label for="confirmPassword">Confirm Password *</label>
                                    <input type="password" id="confirmPassword" name="confirmPassword"
                                        placeholder="Re-enter your password" required>
                                </div>

                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <button type="submit" class="btn-register">Create Account</button>
                            </form>

                            <div class="back-link">
                                <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in
                                        here</a></p>
                            </div>

                            <div class="card-footer">GDPR &amp; HIPAA Compliant • Secure &amp; Confidential</div>
        </section>
    </main>

    <script>
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password.length < 6) {
                alert('Password must be at least 6 characters long');
                return false;
            }

            if (password !== confirmPassword) {
                alert('Passwords do not match');
                return false;
            }

            return true;
        }
    </script>
</body>

</html>