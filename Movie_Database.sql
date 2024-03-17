create database movie_ticket_booking;
use movie_ticket_booking;

CREATE TABLE Movie (
  MovieID INT PRIMARY KEY,
  Title VARCHAR(100) NOT NULL,
  Description VARCHAR(255),
  Language VARCHAR(20) NOT NULL,
  ReleaseDate DATE,
  Genre VARCHAR(20) NOT NULL,
  PgRating INT,
  Duration INT
);

CREATE TABLE User (
  UserID INT PRIMARY KEY,
  Username VARCHAR(64) NOT NULL UNIQUE,
  Email VARCHAR(64) NOT NULL UNIQUE,
  Password VARCHAR(64) NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  MobileNumber VARCHAR(15) NOT NULL
);

CREATE TABLE City (
  CityID INT PRIMARY KEY,
  CityName VARCHAR(100) NOT NULL,
  State VARCHAR(100) NOT NULL,
  ZipCode VARCHAR(20) NOT NULL
);

CREATE TABLE Cinema (
  CinemaID INT PRIMARY KEY,
  CinemaName VARCHAR(100) NOT NULL,
  TotalHalls INT NOT NULL,
  CityID INT
);
alter table Cinema add foreign key(CityID) references City(CityID);

CREATE TABLE CinemaHall (
  CinemaHallID INT PRIMARY KEY,
  CinemaHallName VARCHAR(100) NOT NULL,
  TotalSeats INT NOT NULL,
  CinemaID INT
);
alter table CinemaHall add foreign key(CinemaId) references Cinema(CinemaID);

CREATE TABLE CinemaSeat (
  CinemaSeatID INT PRIMARY KEY,
  SeatNumber ENUM('A1','A2','A3','A4','A5','A6','A7','A8','A9','A10','B1','B2','B3','B4','B5','B6','B7','B8','B9','B10','C1','C2','C3','C4','C5','C6','C7','C8','C9','C10','D1','D2','D3','D4','D5','D6','D7','D8','D9','D10','E1','E2','E3','E4','E5','E6','E7','E8','E9','E10','F1','F2','F3','F4','F5','F6','F7','F8','F9','F10','G1','G2','G3','G4','G5','G6','G7','G8','G9','G10','H1','H2','H3','H4','H5','H6','H7','H8','H9','H10'),
  CinemaHallID INT
);
alter table CinemaSeat add foreign key(CinemaHallID) references CinemaHall(CinemaHallID);

CREATE TABLE Show_ (
  ShowID INT PRIMARY KEY,
  MovieID INT,
  CinemaHallID INT,
  ShowDate DATE NOT NULL,
  StartTime DATETIME NOT NULL,
  EndTime DATETIME NOT NULL
);
alter table Show_ add foreign key(MovieID) references Movie(MovieID);
alter table Show_ add foreign key(CinemaHallID) references CinemaHall(CinemaHallID);

CREATE TABLE Booking (
  BookingID INT PRIMARY KEY,
  UserID INT,
  ShowID INT,
  NoOfSeats INT
);
alter table Booking add foreign key(UserID) references User(UserID);
alter table Booking add foreign key(ShowID) references Show_(ShowID);

CREATE TABLE ShowSeat (
  ShowSeatID INT PRIMARY KEY,
  ShowID INT,
  CinemaSeatID INT,
  BookingID INT
);
alter table ShowSeat add foreign key(ShowID) references Show_(ShowID);
alter table ShowSeat add foreign key(CinemaSeatID) references CinemaSeat(CinemaSeatID);
alter table ShowSeat add foreign key(BookingID) references Booking(BookingID);

CREATE TABLE Feedback (
  FeedbackID INT PRIMARY KEY,
  UserID INT,
  ShowID INT,
  Feedback VARCHAR(255),
  FeedbackDate DATETIME
);
alter table Feedback add foreign key(UserID) references User(UserID);
alter table Feedback add foreign key(ShowID) references Show_(ShowID);

select * from Movie;
select * from User;
select * from Booking;
select * from City;
select * from Feedback;
select * from ShowSeat;
select * from Cinema;
select * from Show_;
select * from CinemaSeat;

