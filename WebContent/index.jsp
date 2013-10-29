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
	<link href="images/favicon.ico" rel="shortcut icon">
	<link href="css/bootstrap.css" rel="stylesheet" media="screen">
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
    <link href="css/kreaker.css" rel="stylesheet">
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
	<!-- Fixed navbar -->
	<div class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
		        <a class="navbar-brand" href="index.jsp">SegClaro</a>
	        </div>
	        <div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
				    <li><a href="oss.jsp">Ordenes</a></li>
				    <li><a href="mastid.jsp">Maestro de ID's</a></li>
				    <li><a href="/PisaReports/Main">Salir a PR!</a></li>				    
			    </ul>
			    <ul class="nav navbar-nav navbar-right">
			    	<li><a href="#"><span class="label label-primary"><%=User%></span></a></li>
			    </ul>
			</div>
		</div>
    </div><!-- Fixed navbar End -->
	<div class="container">
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
	<!-- Footer -->
	<footer class="footer">
		<div class="col-md-12 text-left"><span class="label label-default">Copyright &copy; 2013 Alejandro Lopez Monzon</span></div>
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