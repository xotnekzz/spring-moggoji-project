<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 영화 코멘트</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="../js/star.js"></script>
<script type="text/javascript">
$(function(){
  $('#frm_update').hide();
});

function updateco(movieCd,memberno){
  //alert("창");
  $('#frm_update').show();
  
  $.ajax({
    url: "./read.do", // 요청을 보낼주소
    type: "get",  
    cache: false,
    dataType: "json", 
    data: 'movieCd='+movieCd+"&memberno="+memberno,  
    
    success: function(rdata) { // callback 함수
      var frm_update = $('#frm_update');
      $('#grade',frm_update).val(rdata.grade);
      $('#content',frm_update).val(rdata.content);

    },
    
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      
      var panel='';
      panel+="<DIV id='panel' class='popup1' style='height: 350px;'>"
      panel+=msg;
      panel+="<br><button type='button' onclick=\"$('#main_panel').hide();\">닫기</button>";
      panel+="</DIV>";
      
      $('#main_panel').html(panel);
      $('#main_panel').show(); 
    }
  });
}

function update_cancel(){
  $('#panel_update').hide();
}

//댓글 수정
function uupdateco(movieCd,memberno){
  var frm_update = $('#frm_update');
  $('#movieCd', frm_update).val(movieCd);
  $('#memberno', frm_update).val(memberno);
  
  var html = '';
  html += "<DIV id='panel' class='popup'>";
  html += "  댓글을 수정합니다.<br>";
 // html += " <span style='text-align: center;'>${movieNmVO.movieNm}</span>";
/*   html += " <div id ='rating' style='float: left;'>";
  html += " <span>"
  html += " <img id='image1' onmouseover=\"show(1)\" onclick=\"mark(1)\" onmouseout=\"noshow(1)\" src='../mcomment/images/star_off.png'>";
  html += " <img id='image2' onmouseover=\"show(2)\" onclick=\"mark(2)\" onmouseout=\"noshow(2)\" src='../mcomment/images/star_off.png'>";
  html += " <img id='image3' onmouseover=\"show(3)\" onclick=\"mark(3)\" onmouseout=\"noshow(3)\" src='../mcomment/images/star_off.png'>";
  html += " <img id='image4' onmouseover=\"show(4)\" onclick=\"mark(4)\" onmouseout=\"noshow(4)\" src='../mcomment/images/star_off.png'>";
  html += " <img id='image5' onmouseover=\"show(5)\" onclick=\"mark(5)\" onmouseout=\"noshow(5)\" src='../mcomment/images/star_off.png'>";
  html += " </span>";
  html += " <input type='hidden' name='grade'>";
  html += " </div>";  */
  html += "  <input type='text' name='grade' id='grade' value=''>"
  html += " <textarea name='content' id='content' rows='3' placeholder='댓글을 입력하세요' style='width: 100%; resize: none; '></textarea> ";
  html += " <button type='button' onclick='frm_update.submit();' class='popup_button'> 수정 </button>";
  html += " <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 닫기 </button>";
  html += "</DIV>"; 
  
  $('#main_panel').html(html);
  $('#main_panel').show(); 
}

//댓글삭제
function deleteco(movieCd,memberno,mcno){
  var frm_delete = $('#frm_delete');
  $('#movieCd', frm_delete).val(movieCd);
  $('#memberno', frm_delete).val(memberno);
  $('#mcno', frm_delete).val(mcno);
  
  var html = '';
  html += "<DIV id='panel' class='popup1' style='height: 135px; width: 25%; line-height: 30px; '>";
  html += "  댓글을 삭제합니다.<br>";
  html += "  삭제하면 복구 할 수 없습니다.<br><br>";
  html += "  <button type='button' onclick='frm_delete.submit();' class='popup_button'> 삭제 </button>";
  html += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 닫기 </button>";
  html += "</DIV>"; 
  
  $('#main_panel').html(html);
  $('#main_panel').show(); 
}

