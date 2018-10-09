<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.text.*" %>
<%@ page import = "connessione.ConnManager"%>
<!DOCTYPE html>
<html>
<head>
<title>Registra Nuovo Biglietto (Solo Stagione 2018)</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<div class="container">

<header>
   <h1>Registra Nuovo Biglietto (Solo Stagione 2018)</h1>
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
		if(request.getParameter("success") != null){
			if(request.getParameter("success").equals("true")){
				%>
				<p style="color: green;">Operazione eseguita con successo!</p>
				<%
			}
		}
		if(request.getParameter("error") != null) {%>
		<p style="color: red;"><%=request.getParameter("error")%></p>
		<%} %>

  <p>Per favore, inserisci i dati richiesti di seguito.</p>
  
  <form action="action_reg_biglietto.jsp" method="post">
    Codice fiscale PassHolder<br>
    <input type="text" name="cf" value="">
    <br><br>
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
    
    <br>
    Tipologia del #Posto<br>
    <select name="select_tipologia" id="select_tipologia">
    	<option selected="selected">---</option>
    	<option value="norm">Normale</option>
    	<option value="dir">Dirigente</option>
    	<option value="dis">Disabile</option>
    </select>
    <br>
    #Posto<br>
    <input type="text" name="numeroposto" value="" placeholder="es: 33">
    <br>
    <br>
    <button type="button" id="calc_prezzo" onclick="calcolaPrezzo()">Calcola Prezzo</button>
    <input type="text" name="prezzo" id="prezzo" value="" readonly> Euro
    <p id="prezzo_eff"></p>

    <br><br>
    <input type="submit" id="sub" value="Registra Biglietto" disabled>
  	
  </form>
  
  <div class="absolute">
  	<img alt="" src="immagini/settori.jpg" width="700px">
  </div>
</article>

</div>



<script>
function calcolaPrezzo() {
	var prezzo = 16;
	var settore = document.getElementById("select_settore").options[document.getElementById("select_settore").selectedIndex].value;
	var partita = document.getElementById("select_partita").options[document.getElementById("select_partita").selectedIndex].value;
	var tipologia = document.getElementById("select_tipologia").options[document.getElementById("select_tipologia").selectedIndex].value;
	
	if( settore === "SET1" || 
		settore === "SET2" || 
		settore === "SET3" || 
		settore === "SET4" )
		{	//se i settori sono 1, 2, 3, 4
			prezzo += 10;	
		}
	if( (partita == 2) || 
		(partita == 5) || 
		(partita == 12) || 
		(partita == 19) || 
		(partita == 20) )
		{	//se le partite sono contro: Inter, Benfica, Arsenal, PSG, Barcellona
			prezzo += 10;		
		}
	document.getElementById("prezzo").value = prezzo;
	document.getElementById("prezzo_eff").innerHTML = "";
	if(tipologia === "dir") 
    {	//dirigente   	
    	document.getElementById("prezzo_eff").innerHTML = "Prezzo [effettivo]: "+0+ "Euro";
    }
    if(tipologia === "dis") 
    {	//tifoso diversamente abile    	
    	document.getElementById("prezzo_eff").innerHTML = "Prezzo [effettivo]: "+prezzo/2+"Euro";
    }
    document.getElementById("sub").disabled = false;
}
</script>


</body>
</html>