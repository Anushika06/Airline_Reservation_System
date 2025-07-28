# ✈️ Airline Reservation System

## What This Project Does  
This Java application connects to a MySQL database to help airline staff efficiently manage flight-related queries. It acts as a simple command-line tool for accessing frequently needed data like top passengers, baggage weights, and flight delays.

When you run the application, you're presented with a menu of 5 essential queries:

1. Search Flights – Find flights between a given source and destination  
2. Top Travelers – View the top N passengers based on miles traveled  
3. Crew Workload – Analyze how many flights each crew member has worked monthly  
4. Flight Delays – Explore the routes that face the most delays  
5. Baggage Insights – Check average baggage weight for each flight class  


## 🛠️ How It Works

The project has three main components:

- AirlineApp.java – The main class that shows the menu and runs the queries  
- DatabaseConnection.java – Handles database connection to MySQL (airdb)  
- frequent_queries/Query1 to Query5.java – Each file implements one of the query features  

Each query file connects to the database and prints results clearly for the user. It uses tables such as Flights, Passengers, FlightBooking, Crew, and Baggage.

## 🗃️ Database Structure

The MySQL database (airdb) contains tables like:

- Flight – All scheduled flights  
- Passengers – Customer information  
- FlightBooking – Bookings made by passengers  
- Crew – Flight crew data  
- Baggage – Checked baggage details  

You can find schema and sample data in the resources/ folder:

- schema.sql – Creates all required tables  
- sample_data.sql – Inserts test data for trying out queries  

## 🚀 Getting Started

### Requirements:

- Java 17 or higher  
- MySQL Server running locally  
- MySQL JDBC Driver (mysql-connector-j-9.3.0.jar) inside lib/  
- The airdb database initialized with schema and sample data  

## ▶️ Running the Application

## Option 1: Compile and Run from Source

#### Compile Java code
```bash
javac -cp "lib/mysql-connector-j-9.3.0.jar" -d bin src/db/*.java src/frequent_queries/*.java src/AirlineApp.java
```

#### Run the app (Windows)
```bash
java -cp "bin;lib/mysql-connector-j-9.3.0.jar" AirlineApp
```

#### On macOS/Linux, replace `;` with `:` in classpath


## Option 2: Create and Run Executable JAR

#### Create Manifest
```bash
echo "Main-Class: AirlineApp" > Manifest.txt
```

#### Create JAR file
```bash
jar cfm AirlineApp.jar Manifest.txt -C bin . -C resources .
```

#### Run the JAR (Windows)
```bash
java -cp "AirlineApp.jar;lib/mysql-connector-j-9.3.0.jar" AirlineApp
```

#### On macOS/Linux, replace `;` with `:`

## 🧱 Database Setup

### Open your MySQL client (or terminal)  
### Create the database and tables:
```bash
mysql -u root -p airdb < resources/schema.sql
mysql -u root -p airdb < resources/sample_data.sql
```

## 📺 What You'll See

After launching, a menu appears. Just type the query number, follow prompts (like source & destination), and get instant results from your database.

It uses sample data, so you can test everything without adding real records.

### 🧰 Tech Stack

- Java – Core language for the app  
- JDBC – To connect Java to MySQL  
- MySQL – Stores all flight, booking, and crew data  
- MySQL Connector/J – JDBC driver  
