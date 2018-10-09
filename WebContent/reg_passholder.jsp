<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.text.*" %>
<%@ page import = "connessione.ConnManager"%>
<!DOCTYPE html>
<html>
<head>
<title>Registra Nuovo PassHolder</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>

<div class="container">

<header>
   <h1>Registra Nuovo PassHolder</h1>
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
  
  <form action="action_reg_passholder.jsp" method="post">
  	
    Codice fiscale utente<br>
    <input type="text" name="cf" value="">
    <br>
    <br>
    Nome<br>
    <input type="text" name="nome" value="">
    <br>
    <br>
    Cognome<br>
    <input type="text" name="cognome" value="">
    <br>
    <br>
    Data Nascita<br>
    <input type="text" name="datanascita" value="" placeholder="es: 26-Ott-1992">
    <br>
    <br>
    Luogo Nascita<br>
    <input type="text" name="luogonascita" value="">
    <br>
    
    <br><br>
    <input type="submit" value="Registra PassHolder">
  </form>
  
  
  <div class="absolute">
    <img alt="" src="immagini/tifosi.jpg" width="700px">
  </div>
</article>


</div>

</body>
</html>