<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Properties" %>
<html>
<head>
<link rel="stylesheet" href="style/styles.css" type="text/css">
<link rel="stylesheet" href="style/menu.css" type="text/css">
<link rel="shortcut icon" href="images/favicon.ico">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/menu.js"></script>
<script>document.write('<div style="display:none;"><a href="http://apycom.com/">Apycom</a></div>');</script>
<title>Seguridad Claro</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="GENERATOR" content="Rational Application Developer">
<%
Properties Props = new Properties();
String propertyFileName = "conf.properties";
Props.load(getClass().getClassLoader().getResourceAsStream(propertyFileName));
String User = (request.getRemoteUser()!=null ? request.getRemoteUser() : "JL637879");
int slvl = 25;
%>
</head>
<body>
<style type="text/css">
	* { 
		margin:0;
 		padding:0;
	}
	div#menu { margin:5px auto; }
</style>
<div id="menu">
	<ul class="menu">
		<li><a href="index.jsp"><span>Indice</span></a></li>
		<li><a href="oss.jsp"><span>Ordenes</span></a></li>
		<li><a href="mastid.jsp"><span>Maestro de ID's</span></a></li>
		<li class="last"><a href="/PisaReports/"><span>Salir a PR!</span></a></li>
	</ul>
</div>
<div style="position: relative; width: auto;font-size:small;">
<p style="padding: 0; margin: 0; position: absolute; left: 0;font:11px 'Trebuchet MS'; color:#aaa;">&nbsp;&nbsp;Copyright &copy; 2013 Alejandro Lopez Monzon</p>
<p style="padding: 0; margin: 0; position: absolute; right: 0;color:white">Usuario: <em><%=User%></em>&nbsp;&nbsp;</p></br>
</div>
<h1>Seguridad Claro</h1>
<h2>Master de Identificadores</h2>
</body>
</html>
