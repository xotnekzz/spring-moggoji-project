<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<!-- <link href="../css/style.css" rel="Stylesheet" type="text/css"> -->

<style type="text/css">

#topheader .navbar-nav li > a {
  text-transform: capitalize;
  color: #000;
  transition: background-color .2s, color .2s; 
}


#topheader .navbar-nav li > a:hover, 
#topheader .navbar-nav li > a:focus {
    background-color: #333;
    color: #fff;
}

#topheader .navbar-nav li.active > a {
  background-color: #333;
  color: #fff;
}

</style>
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$( '#topheader .navbar-nav a' ).on( 'click', function () {
  $( '#topheader .navbar-nav' ).find( 'li.active' ).removeClass( 'active' );
  $( this ).parent( 'li' ).addClass( 'active' );
});
</script>
</head>
<body>
<DIV class='container'>
<DIV class='content'>
 
<div id="topheader">
  <nav class="navbar navbar-default">
       <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav">
            <li><a href="#page1">page 1</a></li>
            <li><a href="#page2">page 2</a></li>
            <li><a href="#page3">page 3</a></li>
          </ul>
       </div>
  </nav>
</div>

</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>