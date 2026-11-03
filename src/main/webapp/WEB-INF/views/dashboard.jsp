<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard | StudentPro</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>

<div class="layout">

    <aside class="sidebar">
        <a class="brand" href="${pageContext.request.contextPath}/students">
            Student<span>Pro</span>
        </a>

        <div class="menu-label">MAIN MENU</div>

        <a class="nav-link active"
           href="${pageContext.request.contextPath}/students?action=dashboard">
            ▦ Dashboard
        </a>

        <a class="nav-link"
           href="${pageContext.request.contextPath}/students?action=list">
            ♙ Students
        </a>

        <a class="nav-link"
           href="${pageContext.request.contextPath}/students?action=new">
            ＋ Add Student
        </a>

        <div class="sidebar-bottom">
            <strong>Student Management</strong>
            <small>Version 2.0</small>
        </div>
    </aside>

    <main class="main-content">

        <header class="topbar">
            <div>
                <h1>Dashboard</h1>
                <p>Welcome to your student management system.</p>
            </div>

            <a class="btn btn-primary"
               href="${pageContext.request.contextPath}/students?action=new">
                + Add Student
            </a>
        </header>

        <section class="welcome-panel">
            <div>
                <span class="eyebrow">STUDENT MANAGEMENT SYSTEM</span>
                <h2>Manage your students smarter.</h2>
                <p>Organize records and monitor academic performance.</p>

                <a class="btn btn-light"
                   href="${pageContext.request.contextPath}/students?action=list">
                    View Students
                </a>
            </div>

            <div class="welcome-art">🎓</div>
        </section>

        <section class="stats-grid">

            <article class="stat-card">
                <div class="stat-icon blue">♙</div>
                <p>Total Students</p>
                <h2><c:out value="${totalStudents}"/></h2>
                <small>Registered students</small>
            </article>

            <article class="stat-card">
                <div class="stat-icon purple">▤</div>
                <p>Total Courses</p>
                <h2><c:out value="${totalCourses}"/></h2>
                <small>Different courses</small>
            </article>

            <article class="stat-card">
                <div class="stat-icon green">↗</div>
                <p>Average Marks</p>
                <h2><c:out value="${averageMarks}"/>%</h2>
                <small>Overall performance</small>
            </article>

        </section>

        <section class="content-card">

            <div class="section-heading">
                <div>
                    <h2>Recent Students</h2>
                    <p>Latest registered students</p>
                </div>

                <a class="text-link"
                   href="${pageContext.request.contextPath}/students?action=list">
                    View All →
                </a>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Student</th>
                        <th>Email</th>
                        <th>Course</th>
                        <th>Marks</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="student" items="${recentStudents}">
                        <tr>
                            <td>#<c:out value="${student.id}"/></td>
                            <td><strong><c:out value="${student.name}"/></strong></td>
                            <td><c:out value="${student.email}"/></td>
                            <td><c:out value="${student.course}"/></td>
                            <td><span class="marks-badge">
                                <c:out value="${student.marks}"/>%
                            </span></td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty recentStudents}">
                        <tr>
                            <td colspan="5" class="empty-state">
                                No students registered yet.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </section>

        <footer class="footer">
            StudentPro - Student Management V2
        </footer>

    </main>
</div>

</body>
</html>
