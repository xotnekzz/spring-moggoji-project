<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${mname}님의 영화 코멘트</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="../js/star.js"></script>
<script type="text/javascript">

//평점 값 넘기기
function setvalue(star){
  //alert("선택 : "+star);
  $('#grade','#frm_update').val(star);
}

//댓글 수정 처리
function frm_update_submit(){
  //var grade = $('#grade', '#frm_update').val();
  //alert('grade:'+grade)
  var content = $('#content', '#panel').val();
  //alert('content:'+content)
  $('#content','#frm_update').val(content);

  $('#frm_update').submit();
}

//댓글 한 건 조회
function updateco(movieCd,memberno){
  
  $.ajax({
    url: "./read.do", // 요청을 보낼주소
    type: "get",  
    cache: false,
    dataType: "json", 
    data: 'movieCd='+movieCd+"&memberno="+memberno,  
    
    success: function(data) { // callback 함수
      //var frm_update = $('#frm_update');
      //var grade = $('#grade',frm_update).val(rdata.grade);
      var movieNm = data.movieNm;
      //var grade = date.grade;
      var content =data.content;
      
      var html = '';
      html += "<DIV id='panel' name ='panel' class='popup_modify'>";
      html += "<span>댓글을 수정합니다.</span>"
      html += "<h3 style='text-align: left;'>"+movieNm+"</h3>"
      html += " <div id ='rating' style='float: left;'>";
      html += " <span>"
      html += " <img id='image1' onmouseover=\"show(1)\" onclick=\"javascript:setvalue(1);mark(1);\" onmouseout=\"noshow(1)\" src='../mcomment/images/star_off.png'>";
      html += " <img id='image2' onmouseover=\"show(2)\" onclick=\"javascript:setvalue(2);mark(2);\" onmouseout=\"noshow(2)\" src='../mcomment/images/star_off.png'>";
      html += " <img id='image3' onmouseover=\"show(3)\" onclick=\"javascript:setvalue(3);mark(3);\" onmouseout=\"noshow(3)\" src='../mcomment/images/star_off.png'>";
      html += " <img id='image4' onmouseover=\"show(4)\" onclick=\"javascript:setvalue(4);mark(4);\" onmouseout=\"noshow(4)\" src='../mcomment/images/star_off.png'>";
      html += " <img id='image5' onmouseover=\"show(5)\" onclick=\"javascript:setvalue(5);mark(5)\" onmouseout=\"noshow(5)\" src='../mcomment/images/star_off.png'>";
      html += " </span>";
      html += " </div>";  
      html += " <textarea name='content' id='content' rows='3' placeholder='"+content+"' style='width: 100%; resize: none; '></textarea> ";
      html += " <button type='button' onclick='frm_update_submit();' class='popup_button'> 수정 </button>";
      html += " <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 닫기 </button>";
      html += "</DIV>"; 
      
      $('#main_panel').html(html);
      $('#main_panel').show(); 
      
      $('#movieCd', '#frm_update').val(movieCd);
      $('#memberno', '#frm_update').val(memberno);
    },
    
    error: function(request, status, error) { // callback 함수
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

function update_cancel(){
  $('#panel_update').hide();
}

function deleteco(movieCd,memberno,mcno){
  var frm_delete = $('#frm_delete');
  $('#movieCd', frm_delete).val(movieCd);
  $('#memberno', frm_delete).val(memberno);
  $('#mcno', frm_delete).val(mcno);
  
  var html = '';
  html += "<DIV class='popup_delete'>";
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
      html += "<DIV class='popup_movie'>" ;
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
<DIV class='list_content'>

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
      <c:when test="${param.word ne '' && param.word ne null}">
        <input type='text' name='word' id='word' value='${param.word }'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px;">
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word'  placeholder='영화 제목으로 검색' value='' style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px; ">
      </c:otherwise>
    </c:choose>
    <button type='submit'  style="background-color: #ffffff; border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px 6px;">검색</button>
  </ASIDE> 
  </form>
<br><br>

 <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
    <input type='hidden' name='movieCd' id='movieCd' value=''>
    <input type='hidden' name='memberno' id='memberno' value=''>
    <input type='hidden' name='grade' id='grade' value=''>
    <input type='hidden' name='content' id='content' value=''>
  </FORM>
  
 <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
    <input type='hidden' name='movieCd' id='movieCd' value=''>
    <input type='hidden' name='memberno' id='memberno' value=''>
    <input type='hidden' name='mcno' id='mcno' value=''>
 </FORM>
  
 <div>
  <c:forEach var="movieNmVO" items="${list }">
  
 <div class="comment_out">
  <c:choose>
    <c:when test="${movieNmVO.thumb ne''}">
    <div class="main_movie" style="width: 48%;">
     <A href="javascript:movie_detail(${movieNmVO.movieCd})"  ><img src="../movie/storage/${movieNmVO.thumb }" style="height: 335px;"></A>
      <h5>${movieNmVO.movieNm}</h5>
      <!-- <h5>별점</h5> -->
    </div>
     </c:when>
   <c:otherwise> 
    <div class="main_movie" style="width: 48%;">
    <A href="javascript:movie_detail(${movieNmVO.movieCd})"  > <img src="./images/grid_movie.png" style="height: 335px;"></A>
      <h5>${movieNmVO.movieNm}</h5>
      <!-- <h5>별점</h5> -->
    </div>
   </c:otherwise>
   </c:choose>
   
  <div class="comment">
  <div style="text-align: right;">
   <A href="javascript:updateco(${movieNmVO.movieCd},${movieNmVO.memberno})"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
    <A href="javascript:deleteco(${movieNmVO.movieCd},${sessionScope.memberno},${movieNmVO.mcno})"><IMG src='./images/trash.png' style="width: 16px;" title='삭제' ></A>
  </div>
  <br><br>
    <span style="font-size: 20px; text-align: left;"> ${movieNmVO.movieNm}</span><br><br><br>
     <c:forEach begin="1" end="${movieNmVO.grade}">
        <img src="./images/star_on.png" style="width: 15px;">
      </c:forEach><br>
    ${movieNmVO.content}
  </div>
</div>

  </c:forEach>
  </div>
<DIV style='text-align: center; clear: both; '></DIV>
  <DIV>${paging }</DIV>  <!-- 페이지 목록 출력 -->
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>