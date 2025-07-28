package frequent_queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class Query4 {
    public static void run(Connection connection, Scanner sc) {
        String query = """
            SELECT 
                r.id AS route_id, 
                l1.location_name AS start_location, 
                l2.location_name AS end_location, 
                COUNT(d.flight_id) AS delay_count
            FROM 
                Route r
            JOIN 
                Location l1 ON r.start_location = l1.location_id
            JOIN 
                Location l2 ON r.end_location = l2.location_id
            JOIN 
                Flight f ON r.id = f.route_id
            JOIN 
                Delay d ON d.flight_id = f.flight_id
            GROUP BY 
                r.id, l1.location_name, l2.location_name
            ORDER BY 
                delay_count DESC
            LIMIT ?
        """;

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            System.out.print("Enter number of top delayed routes to show: ");
            int limit = sc.nextInt();
            sc.nextLine(); // consume newline

            if (limit <= 0) {
                System.out.println("Limit must be a positive integer.");
                return;
            }

            preparedStatement.setInt(1, limit);

            ResultSet resultSet = preparedStatement.executeQuery();

            System.out.println("\nTop " + limit + " Delayed Routes:\n");

            boolean found = false;
            while (resultSet.next()) {
                found = true;
                int routeId = resultSet.getInt("route_id");
                String start = resultSet.getString("start_location");
                String end = resultSet.getString("end_location");
                int delayCount = resultSet.getInt("delay_count");
                System.out.println("Route ID: " + routeId + " | From: " + start + " | To: " + end + " | Delays: " + delayCount);
            }

            if (!found) {
                System.out.println("No delayed routes found.");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
