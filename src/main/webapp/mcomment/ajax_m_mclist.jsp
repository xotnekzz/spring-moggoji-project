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
 $(function(){
   list($(sessionScope.memberno))
 })
 
 //목록
 function list(memberno){
   $.ajax({
     url: "./mcomment/m_mclist_json.do", // 요청을 보낼주소
     type: "get",  
     cache: false,
     dataType: "json", 
     data: "memberno=" + memberno, 

     success: function(data) { // callback 함수
       var html = '';

       for(index=0; index < data.length; index++) {
         html += "<TR>";
         html += "<TD style='text-align: center ;><A href='"++"'>"+data[index].movieNm+"</A></TD>";
         
         for(i = 0; i<=data[index].grade; i++){
           html += "<TD><img src="./images/star_on.png" style="width: 15px;"></TD>";
         }
         html += "<TD>"+data[index].content+"</TD>";
         html += "<TD style='text-align: center;'>"; 
         html += "<A href=\"javascript:update("+data[index].movieCd+")\"><IMG src='./images/edit.png' title='수정'></A>";  
         html += "<A href=\"javascript:deleteco("+data[index].movieCd+","+data[index].memberno+")\"><IMG src='./images/trash.png' title='삭제'></A>";
         html += "</TD>";
         html += "</TR>";
       }

       $('#m_mclist').empty();
       $('#m_mclist').append(html);
     },
     error: function(request, status, error) { // callback 함수
       console.log('<strong>ERROR</strong><br>' +  error + '<br>');
     }
   });
 }
 
//영화 댓글 삭제
 function deleteco(movieCd,memberno){
  
   $.ajax({     
     url: "../mcomment/deleteco.do",  
     type: "POST", 
     cache: false,
     dataType: "json", 
     data: "movieCd="+movieCd+"&memberno="+memberno,   
     /* data: $('#deletefrom').serialize(),   */
     
     success: function(data) { 
       
      },
     error: function (request, status, error) { 
       console.log('<strong>ERROR</strong><br>' +  error + '<br>');
     }
   });
   
 }
</script>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />

<jsp:include page="/mypage/my_top.jsp" flush='false' />
<DIV class='list_content'>

<form name='frm' id='frm' method="get" action="./m_mclist.do">
  <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno }'>

 <ASIDE style='float: left;'>
     MyPage >  <A href='./m_mclist.do?memberno=${memberno}' >코멘트</A>  
     <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${m_mccount } 건) 
    </c:if>
 </ASIDE>
 
 <ASIDE style='float: right;'>
    <c:choose>
      <c:when test="${param.title != '' }">
        <input type='text' name='word' id='word' value='${param.word }'  style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px;">
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style="border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px; ">
      </c:otherwise>
    </c:choose>
    <button type='submit'  style="background-color: #ffffff; border: solid 1px #aaaaaa; border-radius: 4px; padding: 3px 6px;">검색</button>
  </ASIDE> 
  </form>
<br><br>

<table class="table table-striped" style='width: 100%;'>
<colgroup>
 <col style='width: 25%;'/>
 <col style='width: 15%;'/>
 <col style='width: 50%;'/>
 <col style='width: 10%;'/>
</colgroup>
<thead>
  <TR>
  <TH class='th' style="text-align: center;">영화제목</TH>
  <TH class='th' style="text-align: center;">평점</TH>
  <TH class='th' style="text-align: center;">코멘트</TH>
  <TH class='th' style="text-align: center;">기타</TH>
</TR>
</thead>
<tbody id='m_mclist'>
</table>

<DIV>${paging }</DIV>  <!-- 페이지 목록 출력 -->
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
 
</body>
</html>