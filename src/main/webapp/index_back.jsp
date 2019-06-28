<%@ page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html>
<head>
	<meta charset="UTF-8">
	<title>moggoji</title>
  <link href="./css/style.css" rel="Stylesheet" type="text/css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<style>
@import url(http://weloveiconfonts.com/api/?family=fontawesome);
@import url(http://fonts.googleapis.com/css?family=Open+Sans:400,700);
[class*="fontawesome-"]:before {
  font-family: 'Jeju Gothic', serif;
}
*{
font-family: 'Jeju Gothic', serif;
}

* {
  box-sizing: border-box;
}

html {
  height: 100%;
}

body {
  background-color: #FFFFFF; /* #D1B2FF; */
  color: #606468;
  font: 400 0.875rem/1.5 "Open Sans", sans-serif;
  margin: 0;
  min-height: 100%;
}

a {
  color: #AAAAAA; /* #eee */
  outline: 0;
  text-decoration: none;
}
a:focus, a:hover {
  text-decoration: underline;
}

input {
  border: 0;
  color: inherit;
  font: inherit;
  margin: 0;
  outline: 0;
  padding: 0;
  -webkit-transition: background-color .3s;
          transition: background-color .3s;
}

.site__container {
  -webkit-box-flex: 1;
  -webkit-flex: 1;
      -ms-flex: 1;
          flex: 1;
  padding: 3rem 0;
}

.form input[type="password"], .form input[type="text"], .form input[type="submit"] {
  width: 100%;
}
.form--login {
  color: #606468;
}
.form--login label,
.form--login input[type="text"],
.form--login input[type="password"],
.form--login input[type="submit"] {
  border-radius: 0.25rem;
  padding: 1rem;
}
.form--login label {
  background-color: #363b41;
  border-bottom-right-radius: 0;
  border-top-right-radius: 0;
  padding-left: 1.25rem;
  padding-right: 1.25rem;
}
.form--login input[type="text"], .form--login input[type="password"] {
  background-color: #3b4148;
  color: white;
  border-bottom-left-radius: 0;
  border-top-left-radius: 0;
}
.form--login input[type="text"]:focus, .form--login input[type="text"]:hover, .form--login input[type="password"]:focus, .form--login input[type="password"]:hover {
  background-color: #434A52;
}
.form--login input[type="submit"] {
  background-color: #ea4c88;
  color: #eee;
  font-weight: bold;
  text-transform: uppercase;
}
.form--login input[type="submit"]:focus, .form--login input[type="submit"]:hover {
  background-color: #d44179;
}
.form__field {
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  margin-bottom: 1rem;
}
.form__input {
  -webkit-box-flex: 1;
  -webkit-flex: 1;
      -ms-flex: 1;
          flex: 1;
}

.align {
  -webkit-box-align: center;
  -webkit-align-items: center;
      -ms-flex-align: center;
          align-items: center;
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  -webkit-flex-direction: row;
      -ms-flex-direction: row;
          flex-direction: row;
}

.hidden {
  border: 0;
  clip: rect(0 0 0 0);
  height: 1px;
  margin: -1px;
  overflow: hidden;
  padding: 0;
  position: absolute;
  width: 1px;
}

.text--center {
  text-align: center;
}

.grid__container {
  margin: 0 auto;
  max-width: 20rem;
  width: 90%;
}

</style>

<script type="text/javascript">

$(function() {
  
  $("#fileMF").on('change', function(){
      readURL(this);
  });
  $("#login").show();
  $("#join").hide();
  
 if(${param.count ==0}){
  alert('로그인에 실패하였습니다. 아이디와 비밀번호를 확인하여 주세요.');
 }


  
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
    url: "./member/checkId.do",
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

function join(){
  $("#login").hide();
  $("#join").show();
}

function login(){
  $("#login").show();
  $("#join").hide();
}

function forgot_Password(){
  // 문자열: ', ""
  var url = './member/forgot_password.jsp';
  var width = 550;
  var height = 450;
  var win = window.open(url, '비밀번호 찾기', 'width='+width+'px, height='+height+'px');
  var x = (screen.width - width) / 2; 
  var y = (screen.height - height) / 2;
  
  win.moveTo(x, y);
}

//로그인 실패


</script>
</head>

<body class="align">
<!-- login일때 ajax로 변환 -->
  <div id="login" name="login" class="site__container">
  <h2 style="padding-left: 40.5%;"><img src="./member/images/moggoji.png"></h2>
    <div class="grid__container">
      <form name='frm' method="post" action="./member/login_check.do" onsubmit="return send(this);" class="form form--login">
        <div class="form__field">
          <label class="fontawesome-user" for="email"><span class="hidden">Email</span></label>
          <input id="email" name="email" type="text" class="form__input" placeholder="Email" required="required" autocomplete="off">
        </div>
        <div class="form__field">
          <label class="fontawesome-lock" for="passwd"><span class="hidden">Password</span></label>
          <input id="passwd" name="passwd" type="password" class="form__input" placeholder="Password" required>
        </div>
        <div class="form__field">
          <input type="submit" value="Log In">
        </div>
      </form>
      <p class="text--center">Not a member? <span class="fontawesome-arrow-right"></span> 
      <a href="javascript:join()">Sign up now</a> </p>
      <p class="text--center">Forgot password? <span class="fontawesome-arrow-right"></span> 
      <a href="javascript:forgot_Password()">Click</a> </p>
    </div>
  </div>
  
  <div id="join" name="join" class="site__container"> <!-- 회원가입 -->
    <h2 style="padding-left: 40.5%;"><img src="./member/images/moggoji.png"></h2>
    <FORM name='frm' method='POST' action='./member/create.do' onsubmit="return send();" enctype="multipart/form-data" class="form form--login">
    <fieldset class='fieldset_no_line' style='width : 40%; margin : 0px auto;'>
    <div style="float: left; width: 240px; height: 290px; margin-top: 30px;">
      <div style="height: 80%;">
       <img id="user" src="./member/images/user.png" style="border: 1px solid; width : 220px;">
      </div>
    <div>
      <ul>
        <li class='li_none'>
          <input type='file' name='fileMF' id='fileMF'>
        </li>
      </ul>
    </div>
  </div>
  
  <div style="margin-top: 30px;">
    <div class="form__field">
          <label class="fontawesome-user" for="mname"><span class="hidden">Name</span></label>
          <input name='mname' id="mname" type="text" class="form__input" placeholder="Name" required="required" autocomplete="off">
    </div>
    <div class="form__field">
          <label class="fontawesome-user" for="memail"><span class="hidden">Email</span></label>
          <input name='memail' id='memail' type="text" class="form__input" placeholder="Email" required="required" autocomplete="off">
    </div>
    <div class="form__field">
          <A href='#' onclick="checkId()">[이메일 중복 검사]</A> 
          <SPAN id='id_span'></SPAN>
    </div>
    <div class="form__field">
          <label class="fontawesome-lock" for="mpasswd"><span class="hidden">Password</span></label>
          <input name='mpasswd' id='mpasswd' type="password" class="form__input" placeholder="Password" required>
    </div>
    <div class="form__field">
          <input type="submit" value="Join">
    </div>
   </div>
    </fieldset>
    </form>
      <p class="text--center">Not a member? <span class="fontawesome-arrow-right"></span> 
      <a href="javascript:login()">Login</a> </p>
    <br>
  </div>


</body>
</html>