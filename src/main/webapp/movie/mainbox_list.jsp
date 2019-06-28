<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>박스오피스</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">

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
<DIV id='main_panel'></DIV>
<DIV class='content'>
 
<ASIDE style='float: left;'>
  <A href='./mainbo_list'>박스오피스</A>  
</ASIDE>
<br><br>

<DIV>

<div class="bocoffice_rank" style="height: 326px;">
  <div style="margin: 5px;">
    <span style="font-size: 18px;">박스오피스 랭킹</span><br>
 </div>
    <hr style="margin-top: 5px; margin-bottom: 8px;">
  <c:forEach var="mainBoxOfficeVO" items="${list }">
    <div style="margin: 7px; ">
      <span class="span_rank">&nbsp;${mainBoxOfficeVO.rank}&nbsp;</span> 
       <A href="javascript:movie_detail(${mainBoxOfficeVO.movieCd})"><span style="font-size: 12.5px; ">${mainBoxOfficeVO.movieNm}</span></A>
       <br>
    </div>
  </c:forEach>
</div>

<div class="boxoffice_total">  
<c:forEach var="mainBoxOfficeVO" items="${list }">
 <div class="boxoffice_out"> 
  <c:choose>
    <c:when test="${mainBoxOfficeVO.thumb !='' && mainBoxOfficeVO.thumb!=null }">
    <div class="main_movie" style="width: 28%; height: 310px;">
     <A href="javascript:movie_detail(${mainBoxOfficeVO.movieCd})"><img src="./storage/${mainBoxOfficeVO.thumb }"  style="height: 310px;"></A>
      <h5>${mainBoxOfficeVO.movieNm}</h5>
      <!-- <h5>별점</h5> -->
    </div>
     </c:when>
   <c:otherwise> 
    <div class="main_movie" style="width: 28%; height: 310px;">
    <A href="javascript:movie_detail(${mainBoxOfficeVO.movieCd})"> <img src="./images/grid_movie.png"  style="height: 310px;"></A>
      <h5>${mainBoxOfficeVO.movieNm}</h5>
      <!-- <h5>별점</h5> -->
    </div>
   </c:otherwise>
   </c:choose>
   
  <div class="boxoffice">
    <br>
    <span style="font-size: 25px;"> ${mainBoxOfficeVO.movieNm}</span><br><br>
    <span >개봉날짜 : ${mainBoxOfficeVO.openDt}</span> &nbsp;&nbsp; <span>누적 관객수 : ${mainBoxOfficeVO.audiAcc}</span><br>
    <hr style="border:  solid 0.5px #cccccc"><br>
    <span class="span_font">${mainBoxOfficeVO.genre}.&nbsp; ${mainBoxOfficeVO.showTm}분. &nbsp;${mainBoxOfficeVO.watchGradeNm}</span> <br>
    <span class="span_font">평점</span><br><br>
    <span class="span_font">감독 : ${mainBoxOfficeVO.director }</span><br>
    <span class="span_font">배우 : ${mainBoxOfficeVO.actors }</span>
 </div>

 </div><!-- boxoffice_out end -->
 </c:forEach>
</div>

</DIV>
 
 

 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>