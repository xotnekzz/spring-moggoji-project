<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>
<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<DIV class='content' style="width: 70%; margin: 0px auto;">

  <ASIDE style='float: left;'>
      <A href='./list.do'>영화 </A>  > 등록
  </ASIDE>
  <ASIDE style='float: right;'>
    <!-- <A href="javascript:location.reload();">새로고침</A> -->
  </ASIDE> 
  
  <br>
 
  <form name='frm' method='POST' action='./create.do' enctype="multipart/form-data" class="form-horizontal">
               
      <input type='hidden' name='categoryno' id='categoryno' value='${param.categoryno}'>
      <input type='hidden' name='mno' id='mno' value='${sessionScope.mno }'>
      
      <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">영화 코드</label>
        <div class="col-md-2">
          <input type='number' class="form-control input-lg" name='movieCd' id='movieCd' required="required"  >
      </div>
      </div>   
      
       <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">영화 제목</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='title' id='title' required="required" placeholder="영화 제목" >
        </div>
      </div>  
      
       <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">개봉년도</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='title' id='title' required="required" placeholder="영화 제목" >
        </div>
      </div>  
      
      <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">관람등급</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='title' id='title' required="required" placeholder="영화 제목" >
        </div>
      </div> 
      
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">상영시간</label>
        <div class="col-md-10">
           <input type='text' class="form-control input-lg" name='runtime' id='runtime' required="required" placeholder="120분" >
        </div>
      </div>
      
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">국가명</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='nationNm' id='nationNm' required="required" placeholder="대한민국" >
        </div>
      </div>
             
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">줄거리</label>
        <div class="col-md-10">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10'></textarea>
        </div>
      </div>
      
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">키워드</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='word' id='word'  value='' placeholder="#키워드">
        </div>
      </div>
      
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">영상</label>
        <div class="col-md-10">
          <textarea class="form-control input-lg" name='content' id='content'  rows='3' placeholder="YouTube"></textarea>
        </div>
      </div> 
      
      <div class="form-group">   
        <label for="filesMF" class="col-md-2 control-label">포스터</label>
        <div class="col-md-10">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
        </div>
      </div>   
 
      <div style='text-align: center;'>
        <button class="btn btn-default" type="submit">등록</button>
        <button class="btn btn-default" type="button" onclick="location.href='./list.do?'">취소[목록]</button>
        <br>
      </div>
      
  </form>
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>