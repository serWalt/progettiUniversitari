<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.text.*" %>
<%@ page import = "connessione.ConnManager"%>
<%	
	String cf = request.getParameter("cf");
	String nome = request.getParameter("nome");
	String cognome = request.getParameter("cognome");
	String datanascita = request.getParameter("datanascita");
	String luogonascita = request.getParameter("luogonascita");
	ConnManager cm=null;
	Connection con;
	PreparedStatement pst;
	
	try {
		
		cm = new ConnManager();
		con = cm.getConnection(); 
		
		System.out.println("insert into passholder values('"+cf+"', '"+nome+"', '"+cognome+"', '"+datanascita+"', '"+luogonascita+"')");
		
		pst = con.prepareStatement("insert into passholder values('"+cf+"', '"+nome+"', '"+cognome+"', '"+datanascita+"', '"+luogonascita+"')");
		
		pst.executeQuery();
		cm.closeConnection();
		response.sendRedirect("reg_passholder.jsp?success=true");
	}catch(Exception e){
		response.sendRedirect("reg_passholder.jsp?error="+e.getMessage());		
		cm.closeConnection();
	}
%>