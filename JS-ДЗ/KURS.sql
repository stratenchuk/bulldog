-- Создание базы данных Barbos
CREATE DATABASE Barbos;
GO

-- Использование базы данных Barbos
USE Barbos;
GO

-- Создание таблицы пользователей
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);

-- Создание таблицы курсов
CREATE TABLE Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Users(user_id) ON DELETE SET NULL
);

-- Создание таблицы уроков
CREATE TABLE Lessons (
    lesson_id INT PRIMARY KEY IDENTITY(1,1),
    course_id INT,
    title VARCHAR(100) NOT NULL,
    content TEXT,
    order_index INT,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Создание таблицы записей на курсы
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    course_id INT,
    enrollment_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Создание таблицы оценок
CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    course_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);
