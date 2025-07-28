package frequent_queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class Query3 {
    public static void run(Connection connection, Scanner sc) {
        String query = """
            SELECT 
                c.name, 
                cf.role, 
                COUNT(cf.flight_id) AS flight_count
            FROM 
                CrewMember c
            JOIN 
                Crew_Flight cf ON c.crew_id = cf.crew_id
            JOIN 
                CrewMonthlyWorkload cmw ON cf.crew_id = cmw.crew_id
            WHERE 
                MONTH(cmw.month) = ? AND YEAR(cmw.month) = ?
            GROUP BY 
                c.name, cf.role
            ORDER BY 
                flight_count DESC
        """;

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            System.out.print("Enter month (1-12): ");
            int month = sc.nextInt();

            System.out.print("Enter year (e.g., 2025): ");
            int year = sc.nextInt();
            sc.nextLine(); // consume newline

            preparedStatement.setInt(1, month);
            preparedStatement.setInt(2, year);

            ResultSet resultSet = preparedStatement.executeQuery();

            boolean found = false;
            while (resultSet.next()) {
                found = true;
                String name = resultSet.getString("name");
                String role = resultSet.getString("role");
                int count = resultSet.getInt("flight_count");
                System.out.println("Name: " + name);
                System.out.println("Role: " + role);
                System.out.println("Count of Flights: " + count);
                System.out.println();
            }

            if (!found) {
                System.out.println("No records found for the specified month and year.");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
