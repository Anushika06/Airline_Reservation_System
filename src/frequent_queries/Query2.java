package frequent_queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class Query2 {
    public static void run(Connection connection, Scanner sc) {
        try {
            String query = "SELECT name, email, gender, total_miles FROM Passenger ORDER BY total_miles DESC LIMIT ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);

            System.out.print("Enter the limit: ");
            int limit = sc.nextInt();
            sc.nextLine(); // consume newline

            if (limit <= 0) {
                System.out.println("Limit must be a positive integer.");
                return;
            }

            preparedStatement.setInt(1, limit);
            ResultSet resultSet = preparedStatement.executeQuery();

            boolean found = false;
            while (resultSet.next()) {
                found = true;
                System.out.println("Name: " + resultSet.getString("name"));
                System.out.println("Email: " + resultSet.getString("email"));
                System.out.println("Gender: " + resultSet.getString("gender"));
                System.out.println("Total Miles: " + resultSet.getString("total_miles"));
                System.out.println();
            }

            if (!found) {
                System.out.println("No records found!");
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
