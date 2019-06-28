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
<DIV class='container'  style="width: 100%; ">

<jsp:include page="/menu/top.jsp" flush='false' />

<%-- <jsp:include page="/mypage/my_top.jsp" flush='false' /> --%>

<DIV class='list_content'  >

  <ASIDE style='float: left;'>
      MyPage >  <A href='./m_list_search.do?memberno=${memberno}&title=${param.title}&nowPage=${nowPage}'>리뷰 목록 </A>  > 등록
  </ASIDE>
  <ASIDE style='float: right;'>
   <!--  <A href="javascript:location.reload();">새로고침</A> -->
  </ASIDE> 
  
  <br><br>
 
  <FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data" class="form-horizontal">
               
      <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno }'>
      <input type='hidden' name='mname' id='mname' value="${ sessionScope.mname}">
 
      <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">영화 제목</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='title' id='title' required="required" placeholder="영화 제목" >
        </div>
      </div>   
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">내용</label>
        <div class="col-md-10">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10' ></textarea>
        </div>
      </div>
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">YouTube</label>
        <div class="col-md-10">
          <textarea class="form-control input-lg" name='youtube' id='youtube'  rows='3'></textarea>
        </div>
      </div>
      <div class="form-group">   
        <label for="file1MF" class="col-md-2 control-label">대표이미지</label>
        <div class="col-md-10">
          <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40'>
          <br>
        </div>
      </div>  
      <div class="form-group">   
        <label for="visible" class="col-md-2 control-label">출력 여부</label>
        <div class="col-md-10">
        <label style="float: left;">
            <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Y &nbsp;
          </label>
          <label style="float: left;">
            <input type='radio' name='visible' id='visible' value='N'> N
          </label>
        </div>
      </div>
      
<%--       <div class="form-group">
      <label for="content" class="col-md-2 control-label">mname</label>
        <div class="col-md-10">
          <input type="text" class="form-control input-lg" name='mname' id='mname' value="${ sessionScope.mname}">
        </div>
      </div> --%>
       
      <DIV style='text-align: center; margin-bottom: 10px;'>
        <button class="btn btn-default" type="submit">등록</button>
        <button class="btn btn-default" type="button" onclick="location.href='./list_search.do?'">취소(목록)</button>
      </DIV>
    </FORM>
    
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>