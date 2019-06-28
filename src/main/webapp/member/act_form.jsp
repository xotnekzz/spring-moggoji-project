<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>권한 변경</title> 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head> 
 
<body>
<DIV class='container' style="margin-top: 20px;">
<DIV class='content' style="margin-top: 0px; margin: 0px auto;">
  <DIV class='aside_menu'>
    <ASIDE style='float: center;'>[권한 변경]</ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
<FORM name='frm' method='POST' action='./act_proc.do'>
  <input type='hidden' name='memberno' value='${memberVO.memberno}'>
  <fieldset class='fieldset_no_line' style="text-align: center;">
    <ul style="padding: 0px;">
      <li class='li_center'>
        <label>
          <input type='radio' name='mact' id='act1' value='M'>
          M: 마스터
        </label>
      </li>
      <li class='li_center'>
        <label>
          <input type='radio' name='mact' id='act2' value='Y'>
          Y: 로그인 가능
        </label>
      </li>      
      <li class='li_center'>
        <label>
          <input type='radio' name='mact' id='act3' value='N'>
          N: 로그인 불가
        </label>
      </li>         
      <li class='li_center'>
        <button type="submit">권한 변경 적용</button>
        <button type='button' onclick="window.close();">닫기</button> 
      </li>
    </ul>
  </fieldset>
</FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
 
</html> 