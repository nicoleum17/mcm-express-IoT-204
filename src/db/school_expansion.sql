-- 1. Backup is assumed to be done externally via mysqldump
-- Using mysqldump to export the 'escuela' database
-- mysqldump -u root -p escuela > escuela_backup.sql

-- 2. Create the new database 'school'
CREATE DATABASE school;

-- 3. Import is assumed to be done externally via mysqldump and mysql commands
-- Import the data into 'school'
-- mysql -u root -p school < escuela_backup.sql

-- 4. Switch to the new database
USE school;

-- 5. Rename tables from Spanish to English
RENAME TABLE alumnos TO students,
             cursos TO courses,
             matriculas TO enrollments,
             profesores TO teachers;
             
-- 6. Eliminate all the current rows in all the tables
-- Truncate child tables first
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE enrollments;
TRUNCATE TABLE courses;

-- Then truncate parent tables
TRUNCATE TABLE teachers;
TRUNCATE TABLE students;
SET FOREIGN_KEY_CHECKS = 1;

-- 7. Modify the table 'alumnos' to add 6 new fields
ALTER TABLE students
  ADD COLUMN apellido VARCHAR(100) NOT NULL,
  ADD COLUMN correo_electronico VARCHAR(100) NOT NULL,
  ADD COLUMN direccion VARCHAR(255),
  ADD COLUMN telefono VARCHAR(20),
  ADD COLUMN genero ENUM('M', 'F', 'Otro') NOT NULL,
  ADD COLUMN grado VARCHAR(50) NOT NULL;

-- 8. Insert 25 new registers into the table 'alumnos'
INSERT INTO students (nombre, fecha_nacimiento, apellido, correo_electronico, direccion, telefono, genero, grado) VALUES
('Ana', '2005-03-15', 'Gómez', 'ana.gomez@escuela.com', 'Calle 123, Ciudad', '555-1234', 'F', '10°'),
('Luis', '2004-07-22', 'Martínez', 'luis.martinez@escuela.com', 'Avenida 456, Ciudad', '555-5678', 'M', '11°'),
('María', '2005-11-30', 'Rodríguez', 'maria.rodriguez@escuela.com', 'Boulevard 789, Ciudad', '555-9012', 'F', '10°'),
('Carlos', '2003-05-18', 'López', 'carlos.lopez@escuela.com', 'Plaza 321, Ciudad', '555-3456', 'M', '12°'),
('Laura', '2004-09-05', 'Fernández', 'laura.fernandez@escuela.com', 'Camino 654, Ciudad', '555-7890', 'F', '11°'),
('Jorge', '2005-02-25', 'Hernández', 'jorge.hernandez@escuela.com', 'Ruta 987, Ciudad', '555-2345', 'M', '10°'),
('Sofía', '2004-12-10', 'García', 'sofia.garcia@escuela.com', 'Carrera 135, Ciudad', '555-6789', 'F', '11°'),
('Miguel', '2003-08-14', 'Díaz', 'miguel.diaz@escuela.com', 'Paseo 246, Ciudad', '555-0123', 'M', '12°'),
('Elena', '2005-04-03', 'Sánchez', 'elena.sanchez@escuela.com', 'Alameda 357, Ciudad', '555-4567', 'F', '10°'),
('Pedro', '2004-06-21', 'Ramírez', 'pedro.ramirez@escuela.com', 'Autopista 468, Ciudad', '555-8901', 'M', '11°'),
('Isabella', '2005-01-19', 'Torres', 'isabella.torres@escuela.com', 'Carretera 579, Ciudad', '555-3456', 'F', '10°'),
('Diego', '2003-10-27', 'Vargas', 'diego.vargas@escuela.com', 'Ruta 680, Ciudad', '555-7890', 'M', '12°'),
('Valentina', '2004-03-08', 'Castillo', 'valentina.castillo@escuela.com', 'Boulevard 791, Ciudad', '555-1234', 'F', '11°'),
('Sebastián', '2005-05-16', 'Ortiz', 'sebastian.ortiz@escuela.com', 'Callejón 802, Ciudad', '555-5678', 'M', '10°'),
('Camila', '2004-07-30', 'Morales', 'camila.morales@escuela.com', 'Avenida 913, Ciudad', '555-9012', 'F', '11°'),
('Andrés', '2005-02-04', 'Silva', 'andres.silva@escuela.com', 'Plaza 024, Ciudad', '555-3456', 'M', '12°'),
('Natalia', '2005-11-22', 'Rojas', 'natalia.rojas@escuela.com', 'Camino 135, Ciudad', '555-7890', 'F', '10°'),
('Diego', '2004-02-04', 'Reyes', 'diego.reyes@escuela.com', 'Carrera 246, Ciudad', '555-2345', 'M', '11°'),
('Lucía', '2005-04-17', 'Guerrero', 'lucia.guerrero@escuela.com', 'Paseo 357, Ciudad', '555-6789', 'F', '10°'),
('Fernando', '2003-06-29', 'Vega', 'fernando.vega@escuela.com', 'Ruta 468, Ciudad', '555-0123', 'M', '12°'),
('Gabriela', '2004-08-11', 'Flores', 'gabriela.flores@escuela.com', 'Alameda 579, Ciudad', '555-4567', 'F', '11°'),
('Emiliano', '2005-10-05', 'Paredes', 'emiliano.paredes@escuela.com', 'Autopista 680, Ciudad', '555-8901', 'M', '10°'),
('Paula', '2004-12-19', 'Navarro', 'paula.navarro@escuela.com', 'Boulevard 791, Ciudad', '555-1234', 'F', '11°'),
('Arturo', '2003-03-25', 'Mendoza', 'arturo.mendoza@escuela.com', 'Callejón 802, Ciudad', '555-5678', 'M', '12°'),
('Daniela', '2005-05-08', 'Gil', 'daniela.gil@escuela.com', 'Avenida 913, Ciudad', '555-9012', 'F', '10°'),
('Ricardo', '2004-07-20', 'Medina', 'ricardo.medina@escuela.com', 'Plaza 024, Ciudad', '555-3456', 'M', '11°'),
('Patricia', '2005-09-14', 'Fuentes', 'patricia.fuentes@escuela.com', 'Camino 135, Ciudad', '555-7890', 'F', '10°');

