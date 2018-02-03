<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 
<title>Cipper - <tiles:insertAttribute name="title" /></title>

<link rel="stylesheet" type="text/css" href="/webjars/bootstrap/4.0.0/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="../../css/myStyle.css"/>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

<link rel="icon" type="image/png" href="../../images/favicon4.png" /> 

<script src="../../js/jquery-1.11.1.js"></script>
 
</head>
<body id="sfondo">
 
	<tiles:insertAttribute name="header" />
	<br>
	
	<div class="container-fluid" style="min-height: 78vh;">
		<div class="container">
			<tiles:insertAttribute name="body" />
		</div>
	</div>
	
	<br>
	<tiles:insertAttribute name="footer"/>

	<script src="../../js/jquery.min.js"></script>
	<script src="../../js/popper.min.js"></script>
	<script type="text/javascript" src="/webjars/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	
</body>
</html>