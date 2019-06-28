<%@ page contentType="text/html; charset=UTF-8" %>

<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
//장르 검색
function genres(genre){
  location.href = "/movie/movie/main_movie_genre.do?genre="+genre;
}
</script>

 <div style="text-align: center; width: 100%;" > <!-- 장르 -->
   <div class='index_genr'><a href="javascript:genres('드라마')"><img src="./images/g_1.jpg" ></a><h4>드라마</h4></div>
    <div class='index_genr'><a href="javascript:genres('코미디')"><img src="./images/g_2.jpg"></a><h4>코미디</h4></div>
    <div class='index_genr'><a href="javascript:genres('애니메이션')"><img src="./images/g_3.jpg"></a><h4>애니메이션</h4></div>
    <div class='index_genr'><a href="javascript:genres('스릴러')"><img src="./images/g_4.jpg"></a><h4>스릴러</h4></div>
    <div class='index_genr'><a href="javascript:genres('다큐멘터리')"><img src="./images/g_5.jpg"></a><h4>다큐멘터리</h4></div>
    <div class='index_genr'><a href="javascript:genres('액션')"><img src="./images/g_6.jpg"></a><h4>액션</h4></div>
    <div class='index_genr'><a href="javascript:genres('판타지')"><img src="./images/g_7.jpg"></a><h4>판타지</h4></div>
    <div class='index_genr'><a href="javascript:genres('로맨스')"><img src="./images/g_8.jpg"></a><h4>로맨스</h4></div>
    <div class='index_genr'><a href="javascript:genres('SF')"><img src="./images/g_9.jpg"></a><h4>SF</h4></div>
    <div class='index_genr'><a href="javascript:genres('공포')"><img src="./images/g_10.jpg"></a><h4>공포(호러)</h4></div>
   </div>

