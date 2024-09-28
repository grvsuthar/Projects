CREATE DATABASE ola_passenger_pickup_drop;

USE ola_passenger_pickup_drop;

CREATE TABLE passengers (
  passenger_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE locations (
  location_id INT PRIMARY KEY AUTO_INCREMENT,
  address VARCHAR(200) NOT NULL,
  latitude DECIMAL(10, 8) NOT NULL,
  longitude DECIMAL(11, 8) NOT NULL
);

CREATE TABLE rides (
  ride_id INT PRIMARY KEY AUTO_INCREMENT,
  passenger_id INT NOT NULL,
  pickup_location_id INT NOT NULL,
  drop_location_id INT NOT NULL,
  ride_date DATETIME NOT NULL,
  ride_status ENUM('pending', 'completed', 'cancelled') NOT NULL DEFAULT 'pending',
  FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
  FOREIGN KEY (pickup_location_id) REFERENCES locations(location_id),
  FOREIGN KEY (drop_location_id) REFERENCES locations(location_id)
);

select * from passengers where passenger_id = 2 ;

SELECT 
  r.ride_id,
  p.name AS passenger_name,
  p.email AS passenger_email,
  p.phone_number AS passenger_phone_number,
  pl.address AS pickup_location,
  pl.latitude AS pickup_latitude,
  pl.longitude AS pickup_longitude,
  dl.address AS drop_location,
  dl.latitude AS drop_latitude,
  dl.longitude AS drop_longitude,
  r.ride_date,
  r.ride_status
FROM 
  rides r
  INNER JOIN passengers p ON r.passenger_id = p.passenger_id
  INNER JOIN locations pl ON r.pickup_location_id = pl.location_id
  INNER JOIN locations dl ON r.drop_location_id = dl.location_id;
