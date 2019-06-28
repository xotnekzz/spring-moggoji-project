<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">

var count = ${param.count}

$(function(){
   if(count == 0){    
     login_fail();
  }  
});

function forgot_Password(){
  var url = './forgot_password.jsp';
  var width = 550;
  var height = 450;
  var win = window.open(url, '비밀번호 찾기', 'width='+width+'px, height='+height+'px');
  var x = (screen.width - width) / 2; 
  var y = (screen.height - height) / 2;
  
  win.moveTo(x, y);
}

function login_fail() {
  var html = '';
  html += "<DIV class='popup_delete' style='height: 138px; width: 25%; left: 38%; top: 35%;'>";
  html += "  로그인에 실패하였습니다.<br>";
  html += "  아이디와 비밀번호를 확인해주세요.<br><br>";
  html += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 확인 </button>";
  html += "</DIV>"; 
  
  $('#main_panel').html(html);
  $('#main_panel').show(); 
}



</script>
<style type="text/css">

div.well{
  height: 250px;
} 

.Absolute-Center {
  margin: auto;
  position: absolute;
  top: 0; left: 0; bottom: 0; right: 0;
}

.Absolute-Center.is-Responsive {
  width: 50%; 
  height: 50%;
  min-width: 200px;
  max-width: 400px;
  padding: 40px;
}
</style>
<script type="text/javascript">

</script>

</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <DIV class='content'>
    <DIV id='main_panel'></DIV>
        <!-- 레이어 선언 -->
        <DIV id='popup' class='popup1' style='display: none;'>
          <h2 style='color: #FFFFFF; text-decoration: underline;'>알림</h2>
          <div id='popup_content'></div>
          [<A href="javascript: hide('popup'); focus();">CLOSE</A>]
        </DIV>
   
        <DIV >
          <ASIDE style='float: left; font-size: 20px; margin-top: 4px;'> 로그인 </ASIDE>        
          <DIV class='menu_line' style='clear: both;'></DIV>
        </DIV>
        <div style="text-align: center;">
          <h2 style="float: center;"><img src="./images/moggoji.png"> </h2>
        </div>
        <DIV>
          <FORM name='frm' method='POST' action='./login_check.do' onsubmit="return send(this);" style="margin : 0px;">
            <fieldset class='fieldset_no_line'>
              <div class="col-sm-6 col-md-4 col-md-offset-4">
                      <div class="form-group input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input class="form-control" type="email" name='email' placeholder="email" autocomplete="off"/>          
                      </div>
                      <div class="form-group input-group">
                         <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                         <input class="form-control" type="password" name='passwd' placeholder="password"/>
                      </div>
                      <div class="form-group">
                          <button type="submit" class="btn btn-def btn-block">Login</button>
                      </div>
                      <div class="form-group text-center">
                         <A href="javascript:forgot_Password()">Forgot Password</A>&nbsp;|&nbsp;<a href="./create.do">Join</a>
                      </div>      
                </div>
            </fieldset>
          </FORM>
        </DIV>
        
        <DIV class='menu_line' style='clear: both;'></DIV>
    </DIV>
    <!-- content END -->
  </DIV>
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  <!-- container END -->
</body>

</html>