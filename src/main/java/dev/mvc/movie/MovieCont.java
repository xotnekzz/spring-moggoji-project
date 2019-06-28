package dev.mvc.movie;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
/*import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;*/
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;
import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;

@Controller
public class MovieCont {
 
  @Autowired 
  @Qualifier("dev.mvc.movie.MovieProc")
  private MovieProcInter movieProc; 
  
  public MovieCont() { 
    //System.out.println("--> MovieCont Created...");
  }  
  
  //index 박스오피스 목록 ajax
  @ResponseBody
  @RequestMapping(value="/movie/boxlist.do", produces="application/json; charset=utf8", method=RequestMethod.GET)
  public ResponseEntity boxlist() {
    //ResponseEntity : 응답 + 응답 코드
    
    //System.out.println("index 박스오피스"); 
    
    HttpHeaders responseHeaders = new HttpHeaders();

    List<BoxOfficeVO> boxOffice_List = movieProc.boxOffice_List();
    
    JSONArray json = new JSONArray(boxOffice_List);

    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
/*  //인덱스 박스오피스(rank) json
  @ResponseBody
  @RequestMapping(value="/movie/boxlist.do", produces="application/json; charset=utf8", method=RequestMethod.GET)
  public ResponseEntity boxlist() {
    //ResponseEntity : 응답 + 응답 코드
    
    //System.out.println("index 박스오피스"); 
    
    HttpHeaders responseHeaders = new HttpHeaders();

    List<MainBoxOfficeVO> mainbo_list = movieProc.mainbo_list();
    
    JSONArray json = new JSONArray(mainbo_list);

    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }*/
  
  /**
   * import org.json.simple.JSONArray; simple.JSONArray필요!!!!! 잠시 JSONArray지우기
   * 영화 등록 (영화진흥위원회 OpenAPI) 
   * @return
   * @throws OpenAPIFault
   * @throws Exception
   */
 /*  
  //http://localhost:9090/movie/movie/create.do
   @RequestMapping(value="/movie/create.do", method=RequestMethod.GET)
   public ModelAndView createmovie() throws OpenAPIFault, Exception {
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/movie");  
     
     // 영화 공공데이터 코드 영역  
    
    //64650개
     String curPage = "2"; //(1~2)
     String itemPerPage = "32479"; //32325
     String movieNm = "";
     String directorNm = "";
     String openStartDt = "";
     String openEndDt = "";
     String prdtStartYear = "";
     String prdtEndYear = "";  
     String repNationCd = "";
     String[] movieTypeCdArr = null;
     
     String key = "e9d0301005f12bb578caf805757ad88f"; //9de93e5e1641da0a8dd8b79af11c0a74
         
     KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
    
     String movieList = service.getMovieList(true, curPage, itemPerPage, movieNm, directorNm,
         openStartDt, openEndDt, prdtStartYear, prdtEndYear, repNationCd, movieTypeCdArr); 
     //System.out.println(movieList);
     
     movieList = "{" + movieList.substring(54, movieList.length()-2);
     //System.out.println(movieList);
     
     JSONParser parser = new JSONParser();
     JSONObject jsonobj = (JSONObject)parser.parse(movieList);
     
     JSONArray jsonarray = (JSONArray)jsonobj.get("movieList"); 
     
     MovieVO movieVO = new MovieVO();  
     for (int i=0 ; i < jsonarray.size() ; i++) {
       JSONObject movieInfo = (JSONObject) jsonarray.get(i);
      
       //영화코드, 영화제목, 영화영어제목, 개봉연도, 제작연도, 국가명, 장르, 감독
       movieVO.setMovieCd(movieInfo.get("movieCd").toString());
       movieVO.setMovieNm(movieInfo.get("movieNm").toString());
      
       if( movieInfo.get("movieNmEn") != null) {
         movieVO.setMovieNmEn(movieInfo.get("movieNmEn").toString());
       } else {
         movieVO.setMovieNmEn("");
       } 
       
       if( movieInfo.get("openDt") != null) {
         movieVO.setOpenDt(movieInfo.get("openDt").toString());
         } else {
           movieVO.setOpenDt(""); 
         }
      
       if( movieInfo.get("prdtYear") != null) {
         movieVO.setPrdtYear(movieInfo.get("prdtYear").toString());
       } else { 
         movieVO.setPrdtYear("");
       }
       movieVO.setRepNationNm(movieInfo.get("nationAlt").toString());
       
       if(movieInfo.get("genreAlt")!= null){
         movieVO.setGenre(movieInfo.get("genreAlt").toString());
       }else{
         movieVO.setGenre("");
       }
       
       if(movieInfo.get("directors")!= null){
         JSONArray jsonarray1 = (JSONArray)movieInfo.get("directors");  
         if(jsonarray1.isEmpty()){
           movieVO.setDirector("");
         }else{
           JSONObject directors = (JSONObject) jsonarray1.get(0);
           String peopleNm = directors.get("peopleNm").toString();
           movieVO.setDirector(peopleNm);
         }
       }else{
         movieVO.setDirector("");
       }
       
       
       movieProc.create(movieVO);
      }  
     System.out.println("json 호출2"); 
     // ---------------------------------------------------------------------------------------- 
      //영화 공공데이터 코드 영역 끝   
    
     return mav; 
   } */
   
   /**
    * 영화 추가정보 입력 (영화진흥위원회 OpenAPI) 
    * @return
    * @throws OpenAPIFault
    * @throws Exception
    */
  /* 
   //http://localhost:9090/movie/movie/update.do
   @RequestMapping(value="/movie/update.do", method=RequestMethod.GET)
   public ModelAndView updatemovie() throws OpenAPIFault, Exception {
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/movie");  
     
     // 영화 공공데이터 코드 영역  
     MovieVO movieVO = new MovieVO();
      
     String key = "5e16e72330b5f73333cc569f154e0dff"; 
     // e9d0301005f12bb578caf805757ad88f  / 9de93e5e1641da0a8dd8b79af11c0a74 / d4c65a608cd98b2bd81102d1dd45b350
     // 5e16e72330b5f73333cc569f154e0dff  / c10b76fceeea766770018eedd309b999  / 03d5f814faca9ecd5eef8fe5955ac5c9
     KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
     
       
     // DBMS ( 모든 영화 코드 조회)
     List<MovieVO> codeList = movieProc.codeList();
     //System.out.println("리스트사이즈 : "+ codeList.size());
     
     for (int i = 0; i < codeList.size(); i++) { // 영화 코드 하나씩 반복 

       String movieCd = codeList.get(i).getMovieCd();
       String movieList = service.getMovieInfo(true, movieCd); // 영화코드별 영화 상세내용 가져오기(영화시간, 관람가)

       //System.out.println("movieList : " + movieList);
       
       if(movieList.length() > 100){
       
       movieList = "{" + movieList.substring(54, movieList.length() - 22); // JSON 문자열 형태로 가공

       //System.out.println("select 호출 : " + movieList); 

       JSONParser parser = new JSONParser();
       JSONObject movieInfo = (JSONObject) parser.parse(movieList); // 문자열 -> JSONObject 변환
       
       //상영시간
       if(movieInfo.get("showTm") != null) {
         movieVO.setShowTm(movieInfo.get("showTm").toString());
       } else {
         movieVO.setShowTm(""); 
       }
       
       //관람가
       if (movieInfo.get("audits") != null ) { // audits는 JSONArray 형태이므로 분리가 필요함.
         JSONArray jsonarray = (JSONArray)movieInfo.get("audits");  
         if(jsonarray.isEmpty()){
           movieVO.setWatchGradeNm("");
           }else{
             JSONObject audit = (JSONObject)jsonarray.get(0);  // 결과는 1개이므로 인덱스는 '0' 고정
             String watchGradeNm = audit.get("watchGradeNm").toString(); 
             movieVO.setWatchGradeNm(watchGradeNm);
           }
         } else {
         movieVO.setWatchGradeNm("");
       }
       
       //배우
       if(movieInfo.get("actors")!= null){
         JSONArray jsonarray = (JSONArray)movieInfo.get("actors");  
         if(jsonarray.isEmpty()){
           movieVO.setActors("");
         }else{
           String actor ="";
           for(int j = 0; j<jsonarray.size(); j++){
             JSONObject audit = (JSONObject)jsonarray.get(j); 
             
             if(audit.get("cast").equals(null)  || audit.get("cast").equals("") ){
               actor += audit.get("peopleNm").toString()+", ";
             }else{
               actor += audit.get("peopleNm").toString() + "("+ audit.get("cast")+"), ";
             }
           }
           String actor1 = actor.substring(0, actor.length()-2); 
           movieVO.setActors(actor1);
         }
       }
       
       //25000
       movieVO.setMovieCd(movieCd);
        
       // DBMS (영화 추가정보 입력)
       movieProc.update(movieVO);
      }
     } 
     System.out.println("수정완료!");
     return mav; 
   }
   */
  
  /**
   * 박스오피스 (영화진흥위원회 OpenAPI) 
   * @return
   * @throws OpenAPIFault
   * @throws Exception
   */
  /*
   //http://localhost:9090/movie/movie/boxOffice.do
   @RequestMapping(value="/movie/boxOffice.do", method=RequestMethod.GET)
   public ModelAndView create() throws OpenAPIFault, Exception {
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/movie/boxOffice");  
     
  
     // 영화 공공데이터 코드 영역  
    
     String targetDt = "20180729"; //yyyymmdd
     String weekGb = "0"; // 0-주간 / 1-주말 / 2-주중
     String itemPerPage = "10";
     String multiMovieYn = "";
     String repNationCd = "";
     String wideAreaCd = "";
     
     String key = "5e16e72330b5f73333cc569f154e0dff";
         
     KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
    
     String boxOfficeList = service.getWeeklyBoxOffice(true, targetDt, itemPerPage, weekGb, multiMovieYn, repNationCd, wideAreaCd);
       
     //System.out.println(boxOfficeList);
     
     boxOfficeList = boxOfficeList.substring(19, boxOfficeList.length()-2);
     //System.out.println(boxOfficeList);
     
     JSONParser parser = new JSONParser();
     JSONObject jsonobj = (JSONObject)parser.parse(boxOfficeList);
     
     JSONArray jsonarray = (JSONArray)jsonobj.get("weeklyBoxOfficeList"); 
     
     BoxOfficeVO  boxOfficeVO = new BoxOfficeVO();
     
     for (int i=0 ; i < jsonarray.size() ; i++) {
       JSONObject boxOfficeInfo = (JSONObject) jsonarray.get(i);
       //System.out.println( "boxOfficeInfo "+ i + " : " + boxOfficeInfo);
       
       boxOfficeVO.setMovieCd(boxOfficeInfo.get("movieCd").toString());
       boxOfficeVO.setMovieNm(boxOfficeInfo.get("movieNm").toString());
       boxOfficeVO.setOpenDt(boxOfficeInfo.get("openDt").toString());
       boxOfficeVO.setAudiAcc(boxOfficeInfo.get("audiAcc").toString());
       
       boxOfficeVO.setRank(i+1);
       
       movieProc.boxOffice_update(boxOfficeVO);
     }
     
      
       return mav; 
   } */
   
   // 박스오피스 목록
   @RequestMapping(value="/movie/mainbo_list.do", method=RequestMethod.GET)
   public ModelAndView mainbo_list() {
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/movie/mainbox_list");  
     
     List<MainBoxOfficeVO> mainbo_list = movieProc.mainbo_list();
     mav.addObject("list", mainbo_list);
     return mav;
   }
   
   //인덱스 박스오피스 그리드
   @RequestMapping(value="/movie/box_grid.do", method=RequestMethod.GET)
   public ModelAndView box_grid() {
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/movie/box_grid");  
     
     List<MainBoxOfficeVO> mainbo_list = movieProc.mainbo_list();
     mav.addObject("list", mainbo_list);
     return mav;
   }
   
  
   //영화 상세보기
   @RequestMapping(value="/movie/read.do", method=RequestMethod.GET)
   public ModelAndView read(String movieCd, HttpSession session)  {
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/movie_detail/movie_detail");  
     
     //System.out.println("movie/read.do"); 
     MovieVO movieVO = movieProc.a_movieread(movieCd);
     mav.addObject("movieVO",movieVO);
     
     //영화별 댓글 갯수
     int mcc = movieProc.mcc(movieCd);
     mav.addObject("mcc", mcc);
     
     //영화별 댓글 평점 합
     if(mcc != 0){
       int sum = movieProc.grade_sum(movieCd);
       
       //영화별 회원의 평점 평균
       double avg_grade = (double)sum/(double)mcc; 
       mav.addObject("avg_grade", avg_grade);
     }
     
     
     /*좋아요 갯수*/
     int like_count = movieProc.like_count(movieCd);
     mav.addObject("like_count", like_count);
     
     /*좋아요 체크 확인*/
     int memberno = (int) session.getAttribute("memberno");
     HashMap<String, Object> hashMap = new HashMap<String, Object>();
     hashMap.put("movieCd", movieCd);              
     hashMap.put("memberno", memberno);
     int like_check = movieProc.a_like_count(hashMap);
     if(like_check == 1){ // 좋아요를 누른적이 있다면
       MovielikeVO movielikeVO = movieProc.like_read(hashMap);
       like_check = movielikeVO.getLike_check();
     }else{
       like_check = 0;
     }
     mav.addObject("like_check", like_check);
     /*좋아요 체크 확인 끝*/

     //회원의 영화 댓글 갯수 확인(한번만 쓰게 하기 위해)
     int mc_check = movieProc.mc_check(hashMap);
     mav.addObject("mc_check",mc_check);
     
     
     
     String actors = movieVO.getActors();
     //System.out.println(actors); 
     
     if(movieVO.getActors()!= "null"){
       String actor1[] = actors.split(", ");
       mav.addObject("actor", actor1); 
     }

     
   /*  for(String s:actor){
       System.out.println(s);  
       mav.addObject("actor" , s);
     }  */
     return mav;
   }  
   
 //영화 보고싶어요
   @ResponseBody
   @RequestMapping(value="/movie/like.do", produces="application/json; charset=utf8", method=RequestMethod.GET)
   public String like(String movieCd, HttpSession session){
     
     int memberno = (int) session.getAttribute("memberno");
     JSONObject obj = new JSONObject();
     
     ArrayList<String> msgs = new ArrayList<String>();
     HashMap<String, Object> hashMap = new HashMap<String, Object>();
     hashMap.put("movieCd", movieCd);
     hashMap.put("memberno", memberno);
       
     int like_check = 0;
     
     if(movieProc.a_like_count(hashMap) == 0){ // 해당영화의 좋아요 처음 눌렀다면
       movieProc.like_create(hashMap); // 좋아요 생성
     }else{ // 해당영화의 좋아요 누른적이 있다면
       MovielikeVO movielikeVO = movieProc.like_read(hashMap);
       
       if(movielikeVO.getLike_check() == 1){ // 취소
         movieProc.like_check_cancel(hashMap);
         like_check = 0;
       }else if(movielikeVO.getLike_check() == 0){
         movieProc.like_check(hashMap);
         like_check = 1;
       }
     }
     
     int like_count = movieProc.like_count(movieCd);
     
     obj.put("like_count", like_count);
     obj.put("like_check", like_check);
     
     return obj.toString();
    }
  
  //관리자 영화 목록(전체 페이징x)
  @RequestMapping(value="/movie/a_movielist.do", method=RequestMethod.GET)
  public ModelAndView a_movielist()  {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/movie/list");  
    
    List<MovieVO> list = movieProc.a_movielist();
    
    mav.addObject("list",list);
    
    return mav;
  }
  
  //관리자 영화 한 건 조회
  @RequestMapping(value="/movie/a_movieread.do", method=RequestMethod.GET)
  public ModelAndView a_movieread(String movieCd)  {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/movie/a_read");  
    
    MovieVO movieVO = movieProc.a_movieread(movieCd);
    mav.addObject("movieVO",movieVO);
    
    return mav;
  }
  
//영화 수정 폼
  @RequestMapping(value="/movie/a_movieupdate.do", method = RequestMethod.GET)
 public ModelAndView update(String movieCd) {
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/movie/a_update"); 

   MovieVO movieVO = movieProc.a_movieupdate(movieCd);
   mav.addObject("movieVO", movieVO);

   return mav;
 }
  
  //관리자 영화 수정 처리
  @RequestMapping(value="/movie/a_movieupdate.do", method=RequestMethod.POST)
  public ModelAndView a_movieupdate(HttpServletRequest request, MovieVO movieVO)  {
  
    //System.out.println("--> a_movieupdate.do!!!!");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/movie/a_message");
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    String movieCd = movieVO.getMovieCd();
    
    // -----------------------------파일 전송----------------------------------------------
    
   /* <input type="file" class="form-control input-lg" name='moiveImgMF' id='moiveImgMF' >
    ↓
     name='moiveImgMF'에 해당하는 필드를 찾아서 File 객체를 자동으로 할당
    ↓
    MovieVO.java: private MultipartFile moiveImgMF;
    ↓
     파일 객체 사용: MultipartFile moiveImgMF = movieVO.getMoiveImgMF();          
     */
    
    String upDir = Tool.getRealPath(request, "/movie/storage");
    MultipartFile movieImgMF = movieVO.getMovieImgMF();
    String movieImg = "";                    // DBMS moiveImg 컬럼의 값
    long imgSize = movieImgMF.getSize(); // 파일 크기
    String thumb = "";                 // DBMS thumb 컬럼의 값
     
    // 기존에 등록된 글 정보 로딩
    MovieVO movieVO_old = movieProc.a_movieread(movieVO.getMovieCd());
    
    //System.out.println("movieVO_old" + movieVO_old);
    
   if (imgSize > 0) { // 등록된 파일이 있다면
     Tool.deleteFile(movieVO_old.getMovieImg());
     Tool.deleteFile(movieVO_old.getThumb());
     Tool.deleteFile(upDir, movieVO_old.getMovieImg());    // 기존 파일 삭제
     Tool.deleteFile(upDir, movieVO_old.getThumb()); // 기존 Thumb 파일 삭제
    
     movieImg = Upload.saveFileSpring(movieImgMF, upDir); // 신규 파일 업로드
     
     if (Tool.isImage(movieImg)) { // 새로운 파일 이미지인지 검사
       thumb = Tool.preview(upDir, movieImg, 245, 370); // Thumb 이미지 생성
     } 
    } else {
      // 파일을 변경하지 않는 경우 기존 파일 정보 사용
      movieImg = movieVO_old.getMovieImg();
      imgSize = movieVO_old.getImgSize();
      thumb = movieVO_old.getThumb();
    } 
     
    movieVO.setMovieImg(movieImg);
    movieVO.setImgSize(imgSize);
    movieVO.setThumb(thumb);
 // -----------------------------파일 전송 종료----------------------------------------------
    
    if (movieProc.a_movieupdate(movieVO) == 1) {
      msgs.add("글을 변경했습니다.");
      links.add("<button type='button' onclick=\"location.href='./a_movieread.do?movieCd="+movieCd+"'\">변경 확인</button>");
      
    } else {
      msgs.add("글 변경에 실패했습니다.");
      msgs.add("죄송하지만 다시 한 번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
       
    }
    links.add("<button type='button' onclick=\"location.href='./a_movielist_search.do'\">목록</button>");
    
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    return mav;
    
  }  
  
  //관리자 ) 목록 + 검색(영화제목) + 페이징
  @RequestMapping(value = "/movie/a_movielist_search.do", method = RequestMethod.GET)
  public ModelAndView a_list_search(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    //System.out.println("--> a_list_search.do GET called.");
    //System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
     
    // 검색 기능 추가
    mav.setViewName("/movie/a_list_search");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Object 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("word", word);              
    hashMap.put("nowPage", nowPage);       
    
    // 검색 목록
    List<MovieVO> list = movieProc.a_list_search(hashMap);
    //System.out.println( "리스트 사이즈 : "+list.size());
    mav.addObject("list", list);
      
    // 검색된 레코드 갯수
    int asearch_count = movieProc.asearch_count(hashMap);
    mav.addObject("asearch_count", asearch_count);


    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = movieProc.apaging(asearch_count, nowPage, word);
    mav.addObject("paging", paging);
 
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  //메인메뉴 ) 목록 + 검색(영화제목) + 페이징
  @RequestMapping(value = "/movie/main_movie.do", method = RequestMethod.GET)
  public ModelAndView main_movie(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      @RequestParam(value="col", defaultValue="") String col
      ) { 
    //System.out.println("--> a_list_search.do GET called.");
    //System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
     
    // 검색 기능 추가
    mav.setViewName("/movie/main_movie");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Object 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("word", word);              
    hashMap.put("nowPage", nowPage);       
    hashMap.put("col", col);       
    
    // 검색 목록
    List<MovieVO> list = movieProc.main_movie(hashMap);
    //System.out.println( "리스트 사이즈 : "+list.size());
    mav.addObject("list", list);
      
    // 검색된 레코드 갯수
    int search_count = movieProc.search_count(hashMap);
    mav.addObject("search_count", search_count);


    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = movieProc.paging(search_count, nowPage, col, word);
    mav.addObject("paging", paging);
 
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
//장르메뉴 ) 목록 + 검색(영화제목) + 페이징
  @RequestMapping(value = "/movie/main_movie_genre.do", method=RequestMethod.GET)
  public ModelAndView main_movie_genre(
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      String genre) { 
    
    //System.out.println("장르 controller에 들어옴");
    ModelAndView mav = new ModelAndView();
     
    // 검색 기능 추가
    mav.setViewName("/movie/main_movie_genre");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Object 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("genre", genre);              
    hashMap.put("nowPage", nowPage);       
    
    // 검색 목록
    List<MovieVO> list = movieProc.list_search_genre(hashMap);
    //System.out.println( "리스트 사이즈 : "+list.size());
    mav.addObject("list", list);
      
    //System.out.println("검색하고 나옴.");
    
    // 검색된 레코드 갯수
    int search_count = movieProc.search_count_genre(hashMap);
    mav.addObject("search_count", search_count);

    //System.out.println("search_count : "+ search_count);
    
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열*/
      
    String paging = movieProc.paging_genre(search_count, nowPage, genre);
    mav.addObject("paging", paging);
 
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  
  //회원별 보고싶어요 페이징
  @RequestMapping(value = "/movie/moviebucket.do", method = RequestMethod.GET)
  public ModelAndView moviebucket(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      HttpSession session
      ) { 
    //System.out.println("--> a_list_search.do GET called.");
    //System.out.println("--> nowPage: " + nowPage);
    int memberno = (int) session.getAttribute("memberno");
    
    ModelAndView mav = new ModelAndView();
     
    // 검색 기능 추가
    mav.setViewName("/movie/m_moviebucket");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Object 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("word", word);              
    hashMap.put("nowPage", nowPage);    
    hashMap.put("memberno", memberno);  
    
    // 검색 목록
    List<MoviebucketVO> list = movieProc.moviebucket(hashMap);
    mav.addObject("list", list);
      
    // 검색된 레코드 갯수
    int mbc = movieProc.mbc(hashMap);
    mav.addObject("mbc", mbc);


    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = movieProc.apaging(mbc, nowPage, word);
    mav.addObject("paging", paging);
 
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }

  
}
