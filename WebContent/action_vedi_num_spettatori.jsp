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
  	String stagione = request.getParameter("select_stagione");
  	
  	ConnManager cm=null;
	Connection con;
	PreparedStatement pst=null;
	ResultSet rs;
  	
	try {
		
		cm = new ConnManager();
		con = cm.getConnection(); 		
		
		
		System.out.println("select NUM_PARTITA,AVVERSARIO,"+ 
				"TOT_SETTORE1+TOT_SETTORE2+TOT_SETTORE3+TOT_SETTORE4+TOT_SETTORE5+TOT_SETTORE6+TOT_SETTORE7+TOT_SETTORE8+TOT_SETTORE9+TOT_SETTORE10 TOTALE,"+
				"TOT_SETTORE1,TOT_SETTORE2,TOT_SETTORE3,TOT_SETTORE4,TOT_SETTORE5,TOT_SETTORE6,TOT_SETTORE7,TOT_SETTORE8,TOT_SETTORE9,TOT_SETTORE10 "+
				"from"+
				"(select deref(biglietto.partita).num_partita as NUM_PARTITA, deref(biglietto.partita).squadra_affrontata as AVVERSARIO,"+
				"deref(biglietto.settore).cod_settore as SETTORE from biglietto "+
				"where deref(biglietto.partita).stagione.id_stagione = '"+stagione+"')"+
				"PIVOT(count(*) for SETTORE in ('SET1' TOT_SETTORE1, 'SET2' TOT_SETTORE2, 'SET3' TOT_SETTORE3,"+ 
				"'SET4' TOT_SETTORE4, 'SET5' TOT_SETTORE5, 'SET6' TOT_SETTORE6, 'SET7' TOT_SETTORE7, 'SET8' TOT_SETTORE8,"+
				"'SET9' TOT_SETTORE9, 'SET10' TOT_SETTORE10))order by NUM_PARTITA");
		
		pst = con.prepareStatement("select NUM_PARTITA,AVVERSARIO,"+ 
				"TOT_SETTORE1+TOT_SETTORE2+TOT_SETTORE3+TOT_SETTORE4+TOT_SETTORE5+TOT_SETTORE6+TOT_SETTORE7+TOT_SETTORE8+TOT_SETTORE9+TOT_SETTORE10 TOTALE,"+
				"TOT_SETTORE1,TOT_SETTORE2,TOT_SETTORE3,TOT_SETTORE4,TOT_SETTORE5,TOT_SETTORE6,TOT_SETTORE7,TOT_SETTORE8,TOT_SETTORE9,TOT_SETTORE10 "+
				"from"+
				"(select deref(biglietto.partita).num_partita as NUM_PARTITA, deref(biglietto.partita).squadra_affrontata as AVVERSARIO,"+
				"deref(biglietto.settore).cod_settore as SETTORE from biglietto "+
				"where deref(biglietto.partita).stagione.id_stagione = '"+stagione+"')"+
				"PIVOT(count(*) for SETTORE in ('SET1' TOT_SETTORE1, 'SET2' TOT_SETTORE2, 'SET3' TOT_SETTORE3,"+ 
				"'SET4' TOT_SETTORE4, 'SET5' TOT_SETTORE5, 'SET6' TOT_SETTORE6, 'SET7' TOT_SETTORE7, 'SET8' TOT_SETTORE8,"+
				"'SET9' TOT_SETTORE9, 'SET10' TOT_SETTORE10))order by NUM_PARTITA");
		rs = pst.executeQuery();
		%>
		<div class="absolute_tab">
    	<table class="tg">
		  <tr>
		    <th class="tg2">PARTITA</th>
		    <th class="tg2">AVVERSARIO</th>
		    <th class="tg2">TOT</th>
		    <th class="tg2">TOT_S1</th>
		    <th class="tg2">TOT_S2</th>
		    <th class="tg2">TOT_S3</th>
		    <th class="tg2">TOT_S4</th>
		    <th class="tg2">TOT_S5</th>
		    <th class="tg2">TOT_S6</th>
		    <th class="tg2">TOT_S7</th>
		    <th class="tg2">TOT_S8</th>
		    <th class="tg2">TOT_S9</th>
		    <th class="tg2">TOT_S10</th>
		  </tr>
		  <%while(rs.next()){%>
		  <tr>
		    <td class="tg2"><%=rs.getString("NUM_PARTITA")%></td>
		    <td class="tg2"><%=rs.getString("AVVERSARIO")%></td>
		    <td class="tg2"><%=rs.getString("TOTALE")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE1")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE2")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE3")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE4")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE5")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE6")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE7")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE8")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE9")%></td>
		    <td class="tg2"><%=rs.getString("TOT_SETTORE10")%></td>
		  </tr>
		  <%} %>
		</table>
    	
    </div>
    <%						
		cm.closeConnection();
	}catch(Exception e){
		response.sendRedirect("vedi_num_spettatori.jsp?error="+e.getMessage());		
		cm.closeConnection();
	}
	
  %>
  
</article>

</div>


</body>
</html>