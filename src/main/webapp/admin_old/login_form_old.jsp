<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<style type="text/css">
  .login_button{
  width: 81%; 
  height: 22px; 
  font-size: 10px; 
  font-weight: bold; 
  background-color: #8C8C8C; 
  color:#D3C9C9; 
  border:none;
  }
  .join_button{
  width: 77%; 
  margin-left:10px;
  height: 22px; 
  font-size: 10px; 
  font-weight: bold;
  color:#666; 
  border:none;
  }
  
</style>
<script type="text/javascript" src="../js/tool.js"></script>
<script type="text/javascript">

</script>

</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <DIV class='content'>
        <!-- 레이어 선언 -->
        <DIV id='popup' class='popup1' style='display: none;'>
          <h2 style='color: #FFFFFF; text-decoration: underline;'>알림</h2>
          <div id='popup_content'></div>
          [<A href="javascript: hide('popup'); focus();">CLOSE</A>]
        </DIV>
   
     	<DIV >
          <ASIDE style='float: left; font-size: 20px; margin-top: 4px;'>회원 ＞ 로그인 </ASIDE>  
          <ASIDE style='float: right;'>
           <A href='javascript: location.reload()'><img src="./images/refresh.png" style="width : 16px"></A> 
          </ASIDE>          
          <DIV class='menu_line' style='clear: both;'></DIV>
        </DIV>
        <div style="text-align: center;">
          <h2 style="float: center;"><img src="./images/moggoji.png"> </h2>
        </div>
        
        <DIV>
          <FORM name='frm' method='POST' action='./login_ck_proc.jsp' onsubmit="return send(this);" style="margin : 0px; float: left;">
            <input type="hidden" name="url_address" value="">
            <fieldset class='fieldset_no_line'>
              <ul>
                <li class='li_none'>
                <label for='email' style="border: solid 1px; color: #D3C9C9;">email　　
                <input type='email' class="form-control input-lg" name='email' id='email' value='' style='width: 50%; border:none; padding-right : 20px;' autocomplete="off"> 
                </label>
                </li>
                <li class='li_none'>
                <label for='passwd' style="border: solid 1px; color: #D3C9C9;">password
                <input type='password' class="form-control input-lg" name='passwd' id='passwd' value='' style='width: 50%; border:none; padding-right : 22px;' autocomplete="off"> 
                </label>
                </li>
                <li class='li_none'>
                <br>
                  <button type='submit' class="btn btn-default">LOGIN</button>
                  <button type='button' onclick="history.back();" class="btn btn-default">JOIN</button>
                </li>
              </ul>
              <p style="font-weight: bold; font-size : 10px; color: #666;">　JOIN US</p>
              <button onclick="location='/admin/create_form.jsp'" class="join_button">JOIN</button>
            </fieldset>
              
          </FORM>
          <img src="./images/r3.jpg" style="width : 300px; float: right;">
        </DIV>
        
        <DIV class='menu_line' style='clear: both;'></DIV>
    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->
</body>

</html>