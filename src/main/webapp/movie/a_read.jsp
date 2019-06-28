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

</head>
<body>
<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/admin/admin_top.jsp" flush='false' />

<DIV class='content' style="width: 80%; margin: 0px auto;">

  <ASIDE style='float: left;'>
       관리자 > <A href='./a_movielist_search.do'>영화 목록</A>  > ${ movieVO.movieCd}
  </ASIDE>
  <ASIDE style='float: right;'>
     <A href="./a_movieupdate.do?movieCd=${movieVO.movieCd}&nowPage=${param.nowPage}&movieNm=${param.movieNm}">수정하기</A>
  </ASIDE> 
  <table class="table">
   <caption> </caption>
    <tr>
      <td class="col-md-3">영화 번호</td>
      <td class="col-md-9">${ movieVO.movieno}</td>
    </tr>
    <tr>
      <td>영화 코드</td>
      <td>${ movieVO.movieCd}</td>
    </tr>      
    <tr>
      <td>영화 제목</td>
      <td> ${ movieVO.movieNm}</td>
    </tr>   
    <tr>
      <td>영화 영어제목</td>
      <td> ${ movieVO.movieNmEn}</td>
    </tr>
    <tr>
      <td>장르</td>
      <td> ${ movieVO.genre}</td>
    </tr> 
    <tr>
      <td>감독</td>
      <td> ${ movieVO.director}</td>
    </tr>     
    <tr>
      <td>국가명</td>
      <td> ${ movieVO.repNationNm}</td>
    </tr> 
    <tr>
      <td>제작 년도</td>
      <td> ${ movieVO.prdtYear}</td>
    </tr> 
    <tr>
      <td>개봉 날짜</td>
      <td> ${ movieVO.openDt}</td>
    </tr> 
    <tr>
      <td>관람등급</td>
      <td> ${ movieVO.watchGradeNm}</td>
    </tr> 
    <tr>
      <td>상영시간</td>
      <td> ${ movieVO.showTm} 분</td> 
    </tr> 
    <tr>
      <td>줄거리</td>
      <td> ${ movieVO.plot}</td>
    </tr> 
    <tr>
      <td>키워드</td>
      <td> ${ movieVO.keyword}</td>
    </tr> 
    <tr>
      <td>영상</td>
      <td> ${ movieVO.vodclass}</td>
    </tr> 
    <tr>
      <td>포스터</td>
      <td>
    <c:set var='movieImg' value="${fn:toLowerCase(movieVO.movieImg)}" />
          <!-- 소문자로 변경된 파일명이 이미지인지 검사 -->
          <c:choose>
            <c:when test="${fn:endsWith(movieImg, '.jpg')}">
              <IMG id='movieImg' src='./storage/${movieVO.movieImg}' style='width: 20%;'>
            </c:when>
            <c:when test="${fn:endsWith(movieImg, '.gif')}">
              <IMG id='movieImg'  src='./storage/${movieVO.movieImg}' style='width: 20%;'>
            </c:when>
            <c:when test="${fn:endsWith(movieImg, '.png')}">
              <IMG id='movieImg'  src='./storage/${movieVO.movieImg}' style='width: 20%;'>
            </c:when>
            <c:when test="${movieVO.movieImg.length() > 0}">
              ${movieVO.movieImg }  <!-- 이미지가 아니면서 파일이 존재하는 경우 파일명 출력 -->
            </c:when>
          </c:choose>
       </td>
    </tr> 
                                                  
  </table>

      <div style='text-align: center;'>
        <button class="btn btn-default" type="button" onclick="location.href='./a_movielist_search.do?&nowPage=${param.nowPage}&movieNm=${param.movieNm}'">목록</button>
        <br>
      </div>

 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>