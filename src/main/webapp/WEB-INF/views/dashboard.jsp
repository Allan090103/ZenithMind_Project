<%@ page contentType="text/html; charset=UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>ZenithMind Dashboard</title>
        <%@ include file="common/header.jsp" %>

            <div style="text-align: center; margin-bottom: 3rem;">
                <h1>Welcome back, Alex</h1>
                <p>Your daily wellness check-in awaits.</p>
            </div>

            <div class="card-grid">
                <a href="modules" class="card">
                    <div class="card-icon"><span class="material-symbols-outlined">menu_book</span></div>
                    <h3>Learning Modules</h3>
                    <p>Explore resources to build resilience and understanding.</p>
                    <span class="btn btn-primary" style="margin-top: auto; text-align: center;">Start Learning</span>
                </a>

                <a href="mood" class="card">
                    <div class="card-icon"><span class="material-symbols-outlined">mood</span></div>
                    <h3>Mood Tracker</h3>
                    <p>Log your emotions and track your journey over time.</p>
                    <span class="btn btn-primary" style="margin-top: auto; text-align: center;">Check In</span>
                </a>

                <a href="support" class="card">
                    <div class="card-icon"><span class="material-symbols-outlined">forum</span></div>
                    <h3>Virtual Support</h3>
                    <p>Connect with professionals or your support circle.</p>
                    <span class="btn btn-primary" style="margin-top: auto; text-align: center;">Get Help</span>
                </a>
            </div>

            <%@ include file="common/footer.jsp" %>

    </html>