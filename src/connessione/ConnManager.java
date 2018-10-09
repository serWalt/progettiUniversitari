package connessione;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnManager {
	
	private static String user = "walterBD2";
	private static String pass = "bdii1213";
	private static String sid = "orcl";
	private static String host = "localhost";
	private static int port = 1521;
	private static String url = "jdbc:oracle:thin:@" + host + ":" + port + ":" + sid;
	
	private Connection conn;
	
	public ConnManager(){
		 try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = (Connection) DriverManager.getConnection(url, user, pass);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() {
		return conn;
	}
	
	public void closeConnection() {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
