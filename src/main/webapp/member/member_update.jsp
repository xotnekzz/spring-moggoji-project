<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
<script type="text/javascript">
$(function() {
  $("#fileMF").on('change', function(){
      readURL(this);
  });
});

function readURL(input) {
  if (input.files && input.files[0]) {
  var reader = new FileReader();

  reader.onload = function (e) {
          $('#user').attr('src', e.target.result);
      }
    reader.readAsDataURL(input.files[0]);
  }
}
</script>
</head>
<body>
<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/admin/admin_top.jsp" flush='false' />

<DIV class='list_content' >

  <ASIDE style='float: left;'>
       관리자 > <A href='./member_list_search.do?&word=${param.word}&nowPage=${param.nowPage}'>회원 목록</A>  > 수정
  </ASIDE>
<br><br> 
  <FORM name='frm' method='POST' action='./member_update.do' enctype="multipart/form-data">
  <input type='hidden' name='memberno' id='memberno' value='${memberVO.memberno }'>
  <input type='hidden' name='memail' id='memail' value='${memberVO.memail }'>
  <input type='hidden' name='word' id='word' value='${param.word }'>
  <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
  <fieldset class='fieldset_no_line' style='width : 60%; margin : 0px auto;'>
  
  <div style="float: left; width: 240px; height: 290px; margin-top: 50px;">
    <div style="height: 80%;">
    <!-- 이미지가 있으면 기존이미지 보여주고 아니면 user이미지 보여주기 -->
    <c:choose>
      <c:when test = "${memberVO.mfile != null }">
          <img id="user" src="./storage/${memberVO.mfile}" style="border: 1px solid; height : 220px; width: 240px;">
      </c:when>
      <c:otherwise>
        <img id="user" src="./images/user.png" style="border: 1px solid; height : 220px;">
      </c:otherwise>
    </c:choose>
    </div>
    <div>
      <ul>
        <li class='li_none'>
          <input type='file' name='fileMF' id='fileMF'>
       </li>
      </ul>
    </div>
  </div>
  <div style="float: left; width: 60%; text-align: left; margin-top: 50px;" >
     <ul>
      <li class='li_none'>
        <label class='label_basic' for='name'>성명</label>
        <input type='text' class="form-control input-lg" name='mname' id='mname' value="${memberVO.mname }">
      </li>
      <li class='li_none'>
        <label class='label_basic' for='passwd'>패스워드</label>
        <input type='text' class="form-control input-lg" name='mpasswd' id='mpasswd' value="${memberVO.mpasswd }">
      </li>
    </ul>
    </div>
    <br>
  </fieldset>
  <div style="margin-top: 30px; padding-left: 90px;">
        <button type='submit' class="btn btn-default">수정하기</button>
        <button type='button' onclick="location.href='./member_list_search.do?&word=${param.word}&nowPage=${param.nowPage}'" class="btn btn-default">취소[목록]</button>
    </div>
</FORM>

    
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>