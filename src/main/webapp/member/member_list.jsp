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
// 권한 변경
function act_form(memberno, mact) {
  // 문자열: ', ""
  var url = './act_form.do?memberno=' + memberno + '&mact=' + mact;
  var width = 380;
  var height = 320;
  var win = window.open(url, '권한 변경', 'width='+width+'px, height='+height+'px');
  var x = (screen.width - width) / 2; 
  var y = (screen.height - height) / 2;
  
  win.moveTo(x, y);
}
</script>
</head> 
 
<body>
<DIV class='container' style="width:100%; ">
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/admin/admin_top.jsp" flush='false' />

<DIV class='list_content' >
 
 <div>
 <form name='frm' id='frm' method="get" action="./member_list_search.do">
  <ASIDE style='float: left;'>
     관리자 >  <A href='./member_list_search.do'>회원 목록</A>  
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>
    
    <ASIDE style='float: right;'>
    <SELECT name='col' id='col'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px;">
          <OPTION value='none'<c:out value="${param.col == 'none'?'selected':''}"/>>검색 목록</OPTION>
          <OPTION value='memberno' <c:out value="${param.col == 'memberno'?'selected':''}"/>>번호</OPTION>
          <OPTION value='mname' <c:out value="${param.col == 'mname'?'selected':''}"/>>이름</OPTION>
          <OPTION value='memail' <c:out value="${param.col == 'memail'?'selected':''}"/>>이메일</OPTION>
          <OPTION value='mact' <c:out value="${param.col == 'mact'?'selected':''}"/>>권한</OPTION>
    </SELECT>
    <c:choose>
      <c:when test="${param.word ne '' }">
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
 
  <table class="table table-striped" style='width: 100%;'>
  <caption> </caption>

  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 20%;'/>
    <col style='width: 15%;'/>
    <col style='width: 22%;'/>
    <col style='width: 5%;'/>
    <col style='width: 23%;'/>
    <col style='width: 20%;'/>
  </colgroup>
  <TR>
    <TH class='th' style="text-align: center;">번호</TH>
    <TH class='th' style="text-align: center;">사진</TH>
    <TH class='th' style="text-align: center;">성명</TH>
    <TH class='th' style="text-align: center;">이메일</TH>
    <TH class='th' style="text-align: center;">권한</TH>
    <TH class='th' style="text-align: center;">가입일</TH>
    <TH class='th' style="text-align: center;">기타</TH>
  </TR>
 
   <c:forEach var="memberVO" items="${list}">
  <TR>
    <TD class='td' style="text-align: center; vertical-align: middle;">${memberVO.memberno}</TD>
    
      <c:choose>
        <c:when test="${memberVO.mfile ne ''}">
           <TD class='td' style="text-align: center; width: 100px; "><IMG src='./storage/${memberVO.mfile }' style=" height : 100px;"></TD> <!-- 이미지 파일명 출력 -->
        </c:when>
        <c:otherwise>
        <!-- 파일이 존재하지 않는 경우 -->
         <TD class='td' style="text-align: center;"><IMG src='./images/user.png' style='height: 100px;'></TD>
        </c:otherwise>
      </c:choose>
    
    <TD class='td' style="text-align: center; vertical-align: middle;">${memberVO.mname}</TD>
    <TD class='td' style="text-align: center; vertical-align: middle;">${memberVO.memail}</TD>
    <TD class='td' style="text-align: center; vertical-align: middle;">
    <A href="javascript: act_form(${memberVO.memberno}, '${memberVO.mact}')">${memberVO.mact}</A>
    </TD>
    <TD class='td' style="text-align: center; vertical-align: middle;">${memberVO.mdate}</TD>
    <TD class='td' style="text-align: center; vertical-align: middle;">
      <A href="./member_update.do?memberno=${memberVO.memberno}&word=${word}&nowPage=${nowPage}"><IMG src='./images/edit.png' style="width: 16px;" title='수정'></A>
      <A href="./member_delete.do?memberno=${memberVO.memberno}&word=${word}&nowPage=${nowPage}"><IMG src='./images/trash.png' style="width: 16px;" title='삭제'></A>
      <%-- <FORM name='delete' id='delete' method='post' action='./member_delete.do'>
         <input type='hidden' name='memberno' id='memberno' value='${memberVO.memberno}'>
         <IMG src='./images/trash.png' style="width: 16px;" title='삭제'></a>
       </FORM> --%>
    </TD>
    
  </TR>
  </c:forEach> 
  
</TABLE>
<DIV style='text-align: center; clear: both; '></DIV>
  <DIV>${paging }</DIV>  <!-- 페이지 목록 출력 -->
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>