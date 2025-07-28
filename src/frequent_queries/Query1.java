package frequent_queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class Query1 {
    public static void run(Connection connection, Scanner sc) {
        try {
            String query = """
                    SELECT f.flight_id, f.date_of_depart,
                           l1.airport_name AS start_airport,
                           l2.airport_name AS end_airport
                    FROM Flight f
                    JOIN Route r ON f.route_id = r.id
                    JOIN Location l1 ON r.start_location = l1.location_id
                    JOIN Location l2 ON r.end_location = l2.location_id
                    WHERE ((LOWER(l1.location_name) = LOWER(?) AND LOWER(l2.location_name) = LOWER(?))
                        OR  (LOWER(l1.location_name) = LOWER(?) AND LOWER(l2.location_name) = LOWER(?)))
                    """;

            PreparedStatement preparedStatement = connection.prepareStatement(query);

            System.out.print("Enter the Source: ");
            String source = sc.nextLine();

            System.out.print("Enter the Destination: ");
            String destination = sc.nextLine();

            preparedStatement.setString(1, source);
            preparedStatement.setString(2, destination);
            preparedStatement.setString(3, destination);
            preparedStatement.setString(4, source);

            ResultSet resultSet = preparedStatement.executeQuery();

            boolean found = false;
            while (resultSet.next()) {
                found = true;
                System.out.println("\nFlight Id: " + resultSet.getInt("flight_id"));
                System.out.println("Date of Departure: " + resultSet.getDate("date_of_depart"));
                System.out.println("Start Airport: " + resultSet.getString("start_airport"));
                System.out.println("End Airport: " + resultSet.getString("end_airport"));
            }

            if (!found) {
                System.out.println("No such flights!");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
