<%@ include file="common/header.jsp" %>

    <div style="max-width: 600px; margin: 0 auto; text-align: center;">
        <h1>Mood Tracker</h1>
        <p>How are you feeling today?</p>

        <div class="card" style="margin-top: 2rem; display: flex; flex-direction: column; gap: 1rem;">
            <form style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <button class="btn" style="background:#dcfce7; color: #166534; padding: 2rem; font-size: 1.2rem;">😊
                    Happy</button>
                <button class="btn" style="background:#f1f5f9; color: #475569; padding: 2rem; font-size: 1.2rem;">😐
                    Neutral</button>
                <button class="btn" style="background:#dbeafe; color: #1e40af; padding: 2rem; font-size: 1.2rem;">😔
                    Sad</button>
                <button class="btn" style="background:#fee2e2; color: #991b1b; padding: 2rem; font-size: 1.2rem;">😡
                    Stressed</button>
            </form>
        </div>

        <div style="margin-top: 2rem;">
            <a href="dashboard" class="btn" style="background:var(--secondary); color:white;">⬅ Back to Dashboard</a>
        </div>
    </div>

    <%@ include file="common/footer.jsp" %>