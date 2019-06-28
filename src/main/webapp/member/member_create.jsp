<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>회원 가입</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script type="text/javascript">

$(function() {
  $("#fileMF").on('change', function(){
      readURL(this);
  });
});

function readURL(input) {
  if (input.files && input.files[0]) {
  var reader = new FileReader();

  reader.onload = function (e) {
          $('#user').attr('src', e.target.result);
      }
    reader.readAsDataURL(input.files[0]);
  }
}

function checkId(){
  var frm = $('#frm');
  var params = 'memail='+$('#memail').val();
  //alert('params: ' + params);
  
  $.ajax({
    url: "./checkId.do",
    type: "GET",
    cache: false,
    dataType: "json", // or html
    data: params,
    success: function(data){
      var msg = "";
       if (data.cnt == 1) {
        msg = "<span style='color:red'>이미 사용중인 email 입니다.</span>";
      } else if(data.cnt == 0){
        msg = "<span style='color:green'>사용 가능한 email 입니다.</span>";
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
<DIV class='container' style="width:100%; ">
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
<DIV class='aside_menu'>
  <ASIDE style='float: left; font-size: 20px; margin-top: 4px;'>회원가입 </ASIDE>
  <ASIDE style='float: left; font-size: 15px; margin-top: 10px;'>　MOGGOJI에 오신것을 환영합니다.</ASIDE>
  
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
  <div style="text-align: center;">
  <h2 style="float: center;"><img src="./images/moggoji.png"> </h2>
  </div>
  
  <br>
 <div>
<FORM name='frm' method='POST' action='./create.do' onsubmit="return send();" enctype="multipart/form-data">
  <fieldset class='fieldset_no_line' style='width : 60%; margin : 0px auto;'>
  <div style="float: left; width: 240px; height: 290px; margin-top: 30px;">
    <div style="height: 80%;">
      <img id="user" src="./images/user.png" style="border: 1px solid; width : 220px;">
    </div>
    <div>
    <ul>
      <li class='li_none'>
        <input type='file' name='fileMF' id='fileMF'>
      </li>
    </ul>
    </div>
  </div>
  <div style="float: left; width: 60%; text-align: left;">
     <ul>
      <li class='li_none'>
        <label class='label_basic' for='name'>성명</label>
        <input type='text' class="form-control input-lg" name='mname' id='mname' required="required" placeholder="모꼬지" autocomplete="off">
      </li>
      <li class='li_none'>
        <label class='label_basic' for='email'>이메일</label>
        <input type='email' class="form-control input-lg" name='memail' id='memail' required="required" placeholder='test@mail.com' autocomplete="off">
        [<A href='#' onclick="checkId()">이메일 중복 검사</A>] 
        <SPAN id='id_span'></SPAN>
      </li>
      <li class='li_none'>
        <label class='label_basic' for='passwd'>패스워드</label>
        <input type='password' class="form-control input-lg" name='mpasswd' id='mpasswd'>
      </li>
      <!-- <li class='li_none'>
        <label class='label_basic' for='passwd2'>패스워드확인</label>
        <input type='password' class="form-control input-lg" name='passwd2' id='passwd2' value='123'>
      </li> -->
    </ul>
    </div>
    <br>
  </fieldset>
  <div style="margin-top: 30px; padding-right: 50px;">
        <button type='submit' class="btn btn-default">회원가입</button>
        <button type='button' onclick='history.back();' class="btn btn-default">취소</button>
    </div>
</FORM>
</div>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html> 