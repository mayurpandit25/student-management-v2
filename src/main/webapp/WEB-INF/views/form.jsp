<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Form | StudentPro</title>
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

        <a class="nav-link"
           href="${pageContext.request.contextPath}/students?action=list">
            ♙ Students
        </a>

        <a class="nav-link active"
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
                <h1>
                    <c:choose>
                        <c:when test="${student != null}">
                            Edit Student
                        </c:when>
                        <c:otherwise>
                            Add New Student
                        </c:otherwise>
                    </c:choose>
                </h1>

                <p>Enter student information below.</p>
            </div>
        </header>

        <section class="form-card">

            <c:if test="${not empty error}">
                <div class="alert error">
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <form method="post"
                  action="${pageContext.request.contextPath}/students">

                <c:if test="${student != null}">
                    <input type="hidden"
                           name="id"
                           value="${student.id}">
                </c:if>

                <div class="form-heading">
                    <h2>Student Details</h2>
                    <p>Complete all required fields.</p>
                </div>

                <div class="form-grid">

                    <div class="form-group">
                        <label>Full Name *</label>
                        <input type="text"
                               name="name"
                               maxlength="100"
                               placeholder="Enter full name"
                               value="<c:out value='${student.name}'/>"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Email Address *</label>
                        <input type="email"
                               name="email"
                               maxlength="100"
                               placeholder="student@example.com"
                               value="<c:out value='${student.email}'/>"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Course *</label>

                        <input type="text"
                               name="course"
                               list="course-options"
                               maxlength="100"
                               placeholder="Enter or select a course"
                               value="<c:out value='${student.course}'/>"
                               required>

                        <datalist id="course-options">
                            <option value="Computer Science">
                            <option value="Information Tech">
                            <option value="Electronics">
                            <option value="Mechanical">
                            <option value="Civil">
                            <option value="Electrical">
                            <option value="Business Administration">
                        </datalist>
                    </div>

                    <div class="form-group">
                        <label>Marks (%) *</label>
                        <input type="number"
                               name="marks"
                               min="0"
                               max="100"
                               step="0.01"
                               placeholder="Enter marks"
                               value="<c:if test='${student != null}'>${student.marks}</c:if>"
                               required>
                    </div>

                </div>

                <div class="form-actions">

                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${student != null}">
                                Update Student
                            </c:when>
                            <c:otherwise>
                                Save Student
                            </c:otherwise>
                        </c:choose>
                    </button>

                    <a class="btn btn-secondary"
                       href="${pageContext.request.contextPath}/students?action=list">
                        Cancel
                    </a>

                </div>
            </form>

        </section>

    </main>
</div>

</body>
</html>
