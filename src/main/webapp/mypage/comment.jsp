<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
String root = request.getContextPath();
int movieno = 1;
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

$(function(){
/*   $('#read').hide();
  $('#poster').on("click", popup); */
})

function popup(movieno){

/*   $('#read').show(); */

    
  
};

</script>


</head>
<body>

<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/mypage/my_top.jsp" flush='false' />

<!-- <DIV class="popup1" id = 'read'> </DIV> -->

<DIV class='content' style="width: 70%; margin: 0px auto;">

<ASIDE style='float: left;'>
    <A href='./list.do'>코멘트</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <!-- <A href="javascript:location.reload();">새로고침</A> -->
  </ASIDE> 
  <br>

<div class="comment_out">
 <div class="main_movie" style="width: 48%;">
 <a style="top:0%; height: 375px;" href="javascript:popup(<%=movieno%>)">
  <IMG src=' ./images/1.png' style="height: 380px;">
  </a>
    <h4>영화 제목</h4>
    <h5>별점</h5>
 </div>
 <div class="comment">
   영화제목<br>
   장르 <br>
   별점<br><br>
   남긴 코멘트
 </div>
</div>

<!-- <div class="comment_out">
 <div class="textwithb" style="width: 48%;">
  <IMG src=' ./images/2.png' >
    <h4>영화 제목</h4>
    <h5>별점</h5>
 </div>
 <div  class="comment">
   영화제목<br>
   장르 <br>
   별점<br><br>
   남긴 코멘트
 </div>
</div> -->


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>