<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
String root = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script type="text/javascript">
$( '#topheader .navbar-nav a' ).on( 'click', function () {
  $( '#topheader .navbar-nav' ).find( 'li' ).removeClass( 'active' );
  $( this ).parent( 'li' ).addClass( 'active' ); 
});
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container' style="width: 100%; margin-top: 50px; padding: 0px;">

<div id="topheader" style="width: 100%;">
 <nav class="navbar navbar-default" style="width: 100%;">
  <div class="container-fluid" style="width: 75%;" >
    <ul class="nav navbar-nav" >
      <li class="active" style="font-size: 18px;"><a href="#">MyPage</a></li>
      <li><A href="<%=root %>/member/mupdate.do">내정보</A></li>
      <li><a href="<%=root %>/review/m_list_search.do">리뷰 </a></li>
      <li><a href="<%=root %>/movie/moviebucket.do">보고싶어요</a></li>
      <li><a href="<%=root %>/mcomment/m_mclist.do">코멘트</a></li>
    </ul>
    </div>
</nav>
</div>
 
</DIV> <!-- container END -->
 
</body>
</html>