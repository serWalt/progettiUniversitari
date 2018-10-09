<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.text.*" %>
<%@ page import = "connessione.ConnManager"%>
<!DOCTYPE html>
<html>
<head>
<title>Visualizza Mappatura Stadio</title>
<link rel="stylesheet" href="styles.css">
</head>

<body>
<div class="container"> 
<header>
   <h1>Visualizza Mappatura Stadio</h1>
</header>

<nav>
  <ul>
    <li><a href="reg_biglietto.jsp">Registra Nuovo Biglietto</a></li>
    <li><a href="reg_passholder.jsp">Registra Nuovo PassHolder</a></li>
    <li><a href="vedi_map_stadio.jsp">Visualizza Mappatura Stadio</a></li>
    <li><a href="vedi_num_spettatori.jsp">Visualizza Numero Spettatori</a></li>
    <li><a href="welcome.jsp">Torna alla schermata iniziale</a></li>
  </ul>
</nav>

<article>

<%
  	String partita = request.getParameter("select_partita");
  	String settore = request.getParameter("select_settore");
  	
  	ConnManager cm=null;
	Connection con;
	PreparedStatement pst=null;
	ResultSet rs;
  	
	try {
		
		cm = new ConnManager();
		con = cm.getConnection(); 
		
		System.out.println("select deref(biglietto.posto).num_posto as NUM_POSTO, "+ 
				"deref(biglietto.posto).tipologia as TIPO, "+ 
			    "biglietto.cod_biglietto as COD_BIGLIETTO, "+ 
			    "deref(biglietto.passholder).cf as CF, "+ 
			    "deref(biglietto.passholder).nome as NOME, "+ 
				"deref(biglietto.passholder).cognome as COGNOME, "+ 
				"deref(biglietto.passholder).data_nascita as DATA_NASCITA, "+ 
				"deref(biglietto.passholder).luogo_nascita as LUOGO_NASCITA "+
				"from biglietto "+ 
				"where deref(biglietto.partita).num_partita = "+partita+
				" and deref(biglietto.settore).cod_settore = '"+settore+"' "+
				"order by deref(biglietto.posto).num_posto");
		
		pst = con.prepareStatement("select deref(biglietto.posto).num_posto as NUM_POSTO, "+ 
				"deref(biglietto.posto).tipologia as TIPO, "+ 
			    "biglietto.cod_biglietto as COD_BIGLIETTO, "+ 
			    "deref(biglietto.passholder).cf as CF, "+ 
			    "deref(biglietto.passholder).nome as NOME, "+ 
				"deref(biglietto.passholder).cognome as COGNOME, "+ 
				"deref(biglietto.passholder).data_nascita as DATA_NASCITA, "+ 
				"deref(biglietto.passholder).luogo_nascita as LUOGO_NASCITA "+
				"from biglietto "+ 
				"where deref(biglietto.partita).num_partita = "+partita+
				" and deref(biglietto.settore).cod_settore = '"+settore+"' "+
				"order by deref(biglietto.posto).num_posto");
		rs = pst.executeQuery();
		%>
		<div class="absolute_tab">
    	<table class="tg">
		  <tr>
		    <th class="tg2">NUM POSTO</th>
		    <th class="tg2">TIPOLOGIA</th>
		    <th class="tg2">BIGLIETTO</th>
		    <th class="tg2">CF</th>
		    <th class="tg2">NOME</th>
		    <th class="tg2">COGNOME</th>
		    <th class="tg2">DATA NASCITA</th>
		    <th class="tg2">LUOGO NASCITA</th>
		  </tr>
		  <%while(rs.next()){%>
		  <tr>
		    <td class="tg2"><%=rs.getString("NUM_POSTO")%></td>
		    <td class="tg2"><%=rs.getString("TIPO")%></td>
		    <td class="tg2"><%=rs.getString("COD_BIGLIETTO")%></td>
		    <td class="tg2"><%=rs.getString("CF")%></td>
		    <td class="tg2"><%=rs.getString("NOME")%></td>
		    <td class="tg2"><%=rs.getString("COGNOME")%></td>
		    <td class="tg2"><%=rs.getString("DATA_NASCITA")%></td>
		    <td class="tg2"><%=rs.getString("LUOGO_NASCITA")%></td>
		  </tr>
		  <%} %>
		</table>
    	
    </div>
    <%						
		cm.closeConnection();
	}catch(Exception e){
		response.sendRedirect("vedi_map_stadio.jsp?error="+e.getMessage());		
		cm.closeConnection();
	}
	
  %>
  
</article>

</div>


</body>
</html>