//영화상세보기
function movie_detail(movieCd){
  
  $.ajax({     
    url: "../movie/read.do",  
    type: "get", 
    cache: false,
    dataType: "html", 
    data: "movieCd="+movieCd,   
    
    success: function(data) { 
      var html='';
      html += "<DIV class='popup2'>" ;
      html += "<DIV style='text-align: right;'><button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'>X</button></DIV>" ;
      html += data;
      html += "</DIV>"
      
      $('#main_panel').html(html);
      $('#main_panel').show();
     },
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

</script>
</head>
<body>
<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />
<jsp:include page="/mypage/my_top.jsp" flush='false' />

<DIV id='main_panel'></DIV>
<DIV class='list_content' >


<form name='frm' id='frm' method="get" action="./m_mclist.do">
  <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno }'>

 <ASIDE style='float: left;'>
     MyPage >  <A href='./m_mclist.do?memberno=${memberno}' >코멘트</A>  
     <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${m_mccount } 건) 
    </c:if>
 </ASIDE>
 
 <ASIDE style='float: right;'>
    <c:choose>
      <c:when test="${param.title != '' }">
        <input type='text' name='word' id='word' value='${param.word }'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px;">
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px; ">
      </c:otherwise>
    </c:choose>
    <button type='submit'  style="background-color: #ffffff; border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px 6px;">검색</button>
  </ASIDE> 
  </form>
<br><br>

<DIV id='main_panel'></DIV>

 <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
    <input type='hidden' name='movieCd' id='movieCd' value=''>
    <input type='hidden' name='memberno' id='memberno' value=''>
    <span></span>
    <input type='number' name='grade' id='grade' value=''>
    <input type='text' name='content' id='content' value=''>
    <button type="submit" id='submit'>저장</button>
    <button type="button" onclick="update_cancel();">취소</button>
  </FORM>
  
 <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
    <input type='hidden' name='movieCd' id='movieCd' value=''>
    <input type='hidden' name='memberno' id='memberno' value=''>
    <input type='hidden' name='mcno' id='mcno' value=''>
<!--     <input type='hidden' name='word' id='word' value=''>
    <input type='hidden' name='nowPage' id='nowPage' value=''> -->
  </FORM>
  
 <table class="table table-striped" id='m_mclist' style='width: 100%;'>
  <caption> </caption>

  <colgroup>
    <col style='width: 25%;'/>
    <col style='width: 15%;'/>
    <col style='width: 50%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <TR>
   <TH class='th' style="text-align: center;">영화제목</TH>
    <TH class='th' style="text-align: center;">평점</TH>
    <TH class='th' style="text-align: center;">코멘트</TH>
    <TH class='th' style="text-align: center;">기타</TH>
  </TR>
 
  <c:forEach var="movieNmVO" items="${list }">
  <TR>
    <TD class='td' style='vertical-align: middle;'><A href="javascript:movie_detail(${movieNmVO.movieCd })">${movieNmVO.movieNm}</A></TD>
    <TD class='td' style='vertical-align: middle; text-align: center;'>
      <c:forEach begin="1" end="${movieNmVO.grade}">
        <img src="./images/star_on.png" style="width: 15px;">
      </c:forEach>
   </TD>
    <TD class='td' style='vertical-align: middle; text-align: center;'>${movieNmVO.content}</TD>
    <TD class='td' style='vertical-align: middle; text-align: center;'>
      <A href="javascript:updateco(${movieNmVO.movieCd},${movieNmVO.memberno})"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
      <A href="javascript:deleteco(${movieNmVO.movieCd},${sessionScope.memberno},${movieNmVO.mcno})"><IMG src='./images/trash.png' style="width: 16px;" title='삭제'></A>
    </TD>
  </TR>
  </c:forEach>
  
</TABLE>
  <DIV>${paging }</DIV>  <!-- 페이지 목록 출력 -->
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>