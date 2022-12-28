package context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
public Connection getConnection() throws Exception {
	String url="jdbc:sqlserver://"+serverName+":"+portNumber+"\\"+instance+";databaseName="+dbName;
	if (instance==null || instance.trim().isEmpty())
		url="jdbc:sqlserver://"+serverName+":"+portNumber+";databaseName="+dbName +";encrypt=false;";
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	return DriverManager.getConnection(url, userID, password);
}

private final String serverName ="localhost";
private final String dbName ="ShoppingDB";
private final String portNumber ="1433";
private final String instance ="";//LEAVE THIS ONLY EMPTY IF YOUR SQL IS A SINGLE INSTANCE
private final String userID ="sa";
private final String password ="12345";
}
