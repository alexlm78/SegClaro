<!doctype html>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Properties" %>
<%@page import="gt.com.claro.pisa.segclaro.Users" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="javax.naming.Context" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.sql.DataSource" %>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="GENERATOR" content="Rational Application Developer">
	<meta charset="UTF-8">
	<title>Seguridad Claro</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="images/favicon.ico">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">
	<link rel="stylesheet" type="text/css" href="css/kreaker.css">
</head>
<%
Properties Props = new Properties();
String propertyFileName = "conf.properties";
Props.load(getClass().getClassLoader().getResourceAsStream(propertyFileName));
String User = (request.getRemoteUser()!=null ? request.getRemoteUser() : "JL637879");
int alvl = 45;
Users user = new Users(Props,User);
String query="";
int iPage=1;	// ?page=
int rTot=0;
Integer tmp;
if ( request.getParameter("page")!= null ) 
{
	tmp = new Integer(request.getParameter("page").toString());
	iPage = tmp.intValue();
}
if ( user.getSecLvl()>=alvl ) {
%>
<body>
	<div class="container">
		<div class="navbar">
    		<div class="navbar-inner">
			    <a class="brand" href="index.jsp">SegClaro</a>
			    <p class="navbar-text pull-right"><span class="label label-info"><%=User%></span></p>
			    <ul class="nav">
				    <li><a href="oss.jsp">Ordenes</a></li>
				    <li class="active"><a href="mastid.jsp">Maestro de ID's</a></li>
				    <li><a href="/PisaReports/Main">Salir a PR!</a></li>				    
			    </ul>
		    </div>
    	</div>
		<div class="page-header">
			<h1>Seguridad Claro WebApp</h1>
			<h3>Maestro de Identificadores</h3>
		</div>
		<div class="row">
			<div class="span12">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Virtual</th>
							<th>FacturaCon</th>
							<th>ID Titan</th>							
						</tr>
					</thead>
					<tbody>
						<!--tr class="info", sucess, warning, error -->
<%
try 
{
	Context ctx = new InitialContext();
	DataSource ds = (DataSource) ctx.lookup(Props.getProperty("jndi"));
	Connection dbConn = ds.getConnection();
	Statement st = dbConn.createStatement();
	ResultSet tot = st.executeQuery("SELECT COUNT(*) FROM JL637879.SVSGMASTID");
	if ( tot.next() ) 
		rTot = tot.getInt(1);
	
	query = "SELECT STATUS,VIRTUAL,FACCON,IDTITAN FROM JL637879.SVSGMASTID S WHERE RRN(S) BETWEEN "+String.valueOf((iPage*10)-9)+" AND "+String.valueOf(iPage*10);
	ResultSet rs = st.executeQuery(query);
	
	while ( rs.next() )
	{
%>
						<tr<%=(rs.getString("STATUS").compareTo("B")==0)?" class=\"warning\"" : (rs.getString("STATUS").compareTo("T")==0)?" class=\"error\"":" class=\"success\""%>>
							<td><%=rs.getString("VIRTUAL")%></td>
							<td><%=rs.getString("FACCON")%></td>
							<td><%=rs.getString("IDTITAN")%></td>							
						</tr>
<%
	}
	
	tot.close();
	rs.close();
	st.close();
	dbConn.close();
}catch ( Exception ex )
 {
	System.out.println(ex.getMessage());
	ex.printStackTrace();
}
%>						
					</tbody>
				</table>
			</div>
		</div>
		<div class="pagination pagination-centered">
			<ul>
<%if(iPage-1<1){%><li class="disabled"><a href="#">&laquo;</a></li><%}else{%><li><a href="mastid.jsp?page=<%=iPage-1%>">&laquo;</a></li><%}%>
<%				
int pag = (int) Math.ceil((double)rTot/10);
for ( int i=1; i<=pag; i++)
{
%>
				<li<%=(i==iPage)?" class=\"active\"":""%>><a href="mastid.jsp?page=<%=i%>"><%=i%></a></li>
<%
}
%>
<%if(iPage+1>pag){%><li class="disabled"><a href="#">&raquo;</a></li><%}else{%><li><a href="mastid.jsp?page=<%=iPage+1%>">&raquo;</a></li><%}%>
			</ul>
		</div>
	</div>
	<footer class="footer">
		<div class="navbar navbar-fixed-bottom">
			<div class="span12 text-left"><span class="label">Copyright &copy; 2013 Alejandro Lopez Monzon</span></div>
		</div>
	</footer>
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
<%
}else{
%>
<body>
	<div class="container">
	    <div class="alert alert-error">
			<h2>Error!</h2>
			<h4>El usuario <%=User%> no tiene acceso a esta aplicacion</h4>
		</div>
	</div>
</body>
<%
}
%>
</html>
