
var locked = 0;

function show(star){
  if(locked) //1이면 리턴
    return;
  var i;
  var image;
  var el;
  var stateMsg;
  
  for(i =1 ;i <= star; i++){
    image = 'image' + i;
    el = document.getElementById(image);
    el.src="/movie/images/star_on.png"
  }
}

function noshow(star){
  if(locked)
    return;
  var i;
  var image;
  var el;
  
  for(i = 1; i<=star; i++){
    image = 'image' + i;
    el = document.getElementById(image);
    el.src = "/movie/images/star_off.png"
  }
}

function lock(star){
  show(star);
  locked = 1;
}

function mark(star){
  lock(star);
  //alert("js선택 : "+star);
  document.commentForm.grade.value=star;
}