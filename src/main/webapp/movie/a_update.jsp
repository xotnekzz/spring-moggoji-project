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

<DIV class='content' style="width: 70%; margin: 0px auto;">

  <ASIDE style='float: left;'>
       관리자 > <A href='./movie/a_movielist.do'>영화 목록</A>  > 수정
  </ASIDE>
<br><br> 
  <form name='frm' method='POST' action='./a_movieupdate.do' enctype="multipart/form-data" class="form-horizontal">
               
      <input type='hidden' name='movieCd' id='movieCd' value='${movieVO.movieCd}'>
      <%-- <input type='hidden' name='mno' id='mno' value='${sessionScope.mno }'> --%>
      
       <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">영화 번호</label>
        <div class="col-md-3">
          <input type='text' class="form-control input-lg" name='movieno' id='movieno' value="${ movieVO.movieno} " disabled  >
      </div>
      </div>   
      
      <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">영화 코드</label>
        <div class="col-md-3">
          <input type='text' class="form-control input-lg" name='movieCd' id='movieCd' value="${movieVO.movieCd}"  disabled>
      </div>
      </div>   
      
       <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">영화 제목</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='movieNm' id='movieNm' required="required" value="${ movieVO.movieNm}"  disabled>
        </div>
      </div>  
      
      <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">영화 영어제목</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='movieNmEn' id='movieNmEn' required="required" value="${ movieVO.movieNmEn}"  disabled>
        </div>
      </div>    
        
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">국가명</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='nationNm' id='nationNm' required="required" value="${ movieVO.repNationNm}"  disabled>
        </div>
      </div>
      
      <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">제작년도</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='prdtYear' id='prdtYear' required="required" value="${ movieVO.prdtYear}"  disabled>
        </div>
      </div>          
      
       <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">개봉날짜</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='openDt' id='openDt' required="required" value="${ movieVO.openDt}" disabled>
        </div>
      </div>  
      
      <div class="form-group">   
        <label for="title" class="col-md-2 control-label" style="">관람등급</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='watchGradeNm' id='watchGradeNm' required="required" value="${ movieVO.watchGradeNm}"  disabled>
        </div>
      </div> 
      
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">상영시간</label>
        <div class="col-md-10">
           <input type='text' class="form-control input-lg" name='showTm' id='showTm' required="required" value="${ movieVO.showTm}"  disabled>
        </div>
      </div>
      
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">줄거리</label>
        <div class="col-md-10">
          <textarea class="form-control input-lg" name='plot' id='plot'  rows='10'>${ movieVO.plot}</textarea>
        </div>
      </div>
      
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">키워드</label>
        <div class="col-md-10">
          <input type='text' class="form-control input-lg" name='keyword' id='keyword'  value="${ movieVO.keyword}" >
        </div>
      </div>
      
      <div class="form-group">   
        <label for="content" class="col-md-2 control-label">영상</label>
        <div class="col-md-10">
          <textarea class="form-control input-lg" name='vodclass' id='vodclass'  rows='3'  >${ movieVO.vodclass}</textarea>
        </div>
      </div> 
      
<div id='movieImgPanel' class="form-group">
        <label class="col-md-2 control-label"></label>
        <div class="col-md-10">
          <!-- 파일명을 소문자로 변경 -->
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
        </div>
      </div>
      
      <div class="form-group">   
        <label for="movieImgMF" class="col-md-2 control-label">영화 포스터</label>
        <div class="col-md-10">
          <input type="file" class="form-control input-md" name='movieImgMF' id='movieImgMF' >
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div> 
 
      <div style='text-align: center;'>
        <button class="btn btn-default" type="submit">수정하기</button>
        <button class="btn btn-default" type="button" onclick="location.href='./a_movielist.do?'">취소[목록]</button>
        <br>
      </div>
      
  </form>

    
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>