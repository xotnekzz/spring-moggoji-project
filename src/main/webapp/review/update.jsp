<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  window.onload=function(){
   CKEDITOR.replace('content');
  };
  
  $(function() {
    $("#file1MF").on('change', function(){
        readURL(this);
    });
});

function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#mainimg').attr('src', e.target.result);
        }
      reader.readAsDataURL(input.files[0]);
    }
}
</script>
</head>
<body>
<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/mypage/my_top.jsp" flush='false' />

<DIV class='list_content' >

<ASIDE style='float: left;'>
      MyPage >   <A href='./m_list_search.do?memberno=${memberno}&title=${param.title}&nowPage=${nowPage}'>리뷰 목록 </A>  > 수정
  </ASIDE>
  <ASIDE style='float: right;'>
   <!--  <A href="javascript:location.reload();">새로고침</A> -->
  </ASIDE> 
  
 <br><br>
 
  <FORM name='frm' method='POST' action='./update.do' enctype="multipart/form-data" class="form-horizontal">
               
      <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno }'>
      <input type='hidden' name='reviewno' id='reviewno' value='${reviewVO.reviewno}'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage}'>
      <input type='hidden' name='word' id='word' value='${param.word}'>
      
<!--       <input type='hidden' name='memberno' id='memberno' value='1'> -->
      
      <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">영화 제목</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='title' id='title' value='${reviewVO.title}'  >
        </div>
      </div>   
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">내용</label>
        <div class="col-md-10">
          <textarea class="form-control input-lg" name='content' id='content'  rows='10' required="required">${reviewVO.content }</textarea>
        </div>
      </div>
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">YouTube</label>
        <div class="col-md-10">
           <textarea class="form-control input-lg" name='youtube' id='youtube'  rows='3' >${reviewVO.youtube }</textarea>
        </div>
      </div>
      
<div id='mainimgPanel' class="form-group">
        <label class="col-md-2 control-label"></label>
        <div class="col-md-10" style="text-align: left;">
          <!-- 파일명을 소문자로 변경 -->
          <c:set var='mainimg' value="${fn:toLowerCase(reviewVO.mainimg)}" />
          <!-- 소문자로 변경된 파일명이 이미지인지 검사 -->
          <c:choose>
            <c:when test="${fn:endsWith(mainimg, '.jpg')}">
              <IMG id=mainimg src='./storage/${reviewVO.mainimg}' style='width: 20%;'>
            </c:when>
            <c:when test="${fn:endsWith(mainimg, '.gif')}">
              <IMG id='mainimg'  src='./storage/${reviewVO.mainimg}' style='width: 20%;'>
            </c:when>
            <c:when test="${fn:endsWith(mainimg, '.png')}">
              <IMG id='mainimg'  src='./storage/${reviewVO.mainimg}' style='width: 20%;'>
            </c:when>
            <c:when test="${reviewVO.mainimg.length() > 0}">
              ${reviewVO.mainimg }  <!-- 이미지가 아니면서 파일이 존재하는 경우 파일명 출력 -->
            </c:when>
          </c:choose>
        </div>
      </div>
      <div class="form-group">   
        <label for="file1MF" class="col-md-2 control-label">파일</label>
        <div class="col-md-10">
          <input type="file" class="form-control input-md" name='file1MF' id='file1MF' size='40' >
          <br>
        </div>
      </div> 
      <div class="form-group">   
        <label for="visible" class="col-md-2 control-label">출력 여부</label>
        <div class="col-md-10">
        <label style="float: left;">
            <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Y &nbsp;
          </label>
          <label style="float: left;" >
            <input type='radio' name='visible' id='visible' value='N'> N
          </label>
        </div>
      </div>  
 
      <DIV style='text-align: center; margin-bottom: 10px;'>
        <button class="btn btn-default" type="submit">수정</button>
        <button class="btn btn-default" type="button" onclick="location.href='./m_list_search.do?title=${param.title}&nowPage=${nowPage}'">취소[목록]</button>
      </DIV>
    </FORM>
    
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>