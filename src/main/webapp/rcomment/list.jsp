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
  
  getCommentList();
  
  $("#addReadBtn").on("click", addRead);
  
});

function createco(reviewno) { 
  
  $.ajax({     
    url: "../rcomment/create.do",  
    type: "POST", 
    cache: false,
    dataType: "json", 
    data: $('#commentForm').serialize(), 
    
    success: function(data) { 
    /*   if(data =="success"){
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

function getCommentList(){

  $.ajax({
      type: "GET",
      url : "../rcomment/list.do",  
      dataType : "json",
      data:$("#commentForm").serialize(), 
      contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
      
      success : function(data){
        var html = "";
        var commentForm = $('#commentForm');
        if(data.length > 0){
          for(i=0; i<data.length; i++){
            html += "<div>";
            html += "<div><table class='table'><h5><strong>"+data[i].mname+"</strong>(" +data[i].rcdate+ ")";
            if(data[i].memberno == $('#memberno',commentForm).val()){ //댓글을 쓴 회원만 삭제가 보임
              html += "&nbsp; <a href=\"javascript:deleteco("+data[i].rcno+","+ data[i].memberno+")\" '>삭제</a>";
            }
            html +="</h5>";
            html += data[i].content + "<tr><td></td></tr>";
            html += "</table></div>";
            html += "</div>";
           }
          } else {
            html += "<div>";
            html += "<div><table class='table'><h6  style='text-align: center;'>등록된 댓글이 없습니다.</h6>";
            html += "</table></div>";
            html += "</div>";
          }  
        $("#commentList").html(html);
          
      },
      error:function(request,status,error){
     }
  });
}

function deleteco(rcno,memberno) { 
  //alert("deleteco 실행 : "+rcno+ ","+memberno)
  
  $.ajax({     
    url: "../rcomment/deleteco.do",  
    type: "POST", 
    cache: false,
    dataType: "json", 
    data: "rcno="+rcno+"&memberno="+memberno,   
    /* data: $('#deletefrom').serialize(),   */
    
    success: function(data) { 
  /*     if(data =="success"){
        alert("삭제되었습니다.");
      }else if(data =="fail"){
        alert("삭제실패.");
      } */
      getCommentList();
     },
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}

function addRead(){
  $.ajax({
      url: "./read.do",  // /pilot/ajax/read.do
      type: "GET",
      cache: false,
      dataType: "JSON",
      data: "replyPage="+$("#reply_list").attr("data-replyPage"),
      success: function(data){
        $("#reply_list").attr("data-replyPage", data.replyPage+1); // 페이지수 증가
        // alert(data.replyPage);
        // $('#reply_list').html(data.replyPage);
        var content="";
        content += "<DIV style='width: 100%; padding: 10px;'>";
        content += data.title + "("+data.name+") "+data.replyPage+"<br>";
        content += data.content;
        content += "</DIV>";
        $(content).appendTo("#reply_list"); // reply_list의 자식 태그로 추가함.
      },
      error: function (request, status, error){
        alert(request.status + "\n"+request.responseText + "\n" + error);      
      }
  });
}

</script>
</head>
<body>

<div class='comment_form' style="width: 100%; height: 280px; margin-bottom: 50px;">
    <form id='commentForm' name="commentForm" method="post">
      <input type='hidden' id='reviewno' name='reviewno' value='${param.reviewno }'> 
      <input type='hidden' id='memberno' name='memberno' value='${sessionScope.memberno}'>
      <input type='hidden' id='mname' name='mname' value='${sessionScope.mname}'>
     <div> 
<%--       <div>
        <span style="float: left;"><strong>Comment (${count})</strong></span>
        <br>
      </div> --%>
      <div>
        <table style="width: 100%;">
          <tr>
            <td>
              <%-- <input type='text' id='mname' name='mname' value ='${ sessionScope.mname}'  size='10%'  style="float: left;" disabled/>  --%>
              <!-- 회원만 댓글 가능-->
              <c:choose> 
                <c:when test="${sessionScope.memberno!='' &&  sessionScope.memberno != null}">
                <textarea name='content' id='content' rows='3' placeholder="댓글을 입력하세요" style='width: 100%; resize: none; '></textarea>
                <br>
                <div>
                  <button type="button" onclick="createco('${param.reviewno}')" class="btn pull-right btn-default">등록</button>
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
   </form>
   
   <div class="container" style="width: 100%; margin: 0px auto; text-align: left; margin: 0px;">
    <form id="commentListForm" name="commentListForm" method="post">
        <div id="commentList">
        </div>
    </form>
</div>

   
</div>
 
</body>
</html>