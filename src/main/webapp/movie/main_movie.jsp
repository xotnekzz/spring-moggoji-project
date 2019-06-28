<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>영화</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->

<script type="text/javascript">

$(function(){
  //$('#myModal').hide();
   $('#main_panel').hide(); 
});

function popup(movieCd) {
  var url="../movie/read.do?movieCd="+movieCd;
  var name = "pop";
  window.open(url, name, 'height=650, width=1150, left=180, top=100, location=no, scrollbars=yes, status=no, tollbar=no, director=no, menubar=no');
}

//영화 상세보기
function movie_detail(movieCd){
  
  //alert("창");
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
      //$('#myModal').show();
     },
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

// 장르눌렀을 때
function genre() {
  document.getElementById("genres").classList.toggle("show");
}

//Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
      openDropdown.classList.remove('show');
      }
    }
  }
}

function genres(genre){
  location.href = "../movie/main_movie_genre.do?genre="+genre;
}

</script>
</head>
<body>

<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV id='main_panel'></DIV>
<!-- 
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
  <div class="modal-dialog">
   <div class="modal-content"> 
  <div class="modal-header"> 
  <button type="button" class="close" data-dismiss="modal">
  <span aria-hidden="true">×</span>
  </button> 
  </div> 
  <div class="modal-body"> 
  하이
  <DIV id='main_panel'></DIV>
  </div> 
  </div> 
  </div> 
  </div>
 -->
<DIV class='content'  >
<div id="mask"></div>

<form name='frm' id='frm' method="get" action="./main_movie.do">
 
  <ASIDE style='float: left;'>
    <A href='./main_movie.do'>영화</A>  
     
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>
  
  <ASIDE style='float: right;'>
  <div class="dropdown">
   <a href="javascript:genre()" style="background-color: #ffffff; border: solid 1px #aaaaaa; border-radius: 4px; padding: 5px 6px;">장르별 검색</a>
   <div id="genres" class="dropdown-content">
      <a href="javascript:genres('드라마')">드라마</a>
      <a href="javascript:genres('코미디')">코미디</a>
      <a href="javascript:genres('애니메이션')">애니메이션</a>
      <a href="javascript:genres('스릴러')">스릴러</a>
      <a href="javascript:genres('다큐멘터리')">다큐멘터리</a>
      <a href="javascript:genres('액션')">액션</a>
      <a href="javascript:genres('판타지')">판타지</a>
      <a href="javascript:genres('로맨스')">로맨스</a>
      <a href="javascript:genres('SF')">SF</a>
      <a href="javascript:genres('공포')">공포(호러)</a>
  </div>
 </div>

   <c:choose>
      <c:when test="${param.word ne '' && param.word ne null}">
        <input type='text' name='word' id='word' value='${param.word }'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px;">
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' placeholder='영화 제목으로 검색' style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px; ">
      </c:otherwise>
    </c:choose>
    <button type='submit'  style="background-color: #ffffff; border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px 6px;">검색</button>
  </ASIDE> 
</form> 
<br><br>

<div>
  <c:forEach var="movieVO" items="${list }">
   <DIV  class="main_movie">
      <c:choose>
        <c:when test="${movieVO.thumb ne '' }">
  
          <A href="javascript:movie_detail(${movieVO.movieCd})"  ><img src="./storage/${movieVO.thumb }" ></A>
          <%-- <A href="javascript:popup(${movieVO.movieCd})"  class='openMask'><img src="./storage/${movieVO.thumb }" ></A> --%>
          <h5>${movieVO.movieNm }</h5>
        </c:when>
        <c:otherwise>

          <A href="javascript:movie_detail(${movieVO.movieCd})"  > <img src="./images/grid_movie.png" ></A>
<%--           <A href="javascript:popup(${movieVO.movieCd})"  > <img src="./images/grid_movie.png" ></A> --%>
          <h5>${movieVO.movieNm }</h5>
        </c:otherwise>
      </c:choose>
  </DIV>
 </c:forEach>
</div>
<DIV style='text-align: center; clear: both; '></DIV>
  <DIV >${paging }</DIV>  <!-- 페이지 목록 출력 -->
  
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>