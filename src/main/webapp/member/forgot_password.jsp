<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>비밀번호 찾기</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script type="text/javascript">
function checkId(){
  var frm = $('#frm');
  var params = 'memail='+$('#memail').val();
  alert('☆10초만 기다려주세요☆');
  
  $.ajax({
    url: "./forgot_password.do",
    type: "GET",
    cache: false,
    dataType: "json", // or html
    data: params,
    success: function(data){
      var msg = "";
       if (data.cnt == 1) {
        msg = "<span style='color:green'>비밀번호를 전송하였습니다.</span>";
      } else if(data.cnt == 0){
        msg = "<span style='color:red'>없는 email입니다.</span>";
      } 
      $("#id_span").html(msg);
    },
    // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
    error: function (request, status, error){  
      var msg = "에러가 발생했습니다. <br><br>";
      msg += "다시 시도해주세요.<br><br>";
      msg += "request.status: " + request.status + "<br>";
      msg += "request.responseText: " + request.responseText + "<br>";
      msg += "status: " + status + "<br>";
      msg += "error: " + error;
      $("#id_span").html(msg);
    }
  });
}
</script>

</head> 
<body>
<FORM name='frm' method='POST' action='./create.do' onsubmit="return send();" enctype="multipart/form-data">
  <div style="float: left; width: 60%; text-align: left;">
     <ul>
      <li class='li_none'>
        <label class='label_basic' for='email'>이메일</label>
        <input type='email' class="form-control input-lg" name='memail' id='memail' required="required" autocomplete="off">
        [<A href='#' onclick="checkId()">이메일 검사</A>] 
        <SPAN id='id_span'></SPAN>
      </li>
    </ul>
    </div>
    <br>
  <div style="margin-top: 30px; padding-left: 90px;">
        <button type='button' onclick='window.close();' class="btn btn-default">확인</button>
        <button type='button' onclick='window.close();' class="btn btn-default">취소</button>
    </div>
</FORM>
</body>
</html> 