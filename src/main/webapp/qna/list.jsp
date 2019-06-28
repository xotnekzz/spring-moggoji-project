<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>QnA</title> 
 
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
<DIV class='container' style="width: 100%;">
<jsp:include page="/menu/top.jsp" flush='false' />

<DIV class='content'>
 
   <div>
 <form name='frm' id='frm' method="get" action="./list.do">
  <ASIDE style='float: left;'>
     <A href='./list.do'>질문 목록</A>  
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>
    
    <ASIDE style='float: right;'>
    
    <c:if test="${sessionScope.email ne null }">
    <A href='./create.do'>질문하기 &nbsp;</A> 
  </c:if>
  
    <SELECT name='col' id='col' style="padding: 4.5px 6px; border-radius: 4px;">
          <OPTION value='none'<c:out value="${param.col == 'none'?'selected':''}"/>>검색 목록</OPTION>
          <OPTION value='qnatype' <c:out value="${param.col == 'qnatype'?'selected':''}"/>>질문타입</OPTION>
          <OPTION value='title' <c:out value="${param.col == 'title'?'selected':''}"/>>제목</OPTION>
          <OPTION value='mname' <c:out value="${param.col == 'mname'?'selected':''}"/>>성명</OPTION>
    </SELECT>
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
 </div>
  
  <br><br>

  <table class="table table-striped" style='width: 100%;'>
  <caption> </caption>

  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 35%;'/>
    <col style='width: 10%;'/>
    <col style='width: 18%;'/>
    <col style='width: 7%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <TR>
    <TH class='th' style="text-align: center;">상태</TH>
    <TH class='th' style="text-align: center;">질문타입</TH>
    <TH class='th' style="text-align: center;">제목</TH>
    <TH class='th' style="text-align: center;">성명</TH>
    <TH class='th' style="text-align: center;">등록일</TH>
    <TH class='th' style="text-align: center;">조회수</TH>
    <TH class='th' style="text-align: center;">기타</TH>
  </TR>
 
  <c:forEach var="qnaVO" items="${list }">
    <c:choose>
      <c:when test="${qnaVO.seqno == 2 and qnaVO.ansnum == 0}"> <!-- 공지 -->
       <TR style="background-color: pink">
        <TD class='td' style="vertical-align: middle; text-align: center;"></TD>
        <TD class='td' style="vertical-align: middle; text-align: center;">${qnaVO.qnatype}</TD>
        <TD class='td' style='vertical-align: middle;'><A href="./read.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}">${qnaVO.title}</A></TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.mname}</TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.rdate.substring(0,10)}</TD> <!-- .substring(0,10) -->
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.cnt}</TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>
          <c:if test="${qnaVO.memberno == sessionScope.memberno}">
          <A href="./update.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
          <A href="./delete.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}"><IMG src='./images/trash.png' style="width: 16px;" title='삭제'></A>
          </c:if>
        </TD>
       </TR>
     </c:when>
     <c:when test="${qnaVO.ansnum == 1}"> <!-- 답글 -->
       <TR >
        <TD class='td' style="vertical-align: middle; text-align: center;"></TD>
        <TD class='td' style="vertical-align: middle; text-align: center;">${qnaVO.qnatype}</TD>
        <TD class='td' style='vertical-align: middle;'><img src="./images/reply3.jpg">&nbsp;<A href="./read.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}">${qnaVO.title}</A></TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.mname}</TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.rdate.substring(0,10)}</TD> <!-- .substring(0,10) -->
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.cnt}</TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>
          <c:if test="${qnaVO.memberno == sessionScope.memberno }">
          <A href="./update.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
          </c:if>
        </TD>
       </TR>
     </c:when>
     <c:when test="${qnaVO.seqno == 1 and qnaVO.statement == 0}"> <!-- 일반글 처리중-->
      <TR> <!-- 일반글 처리중-->
        <TD class='td' style="vertical-align: middle; text-align: center;">
        <img src="./images/notyet.jpg" style="height: 20px;">
        </TD>
        <TD class='td' style="vertical-align: middle; text-align: center;">${qnaVO.qnatype}</TD>
        <TD class='td' style='vertical-align: middle;'><A href="./read.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}">${qnaVO.title}</A></TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.mname}</TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.rdate.substring(0,10)}</TD> <!-- .substring(0,10) -->
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.cnt}</TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>
          <c:if test="${qnaVO.memberno == sessionScope.memberno or sessionScope.mact == 'M'}">
          <A href="./update.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
          <A href="./delete.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}"><IMG src='./images/trash.png' style="width: 16px;" title='삭제'></A>
          </c:if>
        </TD>
      </TR>
     </c:when>
     <c:when test="${qnaVO.seqno == 1 and qnaVO.statement == 1}"> <!-- 일반글 처리완료-->
      <TR> <!-- 일반글 처리완료-->
        <TD class='td' style="vertical-align: middle; text-align: center;">
        <img src="./images/clear.jpg" style="height: 20px;">
        </TD>
        <TD class='td' style="vertical-align: middle; text-align: center;">${qnaVO.qnatype}</TD>
        <TD class='td' style='vertical-align: middle;'><A href="./read.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}">${qnaVO.title}</A></TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.mname}</TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.rdate.substring(0,10)}</TD> <!-- .substring(0,10) -->
        <TD class='td' style='vertical-align: middle; text-align: center;'>${qnaVO.cnt}</TD>
        <TD class='td' style='vertical-align: middle; text-align: center;'>
          <c:if test="${qnaVO.memberno == sessionScope.memberno or sessionScope.mact == 'M'}">
          <A href="./update.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
          <A href="./delete.do?qnano=${qnaVO.qnano}&word=${word}&nowPage=${nowPage}"><IMG src='./images/trash.png' style="width: 16px;" title='삭제'></A>
          </c:if>
        </TD>
      </TR>
     </c:when>
    </c:choose>
  </c:forEach>
  
</TABLE>
<DIV style='text-align: center; clear: both; '></DIV>
  <DIV>${paging }</DIV>  <!-- 페이지 목록 출력 -->
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>