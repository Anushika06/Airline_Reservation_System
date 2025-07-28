package frequent_queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class Query5 {
    public static void run(Connection connection, Scanner sc) {
        String query = """
            SELECT 
                fb.flight_class, 
                AVG(b.weight) AS avg_weight
            FROM 
                FlightBooking fb
            JOIN 
                Baggage b ON fb.booking_id = b.booking_id
            GROUP BY 
                fb.flight_class
        """;

        try (
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery()
        ) {
            System.out.println("\nAverage Baggage Weight per Flight Class:\n");

            boolean found = false;
            while (resultSet.next()) {
                found = true;
                String flightClass = resultSet.getString("flight_class");
                double avgWeight = resultSet.getDouble("avg_weight");
                System.out.println("Class: " + flightClass + " | Average Weight: " + avgWeight);
            }

            if (!found) {
                System.out.println("No baggage data found.");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
