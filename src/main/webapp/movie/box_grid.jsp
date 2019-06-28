<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!--인덱스 박스오피스 슬라이드  -->
<link href="./css/style.css" rel="Stylesheet" type="text/css">
 <link rel="stylesheet"  href="./css/box_grid.css"/>
    <style>
      ul{
      list-style: none outside none;
        padding-left: 0;
            margin: 0;
    }
     .demo .item{
        margin-bottom: 60px;
    }
    
    .content-slider li{
        background-color: #ffffff;
        text-align: center;
        color: #FFF;
        padding: 0px;
        width: 250px;
    }

    .content-slider h3 {
        margin: 0;
        padding: 70px 0;
    }
    .demo{
      width: 800px;
    }
    </style>
    <!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
    <script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="./js/box_grid.js"></script> 
    <script>
       $(document).ready(function() {
      $("#content-slider").lightSlider({
                loop:true,
                keyPress:true
            });
            $('#image-gallery').lightSlider({
                gallery:true,
                item:1,
                thumbItem:9,
                slideMargin: 0,
                speed:500,
                auto:true,
                loop:true,
                onSliderLoad: function() {
                    $('#image-gallery').removeClass('cS-hidden');
                }  
            });
    });
       
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
    </script>
 
<div class="item" >
    <div class="lSSlideOuter ">
         <div class="lSSlideWrapper usingCss" style="transition-duration: 400ms; transition-timing-function: ease;">
            <ul id="content-slider" class="content-slider lightSlider lsGrab lSSlide" style="width: 3240px; transform: translate3d(-1080px, 0px, 0px); height: 165px; padding-bottom: 0%;">
            <c:forEach var="MainBoxOfficeVO" items="${list }">
            <li class="lslide" style=""> <!-- style="width: 248px; margin-right: 10px;" -->
              <DIV  class="main_movie" style="width: 100%; float: left; height: 365px;">
                <c:choose>
                 <c:when test="${MainBoxOfficeVO.thumb ne '' }">
                  <A href="javascript:movie_detail(${MainBoxOfficeVO.movieCd})"  style="width: 100%; height: 360px;"><img src="/movie/movie/storage/${MainBoxOfficeVO.thumb }"  style="width: 100%; height: 355px;"></A>
                  <h5>${MainBoxOfficeVO.movieNm }</h5>
                </c:when>
              <c:otherwise>
              <A href="javascript:movie_detail(${MainBoxOfficeVO.movieCd})"  style="width: 100%; height: 360px;"> <img src="./images/grid_movie.png" style="width: 100%; height: 355px;"></A>
              <h5>${MainBoxOfficeVO.movieNm }</h5>
              </c:otherwise>
             </c:choose>
            </DIV>
        </li>
     </c:forEach>
      </ul>
    </div>
   </div>
</div>

