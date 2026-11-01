-- Create the Database
CREATE DATABASE IF NOT EXISTS tms_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tms_db;

-- 1. Users Table (Strong Entity)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role INT NOT NULL DEFAULT 3 COMMENT '1=Admin, 2=Project Manager, 3=Employee',
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) NOT NULL DEFAULT 'default-avatar.png',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Project Table (Strong Entity)
CREATE TABLE project (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(200) NOT NULL,
    project_description TEXT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    manager_id INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES users(user_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 3. Project_Members Table (Associative Entity for Many-to-Many between Project and Users)
CREATE TABLE project_members (
    project_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (project_id, user_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. Task Table (Strong/Dependent Entity)
CREATE TABLE task (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    task_name VARCHAR(200) NOT NULL,
    task_description TEXT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    project_id INT NOT NULL,
    assigned_to INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES users(user_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 5. Progress Table (Work logs and time tracking)
CREATE TABLE progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    progress_name VARCHAR(200) NOT NULL,
    progress_description TEXT NOT NULL,
    work_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    time_rendered DECIMAL(5,2) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    project_id INT NOT NULL,
    task_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES task(task_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;