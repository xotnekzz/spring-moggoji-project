<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<FORM name='frm' method='POST' action='./member_delete.do'>
<input type='hidden' name='memberno' id='memberno' value='${memberVO.memberno}'>
<button class="btn btn-default" type="submit">삭제</button>
</FORM>
</body>
</html>