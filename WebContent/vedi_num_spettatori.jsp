<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.text.*" %>
<%@ page import = "connessione.ConnManager"%>
<!DOCTYPE html>
<html>
<head>
<title>Visualizza Numero Spettatori</title>
<link rel="stylesheet" href="styles.css">
</head>

<body>
<div class="container">

<header>
   <h1>Visualizza Numero Spettatori</h1>
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
  
<article class="artdx">

	<%
		if(request.getParameter("error") != null) {%>
		<p style="color: red;"><%=request.getParameter("error")%></p>
		<%} %>
	
  <p>E' possibile stampare le informazioni sul numero di spettatori per partita e per settore per tutta la stagione.</p>
  <p>Per favore, indicare la stagione per la quale mostrare le suddette informazioni..</p>
  
  <form action="action_vedi_num_spettatori.jsp" method="post">

    <%-- /*************************************************/ //SELEZIONA STAGIONE --%>
	<% 
	   ConnManager cm = new ConnManager();
  	   Connection con = cm.getConnection();
  	   Statement st = con.createStatement();
       ResultSet rs;
       rs = st.executeQuery("select id_stagione from stagione");
  	%>
  	
    Seleziona Stagione<br>
    
    <select name="select_stagione" id="select_stagione">
  	<%while(rs.next()){%>  	
    	<option value="<%=rs.getString("id_stagione")%>"><%=rs.getString("id_stagione")%></option>
    <% }
    cm.closeConnection(); %>
        
  	</select>
    
    
    <br><br>
    <input type="submit" id="sub" value="Visualizza"> 	
  	
  </form>
  
  <div class="absolute">
  	<img alt="" src="immagini/numero.jpg" width="700px">
  </div>   
</article>

</div>


</body>
</html>