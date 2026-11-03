<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Profile | StudentPro</title>
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

        <a class="nav-link"
           href="${pageContext.request.contextPath}/students?action=dashboard">
            ▦ Dashboard
        </a>

        <a class="nav-link active"
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
                <h1>Student Profile</h1>
                <p>Student academic information.</p>
            </div>
        </header>

        <section class="profile-card">

            <div class="profile-avatar">
                <c:out value="${student.name.substring(0,1).toUpperCase()}"/>
            </div>

            <h2><c:out value="${student.name}"/></h2>
            <p class="profile-email">
                <c:out value="${student.email}"/>
            </p>

            <div class="profile-details">

                <div>
                    <span>Student ID</span>
                    <strong>#<c:out value="${student.id}"/></strong>
                </div>

                <div>
                    <span>Course</span>
                    <strong><c:out value="${student.course}"/></strong>
                </div>

                <div>
                    <span>Marks</span>
                    <strong><c:out value="${student.marks}"/>%</strong>
                </div>

                <div>
                    <span>Grade</span>
                    <strong><c:out value="${student.grade}"/></strong>
                </div>

                <div>
                    <span>Performance</span>
                    <strong><c:out value="${student.performance}"/></strong>
                </div>

            </div>

            <div class="form-actions">
                <a class="btn btn-primary"
                   href="${pageContext.request.contextPath}/students?action=edit&id=${student.id}">
                    Edit Student
                </a>

                <a class="btn btn-secondary"
                   href="${pageContext.request.contextPath}/students?action=list">
                    Back to Students
                </a>
            </div>

        </section>

    </main>
</div>

</body>
</html>
