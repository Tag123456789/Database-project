CREATE TABLE Films (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INT,
    genre VARCHAR(50),
    rating VARCHAR(10)
);

CREATE TABLE Cinemass (
    cinema_id INT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);


CREATE TABLE Customerss (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    phone VARCHAR(20)
);


CREATE TABLE Showss (
    show_id INT PRIMARY KEY,
    movie_id INT,
    cinema_id INT,
    show_time DATETIME,
    price DECIMAL(6,2),
    FOREIGN KEY (movie_id) REFERENCES Films(movie_id),
    FOREIGN KEY (cinema_id) REFERENCES Cinemass(cinema_id)
);


CREATE TABLE Seats (
    seat_id INT PRIMARY KEY,
    cinema_id INT,
    seat_number VARCHAR(10),
    FOREIGN KEY (cinema_id) REFERENCES Cinemass(cinema_id)
);

/* =========================
   BOOKINGS TABLE
========================= */
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    show_id INT,
    seat_id INT,
    booking_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Customerss(customer_id),
    FOREIGN KEY (show_id) REFERENCES Showss(show_id),
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);


INSERT INTO Films VALUES
(1, 'Inception', 148, 'Sci-Fi', 'PG-13'),
(2, 'Titanic', 195, 'Drama', 'PG-13'),
(3, 'Joker', 122, 'Crime', 'R');

/* =========================
   INSERT CINEMAS
========================= */
INSERT INTO Cinemass VALUES
(1, 'Galaxy Cinema', 'Nasr City'),
(2, 'Cinema Mall', '6 October');


INSERT INTO Customerss VALUES
(1, 'Ahmed Ali', '01012345678'),
(2, 'Sara Mohamed', '01198765432');

INSERT INTO Showss VALUES
(1, 1, 1, '2025-01-10 18:00:00', 120.00),
(2, 2, 2, '2025-01-11 20:00:00', 100.00);


INSERT INTO Seats VALUES
(1, 1, 'A1'),
(2, 1, 'A2'),
(3, 2, 'B1');


INSERT INTO Bookings VALUES
(1, 1, 1, 1, GETDATE()),
(2, 2, 2, 3, GETDATE());



SELECT * FROM Films;


SELECT 
    Films.title,
    Cinemass.name AS cinema,
    Showss.show_time,
    Showss.price
FROM Showss
JOIN Films ON Showss.movie_id = Films.movie_id
JOIN Cinemass ON Showss.cinema_id = Cinemass.cinema_id;


SELECT
    Customerss.full_name,
    Films.title,
    Seats.seat_number,
    Showss.show_time
FROM Bookings
JOIN Customerss ON Bookings.customer_id = Customerss.customer_id
JOIN Showss ON Bookings.show_id = Showss.show_id
JOIN Films ON Showss.movie_id = Films.movie_id
JOIN Seats ON Bookings.seat_id = Seats.seat_id;