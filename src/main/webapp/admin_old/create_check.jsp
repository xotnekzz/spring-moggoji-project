<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>관리자 가입</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
</head> 
<body>
<DIV class='container'>
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
<FORM name='frm' method='POST' action='./create_proc.jsp'>
  
  <fieldset class='fieldset_no_line' style='width : 60%; margin : 0px auto;'>
  
  <div style="float: right; width: 240px; height: 290px; margin-top: 50px;">
    <div style="height: 80%;">
      <img id="user" src="./images/user.png" style="border: 1px solid; height : 220px;">
    </div>
    <div>
      <li class='li_none'>
        <input type='file' name='mfile' id='mfile'>
      </li>
    </div>
  </div>
  <div style="float: left; width: 60%; text-align: left;">
     <ul>
      <li class='li_none'>
        <label class='label_basic' for='mname'>성명</label>
        <input type='text' class="form-control input-lg" name='mname' id='mname' value='완두콩'>
      </li>
      <li class='li_none'>
        <label class='label_basic' for='email'>이메일</label>
        <input type='email' class="form-control input-lg" name='email' id='email' required="required" value='test@mail.com'>
        [<A href='javascript: email_duplicate();'>이메일 중복 검사</A>] 
      </li>
      <li class='li_none'>
        <label class='label_basic' for='passwd'>패스워드</label>
        <input type='password' class="form-control input-lg" name='passwd' id='passwd' value='123'>
      </li>
      <li class='li_none'>
        <label class='label_basic' for='passwd2'>패스워드확인</label>
        <input type='password' class="form-control input-lg" name='passwd2' id='passwd2' value='123'>
      </li>
    </ul>
    </div>
    <br>
  </fieldset>
  <div style="margin-top: 30px; padding-left: 90px;">
        <button type='submit' class="btn btn-default">회원가입</button>
        <button type='button' onclick='history.back();' class="btn btn-default">취소</button>
    </div>
</FORM>
</div>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html> 