<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<!-- 
<script type="text/javascript">
  $(document).ready(function(){ // window.onload = function() { ... }
    imgResize()
  });

  //<div id='file1Panel'> 태그의 width에 맞추어 자동 축소
  function imgResize() {
    var file1 = $('#file1');
    var width = file1.width();
    // alert(width);
    // console.log("loading - width:" + loading + " - " + width);
    // console.log("screen.width-(screen.width * 0.3): " + screen.width-(screen.width * 0.3));
        
    if (file1 != null) {
      // 이미지 width가 화면의 70%보다 크다면
      if (width > screen.width-(screen.width * 0.4)) {
        // console.log("loading - width:" + loading + " - " + width);
        // file1.width(600); // 이미지 축소
        $('#file1Panel').attr('width', '100%');  // 할당된 영역을 100%로 설정함.
        file1.css('width', '900'); // <div id='file1Panel'> 태그의 width에 맞추어 자동 축소
      } else {
        // 작은 이미지는 그대로 출력
      }
    }

  }
  
  function panel_img(mainimg){
    var panel = '';
    panel += "<DIV id='panel' class='popup_img' style='width: 80%;'>";
    panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+mainimg+"' style='width: 100%;'></A>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
    
  }
</script>
   -->
</head>

<body>
<DIV class='container' style='width: 100%; '>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >
 
  <ASIDE style='float: left;'>
  <%--   MyPage >  <A href='./m_list_search.do?memberno=${memberno }&title=${param.title}&nowPage=${param.nowPage}' >리뷰 목록</A>  > ${reviewVO.title} --%>
     <A href="javascript:history.back()">리뷰</A>  > ${reviewVO.title} <!-- 어디로 가야하는지 고민 -->
  </ASIDE>
  <ASIDE style='float: right;'>   
    <c:if test="${sessionScope.memberno ne null }">
      <A href='./create.do'>등록</A>
      </c:if>
      
     <c:if test="${reviewVO.memberno eq sessionScope.memberno }">
      <span>│</span> 
      <A href='./update.do?reviewno=${reviewVO.reviewno }&title=${param.title}&nowPage=${param.nowPage}'>수정</A>
      <span>│</span> 
      <A href='./delete.do?reviewno=${reviewVO.reviewno }&title=${param.title}&nowPage=${param.nowPage}'>삭제</A>&nbsp;
    </c:if>
  </ASIDE> 
  
  <!-- <div class='menu_line'></div> -->
  <hr style="border-bottom: dotted 1px #777777; margin-top: 10px; width: 100%;">
  
      <fieldset class="fieldset" >
        <ul style="width: 100%; padding: 0px;">
          <li class="li_none"  >
          <div style="float: left; text-align: left;">
            <span style="font-size: 30px;">${reviewVO.title}</span> <span>(${reviewVO.cnt})</span>
            <br>
           <!-- </div>
           <div style="float: right;"> -->
           by. <span>${mnameVO.mname}(${mnameVO.memail})  <span>(${reviewVO.rdate.substring(0, 16)})</span></span> <br><br>
           </div>
           
           <%-- 리뷰 별점 :  <span>${reviewVO.review_rating}</span> --%>
           <hr style="border-bottom: dotted 1px #cccccc; margin-top: 10px; width: 100%;">
          </li>
          
          <li class="li_none" >    
            <div id='mainimgPanel' style="text-align: center;">
              <!-- EL 값을 JSTL 변수에 할당 -->
              <c:set var='mainimg' value="${fn:toLowerCase(reviewVO.mainimg)}" />
              
              <c:choose>
                <c:when test="${fn:endsWith(mainimg, '.jpg')}">
                  <IMG id='mainimg' src='./storage/${reviewVO.mainimg}'  style="width: 50%;">
                </c:when>
                <c:when test="${fn:endsWith(mainimg, '.gif')}">
                  <IMG id='mainimg'  src='./storage/${reviewVO.mainimg}' style="width: 50%;">
                </c:when>
                <c:when test="${fn:endsWith(mainimg, '.png')}">
                  <IMG id='mainimg'  src='./storage/${reviewVO.mainimg}' style="width: 50%;">
                </c:when>
              </c:choose>
              <br>
            </div>
          </li>
           
          <li class="li_none">
            <DIV>${reviewVO.content }<br></DIV>
          </li>
          <li class="li_none">
            <DIV> ${reviewVO.youtube }</DIV>
          </li>
        </ul>
      </fieldset>

<span style="float: left;"><strong>Comment (${rcc})</strong></span><!-- 리뷰별 댓글 갯수 -->
<jsp:include page="/rcomment/list.jsp" flush='false' /> 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>

