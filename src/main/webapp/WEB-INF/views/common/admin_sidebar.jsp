<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <aside class="sidebar">
        <div class="brand">
            <svg viewBox="0 0 64 64" role="img" aria-label="ZenithMind">
                <defs>
                    <linearGradient id="sidebarGrad" x1="8" y1="6" x2="56" y2="58" gradientUnits="userSpaceOnUse">
                        <stop offset="0" stop-color="#7de3ff" />
                        <stop offset="1" stop-color="#0095b0" />
                    </linearGradient>
                </defs>
                <path
                    d="M32 7c-9 0-17 7-17 15-8 2-12 7-12 14 0 7 4 12 12 14 2 6 7 10 17 10 10 0 15-4 17-10 8-2 12-7 12-14s-4-12-12-14c0-8-8-15-17-15z"
                    fill="url(#sidebarGrad)" stroke="#0f7596" stroke-width="2" stroke-linejoin="round" />
                <path d="M16 42l10-13 9 11 9-12 12 16" fill="none" stroke="#e3fbff" stroke-width="4"
                    stroke-linecap="round" stroke-linejoin="round" />
            </svg>
            <div class="brand-title">
                ZenithMind<br>
                <small style="font-size:12px;font-weight:500;color:#5a6a7f;">Mental Health Hub</small>
            </div>
        </div>

        <div class="user-card">
            <div class="avatar">
                ${avatarInitial}
            </div>
            <div class="name">
                ${name}
            </div>
            <div class="email">
                ${email}
            </div>
            <div class="dept">
                ${department}
            </div>
            <span class="badge">
                ${roleTitle}
            </span>
        </div>

        <nav>
            <a class="${activePage == 'dashboard' ? 'active' : ''}" href="${dashboardLink}"><span
                    class="icon">D</span>Dashboard</a>
            <a class="${activePage == 'panel' ? 'active' : ''}" href="/admin/panel"><span class="icon">AP</span>Admin
                Panel</a>
            <a class="${activePage == 'users' ? 'active' : ''}" href="/admin/users"><span class="icon">UM</span>User
                Management</a>
            <a class="${activePage == 'analytics' ? 'active' : ''}" href="/admin/analytics"><span
                    class="icon">PA</span>Platform Analytics</a>
            <a class="${activePage == 'moderation' ? 'active' : ''}" href="/admin/moderation"><span
                    class="icon">CM</span>Content Moderation</a>
            <a class="${activePage == 'settings' ? 'active' : ''}" href="/admin/settings"><span
                    class="icon">PS</span>Profile Settings</a>
        </nav>

        <div class="sidebar-footer">
            <a class="logout-btn" href="/">← Logout</a>
        </div>
    </aside>