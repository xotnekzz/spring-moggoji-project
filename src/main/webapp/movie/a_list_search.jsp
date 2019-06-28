<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>관리자 영화목록</title> 
 
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
<DIV class='container' style="width:100%; ">
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/admin/admin_top.jsp" flush='false' />

<DIV class='list_content' >

<form name='frm' id='frm' method="get" action="./a_movielist_search.do">
 
  <ASIDE style='float: left;'>
     관리자 >  <A href='./a_movielist_search.do'>영화 목록</A>  
     
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>
  
  <ASIDE style='float: right;'>
   <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px;">
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px; ">
      </c:otherwise>
    </c:choose>
    <button type='submit'  style="background-color: #ffffff; border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px 6px;">검색</button>
  </ASIDE> 
</form> 
 
  <table class="table table-striped" style='width: 100%;'>
  <caption> </caption>

  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 50%;'/>
    <col style='width: 20%;'/>
  </colgroup>
  <TR>
    <TH class='th' style="text-align: center;">영화번호</TH>
    <TH class='th' style="text-align: center;">영화코드</TH>
    <TH class='th' style="text-align: center;">영화제목</TH>
    <TH class='th' style="text-align: center;">수정</TH>
  </TR>
 
  <c:forEach var="movieVO" items="${list }">
  <TR>
    <TD class='td' style="text-align: center;">${movieVO.movieno}</TD>
    <TD class='td' style="text-align: center;">${movieVO.movieCd}</TD>
    <TD class='td'><A href="./a_movieread.do?movieCd=${movieVO.movieCd}&nowPage=${param.nowPage}&word=${param.word}">${movieVO.movieNm}</A></TD>
    <TD class='td' style="text-align: center;">
      <A href="./a_movieupdate.do?movieCd=${movieVO.movieCd}&nowPage=${param.nowPage}&word=${param.word}"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
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