INSERT INTO Movie (MovieId, Title, Description, Language, ReleaseDate, Genre, PgRating, Duration)
VALUES
(1,'The Avengers', 'Earth\'s mightiest heroes assemble!', 'English', '2012-05-04', 'Action, Adventure', 12, 143),
(2,'The Shawshank Redemption', 'Hope is a good thing, maybe the best of things, and no good thing ever dies.', 'English', '1994-09-23', 'Drama', 17, 142),
(3,'Inception', 'Professional thief who steals corporate secrets through use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 'English', '2010-07-16', 'Action, Thriller', 13, 148);

INSERT INTO User (UserID, Username, Email, Password, FirstName, LastName, MobileNumber)
VALUES
(1,'ironman', 'tony.stark@avengers.com', 'password123', 'Tony', 'Stark', '+1234567890'),
(2,'red', 'reginald.dwyer@shawshank.com', 'iloveandy', 'Red', 'Dwyers', '+1543219876'),
(3,'arthur', 'arthur.miles@inception.com', 'dreamcatcher', 'Arthur', 'Miles', '+1987654321');

INSERT INTO City (CityID, CityName, State, ZipCode)
VALUES
(10,'New York City', 'New York', '10001'),
(20,'Portland', 'Oregon', '97201'),
(30,'Los Angeles', 'California', '90001');

INSERT INTO Cinema (CinemaID, CinemaName, TotalHalls, CityID)
VALUES
(1,'Empire State Theater', 10, 10),
(2,'Hollywood Cinema', 8, 30),
(3,'Fox Tower Theatres', 5, 20);

INSERT INTO CinemaHall (CinemaHallID , CinemaHallName, TotalSeats, CinemaID)
VALUES
(1,'Hall 1', 300, 1),
(2,'Hall 2', 250, 1),
(3,'Hall 3', 150, 2);

INSERT INTO CinemaSeat (CinemaSeatID, SeatNumber, CinemaHallID)
VALUES
(1,'A1', 1),
(2,'A2', 1),
(3,'B1', 2),
(4,'B2', 2);

INSERT INTO Show_ (ShowID, MovieID, CinemaHallID, ShowDate, StartTime, EndTime)
VALUES
(1,1, 1, '2024-02-23', '2024-02-23 19:00:00', '2024-02-23 21:00:00'),
(2,2, 2, '2024-02-25', '2024-02-25 15:00:00', '2024-02-25 17:00:00'),
(3,3, 3, '2024-02-27', '2024-02-27 20:00:00', '2024-02-27 22:00:00');

INSERT INTO Booking (BookingID, UserID, ShowID, NoOfSeats)
VALUES
(1,1, 1, 2),
(2,2, 2, 1),
(3,3, 3, 3);

INSERT INTO ShowSeat (ShowSeatID, ShowID, CinemaSeatID, BookingID)
VALUES
(1,1,1,1),
(2,2,3,2),
(3,2,2,1);

INSERT INTO Feedback (FeedbackID, UserID, ShowID, Feedback, FeedbackDate)
VALUES
(1,1, 1, 'Great movie!', '2024-02-24'),
(2,2, 2, 'A classic that never gets old.', '2024-02-26'),
(3,3, 3, 'Mind-blowing experience!', '2024-02-28');




INSERT INTO Movie (MovieID, Title, Description, Language, ReleaseDate, Genre, PgRating, Duration) 
VALUES 
(4, 'The Godfather', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 'English', '1972-03-24', 'Crime', 18, 175),
(5, 'The Dark Knight', 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', 'English', '2008-07-18', 'Action', 13, 152),
(6, 'Pulp Fiction', 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 'English', '1994-10-14', 'Crime', 18, 154),
(7, 'The Matrix', 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 'English', '1999-03-31', 'Action', 15, 136),
(8, 'Forrest Gump', 'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold from the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.', 'English', '1994-07-06', 'Drama', 13, 142),
(9, 'The Lord of the Rings: The Return of the King', 'Gandalf and Aragorn lead the World of Men against Sauron\'s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.', 'English', '2003-12-17', 'Adventure', 13, 201),
(10, 'Avatar', 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', 'English', '2009-12-18', 'Action', 13, 162),
(11, 'Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.', 'English', '2014-11-07', 'Sci-Fi', 13, 169),
(12, 'The Dark Knight Rises', 'Eight years after the Joker\'s reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane.', 'English', '2012-07-20', 'Action', 13, 164),
(13, 'The Lion King', 'A young lion prince flees his kingdom only to learn the true meaning of responsibility and bravery.', 'English', '1994-06-24', 'Animation', 13, 88),
(14, 'Titanic', 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.', 'English', '1997-12-19', 'Romance', 13, 195),
(15, 'Jurassic Park', 'During a preview tour, a theme park suffers a major power breakdown that allows its cloned dinosaur exhibits to run amok.', 'English', '1993-06-11', 'Sci-Fi', 13, 127);



INSERT INTO User (UserID, Username, Email, Password, FirstName, LastName, MobileNumber) 
VALUES 
(4, 'alice_smith', 'alice@example.com', 'password123', 'Alice', 'Smith', '+1234567890'),
(5, 'bob_doe', 'bob@example.com', 'securepassword', 'Bob', 'Doe', '+1987654321'),
(6, 'sarah_jones', 'sarah@example.com', 'password123', 'Sarah', 'Jones', '+1234567890'),
(7, 'michael_smith', 'michael@example.com', 'securepassword', 'Michael', 'Smith', '+1987654321'),
(8, 'emily_wilson', 'emily@example.com', 'password123', 'Emily', 'Wilson', '+1234567890'),
(9, 'david_brown', 'david@example.com', 'securepassword', 'David', 'Brown', '+1987654321'),
(10, 'chris_evans', 'chris@example.com', 'password123', 'Chris', 'Evans', '+1234567890'),
(11, 'emma_johnson', 'emma@example.com', 'securepassword', 'Emma', 'Johnson', '+1987654321'),
(12, 'sophia_white', 'sophia@example.com', 'securepassword', 'Sophia', 'White', '+1987654321'),
(13, 'oliver_miller', 'oliver@example.com', 'password123', 'Oliver', 'Miller', '+1234567890'),
(14, 'ava_anderson', 'ava@example.com', 'securepassword', 'Ava', 'Anderson', '+1987654321'),
(15, 'james_smith', 'james@example.com', 'password123', 'James', 'Smith', '+1234567890');



INSERT INTO City (CityID, CityName, State, ZipCode) 
VALUES 
(40, 'Chicago', 'Illinois', '60601'),
(50, 'San Francisco', 'California', '94101'),
(60, 'Houston', 'Texas', '77001'),
(70, 'Miami', 'Florida', '33101'),
(80, 'Seattle', 'Washington', '98101'),
(90, 'Boston', 'Massachusetts', '02101'),
(100, 'Philadelphia', 'Pennsylvania', '19101'),
(110, 'Phoenix', 'Arizona', '85001'),
(120, 'Detroit', 'Michigan', '48201'),
(130, 'Las Vegas', 'Nevada', '89101'),
(140, 'San Diego', 'California', '92101'),
(150, 'Denver', 'Colorado', '80201');




INSERT INTO Cinema (CinemaID, CinemaName, TotalHalls, CityID) 
VALUES 
(4, 'Windy City Cinemas', 4, 40),
(5, 'Golden Gate Theater', 2, 50),
(6, 'Houston Cinema', 3, 70),
(7, 'Ocean View Theater', 2, 60),
(8, 'Emerald City Cinemas', 4, 30),
(9, 'Boston Multiplex', 5, 100),
(10, 'Liberty Theaters', 4, 10),
(11, 'Desert Oasis Cinema', 3, 110),
(12, 'Rose City Theaters', 4, 80),
(13, 'Motor City Movies', 3, 90),
(14, 'Sin City Cinemas', 4, 150),
(15, 'Pacific Cinemas', 4, 100);



INSERT INTO CinemaHall (CinemaHallID, CinemaHallName, TotalSeats, CinemaID) 
VALUES 
(4, 'Hall 4', 120, 4),
(5, 'Hall 5', 90, 5),
(6, 'Main Hall', 90, 6),
(7, 'Cinema 1', 100, 7),
(8, 'Big Screen', 150, 8),
(9, 'Grand Theater', 110, 9),
(10, 'Grand Central', 100, 11),
(11, 'Metro Cinema', 150, 4),
(12, 'City Hall', 110, 13),
(13, 'Screen 1', 80, 10),
(14, 'Hall 6', 130, 15),
(15, 'Theater 1', 120, 1);



INSERT INTO CinemaSeat (CinemaSeatID, SeatNumber, CinemaHallID) 
VALUES 
(5, 'A1', 3),
(6, 'A2', 4),
(7, 'C4', 5),
(8, 'A1', 5),
(9, 'A2', 5),
(10, 'B3', 6),
(11, 'C2', 6),
(12, 'A1', 10),
(13, 'A5', 10),
(14, 'B2', 8),
(15, 'C1', 15),
(16, 'C2', 7),
(17, 'A1', 4);




INSERT INTO Show_ (ShowID, MovieID, CinemaHallID, ShowDate, StartTime, EndTime) 
VALUES 
(4, 4, 4, '2024-03-19', '2024-03-19  20:00:00', '2024-03-19  22:30:00'),
(5, 5, 5, '2024-03-20', '2024-03-20  21:00:00', '2024-03-20  23:30:00'),
(6, 6, 6, '2024-03-21', '2024-03-21  19:00:00', '2024-03-21  21:30:00'),
(7, 7, 7, '2024-03-22', '2024-03-22  20:30:00', '2024-03-22  23:00:00'),
(8, 8, 8, '2024-03-23', '2024-03-23  18:00:00', '2024-03-23  20:30:00'),
(9, 9, 9, '2024-03-24', '2024-03-24  17:30:00', '2024-03-24  21:00:00'),
(10, 10, 10, '2024-02-23', '2024-02-23  18:30:00', '2024-02-23  21:00:00'),
(11, 11, 11, '2024-03-19', '2024-03-19  19:30:00', '2024-03-19  22:00:00'),
(12, 12, 12, '2024-03-22', '2024-03-22  18:00:00', '2024-03-22  20:30:00'),
(13, 13, 13, '2024-03-29', '2024-03-29  17:00:00', '2024-03-29  20:30:00'),
(14, 14, 14, '2024-03-31', '2024-03-31  19:00:00', '2024-03-31  21:30:00'),
(15, 15, 15, '2024-02-27', '2024-02-27  18:30:00', '2024-02-27  21:00:00');



INSERT INTO Booking (BookingID, UserID, ShowID, NoOfSeats) 
VALUES 
(4, 4, 4, 2),
(5, 5, 5, 4),
(6, 6, 6, 3),
(7, 7, 7, 2),
(8, 8, 4, 4),
(9, 9, 9, 5),
(10, 10, 10, 2),
(11, 11, 1, 3),
(12, 12, 3, 2),
(13, 13, 9, 4),
(14, 14, 14, 2),
(15, 15, 12, 3);




INSERT INTO ShowSeat (ShowSeatID, ShowID, CinemaSeatID, BookingID) 
VALUES 
(4, 4, 5, 4),
(5, 5, 6, 5),
(6, 5, 6, 5),
(7, 6, 7, 6),
(8, 6, 8, 6),
(9, 7, 9, 7),
(10, 10, 10, 10),
(11, 10, 11, 10),
(12, 11, 12, 11),
(13, 11, 13, 11),
(14, 12, 14, 12),
(15, 12, 15, 12);



INSERT INTO Feedback (FeedbackID, UserID, ShowID, Feedback, FeedbackDate) 
VALUES 
(4, 4, 4, 'Fantastic performance!', '2024-03-19 23:00:00'),
(5, 5, 5, 'The best movie ever!', '2024-03-20 23:30:00'),
(6, 6, 6, 'Mind-blowing experience!', '2024-03-22 23:30:00'),
(7, 7, 7, 'Forrest Gump is a classic!', '2024-03-23 20:30:00'),
(8, 8, 4, 'The performances, the dialogue, and the cinematography make this movie really engaging and I didnt really got bored of this movie.', '2024-03-21 21:00:00'),
(9, 9, 9, 'Enjoyed it with friends!', '2024-03-25 21:30:00'),
(10, 10, 10, 'Avatar was visually stunning!', '2024-03-26 22:00:00'),
(11, 11, 11, 'Interstellar blew my mind!', '2024-03-27 22:30:00'),
(12, 12, 3, 'The end was much of a thriller and nail biting.', '2024-02-29 20:30:00'),
(13, 13, 9, 'Amazing story!', '2024-03-24 23:30:00'),
(14, 14, 14, 'Titanic was a beautiful love story!', '2024-03-31 22:30:00'),
(15, 15, 12, 'The Dark Knight Rises was an epic conclusion!', '2024-03-23 22:00:00');



SELECT * FROM Movie WHERE ReleaseDate > '2010-01-01';

SELECT * FROM Movie WHERE Genre = 'Drama';

SELECT Booking.*, User.FirstName, User.LastName FROM Booking INNER JOIN User ON Booking.UserID = User.UserID;

SELECT Booking.*, Movie.Title FROM Booking INNER JOIN Show_ ON Booking.ShowID = Show_.ShowID INNER JOIN Movie ON Show_.MovieID = Movie.MovieID;

SELECT COUNT(*) AS TotalBookings FROM Booking;

SELECT AVG(Duration) AS AverageDuration FROM Movie;

SELECT * FROM User WHERE UserID IN (
    SELECT DISTINCT Booking.UserID
    FROM Booking
    INNER JOIN Show_ ON Booking.ShowID = Show_.ShowID
    INNER JOIN Movie ON Show_.MovieID = Movie.MovieID
    WHERE Movie.PgRating = 13
);

SELECT * FROM Movie WHERE MovieID IN (
    SELECT DISTINCT Show_.MovieID
    FROM Show_
    INNER JOIN Feedback ON Show_.ShowID = Feedback.ShowID
    GROUP BY Show_.MovieID
    HAVING COUNT(*) > 1
);

SELECT City.*, COUNT(Cinema.CinemaID) AS TotalCinemas FROM City LEFT JOIN Cinema ON City.CityID = Cinema.CityID GROUP BY City.CityID;

SELECT Booking.*, CinemaHall.CinemaHallName FROM Booking INNER JOIN Show_ ON Booking.ShowID = Show_.ShowID INNER JOIN CinemaHall ON Show_.CinemaHallID = CinemaHall.CinemaHallID;

SELECT SUM(TotalSeats) AS TotalSeatsAvailable FROM CinemaHall;

SELECT * FROM Movie WHERE Duration > (
    SELECT AVG(Duration) FROM Movie
);

SELECT Show_.*, Cinema.CinemaName, City.CityName FROM Show_ INNER JOIN CinemaHall ON Show_.CinemaHallID = CinemaHall.CinemaHallID INNER JOIN Cinema ON CinemaHall.CinemaID = Cinema.CinemaID INNER JOIN City ON Cinema.CityID = City.CityID;

SELECT MAX(Duration) AS MaxDuration FROM Movie;

SELECT Feedback.*, User.FirstName, User.LastName, Movie.Title FROM Feedback INNER JOIN User ON Feedback.UserID = User.UserID INNER JOIN Show_ ON Feedback.ShowID = Show_.ShowID INNER JOIN Movie ON Show_.MovieID = Movie.MovieID;

SELECT Movie.Title, City.CityName
FROM Movie
INNER JOIN Show_ ON Movie.MovieID = Show_.MovieID
INNER JOIN CinemaHall ON Show_.CinemaHallID = CinemaHall.CinemaHallID
INNER JOIN Cinema ON CinemaHall.CinemaID = Cinema.CinemaID
INNER JOIN City ON Cinema.CityID = City.CityID; 

SELECT AVG(TotalSeats) AS AverageSeatsPerHall FROM CinemaHall;

SELECT *FROM Movie WHERE Genre = (SELECT Genre FROM Movie GROUP BY Genre ORDER BY COUNT(*) DESC LIMIT 1);

SELECT MIN(PgRating) AS MinPgRating FROM Movie;

CREATE TABLE MovieGenre (
    MovieID INT,
    Genre VARCHAR(20),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);
DESC MovieGenre;

CREATE TABLE MovieLanguage (
    MovieID INT,
    Language VARCHAR(20),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID)
);
DESC MovieLanguage;


INSERT INTO MovieLanguage (MovieID, Language)
SELECT MovieID, Language FROM Movie;
select* from MovieLanguage;


INSERT INTO MovieGenre (MovieID, Genre)SELECT MovieID, SUBSTRING_INDEX(SUBSTRING_INDEX(Genre, ',', n.digit+1), ',', -1) as Genre FROM Movie JOIN (SELECT 0 as digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) as n ON LENGTH(REPLACE(Genre, ',' , '')) <= LENGTH(Genre)-n.digit;
select * from MovieGenre;
