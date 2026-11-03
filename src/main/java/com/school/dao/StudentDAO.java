package com.school.dao;

import com.school.model.Student;
import com.school.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    public List<Student> getAllStudents() throws SQLException {

        List<Student> students = new ArrayList<>();

        String sql = "SELECT * FROM students ORDER BY id DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                students.add(mapRow(rs));
            }
        }

        return students;
    }

    public Student getStudentById(int id) throws SQLException {

        String sql = "SELECT * FROM students WHERE id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }

        return null;
    }

    public void addStudent(Student student) throws SQLException {

        String sql = """
                INSERT INTO students(name,email,course,marks)
                VALUES(?,?,?,?)
                """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getCourse());
            ps.setDouble(4, student.getMarks());

            ps.executeUpdate();
        }
    }

    public void updateStudent(Student student) throws SQLException {

        String sql = """
                UPDATE students
                SET name=?, email=?, course=?, marks=?
                WHERE id=?
                """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getCourse());
            ps.setDouble(4, student.getMarks());
            ps.setInt(5, student.getId());

            ps.executeUpdate();
        }
    }

    public void deleteStudent(int id) throws SQLException {

        String sql = "DELETE FROM students WHERE id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public List<Student> searchStudents(String keyword, String course)
            throws SQLException {

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM students WHERE 1=1");

        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (name LIKE ? OR email LIKE ?)");
        }

        if (course != null && !course.isBlank()) {
            sql.append(" AND course=?");
        }

        sql.append(" ORDER BY id DESC");

        List<Student> students = new ArrayList<>();

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int index = 1;

            if (keyword != null && !keyword.isBlank()) {
                String value = "%" + keyword.trim() + "%";
                ps.setString(index++, value);
                ps.setString(index++, value);
            }

            if (course != null && !course.isBlank()) {
                ps.setString(index, course);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    students.add(mapRow(rs));
                }
            }
        }

        return students;
    }

    public List<String> getAllCourses() throws SQLException {

        List<String> courses = new ArrayList<>();

        String sql = """
                SELECT DISTINCT course FROM students
                WHERE course IS NOT NULL AND course <> ''
                ORDER BY course
                """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                courses.add(rs.getString("course"));
            }
        }

        return courses;
    }

    public int getTotalStudents() throws SQLException {

        String sql = "SELECT COUNT(*) FROM students";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public int getTotalCourses() throws SQLException {

        String sql = "SELECT COUNT(DISTINCT course) FROM students";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public double getAverageMarks() throws SQLException {

        String sql = "SELECT COALESCE(AVG(marks),0) FROM students";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getDouble(1) : 0;
        }
    }

    private Student mapRow(ResultSet rs) throws SQLException {

        return new Student(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("course"),
                rs.getDouble("marks")
        );
    }
}
