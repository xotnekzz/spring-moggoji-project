<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MOGGOJI</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">

 <link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick.css" />
 <link rel="stylesheet" type="text/css" href="http://kenwheeler.github.io/slick/slick/slick-theme.css" />    
 <script src="http://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha256-k2WSCIexGzOj3Euiig+TlR8gA0EmPjuc79OEeY5L45g=" crossorigin="anonymous"></script>
 <script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script> 

 <script type="text/javascript">
 $(document).ready(function () {

	$('.main_slider').slick({
		autoplay : true,
		dots: true,
		speed : 300 /* 이미지가 슬라이딩시 걸리는 시간 */,
		infinite: true,
		autoplaySpeed: 3000 /* 이미지가 다른 이미지로 넘어 갈때의 텀 */,
		arrows: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		fade: false
	});
	
	 $('.box_slider').slick({
		autoplay : false,
		dots: true,
		infinite: true,
		arrows: true,
		slidesToShow: 4,
		slidesToScroll: 4,
		fade: false
	}); 
	 
	 //index_boxOffice();
});

</script>
</head>


<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='container' style='text-align: center; width: 100%;'>

<DIV id='main_panel'></DIV>

  <div class="main_slider">
    <div><img src="../menu/images/main_slider1.jpg" style="width : 100%; height: 400px;"></div>
    <div><img src="../menu/images/main_slider2.jpg" style="width : 100%; height: 400px;"></div>
    <div><img src="../menu/images/main_slider3.jpg" style="width : 100%; height: 400px;"></div>
  </div> 
  
 <DIV class='content'>
     <div class="box_office">
     
        <div class="rank">
          <h2 style="border-bottom: 1px solid #efefef; text-align: left;">영화 랭킹</h2>
          <div id="boxOffice" style="text-align: left;">
            <c:forEach var="boxOfficeVO" items="${list }">
              <ul class='mylist'>
                <li> <A href="javascript:movie_detail(${boxOfficeVO.movieCd})" >${boxOfficeVO.movieNm}</A></li>
              </ul>
            </c:forEach>
         </div>
        </div> 
     </div>
        
   </div>
</DIV>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV>
</body>
</html>