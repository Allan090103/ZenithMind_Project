<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String roleParam = request.getParameter("role");
    if (roleParam == null || roleParam.trim().isEmpty()) {
        roleParam = "student";
    }
    roleParam = roleParam.toLowerCase();

    String name = "Ali";
    String email = "ali@student.edu";
    String department = "Computer Science";
    if ("faculty".equals(roleParam)) {
        name = "Aiman"; email = "aiman@faculty.edu"; department = "Psychology";
    } else if ("professional".equals(roleParam)) {
        name = "Aisyah"; email = "aisyah@wellness.org"; department = "Counseling";
    } else if ("admin".equals(roleParam)) {
        name = "Ain"; email = "ain@admin.edu"; department = "Administration";
    }

    String roleSuffix = "role=" + roleParam;
%>
<%@ include file="common/header.jsp" %>

<section class="main-content">
    <div style="max-width:920px; margin:0 auto;">
        <h1>Profile Settings ⚙️</h1>
        <p>Manage your account preferences and privacy settings</p>

        <style>
            .settings-grid { display: grid; gap: 16px; margin-top:16px; }
            .settings-grid .card { padding:18px; }
            .form-row { display:flex; gap:12px; flex-wrap:wrap; }
            .form-field { flex:1; min-width:200px; display:flex; flex-direction:column; }
            .form-field input { padding:10px; border-radius:8px; border:1px solid rgba(15,37,64,0.06); }
            .toggle { position:relative; width:48px; height:28px; background:#e6eef8; border-radius:16px; cursor:pointer; }
            .toggle input { display:none; }
            .toggle .knob { position:absolute; top:3px; left:3px; width:22px; height:22px; background:#fff; border-radius:50%; transition:all .18s; box-shadow:0 2px 6px rgba(2,6,23,0.08); }
            .toggle input:checked + .knob { left:23px; background:var(--accent, #0d9488); }
            .field-label { font-weight:600; margin-bottom:6px; color:var(--text-main, #0f172a); }
            .card-footer-actions { margin-top:12px; display:flex; gap:12px; }
            .page-logout { margin-top:28px; display:flex; justify-content:center; }
        </style>

        <div class="settings-grid">
            <div class="card">
                <h2 style="margin-top:0">Profile Information</h2>
                <form method="post" action="profile-settings/save?<%= roleSuffix %>">
                    <div class="form-row">
                        <div class="form-field">
                            <label class="field-label">Full Name</label>
                            <input type="text" name="fullName" value="<%= name %>" />
                        </div>
                        <div class="form-field">
                            <label class="field-label">Email</label>
                            <input type="email" name="email" value="<%= email %>" />
                        </div>
                        <div class="form-field">
                            <label class="field-label">Faculty / Department</label>
                            <input type="text" name="department" value="<%= department %>" />
                        </div>
                    </div>
                    <div class="card-footer-actions">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>

            <div class="card">
                <h2 style="margin-top:0">Notifications</h2>
                <form method="post" action="profile-settings/notifications?<%= roleSuffix %>">
                    <div style="display:flex; flex-direction:column; gap:12px; margin-top:8px;">
                        <label style="display:flex; justify-content:space-between; align-items:center;">
                            <div>
                                <div style="font-weight:600">Email Notifications</div>
                                <div style="color:var(--text-muted); font-size:13px">Receive updates via email</div>
                            </div>
                            <label class="toggle"><input type="checkbox" name="emailNotifications" checked /><span class="knob"></span></label>
                        </label>

                        <label style="display:flex; justify-content:space-between; align-items:center;">
                            <div>
                                <div style="font-weight:600">Push Notifications</div>
                                <div style="color:var(--text-muted); font-size:13px">Browser notifications</div>
                            </div>
                            <label class="toggle"><input type="checkbox" name="pushNotifications" /><span class="knob"></span></label>
                        </label>

                        <label style="display:flex; justify-content:space-between; align-items:center;">
                            <div>
                                <div style="font-weight:600">Daily Mood Reminders</div>
                                <div style="color:var(--text-muted); font-size:13px">Remind to log mood</div>
                            </div>
                            <label class="toggle"><input type="checkbox" name="dailyReminders" checked /><span class="knob"></span></label>
                        </label>

                        <div class="card-footer-actions">
                            <button type="submit" class="btn btn-primary">Save Notification Settings</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="card">
                <h2 style="margin-top:0">Privacy & Security</h2>
                <p style="color:var(--text-muted)">Your data is encrypted and protected. We comply with GDPR and HIPAA standards.</p>
                <div style="display:flex; gap:12px; margin-top:12px; flex-wrap:wrap;">
                    <a href="profile-settings/download?<%= roleSuffix %>" class="btn" style="background:#eef6fb; color:var(--text-main);">Download My Data</a>
                    <a href="profile-settings/delete?<%= roleSuffix %>" class="btn btn-danger">Delete Account</a>
                </div>
            </div>
        </div>

        <div class="page-logout">
            <a href="${pageContext.request.contextPath}/? <%= roleSuffix %>" class="btn" style="background:#f3f4f6;">Logout</a>
        </div>

    </div>
</section>

<%@ include file="common/footer.jsp" %>
