import db.DatabaseConnection;
import java.sql.Connection;
import java.util.Scanner;
import frequent_queries.*;

public class AirlineApp {
    public static void main(String[] args) {
        try (
            Scanner sc = new Scanner(System.in);
            Connection con = DatabaseConnection.connect()
        ) {
            while (true) {
                System.out.println("\n===== Airline Reservation System Menu =====");
                System.out.println("1. Search flights by source and destination");
                System.out.println("2. Top passengers by miles");
                System.out.println("3. Crew member workload for a given month/year");
                System.out.println("4. Top delayed routes");
                System.out.println("5. Average baggage weight per flight class");
                System.out.println("0. Exit");
                System.out.print("Enter your choice: ");

                int choice;
                try {
                    choice = Integer.parseInt(sc.nextLine());
                } catch (NumberFormatException e) {
                    System.out.println("Invalid input. Please enter a number.");
                    continue;
                }

                switch (choice) {
                    case 1 -> Query1.run(con, sc);
                    case 2 -> Query2.run(con, sc);
                    case 3 -> Query3.run(con, sc);
                    case 4 -> Query4.run(con, sc);
                    case 5 -> Query5.run(con, sc);
                    case 0 -> {
                        System.out.println("Thank you for using the Airline Reservation System.");
                        return;
                    }
                    default -> System.out.println("Invalid choice. Please try again.");
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
