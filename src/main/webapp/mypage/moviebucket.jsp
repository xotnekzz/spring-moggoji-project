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

function popup(movieCd) {
  var url="http://localhost:9090/movie/movie/read.do?movieCd="+movieCd;
  var name = "pop";
  window.open(url, name, 'height=700, width=1150, left=200, top=50, location=no, scrollbars=yes, status=no, tollbar=no, director=no, menubar=no');
}

$( '#topheader .navbar-nav a' ).on( 'click', function () {
  $( '#topheader .navbar-nav' ).find( 'li.active' ).removeClass( 'active' );
  $( this ).parent( 'li' ).addClass( 'active' );
});


</script>

 
</head>
<body>

<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/mypage/my_top.jsp" flush='false' />

<DIV class='content' style="width: 70%; margin: 0px auto;">

<ASIDE style='float: left;'>
    <A href='./list.do'>보고싶어요</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <!-- <A href="javascript:location.reload();">새로고침</A> -->
  </ASIDE> 
  <br>
  
 <div class="textwithb" id="moviee">
  <a style="top:0%; height: 400px;" >
  <IMG src=' ./images/1.png'  onclick="popup(${movieCd});">
  </a>
  <h4>영화 제목</h4>
<span class="star-input" style="top: 70%;">
  <span class="input">
      <input type="radio" name="star-input" value="1" id="p1">
      <label for="p1">1</label>
      <input type="radio" name="star-input" value="2" id="p2">
      <label for="p2">2</label>
      <input type="radio" name="star-input" value="3" id="p3">
      <label for="p3">3</label>
      <input type="radio" name="star-input" value="4" id="p4">
      <label for="p4">4</label>
      <input type="radio" name="star-input" value="5" id="p5">
      <label for="p5">5</label>
    </span>
    <output for="star-input"><b>0</b>점</output>           
</span>
<script src="../js/star.js"></script>

 </div>

  <div class="textwithb">
  <a style="top:0%; height: 400px;" >
  <IMG src=' ./images/2.png' >
  </a>
  <h4>영화 제목</h4>
  <h5>별점</h5>
 </div>
 
   <div class="textwithb">
  <a style="top:0%; height: 400px;" >
  <IMG src=' ./images/3.png' >
  </a>
  <h4>영화 제목</h4>
  <h5>별점</h5>
 </div>
 
  <div class="textwithb">
  <a style="top:0%; height: 400px;" >  
  <IMG src=' ./images/4.png' >
  </a>
  <h4>영화 제목</h4>
  <h5>별점</h5>
 </div>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>