-- 9. Rename fields within each table
-- a. Rename fields in 'students' table
ALTER TABLE students
  CHANGE COLUMN nombre first_name VARCHAR(100) NOT NULL,
  CHANGE COLUMN apellido last_name VARCHAR(100) NOT NULL,
  CHANGE COLUMN fecha_nacimiento date_of_birth DATE NOT NULL,
  CHANGE COLUMN correo_electronico email VARCHAR(100) NOT NULL,
  CHANGE COLUMN direccion address VARCHAR(255),
  CHANGE COLUMN telefono phone VARCHAR(20),
  CHANGE COLUMN genero gender ENUM('M', 'F', 'Other') NOT NULL,
  CHANGE COLUMN grado grade_level VARCHAR(50) NOT NULL;

-- b. Rename fields in 'courses' table
ALTER TABLE courses
  CHANGE COLUMN nombre course_name VARCHAR(100) NOT NULL,
  ADD COLUMN description TEXT,
  CHANGE COLUMN creditos credits INT NOT NULL,
  ADD COLUMN teacher_id INT NOT NULL;

  -- c. Rename fields in 'enrollments' table
ALTER TABLE enrollments
  CHANGE COLUMN alumno_id student_id INT NOT NULL,
  CHANGE COLUMN curso_id course_id INT NOT NULL,
  ADD COLUMN enrollment_date DATE NOT NULL;
  
-- d. Rename fields in 'teachers' table
ALTER TABLE teachers
  CHANGE COLUMN nombre first_name VARCHAR(100) NOT NULL,
  ADD COLUMN last_name VARCHAR(100) NOT NULL,
  ADD COLUMN email VARCHAR(100) NOT NULL,
  ADD COLUMN phone VARCHAR(20),
  CHANGE COLUMN especialidad department VARCHAR(100) NOT NULL;

-- 10. Update foreign keys in 'enrollments' table
-- (Assuming original foreign key names are 'fk_alumno' and 'fk_curso')
ALTER TABLE enrollments DROP FOREIGN KEY enrollments_ibfk_1;
ALTER TABLE enrollments DROP FOREIGN KEY enrollments_ibfk_2;

