<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 

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

<script src="/movie/js/star.js"></script>
<script type="text/javascript">
var count = 3;

$(function(){
  
  getCommentList();
  
});

function more(){
  //alert("누름");
  
}


function createco(reviewno) { 
  
  $.ajax({     
    url: "/movie/mcomment/create.do", 
    type: "POST", // or GET
    cache: false,
    dataType: "json", 
    data: $('#commentForm').serialize(), 
    
    success: function(data) { 
     /*  if(data =="success"){
        $("#content").val("");
      } */
      getCommentList();
      $('#content').val("");
     },
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

function countup(){
  count += 3;
  getCommentList();
}

function getCommentList(){
  
  //alert("getCommentList 호출")
  $.ajax({
      type: "GET",
      url : "/movie/mcomment/list.do",  
      dataType : "json",
      data:$("#commentForm").serialize(),
      contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
      
      success : function(data){
        //var paging = data.jsonoj;
        var html = "";
        //alert("count : " + count);
        
        if(data.length > 0){
         if(data.length > count){
          for(i=0; i<count; i++){
            html += "<div>";
            html += "<div><table class='table'><h5><strong>"+data[i].mname+"</strong><span style='font-size: 12px;'>(" +data[i].rdate+ ")</span></h5>";
            for(j =0; j< data[i].grade; j++ ){
             html +=  " <img src='/movie/images/star_on.png' style='width: 15px;'>";
             }
            html += "<br>"+data[i].content + "<tr><td></td></tr>";
            html += "</table></div>";
            html += "</div>";
           }
          html +="<div style='text-align: right; margin-bottom: 5px;'><a href=\"javascript:countup();more()\"'>댓글 더보기▼</a></div>";
          
          }else if(data.length <= count){
            for(i=0; i<data.length; i++){
              html += "<div>";
              html += "<div><table class='table'><h5><strong>"+data[i].mname+"</strong><span style='font-size: 12px;'>(" +data[i].rdate+ ")</span></h5>";
              for(j =0; j< data[i].grade; j++ ){
               html +=  " <img src='/movie/images/star_on.png' style='width: 15px;'>";
               }
              html += "<br>"+data[i].content + "<tr><td></td></tr>";
              html += "</table></div>";
              html += "</div>";
             }
            }
         } else {
            html += "<div>";
            html += "<div><table class='table'><h6  style='text-align: center;'>등록된 댓글이 없습니다.</h6>";
            html += "</table></div>";
            html += "</div>";
         }  
        $("#commentList").html(html);
        $("#paging").html(paging)
          
      },
      error:function(request,status,error){
     }
  });
}

</script>
</head>
<body>
<div class='comment_form' style="width: 100%; height: 280px; margin-bottom: 50px;">
    <form id='commentForm' name="commentForm" method="post">
      <input type='hidden' id='movieCd' name='movieCd' value='${param.movieCd }'> 
      <input type='hidden' id='memberno' name='memberno' value='${sessionScope.memberno}'>
      <input type='hidden' id='mname' name='mname' value='${sessionScope.mname}'>
     
<%--  <c:choose>
  <c:when test="${sessionScope.memberno ne null || sessionScope.memberno != ''} "> --%>
    <div> 
     <div>
        <table style="width: 100%;">
          <tr>
            <td>
            <!-- 댓글을 쓴적이 없을 때만 보이게-->
             <c:choose> 
              <c:when test="${mc_check eq 0}">
<%--               <c:when test="${sessionScope.memberno ne'' &&  sessionScope.memberno ne null }"> --%>
               <div id ='rating' >
                <span>
                    <img id='image1' onmouseover="show(1)" onclick="mark(1)" onmouseout="noshow(1)" src="/movie/images/star_off.png">
                    <img id='image2' onmouseover="show(2)" onclick="mark(2)" onmouseout="noshow(2)" src="/movie/images/star_off.png">
                    <img id='image3' onmouseover="show(3)" onclick="mark(3)" onmouseout="noshow(3)" src="/movie/images/star_off.png">
                    <img id='image4' onmouseover="show(4)" onclick="mark(4)" onmouseout="noshow(4)" src="/movie/images/star_off.png">
                    <img id='image5' onmouseover="show(5)" onclick="mark(5)" onmouseout="noshow(5)" src="/movie/images/star_off.png">
                </span>
                <input type="hidden" name="grade">
               </div>
              <textarea name='content' id='content' rows='3' placeholder="댓글을 입력하세요" style='width: 100%; resize: none; '></textarea>
              <br>
              <div>
                <a href="javascript:createco('${param.movieCd}')" class="btn pull-right btn-default">등록</a>
              </div>
              </c:when>
               <c:otherwise>
                <!-- <span>회원만 댓글 가능</span> -->
               </c:otherwise>
             </c:choose>
            </td>
          </tr>
        </table>
      </div>
    </div>
    
<%--   </c:when>
</c:choose> --%>
 </form>

  <div style="width: 100%; margin: 0px auto; text-align: left; margin: 0px;">
    <form id="commentListForm" name="commentListForm" method="post">
        <div id="commentList"></div>
    </form>
  </div>
<%-- <div>${paging }</div> --%>
   
</div>


</body>
</html>