<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>리뷰 삭제</title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

</script>

</head> 

<body>
<DIV class='container' style="width:100%; ">
<jsp:include page="/menu/top.jsp" flush='false' />
<jsp:include page="/mypage/my_top.jsp" flush='false' />
<DIV class='list_content' >   
     
<ASIDE style='float: left;'>
    MyPage >  <A href='./m_list_search.do' >리뷰 목록</A>  > 삭제
  </ASIDE>
  <ASIDE style='float: right;'>   
    <%-- <c:if test="${sessionScope.id ne null }">   --%>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>등록</A>
      <span class='menu_divide' >│</span> 
      <A href='./list.do'>목록</A>
     
    <%-- </c:if> --%>
  </ASIDE> 
  
<!--   <div class='menu_line'></div> -->
<hr style="border-bottom: dotted 1px #777777; margin-top: 10px; width: 100%;">

  <FORM name='frm' method='POST' action='./delete.do' >
      <input type='hidden' name='reviewno' value='${reviewVO.reviewno}'>
      <input type='hidden' name='nowPage' value='${param.nowPage}'>
      <input type='hidden' name='word' value='${param.word}'>
    
      <div class="form-group">   
        <div class="col-md-12" style='text-align: center; margin: 30px;'>
          삭제 되는글: ${reviewVO.title }<br><br>
          삭제하시겠습니까? 삭제하시면 복구 할 수 없습니다.<br><br>
          <button type = "submit">삭제 진행</button>
          <button type = "button" onclick = "history.back()">취소</button>
        </div>
      </div>   
  </FORM>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
