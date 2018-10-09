<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.text.*" %>
<%@ page import = "connessione.ConnManager"%>
<%	
	int cod_biglietto=(int)(Math.random() * 10000);
	int cod_prenotazione=(int)(Math.random() * 10000);
	String num_partita = request.getParameter("select_partita");
	String cf = request.getParameter("cf");
	String settore = request.getParameter("select_settore");
	String posto = request.getParameter("numeroposto");
	String tipologia_posto = request.getParameter("select_tipologia");
	String prezzo=request.getParameter("prezzo");
	ConnManager cm=null;
	Connection con;
	PreparedStatement pst;
	
	if(tipologia_posto.equals("norm")){
		tipologia_posto="1";
		System.out.println(tipologia_posto);
	}				
	if(tipologia_posto.equals("dir")){
		tipologia_posto="0";
		System.out.println(tipologia_posto);
	}				
	if(tipologia_posto.equals("dis")){
		tipologia_posto="2";
		System.out.println(tipologia_posto);
	}
		
	try {
		
		cm = new ConnManager();
		con = cm.getConnection(); 
		
		System.out.println("insert into biglietto values('B_"+cod_biglietto+"', (select ref(p) from partita p where p.num_partita ='"+num_partita+"'),"+
		"(select ref(c) from passholder c where c.cf ='"+cf+"'),"+"(select ref(d) from settore d where d.cod_settore ='"+settore+"'),"+
				"(select ref(r) from posto r where r.num_posto = "+posto+" and r.tipologia ="+tipologia_posto+
				" and deref(r.settore).cod_settore = '"+settore+"'),"+
		prezzo+")");
		
	
		pst = con.prepareStatement(		
				"insert into biglietto values('B_"+cod_biglietto+"', (select ref(p) from partita p where p.num_partita ='"+num_partita+"'),"+
		"(select ref(c) from passholder c where c.cf ='"+cf+"'),"+"(select ref(d) from settore d where d.cod_settore ='"+settore+"'),"+
				"(select ref(r) from posto r where r.num_posto = "+posto+" and r.tipologia ="+tipologia_posto+
				" and deref(r.settore).cod_settore = '"+settore+"'),"+
		prezzo+")");
		pst.executeQuery();
		
		//INSERIMENTO RELATIVA PRENOTAZIONE
		pst = con.prepareStatement(		
				"insert into prenotazione values('P_"+cod_prenotazione+"', SYSDATE,(select ref(p) from passholder p where p.cf ='"+cf+"'),"+
		"(select ref(b) from biglietto b where b.cod_biglietto ='B_"+cod_biglietto+"'))");
		pst.executeQuery();
		
		
		cm.closeConnection();
		response.sendRedirect("reg_biglietto.jsp?success=true");
	}catch(Exception e){
		response.sendRedirect("reg_biglietto.jsp?error="+e.getMessage());		
		cm.closeConnection();
	}
	
%>