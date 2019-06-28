<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MOGGOJI</title>
<link href="/movie/css/style.css" rel="Stylesheet" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

 <link href="./themes/js-image-slider.css" rel="stylesheet" type="text/css" /> 
 <script src="./themes/js-image-slider.js" type="text/javascript"></script> 
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 <script type="text/javascript">
 $(function(){
   getBoxList();
   getBoxGrid();
   genr();
 });
 
 //박스오피스 랭킹
 function getBoxList(){

  $.ajax({
      type: "GET",
      url : "./movie/boxlist.do",  
      dataType : "json",
      data:$("#bocoffice_rank").serialize(), 
      contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
      
      success : function(data){
        var html = "";
        
        if(data.length > 0){
            html += "<ul>";
          for(i=0; i<data.length; i++){
            html += "<li style='list-style:none; margin : 10px 3px;' font-size: 12px;> <span>"+data[i].rank +".&nbsp;</span><A href=\"javascript:movie_detail("+data[i].movieCd+")\"><span>"+ data[i].movieNm+"</span></A></li>";
           }
            html += "</ul>";
          } 
        $("#boxlist").html(html);
          
      },
      error:function(request,status,error){
     }
  });
}
 
 //박스오피스 그리드
 function getBoxGrid(){

   $.ajax({     
     url: "./movie/box_grid.do",  
     type: "get", 
     cache: false,
     dataType: "html", 
     
     success: function(data) { 
       $('#boxgrid').html(data);
      },
     error: function (request, status, error) { 
       console.log('<strong>ERROR</strong><br>' +  error + '<br>');
     }
   });;
} 
 
 
//영화 상세보기
 function movie_detail(movieCd){
   
   $.ajax({     
     url: "./movie/read.do",  
     type: "get", 
     cache: false,
     dataType: "html", 
     data: "movieCd="+movieCd,   
     
     success: function(data) { 
       var html='';
       html += "<DIV class='popup_movie'>" ;
       html += "<DIV style='text-align: right;'><button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'>X</button></DIV>" ;
       html += data;
       html += "</DIV>"
       
       $('#main_panel').html(html);
       $('#main_panel').show();
      },
     error: function (request, status, error) { 
       console.log('<strong>ERROR</strong><br>' +  error + '<br>');
     }
   });
 }
 
//장르 검색
function genr(){
  
  $.ajax({     
    url: "./movie/genre.jsp",  
    type: "get", 
    cache: false,
    dataType: "html", 
    
    success: function(data) { 
      $('#genr').html(data);
     },
    error: function (request, status, error) { 
      console.log('<strong>ERROR</strong><br>' +  error + '<br>');
    }
  });
}
 
</script>
</head>


<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container' style='width: 100%;'>

<DIV id='main_panel'></DIV>

  <div id="sliderFrame"> 
  <div id="slider">
   <!--  <img src="../menu/images/main_slider1.jpg" style="width : 100%; height: 400px;"> -->
    <img src="./menu/images/main_slider2.jpg" style="width : 100%; height: 400px;">
    <img src="./menu/images/main_slider3.jpg" style="width : 100%; height: 400px;">
    <img src="./menu/images/main_slider4.jpg" style="width : 100%; height: 400px;">
  </div> 
  </div>
  
  <div class="group1-Wrapper"> <!-- 슬라이드 이미지 버튼 -->
    <a onclick="imageSlider.previous()" class="group1-Prev"></a>
    <a onclick="imageSlider.next()" class="group1-Next"></a>
  </div>
  
  
 <DIV class='content' style="margin-top: 15px;">

  <h3 style="text-align: left; font-weight: normal;">&nbsp;오늘의 BOX OFFICE</h3>
   <div class='bocoffice_rank' id='bocoffice_rank' > <!-- 박스오피스 랭킹 -->
      <div style="margin: 10px;">
    <span style="font-size: 20px;">박스오피스 랭킹</span><br>
   </div>
   <hr style="margin-top: 5px; margin-bottom: 8px;">
    <div id="boxlist"></div>
   </div>
   
   <div style="float: left; width:74%;"> <!-- 박스오피스 포스터들 -->
    <div id='boxgrid' ></div>
   </div>
   
   
   <DIV style='text-align: center; clear: both; '><br></DIV>
   
   <div style="text-align: left;"> <!-- 장르 -->
    <h3 style="text-align: left; font-weight: normal;">&nbsp;장르별 영화</h3>
    <div id = 'genr'></div>
   </div>

</DIV>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV>
</body>
</html>