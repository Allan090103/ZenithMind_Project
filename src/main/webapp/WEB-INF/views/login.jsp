<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ZenithMind | Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>

        <div class="auth-wrapper">
            <div class="auth-card">
                <h1>ZenithMind</h1>
                <p>Embark on your wellness journey.</p>

                <div style="margin: 2rem 0;">
                    <!-- Placeholder Form -->
                    <input type="text" placeholder="Username"
                        style="width: 100%; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 6px;">
                    <input type="password" placeholder="Password"
                        style="width: 100%; padding: 10px; margin-bottom: 20px; border: 1px solid #ddd; border-radius: 6px;">
                </div>

                <a href="dashboard" class="btn btn-primary" style="display: block;">Sign In</a>
            </div>
        </div>

    </body>

    </html>