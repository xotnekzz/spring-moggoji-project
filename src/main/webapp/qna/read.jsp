<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>

<body>
<DIV class='container' style="width:100%; ">
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  <ASIDE style='float: left;'>
     <A href='./list.do?word=${param.word}&nowPage=${param.nowPage}'>질문 목록</A>
  </ASIDE>

  <ASIDE style='float: right;'>   
    <%-- <c:if test="${sessionScope.id ne null }">   --%>
      <c:choose>
        <c:when test="${qnaVO.memberno == sessionScope.memberno}">
          <A href='./create.do'>등록</A>
          <span> │</span> 
          <A href='./update.do?qnano=${qnaVO.qnano }&title=${param.title}&nowPage=${param.nowPage}'>수정</A>
          <span>│</span> 
          <A href='./delete.do?qnano=${qnaVO.qnano }&title=${param.title}&nowPage=${param.nowPage}'>삭제</A>
        </c:when>
        <c:otherwise>
        </c:otherwise>
      </c:choose>
      
      <c:choose>
        <c:when test="${sessionScope.mact == 'M'}">
          <A href='./reply.do?qnano=${qnaVO.qnano}'>답글</A>
        </c:when>
      </c:choose>
  </ASIDE> 
  
  <hr style="border-bottom: dotted 1px #777777; margin-top: 10px; width: 100%;">
  
      <fieldset class="fieldset" >
        <ul style="width: 100%;">
          <li class="li_none">
            <span style="font-size: 20px;">${qnaVO.title}</span>
            (<span>${qnaVO.rdate.substring(0, 16)}</span>)
           조회수 :  <span>${qnaVO.cnt}</span>
          </li>
          
          <li class="li_none">
            <DIV>${qnaVO.content }</DIV>
          </li>
        </ul>
      </fieldset>



</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>
