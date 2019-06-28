<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript">

function like_func(movieCd){
  
  $.ajax({     
    url: "../movie/like.do",  
    type: "GET", 
    cache: false,
    dataType: "json", 
    data: "movieCd="+movieCd, 
    
    success: function(data) { 
      if(data.like_check ==0){
        like_img="./images/heart.png";
      }else{
        like_img="./images/heart-on.png";
      }
      $('#like_img').attr('src', like_img);
      
     },
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}
 
 </script>
 
 <div style="float: left;  margin-left: 30px; margin-right: 30px;">
 <c:choose>
        <c:when test="${movieVO.movieImg !='' }">
         <img src="./storage/${movieVO.movieImg }"  style="width: 250px; height: 350px;">
        </c:when>
        <c:otherwise>
          <img src="./images/grid_movie.png" style="width: 250px; height: 350px;" >
        </c:otherwise>
      </c:choose>
 </div>
 
 <div style="float: left; width: 70%; margin-bottom: 20px;">
 <br><br>
  <h2>${movieVO.movieNm } &nbsp; 
  <c:choose>
    <c:when test="${memberno ne null }">
       <a href="javascript:like_func(${movieVO.movieCd })"><img id='like_img' src="./images/heart.png"></a>
    </c:when>
    <c:otherwise>
      
    </c:otherwise>
  </c:choose>
  
 </h2> 
  <hr style="border:  dotted 0.5px #AAAAAA">
  ${movieVO.movieNmEn }, ${movieVO.openDt }, ${movieVO.repNationNm }, ${movieVO.genre }, ${movieVO.watchGradeNm }, ${movieVO.showTm }분<br>
  별점<br><br><br><br><br><br><br><br>
  <div style="vertical-align: middle;"><img src="./images/heart.png" style="width: 15px;">보고싶어요 카운트 &nbsp;&nbsp; <!-- 보고싶어요 카운트 -->
 <img src="./images/star-on.png" style="width: 16px;"> ${mcc} </div><!-- 댓글 카운트 -->
 </div>
 
  <hr style="border:  dotted 0.5px #AAAAAA; width: 100%;">
  
<div style="width: 100%; "> 
 <div style="width: 65%; float: left; margin-left: 20px; margin-right: 30px; ">
  <h3>줄거리</h3>
  <p>${movieVO.plot }</p>
 <hr style="border:  dotted 0.5px #AAAAAA; width: 100%; margin-top: 50px;">
 
 <span style="float: left;"><strong>Comment (${mcc})</strong></span>  <br><!-- 영화별 댓글 갯수 -->
 <jsp:include page ="/mcomment/list.jsp" flush="false"/> <!-- 댓글 영역  -->

 </div>
 
  <div style="width: 28%; float: left; text-align: center;">

    <h3>예고편</h3>
    <div style="width: 100%;">${movieVO.vodclass }</div>

    <div>
    <h3>감독</h3>
    <p>${movieVO.director }</p>
    </div>
    
    <div>
    <h3>배우</h3>  

<%-- <c:choose >
 <c:when test="${movieVO.actors !='' }">
    <c:forEach var="actor" items="${actor }">
      <p>${actor}</p>
    </c:forEach>
        </c:when>
        <c:otherwise> --%>
      <p>${movieVO.actors}</p>
<%--         </c:otherwise>
</c:choose> --%>
    
   
    </div>
 </div>
</div>
 
<!-- </DIV> content END -->
