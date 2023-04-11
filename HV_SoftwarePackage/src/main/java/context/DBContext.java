package context;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Provides a way to connect to a SQL Server database using JDBC.
 */
public class DBContext {

    // The SQL Server database details
	private final String serverName = "localhost";
	private final String dbName = "DonationDB";
	private final String portNumber = "1433";
	private final String instance = ""; // LEAVE THIS ONLY EMPTY IF YOUR SQL IS A SINGLE INSTANCE
	private final String userID = "sa";
	private final String password = "12345";

    /**
     * Connects to the SQL Server database and returns a Connection object.
     * 
     * @return a Connection object representing the database connection
     * @throws Exception if there is an error connecting to the database
     */
    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName;

        // If the instance is empty, assume that the SQL Server is a single instance
        if (instance == null || instance.trim().isEmpty())
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName + ";encrypt=false;";

        // Load the SQL Server JDBC driver and return the database connection
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
}
