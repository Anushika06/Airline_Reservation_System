-- 1. CrewMember
INSERT INTO CrewMember VALUES (1, 'Alice Johnson', 'Female', 'alice.johnson@example.com');
INSERT INTO CrewMember VALUES (2, 'Bob Smith', 'Male', 'bob.smith@example.com');
INSERT INTO CrewMember VALUES (3, 'Evan Parker', 'Other', 'evan.parker@example.com');

-- 2. CrewMonthlyWorkload (matching actual flights in June)
INSERT INTO CrewMonthlyWorkload VALUES (1, '2024-06-01', 2); 
INSERT INTO CrewMonthlyWorkload VALUES (2, '2024-06-01', 3); 
INSERT INTO CrewMonthlyWorkload VALUES (3, '2024-06-01', 1);

-- 3. Location
INSERT INTO Location VALUES (1, 'New York', 'John F. Kennedy International Airport', 'JFK', 1, 1);
INSERT INTO Location VALUES (2, 'London', 'Heathrow Airport', 'LHR', 2, 2);
INSERT INTO Location VALUES (3, 'Mumbai', 'Chhatrapati Shivaji Airport', 'BOM', 3, 3);

-- 4. Route
INSERT INTO Route VALUES (101, 1, 2); 
INSERT INTO Route VALUES (102, 2, 3); 
INSERT INTO Route VALUES (103, 3, 1);

-- 5. Flight (June 2024, matches Crew_Flight and Bookings)
INSERT INTO Flight VALUES (1001, 101, '2024-06-12', '09:00:00', '21:00:00', 'Scheduled');
INSERT INTO Flight VALUES (1002, 102, '2024-06-13', '15:00:00', '23:30:00', 'Scheduled');
INSERT INTO Flight VALUES (1003, 103, '2024-06-20', '10:00:00', '22:30:00', 'Scheduled');

-- 6. Crew_Flight (assigned in June, matches above flights)
INSERT INTO Crew_Flight VALUES (1, 1001, 'Pilot', '2024-06-05 07:00:00');
INSERT INTO Crew_Flight VALUES (2, 1001, 'Co-Pilot', '2024-06-05 07:05:00');
INSERT INTO Crew_Flight VALUES (1, 1002, 'Pilot', '2024-06-08 08:00:00');
INSERT INTO Crew_Flight VALUES (2, 1002, 'Engineer', '2024-06-09 06:30:00');
INSERT INTO Crew_Flight VALUES (3, 1003, 'Attendant', '2024-06-15 08:30:00');
INSERT INTO Crew_Flight VALUES (2, 1003, 'Engineer', '2024-06-16 12:00:00');

-- 7. FlightLeg (each flight has one leg for simplicity)
INSERT INTO FlightLeg VALUES (201, 1001, 101, 1, 1, 2, '2024-06-12 09:00:00', '2024-06-12 21:00:00');
INSERT INTO FlightLeg VALUES (202, 1002, 102, 1, 2, 3, '2024-06-13 15:00:00', '2024-06-13 23:30:00');
INSERT INTO FlightLeg VALUES (203, 1003, 103, 1, 3, 1, '2024-06-20 10:00:00', '2024-06-20 22:30:00');

-- 8. FlightFare (all flights, all classes)
INSERT INTO FlightFare VALUES (301, 1001, 'Economy', 500.00);
INSERT INTO FlightFare VALUES (302, 1001, 'Business', 1200.00);
INSERT INTO FlightFare VALUES (303, 1002, 'Economy', 650.00);
INSERT INTO FlightFare VALUES (304, 1003, 'Economy', 850.00);

-- 9. SeatMap (seats for above flights and fares)
INSERT INTO SeatMap VALUES ('12A', 1001, 'Economy', TRUE, 500.00);
INSERT INTO SeatMap VALUES ('1B', 1001, 'Business', TRUE, 1200.00);
INSERT INTO SeatMap VALUES ('14C', 1002, 'Economy', TRUE, 650.00);
INSERT INTO SeatMap VALUES ('21D', 1003, 'Economy', TRUE, 850.00);

-- 10. Passenger
INSERT INTO Passenger VALUES (501, 'Charlie Baker', 'charlieb@example.com', 'Male', 'Silver', 25000, '2023-12-20 15:44:00');
INSERT INTO Passenger VALUES (502, 'Dana S.', 'dana.s@example.com', 'Female', 'Gold', 60000, '2024-01-09 11:19:00');
INSERT INTO Passenger VALUES (503, 'Hashim Ali', 'hashim.ali@example.com', 'Male', 'None', 1000, '2024-05-02 17:10:00');

-- 11. FlightBooking (booked seats for the above flights, matches seat and passenger)
INSERT INTO FlightBooking VALUES (601, 1001, 501, '12A', 'Economy', 4000, 'Confirmed', '2024-05-31 09:14:00');
INSERT INTO FlightBooking VALUES (602, 1001, 502, '1B', 'Business', 15000, 'CheckedIn', '2024-06-01 14:02:00');
INSERT INTO FlightBooking VALUES (603, 1002, 503, '14C', 'Economy', 800, 'Cancelled', '2024-06-08 17:54:00');
INSERT INTO FlightBooking VALUES (604, 1003, 501, '21D', 'Economy', 1200, 'Confirmed', '2024-06-13 17:55:00');

-- 12. Baggage (simple, one for each booking except cancelled)
INSERT INTO Baggage VALUES (701, 601, 1, 22.5);
INSERT INTO Baggage VALUES (702, 602, 1, 25.0);
INSERT INTO Baggage VALUES (703, 604, 1, 20.0);

-- 13. Billing
INSERT INTO Billing VALUES (801, 501, 601, 500.00, 'UPI', 'Paid', '2024-06-01 10:16:00');
INSERT INTO Billing VALUES (802, 502, 602, 1200.00, 'CreditCard', 'Paid', '2024-06-02 09:04:00');
INSERT INTO Billing VALUES (803, 503, 603, 650.00, 'DebitCard', 'Refunded', '2024-06-09 13:00:00');
INSERT INTO Billing VALUES (804, 501, 604, 850.00, 'NetBanking', 'Paid', '2024-06-13 18:00:00');

-- 14. BookingCancellationLog
INSERT INTO BookingCancellationLog VALUES (901, 603, '2024-06-09 07:30:00', 'Personal emergency');

-- 15. FlightCancellationLog
INSERT INTO FlightCancellationLog VALUES (1001, 1003, '2024-06-19 12:00:00', 'Operational reason'); -- flight 1003 cancelled

-- 16. Delay
INSERT INTO Delay VALUES (1101, 1001, 60, '2024-06-12 08:30:00', 'Weather');
INSERT INTO Delay VALUES (1102, 1002, 30, '2024-06-13 14:45:00', 'Crew late arrival');
