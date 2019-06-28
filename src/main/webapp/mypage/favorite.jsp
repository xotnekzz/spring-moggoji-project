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

</script>


</head>
<body>

<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/mypage/my_top.jsp" flush='false' />

<DIV class='content' style="width: 70%; margin: 0px auto;" >

 <ASIDE style='float: left;'>
    <A href='./list.do'>취향</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
  <!--   <A href="javascript:location.reload();">새로고침</A> -->
  </ASIDE> 
  <br>

<div class="center-block">

 <div class="panel panel-default" style="float:left; width: 48%; margin-top: 10px;">
    <div class="panel-heading" style="font-size: 20px;">선호배우</div>
    <form action="" method="get">
    <div class="panel-body " style="margin: 0px auto;">
      <input type="text" class="underline" name="actor1" id="actor1" style="width: 100%; margin-bottom: 5px;">
      <input type="text" class="underline" name="actor2" id="actor2" style="width: 100%; margin-bottom: 5px;">
      <input type="text" class="underline" name="actor3" id="actor3" style="width: 100%; margin-bottom: 5px;">
      <div class="col-md-12 text-center">
       <button type="button" class="btn btn-default" > 등록 </button>
      </div>
    </div>
    </form>
  </div>

 
 <div class="panel panel-default" style="float:left; width: 48%; margin-top: 10px; margin-left: 20px;">
    <div class="panel-heading" style="font-size: 20px;">선호장르</div>
    <form action="" method="get">
    <div class="panel-body" style="margin: 0px auto;">
      <input type="text" class="underline" name="actor1" id="actor1" style="width: 100%; margin-bottom: 5px;">
      <input type="text" class="underline" name="actor2" id="actor2" style="width: 100%; margin-bottom: 5px;">
      <input type="text" class="underline" name="actor3" id="actor3" style="width: 100%; margin-bottom: 5px;">
      <div class="col-md-12 text-center">
        <button type="button" class="btn btn-default" > 등록 </button>
      </div>
    </div>
    </form>
  </div>

</div>

 

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>