ALTER TABLE enrollments
  ADD CONSTRAINT fk_student
    FOREIGN KEY (student_id) REFERENCES students(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT fk_course
    FOREIGN KEY (course_id) REFERENCES courses(id)
    ON DELETE CASCADE;
    
-- 11. Add the missing fk on courses
ALTER TABLE courses
ADD CONSTRAINT fk_teacher
FOREIGN KEY (teacher_id) REFERENCES teachers(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- 12. Add new data to courses, enrollments, and teachers
-- a. Insert records into the 'teachers' table
INSERT INTO teachers (first_name, last_name, email, phone, department) VALUES
('John', 'Smith', 'john.smith@school.com', '555-1001', 'Mathematics'),
('Emily', 'Johnson', 'emily.johnson@school.com', '555-1002', 'Science'),
('Michael', 'Brown', 'michael.brown@school.com', '555-1003', 'History'),
('Sarah', 'Davis', 'sarah.davis@school.com', '555-1004', 'English'),
('David', 'Wilson', 'david.wilson@school.com', '555-1005', 'Physical Education');

-- b. Insert records into the 'courses' table
INSERT INTO courses (course_name, description, credits, teacher_id) VALUES
('Algebra I', 'Introduction to algebraic concepts and principles.', 3, 1),
('Biology', 'Study of living organisms and their interactions.', 4, 2),
('World History', 'Comprehensive overview of global historical events.', 3, 3),
('English Literature', 'Analysis of classic and contemporary literary works.', 3, 4),
('Physical Education', 'Development of physical fitness and teamwork skills.', 2, 5);

-- c. Insert records into the 'enrollments' table
-- We'll use dates within the current academic year, e.g., 2024-09-01 to 2025-06-30
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-09-01'),    -- Ana Gomez enrolled in Algebra I
(2, 2, '2024-09-02'),    -- Luis Martinez enrolled in Biology
(3, 3, '2024-09-03'),    -- María Rodriguez enrolled in World History
(4, 4, '2024-09-04'),    -- Carlos Lopez enrolled in English Literature
(5, 5, '2024-09-05'),    -- Laura Fernandez enrolled in Physical Education
(6, 1, '2024-09-06'),    -- Jorge Hernandez enrolled in Algebra I
(7, 2, '2024-09-07'),    -- Sofía Garcia enrolled in Biology
(8, 3, '2024-09-08'),    -- Miguel Diaz enrolled in World History
(9, 4, '2024-09-09'),    -- Elena Sanchez enrolled in English Literature
(10, 5, '2024-09-10'),   -- Pedro Ramirez enrolled in Physical Education
(11, 1, '2024-09-11'),   -- Isabella Torres enrolled in Algebra I
(12, 2, '2024-09-12'),   -- Diego Vargas enrolled in Biology
(13, 3, '2024-09-13'),   -- Valentina Castillo enrolled in World History
(14, 4, '2024-09-14'),   -- Sebastián Ortiz enrolled in English Literature
(15, 5, '2024-09-15'),   -- Camila Morales enrolled in Physical Education
(16, 1, '2024-09-16'),   -- Andrés Silva enrolled in Algebra I
(17, 2, '2024-09-17'),   -- Natalia Rojas enrolled in Biology
(18, 3, '2024-09-18'),   -- Diego Reyes enrolled in World History
(19, 4, '2024-09-19'),   -- Lucía Guerrero enrolled in English Literature
(20, 5, '2024-09-20'),   -- Fernando Vega enrolled in Physical Education
(21, 1, '2024-09-21'),   -- Gabriela Flores enrolled in Algebra I
(22, 2, '2024-09-22'),   -- Emiliano Paredes enrolled in Biology
(23, 3, '2024-09-23'),   -- Paula Navarro enrolled in World History
(24, 4, '2024-09-24'),   -- Arturo Mendoza enrolled in English Literature
(25, 5, '2024-09-25');   -- Daniela Gil enrolled in Physical Education


-- 13. Verify changes (Run separately)
SHOW TABLES IN school;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE teachers;

-- 14. Delete the old database 'escuela' (Optional)
DROP DATABASE escuela;