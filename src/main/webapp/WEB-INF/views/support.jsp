<%@ include file="common/header.jsp" %>

    <div style="max-width: 600px; margin: 0 auto;">
        <h1>Virtual Support</h1>
        <p>Share what you're feeling. You're not alone.</p>

        <div class="card">
            <form>
                <textarea placeholder="Type your thoughts here..."
                    style="width: 100%; height: 150px; padding: 1rem; border: 1px solid #e2e8f0; border-radius: 8px; font-family: inherit; margin-bottom: 1rem; resize: vertical;"></textarea>
                <button class="btn btn-primary" style="width: 100%;">Send Message</button>
            </form>
        </div>

        <div style="margin-top: 2rem; text-align: center;">
            <a href="dashboard" class="btn" style="background:var(--secondary); color:white;">⬅ Back to Dashboard</a>
        </div>
    </div>

    <%@ include file="common/footer.jsp" %>