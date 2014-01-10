<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Properties" %>
<%@page import="java.util.ArrayList" %>
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
String query="";
int iPage=1;	// ?page=
int rTot=0;		// Register sums
int cPerPage = (session.getAttribute("pPage")!=null) ? (new Integer(session.getAttribute("pPage").toString())).intValue() : 25;
ArrayList filts = null;

// Pagination values.
if( request.getParameter("perPage")!= null )
	cPerPage = (new Integer(request.getParameter("perPage").toString())).intValue();
// Number of page to stay in.
if ( request.getParameter("page")!= null ) 
	iPage = (new Integer(request.getParameter("page").toString())).intValue();

// search criteria.
if ( request.getParameter("valor")!= null && request.getParameter("valor").length()>0)
{
	filts = new ArrayList();
	filts.add(request.getParameter("filtro"));
	filts.add(request.getParameter("valor"));
	iPage=1;
}

// Session values
session.setAttribute("pPage", new Integer(cPerPage));	// Registers by page.

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
				    <li class="active"><a href="oss.jsp">Ordenes</a></li>
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
			<h3>Ordenes de Servicio</h3>			
		</div>
		<div class="panel panel-default"><!-- Panel -->
			<div class="panel-heading">
				<form method="post" class="form-inline container" role="search">
					<div class="col-md-4 col-md-offset-8">
						<button type="submit" class="btn btn-default pull-right"><span class="glyphicon glyphicon-search"></span></button>
				  		<div class="form-group pull-right">
							<select name="filtro" class="form-control">
								<option value="SVSGDSOÑ">Orden</option>
								<option value="SVSGDPHÑ">Virtual</option>
								<option value="SVSGDMBÑ">FacCon</option>
							</select>
						</div>
						<div class="form-group pull-right">
							<input name="valor" type="text" class="form-control" placeholder="Buscar...">
						</div>
					</div>
				</form>
			</div>			
			<div class="panel-body"><!-- Panel Body -->
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Orden</th>
							<th>Virtual</th>
							<th>FacturaCon</th>
							<th>Item</th>
							<th>Fecha Posteo</th>
							<th>Operacion</th>
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
	query = "SELECT COUNT(*) FROM GUAV1.SVSGURIDAD";
	if ( filts!=null)
		query += " WHERE "+filts.get(0)+"='"+filts.get(1)+"'";
		
	ResultSet tot = st.executeQuery(query);
	if ( tot.next() ) 
		rTot = tot.getInt(1);
	
	query = "SELECT SVSGDSTA,SVSGDSOÑ,SVSGDPHÑ,SVSGDMBÑ,SVSGDITM,SVSGDFPST,SVSGDOPER FROM ( SELECT SVSGDSTA,SVSGDSOÑ,SVSGDPHÑ,SVSGDMBÑ,SVSGDITM,SVSGDFPST,SVSGDOPER,ROW_NUMBER() OVER (ORDER BY SVSGDSOÑ ) AS RID FROM GUAV1.SVSGURIDAD ";
	if ( filts!=null)
		query += " WHERE "+filts.get(0)+"='"+filts.get(1)+"'";
	query +=") AS T WHERE T.RID BETWEEN "+String.valueOf((iPage*cPerPage)-(cPerPage-1))+" AND "+String.valueOf(iPage*cPerPage);
		
	ResultSet rs = st.executeQuery(query);
	
	while ( rs.next() )
	{
%>
						<tr<%=(rs.getString("SVSGDSTA").compareTo("E")==0)?" class=\"warning\"" : (rs.getString("SVSGDSTA").compareTo("F")==0)?" class=\"danger\"":(rs.getString("SVSGDSTA").compareTo("P")==0)?" class=\"success\"":(rs.getString("SVSGDSTA").compareTo("B")==0)?" class=\"active\"":""%>>
							<td><%=rs.getString("SVSGDSOÑ")%></td>
							<td><%=rs.getString("SVSGDPHÑ")%></td>
							<td><%=rs.getString("SVSGDMBÑ")%></td>
							<td><%=rs.getString("SVSGDITM")%></td>
							<td><%=rs.getString("SVSGDFPST")%></td>
							<td><%=rs.getString("SVSGDOPER")%></td>
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
			</div> <!-- Panel Body End -->
			<div class="panel-footer">
				<form method="post" class="form-inline container" role="search">
			  		<div class="form-group">
						<select name="perPage" class="form-control">
							<option<%=cPerPage==15?" selected":""%>>15</option>
							<option<%=cPerPage==25?" selected":""%>>25</option>
							<option<%=cPerPage==50?" selected":""%>>50</option>
							<option<%=cPerPage==70?" selected":""%>>70</option>
						</select>
					</div>
					<button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-ok-circle"></span></button>
				</form>
			</div>
		</div> <!-- Panel End -->
		<div class="pagination-centered"> <!-- Pagination -->
			<ul class="pagination">
<%if(iPage-1<1){%><li class="disabled"><a href="#">&laquo;</a></li><%}else{%><li><a href="oss.jsp?page=<%=iPage-1%>">&laquo;</a></li><%}%>
<%				
int pag = (int) Math.ceil((double)rTot/cPerPage);
for ( int i=1; i<=pag; i++)
{
%>
				<li<%=(i==iPage)?" class=\"active\"":""%>><a href="oss.jsp?page=<%=i%>"><%=i%></a></li>
<%
}
%>
<%if(iPage+1>pag){%><li class="disabled"><a href="#">&raquo;</a></li><%}else{%><li><a href="oss.jsp?page=<%=iPage+1%>">&raquo;</a></li><%}%>
			</ul>
		</div> <!-- Pagination End-->
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
<%/* sql SOURCE for the data. */
/*
SELECT SVSGDSTA,SVSGDSO#,SVSGDPH#,SVSGDMB#,SVSGDITM,SVSGDFPST,SVSGDOPER 
FROM (
	 	SELECT SVSGDSTA,SVSGDSO#,SVSGDPH#,SVSGDMB#,SVSGDITM,SVSGDFPST,
	 	SVSGDOPER,ROW_NUMBER() OVER (ORDER BY SVSGDSO# ) AS RID
	 	FROM SVSGURIDAD 
	 ) AS T
WHERE T.RID BETWEEN 26 AND 50
*/
%>
