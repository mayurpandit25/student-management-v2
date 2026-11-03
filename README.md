# Student Management System V2

A Java-based Student Management System.

## Technology Stack

- Java 21
- Jakarta Servlet 6
- JSP
- JSTL 3
- JDBC
- MySQL 8
- Maven
- Apache Tomcat 10.1
- Docker

## Features

- Dashboard
- Student registration
- Student listing
- Student search
- Course filtering
- Student editing
- Student deletion
- Student profile
- Grade calculation
- Academic performance
- Responsive user interface

## Database

Database: school_db

Table: students

Columns:
- id
- name
- email
- course
- marks

## Build

mvn clean package

## Run using Docker

docker compose up -d --build

Open:

http://localhost:8080

## Stop

docker compose down

## Stop and remove database data

docker compose down -v

WARNING: This removes the Docker database volume and its data.
