:root {
--teal: #00b3c7;
--dark: #0a2540;
--text: #4c5d70;
--bg: #f5f7fb;
--card: #ffffff;
--border: #e5ebf4;
--red-soft: #fef2f2;
--red-text: #b91c1c;
--yellow-soft: #fffbeb;
--yellow-text: #b45309;
--green-soft: #f0fdf4;
--green-text: #15803d;
}

* { box-sizing: border-box; }

body {
margin: 0;
font-family: "Segoe UI", Tahoma, sans-serif;
background: var(--bg);
color: var(--text);
}

.app-shell { display: flex; min-height: 100vh; }

.sidebar {
width: 260px;
background: #ffffff;
border-right: 1px solid var(--border);
padding: 32px 26px;
display: flex;
flex-direction: column;
gap: 24px;
position: fixed;
height: 100vh;
}

.dashboard { flex: 1; margin-left: 260px; padding: 32px 48px; }

.brand { display: flex; align-items: center; gap: 12px; }
.brand svg { width: 42px; height: 42px; }
.brand-title { font-size: 20px; font-weight: 600; color: var(--dark); line-height: 1.2; }

.user-card {
background: linear-gradient(135deg, rgba(0, 179, 199, 0.08), rgba(80, 157, 255, 0.1));
border-radius: 18px;
padding: 24px;
text-align: left;
}
.user-card .avatar {
width: 64px; height: 64px; border-radius: 50%; background: #dbefff;
display: flex; align-items: center; justify-content: center;
font-size: 28px; font-weight: 600; color: #3c74f6; margin-bottom: 16px;
}
.user-card .name { font-size: 20px; font-weight: 700; color: var(--dark); margin-bottom: 4px; }
.user-card .email { font-size: 14px; margin-bottom: 4px; color: #4c5d70; }
.user-card .dept { font-size: 14px; margin-bottom: 16px; color: #64748b; }

.badge {
display: inline-block; width: 100%; padding: 10px 16px; border-radius: 12px;
background: #2563eb; color: #fff; font-size: 14px; font-weight: 600; text-align: center; border: none;
}

nav { display: flex; flex-direction: column; gap: 12px; }
nav a {
text-decoration: none; color: var(--text); padding: 12px 14px;
border-radius: 12px; display: flex; align-items: center; gap: 10px; font-weight: 600; transition: all 0.2s ease;
}
nav a.active { background: #00c2c7; color: #fff; }
nav a.active .icon { background: #fff; color: var(--teal); }
nav a:hover:not(.active) { background: rgba(0, 178, 199, 0.08); }

.icon {
width: 22px; height: 22px; border-radius: 6px;
background: rgba(255, 255, 255, 0.4); color: inherit;
display: inline-flex; align-items: center; justify-content: center;
font-size: 11px; font-weight: 700;
}

.btn { display: inline-flex; justify-content: center; align-items: center; padding: 10px 16px; border-radius: 8px;
font-weight: 600; cursor: pointer; border: none; font-size: 14px; transition: all 0.2s; text-decoration: none; }
.btn-primary { background: var(--teal); color: #fff; }
.btn-primary:hover { opacity: 0.9; }
.btn-ghost { background: transparent; color: var(--text); }
.btn-ghost:hover { background: rgba(0, 0, 0, 0.05); }

.page-header { margin-bottom: 32px; display: flex; justify-content: space-between; align-items: center; }
.page-title { font-size: 28px; font-weight: 700; margin: 0; color: var(--dark); }
.page-subtitle { color: var(--text); margin-top: 4px; }

.card { background: #fff; border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); overflow: hidden;
margin-bottom: 24px; }
.card-header { padding: 20px 24px; border-bottom: 1px solid var(--border); display: flex; justify-content:
space-between; align-items: center; }
.card-title { font-size: 16px; font-weight: 700; color: var(--dark); margin: 0; }
.card-body { padding: 24px; }

table { width: 100%; border-collapse: collapse; }
th { text-align: left; padding: 12px 0; color: #64748b; font-size: 12px; font-weight: 600; text-transform: uppercase;
border-bottom: 1px solid var(--border); }
td { padding: 16px 0; border-bottom: 1px solid var(--border); font-size: 14px; }
tr:last-child td { border-bottom: none; }

.status-pill { padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
.status-High { background: var(--red-soft); color: var(--red-text); }
.status-Moderate { background: var(--yellow-soft); color: var(--yellow-text); }
.status-Low { background: var(--green-soft); color: var(--green-text); }

.stat-card { background: #fff; padding: 24px; border-radius: 16px; }
.stat-label { font-size: 14px; color: var(--text); margin-bottom: 8px; }
.stat-value { font-size: 32px; font-weight: 700; color: var(--dark); }
.stat-trend { font-size: 12px; color: #15803d; font-weight: 600; display: flex; align-items: center; gap: 4px; }