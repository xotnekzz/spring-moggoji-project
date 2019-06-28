<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 <script type="text/javascript">
 
 $(function(){
   getStarCount();
 });
 
 
 function getStarCount(){
   $.ajax({
       type: "GET",
       url : "/movie/mcomment/star_all_count.do",  
       cache: false,
       dataType : "json",
       success : function(data){
         $('span.star').html(data.count);
       },
       error:function(request,status,error){
      }
   });
 }
 </script>
</head>
<body>
<DIV style='text-align: left; clear: both; border-top : 1px solid gray; margin-top: 20px; padding-left: 100px;'>

<DIV style='text-align: center; clear: both; '></DIV>

 <img src="/movie/menu/images/moggoji.png" style="height: 60px;"><br>
 영화를 소개하고 추천하는 사이트 입니다.<br>
 <img src="/movie/images/star_on.png">&nbsp;<span class="star"></span> 개의 별점 평가가 쌓이고 있습니다.
 
</DIV>
</body>
</html>