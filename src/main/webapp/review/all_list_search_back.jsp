<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
 
<script type="text/javascript">

</script>
</head> 
 
<body>
<DIV class='container'  style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<DIV class='content'  style="width: 70%; margin: 0px auto;">
 
 <form name='frm' id='frm' method="get" action="./list_search.do">

  <ASIDE style='float: left;'>
     MyPage >  <A href='./list_search.do' >리뷰 목록</A>  
     
     <c:if test="${param.title.length() > 0}"> 
      >
      [${param.title}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>
  
  <ASIDE style='float: right;'>
<%--   <c:if test="${sessionScope.id ne null }"> --%>
    <A href='./create.do'>리뷰 등록 &nbsp;</A> 
<%--   </c:if> --%>
    <c:choose>
      <c:when test="${param.title != '' }">
        <input type='text' name='title' id='title' value='${param.title }'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px;">
      </c:when>
      <c:otherwise>
        <input type='text' name='title' id='title' value='' style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px; ">
      </c:otherwise>
    </c:choose>
    <button type='submit'  style="background-color: #ffffff; border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px 6px;">검색</button>
  </ASIDE> 
 </form>

   <!--  <br><br>
  <div>
    <button type="button" class="btn btn-default" onclick="location.href='./create.do'">감상 등록하기</button> 
  </div> -->


  <table class="table table-striped" style='width: 100%;'>
  <caption> </caption>

  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 25%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <TR>
    <TH class='th' style="text-align: center;">리뷰번호</TH>
    <TH class='th' style="text-align: center;">이미지</TH>
    <TH class='th' style="text-align: center;">제목</TH>
    <TH class='th' style="text-align: center;">등록일</TH>
    <TH class='th' style="text-align: center;">출력여부</TH>
    <TH class='th' style="text-align: center;">조회수</TH>
    <TH class='th' style="text-align: center;">기타</TH>
  </TR>
 
  <c:forEach var="reviewVO" items="${list }">
  <TR>
    <TD class='td' style="vertical-align: middle; text-align: center;">${reviewVO.reviewno}</TD>
    <TD class='td' style='vertical-align: middle; height: 200px;'>
      <c:choose>
        <c:when test="${reviewVO.mainimg !='' }">
          <img src="./storage/${reviewVO.mainimg }" style="width: 90%;">
        </c:when>
        <c:otherwise>
          <img src="./images/main.png" style="width: 90%;">
        </c:otherwise>
      </c:choose>
     <%--  <IMG id='mainimg' src='./storage/${reviewVO.mainimg }' style="width: 80%; "> --%>
    </TD>
    <TD class='td' style='vertical-align: middle;'><A href="./read.do?reviewno=${reviewVO.reviewno}&title=${param.title}&nowPage=${nowPage}">${reviewVO.title}</A></TD>
    <TD class='td' style='vertical-align: middle; text-align: center;'>${reviewVO.rdate.substring(0,10)}</TD>
<%--     <TD class='td' style="text-align: center;"><a href="./show_hide.do=reviewno${reviewVO.reviewno}">${reviewVO.visible}</a></TD> --%>
    <TD class='td' style='vertical-align: middle; text-align: center;'>${reviewVO.visible}</TD>
    <TD class='td' style='vertical-align: middle; text-align: center;'>${reviewVO.cnt}</TD>
    <TD class='td' style='vertical-align: middle; text-align: center;'>
      <A href="./update.do?reviewno=${reviewVO.reviewno}&nowPage=${param.nowPage}&title=${param.title}"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
      <A href="./delete.do?reviewno=${reviewVO.reviewno}&nowPage=${param.nowPage}&title=${param.title}"><IMG src='./images/trash.png' style="width: 16px;" title='삭제'></A>
    </TD>
    
  </TR>
  </c:forEach>
</TABLE>
  <DIV>${paging }</DIV>  <!-- 페이지 목록 출력 -->

 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>