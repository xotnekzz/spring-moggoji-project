<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  window.onload=function(){
   CKEDITOR.replace('content');
  };
</script>
</head>
<body>
<DIV class='container' style="width:100%; ">

<jsp:include page="/menu/top.jsp" flush='false' />

<%-- <jsp:include page="/mypage/my_top.jsp" flush='false' /> --%>

<DIV class='content'>

  <ASIDE style='float: left;'>
      <A href='./list.do?title=${param.title}&nowPage=${nowPage}'>QnA</A>  > 답글등록
  </ASIDE>
  <ASIDE style='float: right;'>
   <!--  <A href="javascript:location.reload();">새로고침</A> -->
  </ASIDE> 
  
  <br>
 
  <FORM name='frm' method='POST' action='./reply.do' class="form-horizontal">
      <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno }'>
      <input type='hidden' name='mname' id='mname' value='${sessionScope.mname }'>
      <input type='hidden' name='qnano' id='qnano' value='${param.qnano}'>
 
     <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">답글 제목</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='title' id='title' required="required" placeholder="답글 제목" >
        </div>
      </div>   
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">내용</label>
        <div class="col-md-10">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10' ></textarea>
        </div>
      </div>
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">패스워드</label>
        <div class="col-md-10">
          <input type='password' class="form-control input-lg" name='qpasswd' id='qpasswd'>
        </div>
      </div>
    
      <DIV style='text-align: center;'>
        <button class="btn btn-default" type="submit">등록</button>
        <button class="btn btn-default" type="button" onclick="location.href='./list.do?'">취소(목록)</button>
      </DIV>
</FORM>
    
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>