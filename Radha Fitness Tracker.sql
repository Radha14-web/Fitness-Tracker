CREATE DATABASE FitnessTracker;
USE FitnessTracker;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    date_of_birth DATE
);


CREATE TABLE Workouts (
    workout_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    workout_date DATE,
    total_calories_burned INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Exercises (
    exercise_id INT PRIMARY KEY AUTO_INCREMENT,
    workout_id INT,
    exercise_name VARCHAR(100),
    duration_minutes INT,  -- Duration in minutes
    calories_burned INT,
    FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id)
);

CREATE TABLE Progress (
    progress_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    workout_id INT,
    weight DECIMAL(5,2),  -- Weight in kg
    calories_burned INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id)
);


INSERT INTO Users (first_name, last_name, email, date_of_birth)
VALUES 
    ('John', 'Doe', 'john.doe@example.com', '1990-05-15'),
    ('Jane', 'Smith', 'jane.smith@example.com', '1985-08-22');

INSERT INTO Workouts (user_id, workout_date, total_calories_burned)
VALUES 
    (1, '2023-06-10', 350),
    (2, '2023-06-11', 400);


INSERT INTO Exercises (workout_id, exercise_name, duration_minutes, calories_burned)
VALUES 
    (1, 'Running', 30, 200),
    (1, 'Push-ups', 10, 50),
    (1, 'Squats', 15, 100),
    (2, 'Cycling', 45, 250),
    (2, 'Jumping Jacks', 20, 150);


INSERT INTO Progress (user_id, workout_id, weight, calories_burned)
VALUES 
    (1, 1, 75.5, 350),
    (2, 2, 65.0, 400);


SELECT u.first_name, u.last_name, SUM(w.total_calories_burned) AS total_calories_burned
FROM Users u
JOIN Workouts w ON u.user_id = w.user_id
GROUP BY u.user_id;

SELECT e.exercise_name, e.duration_minutes, e.calories_burned
FROM Exercises e
JOIN Workouts w ON e.workout_id = w.workout_id
WHERE w.workout_id = 1;

SELECT u.first_name, u.last_name, p.weight, p.calories_burned, w.workout_date
FROM Progress p
JOIN Users u ON p.user_id = u.user_id
JOIN Workouts w ON p.workout_id = w.workout_id
WHERE w.workout_date = '2023-06-10' AND u.user_id = 1;

UPDATE Progress
SET weight = 76.0
WHERE user_id = 1 AND workout_id = 1;

SELECT e.exercise_name, COUNT(*) AS exercise_count
FROM Exercises e
GROUP BY e.exercise_name
ORDER BY exercise_count DESC;

SELECT u.first_name, u.last_name, SUM(p.calories_burned) AS total_calories_burned
FROM Progress p
JOIN Users u ON p.user_id = u.user_id
GROUP BY u.user_id;
