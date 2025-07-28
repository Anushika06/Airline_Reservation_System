CREATE TABLE CrewMember (
    crew_id BIGINT PRIMARY KEY,    
    name VARCHAR(100), 
    gender ENUM('Male', 'Female', 'Other'),
    contact TEXT
);

CREATE TABLE CrewMonthlyWorkload (
    crew_id BIGINT,
    month DATE,
    flight_count INT,
    PRIMARY KEY (crew_id, month),
    FOREIGN KEY (crew_id) REFERENCES CrewMember(crew_id)
);

CREATE TABLE Location (
    location_id BIGINT PRIMARY KEY,
    location_name VARCHAR(100),
    airport_name VARCHAR(100),
    airport_code VARCHAR(10),
    country BIGINT,
    time_zone BIGINT
);

CREATE TABLE Route (
    id BIGINT PRIMARY KEY,
    start_location BIGINT,
    end_location BIGINT,
    FOREIGN KEY (start_location) REFERENCES Location(location_id),
    FOREIGN KEY (end_location) REFERENCES Location(location_id)
);

CREATE TABLE Flight (
    flight_id BIGINT PRIMARY KEY,
    route_id BIGINT,
    date_of_depart DATE,
    start_time TIME,
    end_time TIME,
    status ENUM('Scheduled', 'Delayed', 'Cancelled', 'Completed'),
    FOREIGN KEY (route_id) REFERENCES Route(id)
);

CREATE TABLE Crew_Flight (
    crew_id BIGINT,
    flight_id BIGINT,
    role ENUM('Pilot', 'Co-Pilot', 'Attendant', 'Engineer'),
    assigned_on DATETIME,
    PRIMARY KEY (crew_id, flight_id),
    FOREIGN KEY (crew_id) REFERENCES CrewMember(crew_id),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

CREATE TABLE FlightLeg (
    leg_id BIGINT PRIMARY KEY,
    flight_id BIGINT,
    route_id BIGINT,
    sequence INT,
    start_location BIGINT,
    end_location BIGINT,
    departure_time TIMESTAMP,
    arrival_time TIMESTAMP,
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
    FOREIGN KEY (route_id) REFERENCES Route(id),
    FOREIGN KEY (start_location) REFERENCES Location(location_id),
    FOREIGN KEY (end_location) REFERENCES Location(location_id)
);

CREATE TABLE FlightFare (
    fare_id BIGINT PRIMARY KEY,
    flight_id BIGINT,
    flight_class ENUM('Economy', 'Business', 'First'),
    base_price DECIMAL(10,2),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

CREATE TABLE SeatMap (
    seat_id VARCHAR(10),
    flight_id BIGINT,
    class VARCHAR(20),
    is_available BOOLEAN,
    seat_price DECIMAL(10,2),
    PRIMARY KEY (seat_id, flight_id),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

CREATE TABLE Passenger (
    passenger_id BIGINT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    gender ENUM('Male', 'Female', 'Other'),
    flyer_status ENUM('None', 'Silver', 'Gold', 'Platinum'),
    total_miles BIGINT,
    created_at TIMESTAMP
);

CREATE TABLE FlightBooking (
    booking_id BIGINT PRIMARY KEY,
    flight_id BIGINT,
    passenger_id BIGINT,
    seat_id VARCHAR(10),
    flight_class ENUM('Economy', 'Business', 'First'),
    miles BIGINT,
    status ENUM('Confirmed', 'Cancelled', 'CheckedIn'),
    created_at TIMESTAMP,
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (seat_id, flight_id) REFERENCES SeatMap(seat_id, flight_id)
);

CREATE TABLE Baggage (
    baggage_id BIGINT PRIMARY KEY,
    booking_id BIGINT,
    baggage_no INT,
    weight DECIMAL(6,2),
    FOREIGN KEY (booking_id) REFERENCES FlightBooking(booking_id)
);

CREATE TABLE Billing (
    transaction_id BIGINT PRIMARY KEY,
    user_id BIGINT,
    booking_id BIGINT,
    amount_payable DECIMAL(10,2),
    payment_method ENUM('UPI', 'CreditCard', 'DebitCard', 'NetBanking', 'Wallet', 'Cash', 'Other'),
    payment_status ENUM('Pending', 'Paid', 'Failed', 'Refunded'),
    created_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (booking_id) REFERENCES FlightBooking(booking_id)
);

CREATE TABLE BookingCancellationLog (
    cancel_log_id BIGINT PRIMARY KEY,
    booking_id BIGINT,
    timestamp TIMESTAMP,
    reason TEXT,
    FOREIGN KEY (booking_id) REFERENCES FlightBooking(booking_id)
);

CREATE TABLE FlightCancellationLog (
    flight_cancel_log_id BIGINT PRIMARY KEY,
    flight_id BIGINT,
    timestamp TIMESTAMP,
    reason TEXT,
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

CREATE TABLE Delay (
    log_id BIGINT PRIMARY KEY,
    flight_id BIGINT,
    delay_duration BIGINT,
    timestamp TIMESTAMP,
    reason TEXT,
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

