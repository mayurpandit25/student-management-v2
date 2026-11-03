package com.school.servlet;

import com.school.dao.StudentDAO;
import com.school.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {

    private final StudentDAO dao = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action == null) action = "dashboard";

        try {
            switch (action) {

                case "dashboard":
                    dashboard(req, resp);
                    break;

                case "list":
                    list(req, resp);
                    break;

                case "new":
                    showForm(req, resp, null);
                    break;

                case "edit":
                    Student editStudent = findStudent(req);
                    if (editStudent == null) {
                        resp.sendError(404, "Student not found");
                    } else {
                        showForm(req, resp, editStudent);
                    }
                    break;

                case "view":
                    view(req, resp);
                    break;

                case "delete":
                    int id = Integer.parseInt(req.getParameter("id"));
                    dao.deleteStudent(id);
                    resp.sendRedirect(req.getContextPath()
                            + "/students?action=list&deleted=1");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath()
                            + "/students?action=dashboard");
            }

        } catch (SQLException | NumberFormatException e) {
            throw new ServletException("Student operation failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");

        Student student = new Student();

        student.setName(req.getParameter("name") == null
                ? "" : req.getParameter("name").trim());

        student.setEmail(req.getParameter("email") == null
                ? "" : req.getParameter("email").trim());

        student.setCourse(req.getParameter("course") == null
                ? "" : req.getParameter("course").trim());

        try {
            if (student.getName().isBlank()
                    || student.getEmail().isBlank()
                    || student.getCourse().isBlank()) {

                throw new IllegalArgumentException("All fields are required");
            }

            double marks = Double.parseDouble(req.getParameter("marks"));

            if (!Double.isFinite(marks) || marks < 0 || marks > 100) {
                throw new IllegalArgumentException(
                        "Marks must be between 0 and 100");
            }

            student.setMarks(marks);

            if (id != null && !id.isBlank()) {
                student.setId(Integer.parseInt(id));
                dao.updateStudent(student);

                resp.sendRedirect(req.getContextPath()
                        + "/students?action=list&updated=1");

            } else {
                dao.addStudent(student);

                resp.sendRedirect(req.getContextPath()
                        + "/students?action=list&added=1");
            }

        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("student", student);
            req.getRequestDispatcher("/WEB-INF/views/form.jsp")
                    .forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Database save failed", e);
        }
    }

    private void dashboard(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {

        req.setAttribute("totalStudents", dao.getTotalStudents());
        req.setAttribute("totalCourses", dao.getTotalCourses());
        req.setAttribute("averageMarks", dao.getAverageMarks());

        List<Student> students = dao.getAllStudents();

        req.setAttribute("recentStudents",
                students.subList(0, Math.min(5, students.size())));

        forward(req, resp, "/WEB-INF/views/dashboard.jsp");
    }

    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String course = req.getParameter("course");

        req.setAttribute("students", dao.searchStudents(keyword, course));
        req.setAttribute("courses", dao.getAllCourses());
        req.setAttribute("keyword", keyword == null ? "" : keyword);
        req.setAttribute("selectedCourse", course == null ? "" : course);

        forward(req, resp, "/WEB-INF/views/list.jsp");
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp,
                          Student student)
            throws ServletException, IOException {

        req.setAttribute("student", student);
        forward(req, resp, "/WEB-INF/views/form.jsp");
    }

    private void view(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {

        Student student = findStudent(req);

        if (student == null) {
            resp.sendError(404, "Student not found");
            return;
        }

        req.setAttribute("student", student);
        forward(req, resp, "/WEB-INF/views/profile.jsp");
    }

    private Student findStudent(HttpServletRequest req)
            throws SQLException {

        String id = req.getParameter("id");

        if (id == null || id.isBlank()) return null;

        return dao.getStudentById(Integer.parseInt(id));
    }

    private void forward(HttpServletRequest req, HttpServletResponse resp,
                         String path)
            throws ServletException, IOException {

        req.getRequestDispatcher(path).forward(req, resp);
    }
}
