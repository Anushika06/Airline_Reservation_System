package db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String url = "jdbc:mysql://127.0.0.1:3306/airdb";
    private static final String username = "root";
    private static final String password = "Mn@h_2006";  

    public static Connection connect() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
