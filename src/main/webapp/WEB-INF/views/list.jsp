<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Students | StudentPro</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">
    <script defer
            src="${pageContext.request.contextPath}/assets/js/app.js"></script>
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
                <h1>Students</h1>
                <p>Manage all student records.</p>
            </div>

            <a class="btn btn-primary"
               href="${pageContext.request.contextPath}/students?action=new">
                + Add Student
            </a>
        </header>

        <c:if test="${param.added == '1'}">
            <div class="alert success">Student added successfully.</div>
        </c:if>

        <c:if test="${param.updated == '1'}">
            <div class="alert success">Student updated successfully.</div>
        </c:if>

        <c:if test="${param.deleted == '1'}">
            <div class="alert success">Student deleted successfully.</div>
        </c:if>

        <section class="content-card">

            <div class="section-heading">
                <div>
                    <h2>Student Directory</h2>
                    <p>Search and filter student information.</p>
                </div>
            </div>

            <form class="filter-form"
                  method="get"
                  action="${pageContext.request.contextPath}/students">

                <input type="hidden" name="action" value="list">

                <input type="text"
                       name="keyword"
                       placeholder="Search name or email"
                       value="<c:out value='${keyword}'/>">

                <select name="course">
                    <option value="">All Courses</option>

                    <c:forEach var="course" items="${courses}">
                        <option value="<c:out value='${course}'/>"
                            <c:if test="${selectedCourse eq course}">
                                selected
                            </c:if>>
                            <c:out value="${course}"/>
                        </option>
                    </c:forEach>
                </select>

                <button class="btn btn-primary" type="submit">
                    Search
                </button>

                <a class="btn btn-secondary"
                   href="${pageContext.request.contextPath}/students?action=list">
                    Reset
                </a>
            </form>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Course</th>
                        <th>Marks</th>
                        <th>Grade</th>
                        <th>Actions</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="student" items="${students}">
                        <tr>
                            <td>#<c:out value="${student.id}"/></td>
                            <td><strong><c:out value="${student.name}"/></strong></td>
                            <td><c:out value="${student.email}"/></td>
                            <td><c:out value="${student.course}"/></td>
                            <td><c:out value="${student.marks}"/>%</td>

                            <td>
                                <span class="grade-badge">
                                    <c:out value="${student.grade}"/>
                                </span>
                            </td>

                            <td class="actions">
                                <a class="action-view"
                                   href="${pageContext.request.contextPath}/students?action=view&id=${student.id}">
                                    View
                                </a>

                                <a class="action-edit"
                                   href="${pageContext.request.contextPath}/students?action=edit&id=${student.id}">
                                    Edit
                                </a>

                                <a class="action-delete"
                                   href="${pageContext.request.contextPath}/students?action=delete&id=${student.id}"
                                   onclick="return confirmDelete();">
                                    Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty students}">
                        <tr>
                            <td colspan="7" class="empty-state">
                                No students found.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <div class="table-footer">
                Matching records:
                <strong>${students.size()}</strong>
            </div>

        </section>

        <footer class="footer">
            StudentPro - Student Management V2
        </footer>

    </main>
</div>

</body>
</html>
