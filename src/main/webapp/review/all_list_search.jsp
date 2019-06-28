<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>리뷰</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<style type="text/css">

</style>
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
 
<script type="text/javascript">

</script>
</head> 
 
<body>
<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >
 
 <form name='frm' id='frm' method="get" action="./all_list_search.do">

  <ASIDE style='float: left;'>
     <A href='./all_list_search.do' >리뷰</A>  
     
     <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>
  
  <ASIDE style='float: right;'>
  <c:if test="${sessionScope.email ne null }">
    <A href='./create.do'>리뷰 등록 &nbsp;</A> 
  </c:if>
    <c:choose>
      <c:when test="${param.word ne '' && param.word ne null}">
        <input type='text' name='word' id='word' value='${param.word }'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px;">
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' placeholder='리뷰 제목으로 검색'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px; ">
      </c:otherwise>
    </c:choose>
    <button type='submit'  style="background-color: #ffffff; border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px 6px;">검색</button>
  </ASIDE> 
 </form>
<br><br>

<div>
  <c:forEach var="reviewVO" items="${list }">
   <DIV  class="div_grid_review">
      <c:choose>
        <c:when test="${reviewVO.mainimg ne '' }">
          <div style="height: 270px; padding: 10px 2px;">
          <A href="./read.do?reviewno=${reviewVO.reviewno}&word=${param.word}&nowPage=${nowPage}" ><img src="./storage/${reviewVO.mainimg }" style="width: 90%; height: 260px"></A>
          </div>
        </c:when>
        <c:otherwise>
          <div style="height: 270px; padding: 10px 2px; vertical-align: middle;">
          <A href="./read.do?reviewno=${reviewVO.reviewno}&word=${param.word}&nowPage=${nowPage}" ><img src="./images/grid_review.png" style="width: 90%; height: 260px"></A>
          </div>
        </c:otherwise>
      </c:choose>
    <br>
    <A href="./read.do?reviewno=${reviewVO.reviewno}&word=${param.word}&nowPage=${nowPage}" style="color: black; font-size: 18px;">${reviewVO.title}</A>
    <br>
<%--     ${mname.mname} --%>
 <span>by. ${reviewVO.mname}</span><!-- 리뷰를 쓴 회원이름, 회원이메일 -->
  </DIV>
 </c:forEach>
</div>
<DIV style='text-align: center; clear: both; '></DIV>
  <DIV>${paging }</DIV>  <!-- 페이지 목록 출력 -->

 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>