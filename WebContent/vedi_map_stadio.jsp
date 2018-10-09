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
  
<article class="artdx">

	<%
		if(request.getParameter("error") != null) {%>
		<p style="color: red;"><%=request.getParameter("error")%></p>
		<%} %>
	
  <p>E' possibile stampare la mappa dello stadio per una data partita e settore, con tutte le informazioni su ogni spettatore</p>
  <p>Per favore, inserisci i dati richiesti di seguito.</p>
  
  <form action="action_vedi_map_stadio.jsp" method="post">

    <%-- /*************************************************/ //SELEZIONA PARTITA --%>
	<% 
	   ConnManager cm = new ConnManager();
  	   Connection con = cm.getConnection();
  	   Statement st = con.createStatement();
       ResultSet rs;
       rs = st.executeQuery("select squadra_affrontata,data_partita,num_partita from partita");
  	%>
  	
    Seleziona Partita<br>
    
    <select name="select_partita" id="select_partita">
  	<%while(rs.next()){
  		java.sql.Date date = rs.getDate("data_partita");
  		DateFormat dateFormat = new SimpleDateFormat("dd-MMMM-YYYY");
  		String dateStr = dateFormat.format(date);  	
  	%>
  	
    	<option value="<%=rs.getString("num_partita")%>"><%=rs.getString("squadra_affrontata") + "   ----  In data: " + dateStr %></option>
    <% }%>
    
  	</select>
	
	<!-- /*************************************************/ -->
	
	<br>
    <br>
    <%rs = st.executeQuery("select cod_settore from settore");%>
    
    Settore<br>
    
    <select name="select_settore" id="select_settore">
    <option selected="selected">---</option>
    <%while(rs.next()){%>  	
    	<option value="<%=rs.getString("cod_settore")%>"><%=rs.getString("cod_settore")%></option>
    <% }%>    
    <%cm.closeConnection(); %>
    </select>    
    
    
    <br><br>
    <input type="submit" id="sub" value="Visualizza"> 	
  	
  </form>
  
  <div class="absolute">
  	<img alt="" src="immagini/mappatura.jpg" width="700px">
  </div> 
</article>

</div>


</body>
</html>