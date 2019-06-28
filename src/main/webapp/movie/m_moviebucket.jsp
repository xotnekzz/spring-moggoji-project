<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${mname}님의 보고싶어요</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
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

<form name='frm' id='frm' method="get" action="./moviebucket.do">
  <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno }'>

 <ASIDE style='float: left;'>
     MyPage >  <A href='./moviebucket.do?memberno=${memberno}' >보고싶어요</A>  
     <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${mbc } 건) 
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

<div>
  <c:forEach var="MoviebucketVO" items="${list }">
   <DIV  class="main_movie">
      <c:choose>
        <c:when test="${MoviebucketVO.thumb ne '' }"> 
          <A href="javascript:movie_detail(${MoviebucketVO.movieCd})"  ><img src="./storage/${MoviebucketVO.thumb }" ></A>
          <h5>${MoviebucketVO.movieNm }</h5>
        </c:when>
        <c:otherwise>
          <A href="javascript:movie_detail(${MoviebucketVO.movieCd})"  > <img src="./images/grid_movie.png" ></A>
          <h5>${MoviebucketVO.movieNm }</h5>
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