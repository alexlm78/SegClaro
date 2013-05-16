<!doctype html>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Properties" %>
<%@page import="gt.com.claro.pisa.segclaro.Users" %>
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
				    <li><a href="mastid.jsp">Maestro de ID's</a></li>
				    <li><a href="/PisaReports/Main">Salir a PR!</a></li>				    
			    </ul>
		    </div>
    	</div>
		<div class="page-header">
			<h1>Seguridad Claro WebApp</h1>			
		</div>
		<div class="row">
		<div class="alert alert-success">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<strong>Bienvenido</strong> <em><%=user.getNombre()%></em> a Seguridad Claro WebApp!
		</div>
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