<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>ZenithMind | Case Management</title>
                <style>
                    <%@ include file="professional-styles.jsp" %>

                    /* Modal Styles */
                    .modal {
                        display: none;
                        position: fixed;
                        z-index: 1000;
                        left: 0;
                        top: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(0, 0, 0, 0.5);
                        align-items: center;
                        justify-content: center;
                    }

                    .modal.show {
                        display: flex;
                    }

                    .modal-content {
                        background: white;
                        border-radius: 16px;
                        width: 90%;
                        max-width: 600px;
                        max-height: 90vh;
                        overflow-y: auto;
                    }

                    .modal-header {
                        padding: 24px;
                        border-bottom: 1px solid var(--border);
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .modal-body {
                        padding: 24px;
                    }

                    .modal-footer {
                        padding: 24px;
                        border-top: 1px solid var(--border);
                        display: flex;
                        gap: 12px;
                        justify-content: flex-end;
                    }

                    .close-btn {
                        cursor: pointer;
                        font-size: 24px;
                        color: #64748b;
                        background: none;
                        border: none;
                    }

                    .close-btn:hover {
                        color: var(--dark);
                    }

                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-label {
                        display: block;
                        font-weight: 600;
                        margin-bottom: 8px;
                        color: var(--dark);
                    }

                    .form-input,
                    .form-textarea,
                    .form-select {
                        width: 100%;
                        padding: 12px;
                        border: 1px solid var(--border);
                        border-radius: 8px;
                        font-size: 14px;
                        font-family: inherit;
                    }

                    .form-textarea {
                        resize: vertical;
                        min-height: 120px;
                    }
                </style>
            </head>

            <body>
                <div class="app-shell">
                    <%@ include file="professional-sidebar.jsp" %>

                        <main class="dashboard">
                            <div class="page-header">
                                <div>
                                    <h1 class="page-title">Student Case Management</h1>
                                    <p class="page-subtitle">Manage and monitor student cases with comprehensive
                                        tracking
                                    </p>
                                </div>
                                <div style="display:flex; gap:12px;">
                                    <button class="btn" style="background:#fff; border:1px solid var(--border);"
                                        onclick="exportReport()">Export Report</button>
                                    <button class="btn btn-primary" onclick="addNewCase()">+ Add New Case</button>
                                </div>
                            </div>

                            <!-- Filter Bar -->
                            <div class="card" style="margin-bottom:24px;">
                                <div class="card-body" style="padding:16px 24px;">
                                    <div style="display:flex; gap:16px; align-items:center;">
                                        <div style="flex:1;">
                                            <input type="text" id="searchInput" placeholder="Search students..."
                                                onkeyup="filterTable()"
                                                style="width:100%; padding:10px 16px; border:1px solid var(--border); border-radius:8px; font-size:14px;">
                                        </div>
                                        <select id="riskFilter" onchange="filterTable()"
                                            style="padding:10px 16px; border:1px solid var(--border); border-radius:8px; font-size:14px;">
                                            <option value="">All Risk Levels</option>
                                            <option value="High">High Risk</option>
                                            <option value="Moderate">Moderate Risk</option>
                                            <option value="Low">Low Risk</option>
                                        </select>
                                        <select id="statusFilter" onchange="filterTable()"
                                            style="padding:10px 16px; border:1px solid var(--border); border-radius:8px; font-size:14px;">
                                            <option value="">All Status</option>
                                            <option value="Active">Active</option>
                                            <option value="Monitoring">Monitoring</option>
                                            <option value="Critical">Critical</option>
                                            <option value="Stable">Stable</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Case List -->
                            <div class="card">
                                <div class="card-header">
                                    <h2 class="card-title">Active Cases (<span
                                            id="caseCount">${fn:length(assignedStudents)}</span>)</h2>
                                </div>
                                <div class="card-body" style="padding-top:0;">
                                    <table id="caseTable">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Student Name</th>
                                                <th>Risk Level</th>
                                                <th>Status</th>
                                                <th>Last Session</th>
                                                <th>Next Appointment</th>
                                                <th>Notes</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="student" items="${assignedStudents}">
                                                <tr data-risk="${student[2]}" data-status="${student[3]}">
                                                    <td>#${student[0]}</td>
                                                    <td>
                                                        <div style="display:flex; align-items:center; gap:12px;">
                                                            <div
                                                                style="width:36px; height:36px; border-radius:50%; background:#e0f2fe; display:flex; align-items:center; justify-content:center; font-weight:700; color:#0284c7;">
                                                                ${student[1].substring(0,1)}
                                                            </div>
                                                            <span
                                                                style="font-weight:600; color:var(--dark);">${student[1]}</span>
                                                        </div>
                                                    </td>
                                                    <td><span
                                                            class="status-pill status-${student[2]}">${student[2]}</span>
                                                    </td>
                                                    <td style="color:var(--text);">${student[3]}</td>
                                                    <td style="font-size:13px; color:#64748b;">Dec 15, 2025</td>
                                                    <td style="font-size:13px; color:#64748b;">Dec 20, 2025</td>
                                                    <td
                                                        style="font-size:13px; color:#64748b; max-width:200px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                                                        ${student[4]}</td>
                                                    <td>
                                                        <div style="display:flex; gap:8px;">
                                                            <button class="btn btn-ghost"
                                                                style="padding:6px 12px; font-size:12px;"
                                                                onclick="viewStudent('${student[0]}', '${student[1]}')">View</button>
                                                            <button class="btn btn-ghost"
                                                                style="padding:6px 12px; font-size:12px;"
                                                                onclick="openNotesModal('${student[0]}', '${student[1]}')">Notes</button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Quick Stats -->
                            <div
                                style="display:grid; grid-template-columns: repeat(4, 1fr); gap:16px; margin-top:24px;">
                                <div class="stat-card">
                                    <div class="stat-label">Total Cases</div>
                                    <div class="stat-value">24</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-label">High Risk</div>
                                    <div class="stat-value" style="color:#ef4444;">5</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-label">Active Sessions</div>
                                    <div class="stat-value">12</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-label">Resolved This Month</div>
                                    <div class="stat-value" style="color:#15803d;">8</div>
                                </div>
                            </div>
                        </main>
                </div>

                <!-- Session Notes Modal -->
                <div id="notesModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2 style="margin:0; font-size:20px; color:var(--dark);">Session Notes - <span
                                    id="modalStudentName"></span></h2>
                            <button class="close-btn" onclick="closeNotesModal()">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="form-label">Session Date</label>
                                <input type="date" id="sessionDate" class="form-input"
                                    value="<%= new java.text.SimpleDateFormat(" yyyy-MM-dd").format(new
                                    java.util.Date()) %>">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Session Type</label>
                                <select id="sessionType" class="form-select">
                                    <option>Individual Counseling</option>
                                    <option>Group Therapy</option>
                                    <option>Crisis Intervention</option>
                                    <option>Follow-up</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Observations & Notes</label>
                                <textarea id="sessionNotes" class="form-textarea"
                                    placeholder="Record your observations, student progress, concerns, and recommendations..."></textarea>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Follow-up Required</label>
                                <select id="followupRequired" class="form-select">
                                    <option value="no">No</option>
                                    <option value="yes">Yes</option>
                                </select>
                            </div>
                            <div class="form-group" id="followupDateGroup" style="display:none;">
                                <label class="form-label">Follow-up Date</label>
                                <input type="date" id="followupDate" class="form-input">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn" style="background:#fff; border:1px solid var(--border);"
                                onclick="closeNotesModal()">Cancel</button>
                            <button class="btn btn-primary" onclick="saveNotes()">Save Notes</button>
                        </div>
                    </div>
                </div>

                <script>
                    let currentStudentId = null;

                    function filterTable() {
                        const searchValue = document.getElementById('searchInput').value.toLowerCase();
                        const riskFilter = document.getElementById('riskFilter').value;
                        const statusFilter = document.getElementById('statusFilter').value;
                        const table = document.getElementById('caseTable');
                        const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
                        let visibleCount = 0;

                        for (let row of rows) {
                            const studentName = row.cells[1].textContent.toLowerCase();
                            const risk = row.getAttribute('data-risk');
                            const status = row.getAttribute('data-status');

                            const matchesSearch = studentName.includes(searchValue);
                            const matchesRisk = !riskFilter || risk === riskFilter;
                            const matchesStatus = !statusFilter || status === statusFilter;

                            if (matchesSearch && matchesRisk && matchesStatus) {
                                row.style.display = '';
                                visibleCount++;
                            } else {
                                row.style.display = 'none';
                            }
                        }

                        document.getElementById('caseCount').textContent = visibleCount;
                    }

                    function openNotesModal(studentId, studentName) {
                        currentStudentId = studentId;
                        document.getElementById('modalStudentName').textContent = studentName;
                        document.getElementById('notesModal').classList.add('show');

                        // Load existing notes from sessionStorage if available
                        const savedNotes = sessionStorage.getItem('notes_' + studentId);
                        if (savedNotes) {
                            const notes = JSON.parse(savedNotes);
                            document.getElementById('sessionNotes').value = notes.notes || '';
                        }
                    }

                    function closeNotesModal() {
                        document.getElementById('notesModal').classList.remove('show');
                        document.getElementById('sessionNotes').value = '';
                        document.getElementById('followupRequired').value = 'no';
                        document.getElementById('followupDateGroup').style.display = 'none';
                    }

                    function saveNotes() {
                        const notes = {
                            studentId: currentStudentId,
                            date: document.getElementById('sessionDate').value,
                            type: document.getElementById('sessionType').value,
                            notes: document.getElementById('sessionNotes').value,
                            followup: document.getElementById('followupRequired').value,
                            followupDate: document.getElementById('followupDate').value
                        };

                        // Save to sessionStorage
                        sessionStorage.setItem('notes_' + currentStudentId, JSON.stringify(notes));

                        // Show success message
                        alert('Session notes saved successfully!');
                        closeNotesModal();
                    }

                    function viewStudent(studentId, studentName) {
                        alert('Viewing detailed profile for ' + studentName + ' (ID: ' + studentId + ')');
                    }

                    function addNewCase() {
                        alert('Add New Case functionality - Form would open here');
                    }

                    function exportReport() {
                        alert('Exporting report... This would generate a PDF or CSV file');
                    }

                    // Show/hide follow-up date field
                    document.getElementById('followupRequired').addEventListener('change', function () {
                        const followupGroup = document.getElementById('followupDateGroup');
                        followupGroup.style.display = this.value === 'yes' ? 'block' : 'none';
                    });

                    // Close modal when clicking outside
                    window.onclick = function (event) {
                        const modal = document.getElementById('notesModal');
                        if (event.target === modal) {
                            closeNotesModal();
                        }
                    }
                </script>
            </body>

            </html>