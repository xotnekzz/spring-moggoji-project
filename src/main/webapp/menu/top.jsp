<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="/movie/css/style.css" rel="Stylesheet" type="text/css">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->

<style type="text/css">
 @import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css); 
  a, a:focus, a:visited, a:link {
    text-decoration: none;
    color: #000000;
 }

  a:hover{
  color: #ff8080;
 }

</style>
<script type="text/javascript">

$(function(){
  
  $('span.actors').hide();
  $('span.director').hide();
  $('span.movie').show();
 
});


$('input.search-input').focus(function(){
  $(this).parent().addClass('focus');
}).blur(function(){
  $(this).parent().removeClass('focus');
})

function actors_checked(){

    $('span.actors').show();
    $('span.director').hide();
    $('span.movie').hide();

}

function director_checked(){

    $('span.director').show();
    $('span.actors').hide();
    $('span.movie').hide();

}

function movie_checked(){

    $('span.movie').show();
    $('span.director').hide();
    $('span.actors').hide();

}
</script>
</head>
<body>
<div class="fixed-menu">
 <div style="width: 80%; display: inline-block;">
    <div style=" width: 13%; float : left;">
      <a href="/movie"><img src="/movie/menu/images/moggoji.png" style="  width: 100%; margin-top: 10px;"></a>
    </div>
    
    <div class="menu1">
     <ul >
      <li><a href="/movie/movie/mainbo_list.do" data-hover="박스오피스" style="text-decoration: none;">박스오피스</a></li>
      <li><a href="/movie/movie/main_movie.do" data-hover="영화" style="text-decoration: none;">영화</a></li>
      <li><a href="/movie/review/all_list_search.do" data-hover="리뷰" style="text-decoration: none;">리뷰</a></li>
      <li><a href="/movie/qna/list.do" data-hover="QnA" style="text-decoration: none;">QnA</a></li>
     </ul>
    </div>
    
   <!-- search 부분 시작 -->
  <div class="search">
   <form class="search-form" name='frm' id='frm' method="get" action="/movie/movie/main_movie.do">
    <c:choose>
        <c:when test="${param.word ne '' && param.word ne null}">
          <input class="search-input" type='text' name='word' id='word' value='' autocomplete="off">
        </c:when>
        <c:otherwise>
          <input class="search-input" name="word" id="word" type="text" placeholder="Search">
        </c:otherwise>
     </c:choose>
   
   <div class="search-option">
     <div>
      <input name="col" type="radio" value="actors" id="actors" onclick="actors_checked()">
      <label for="Actor">
          <img src="/movie/images/human.png" style=" width: 20px;">
        <span class="actors">Actor</span>
      </label>
     </div>
     <div>
      <input name="col" type="radio" value="director" id="director" onclick="director_checked()">
      <label for="director" >
        <img src="/movie/images/human2.png" style=" width: 20px;">
        <span class="director">director</span>
      </label>
     </div>
     <div>
       <input name="col" type="radio" value="movieNm" id="movieNm" onclick="movie_checked()" checked="checked">
        <label for="movieNm">
          <img src="/movie/images/movie.png" style=" width: 20px;">
          <span class="movie">movie</span>
        </label>
      </div>
    </div>
    <button type="submit" class="search-button">
      <img src="/movie/images/search2.png" style=" width: 20px;">
    </button>
  </form>
  </div>
   <!-- search 부분 끝 -->
   
    <div class="menu1" style="margin-left: 10px;">
    <c:choose>
       <c:when test="${email != null && mact == 'M'}"> <!-- 관리자 -->
        <ul>
         <li><a href="/movie/member/member_list_search.do" style="text-decoration: none;" data-hover=${email}>${email}</a></li>
         <li><a href="/movie/member/logout.do" data-hover="로그아웃" style="text-decoration: none;">로그아웃</a></li>
        </ul>
        </c:when> 
        <c:when test="${email != null && mact == 'Y'}"> <!-- 회원 -->
        <ul>
        <!--  <li><img src="../member/images/user.png" style="width: 50px; vertical-align: middle;"></li> -->
         <li><a href="/movie/member/mupdate.do" data-hover=${email} style="text-decoration: none;">${email}</a></li>
         <li><a href="/movie/member/logout.do" data-hover="로그아웃" style="text-decoration: none;" >로그아웃</a></li>
        </ul>
      </c:when>
      <c:when test="${email == null}">
       <ul>
         <li><a href="/movie/member/login_form.do" data-hover="로그인" style="text-decoration: none;">로그인</a></li>
         <li><a href="/movie/member/create.do" data-hover="회원가입" style="text-decoration: none;">회원가입</a></li>
       </ul>
      </c:when>
     
    </c:choose>
    </div>
    
    
 </div>
 <div style="border-bottom: 1px solid rgba(0, 0, 0, 0.5);"></div>
</div>

</body>
</html>