package dev.mvc.movie;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import dev.mvc.movie.comment.MovieNmVO;
import dev.mvc.review.Review;
import dev.mvc.tool.Tool;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;


@Component("dev.mvc.movie.MovieProc")
public class MovieProc implements MovieProcInter {
  @Autowired
  @Qualifier("dev.mvc.movie.MovieDAO")
  private MovieDAOInter movieDAO = null;
  
  public MovieProc() { 
    //System.out.println("--> MoiveProc Created.");
  }
   
  //영화넣기(open api)
  @Override
  public int create(MovieVO movieVO) {
    int count = movieDAO.create(movieVO);
    return count;
  }

  //영화코드 목록
  @Override
  public List<MovieVO> codeList() {
    List<MovieVO> codeList = movieDAO.codeList();
    return codeList;
  }

  //영화 수정(open api)
  @Override
  public int update(MovieVO movieVO) {
    int count = movieDAO.update(movieVO);
    return count;
  }

  //관리자 영화 목록
  @Override
  public List<MovieVO> a_movielist() {
    List<MovieVO> list = movieDAO.a_movielist();
    return list;
  }  
  
  //관리자 영화 한 건 조회
  @Override
  public MovieVO a_movieread(String movieCd){
    MovieVO movieVO = movieDAO.a_movieread(movieCd);
    return movieVO;
  }
  
  //관리자 영화 수정 폼
  @Override
  public MovieVO a_movieupdate(String movieCd){
    MovieVO movieVO = movieDAO.a_movieread(movieCd);
    return movieVO;
  }
  
  // 관리자 영화 수정 처리
  @Override
  public int a_movieupdate(MovieVO movieVO){
    int count = movieDAO.a_movieupdate(movieVO);
    return count;
  }
  
  //관리자) 영화 목록
  @Override
  public List<MovieVO> a_list_search(HashMap hashMap) {
    /* 
     페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
     1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
     2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
     3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Movies.RECORD_PER_PAGE;
    
     // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
    int endNum = beginOfPage + Movies.RECORD_PER_PAGE;   
    /*
     1 페이지: WHERE r >= 1 AND r <= 10
     2 페이지: WHERE r >= 11 AND r <= 20
     3 페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<MovieVO> list = movieDAO.a_list_search(hashMap); 
    Iterator<MovieVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      MovieVO movieVO = iter.next();
      String movieNm = Tool.textLength(movieVO.getMovieNm(), 90);
      movieNm = Tool.convertChar(movieNm); // 태그 처리
      movieVO.setMovieNm(movieNm);
    }
    
    return list;
  }
  
  //관리자) 검색된 레코드 갯수
  @Override
  public int asearch_count(HashMap hashMap) {
    int cnt = movieDAO.asearch_count(hashMap);
    return cnt;
  }
  
  /** 
   * 관리자)목록 + 검색(영화제목) + 페이징
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
 @Override
  public String apaging(int asearch_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)asearch_count/Movies.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Movies.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Movies.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Movies.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Movies.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; margin-bottom:5px; font-size: 1.1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:#aaaaaa; font-size: 1.1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color: #aaaaaa; font-size: 1.1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color: #aaaaaa; font-size: 1.1em;}"); 
    str.append("  .span_box_1{");  
    str.append("    text-align: center;");    
    str.append("    font-size: 1.1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #aaaaaa;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); //선택
    str.append("    text-align: center;");     
    str.append("    background-color: #31106D;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1.2em;"); 
    str.append("    border: 1px;");  
    str.append("    border-style: solid;");  
    str.append("    border-color: #31106D;");  
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
   //str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동 
    //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
    // 현재 2 그룹인 경우 : (2-1)*10 = 1그룹의 10
    // 현재 3 그룹인 경우 : (3-1)*10 = 2 그룹의 10
    int _nowPage = (nowGrp-1) * Movies.PAGE_PER_BLOCK; 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./a_movielist_search.do?word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./a_movielist_search.do?word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 
     
 // 10개 다음 페이지로 이동 
    //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
    // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
    // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
    _nowPage = (nowGrp * Movies.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./a_movielist_search.do.do?word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

 /**
  * 메인메뉴 )목록 + 검색(영화제목) + 페이징
  * <Xmp>
  * <select id="main_movie" resultType="MovieVO" parameterType="HashMap">
  * </Xmp>
  * @param hashMap
  * @return
  */
 public List<MovieVO> main_movie(HashMap hashMap){
   /* 
   페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
   1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
   2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
   3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
   */
  int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Movies.RECORD_PER_PAGE;
  
   // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
  int startNum = beginOfPage + 1; 
  //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
  int endNum = beginOfPage + Movies.RECORD_PER_PAGE;   
  /*
   1 페이지: WHERE r >= 1 AND r <= 10
   2 페이지: WHERE r >= 11 AND r <= 20
   3 페이지: WHERE r >= 21 AND r <= 30
   */
  hashMap.put("startNum", startNum);
  hashMap.put("endNum", endNum);
  
  List<MovieVO> list = movieDAO.main_movie(hashMap); 
  Iterator<MovieVO> iter = list.iterator();
  
  while(iter.hasNext() == true) {
    MovieVO movieVO = iter.next();
    String movieNm = Tool.textLength(movieVO.getMovieNm(), 90);
    movieNm = Tool.convertChar(movieNm); // 태그 처리
    movieVO.setMovieNm(movieNm);
    } 
  
  return list;
 }
 
 //메인메뉴) 검색된 레코드 갯수
 @Override
 public int search_count(HashMap hashMap) {
   int cnt = movieDAO.search_count(hashMap);
   return cnt;
 }
 
 /** 
  * 목록 + 검색(영화제목) + 페이징(메인메뉴)
  * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
  * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
  *
  * @param search_count 검색(전체) 레코드수 
  * @param nowPage     현재 페이지
  * @param word 검색어
  * @return 페이징 생성 문자열
  */ 
@Override
 public String paging(int search_count, int nowPage, String col, String word){ 
   int totalPage = (int)(Math.ceil((double)search_count/Movies.RECORD_PER_PAGE)); // 전체 페이지  
   int totalGrp = (int)(Math.ceil((double)totalPage/Movies.PAGE_PER_BLOCK));// 전체 그룹 
   int nowGrp = (int)(Math.ceil((double)nowPage/Movies.PAGE_PER_BLOCK));    // 현재 그룹 
   int startPage = ((nowGrp - 1) * Movies.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
   int endPage = (nowGrp * Movies.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
    
   StringBuffer str = new StringBuffer(); 
    
   str.append("<style type='text/css'>"); 
   str.append("  #paging {text-align: center; margin-top: 5px; margin-bottom:5px; font-size: 1.1em;}"); 
   str.append("  #paging A:link {text-decoration:none; color:#aaaaaa; font-size: 1.1em;}"); 
   str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color: #aaaaaa; font-size: 1.1em;}"); 
   str.append("  #paging A:visited {text-decoration:none;color: #aaaaaa; font-size: 1.1em;}"); 
   str.append("  .span_box_1{");  
   str.append("    text-align: center;");    
   str.append("    font-size: 1.1em;"); 
   str.append("    border: 1px;"); 
   str.append("    border-style: solid;"); 
   str.append("    border-color: #aaaaaa;"); 
   str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
   str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
   str.append("  }"); 
   str.append("  .span_box_2{"); //선택
   str.append("    text-align: center;");     
   str.append("    background-color: #31106D;"); 
   str.append("    color: #FFFFFF;"); 
   str.append("    font-size: 1.2em;"); 
   str.append("    border: 1px;");  
   str.append("    border-style: solid;");  
   str.append("    border-color: #31106D;");  
   str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
   str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
   str.append("  }"); 
   str.append("</style>"); 
   str.append("<DIV id='paging'>"); 
  //str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

   // 이전 10개 페이지로 이동 
   //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
   // 현재 2 그룹인 경우 : (2-1)*10 = 1그룹의 10
   // 현재 3 그룹인 경우 : (3-1)*10 = 2 그룹의 10
   int _nowPage = (nowGrp-1) * Movies.PAGE_PER_BLOCK; 
   if (nowGrp >= 2){ 
     str.append("<span class='span_box_1'><A href='./main_movie.do?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
   } 

   for(int i=startPage; i<=endPage; i++){ 
     if (i > totalPage){ 
       break; 
     } 
 
     if (nowPage == i){ 
       str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
     }else{
       // 현재 페이지가 아닌 페이지
       str.append("<span class='span_box_1'><A href='./main_movie.do?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
     } 
   } 
    
// 10개 다음 페이지로 이동 
   //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
   // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
   // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
   _nowPage = (nowGrp * Movies.PAGE_PER_BLOCK)+1; 
   if (nowGrp < totalGrp){ 
     str.append("<span class='span_box_1'><A href='./main_movie.do?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
   } 
   str.append("</DIV>"); 
    
   return str.toString(); 
 }

//장르) 검색된 레코드 갯수
@Override
public int search_count_genre(HashMap hashMap) {
int cnt = movieDAO.search_count_genre(hashMap);
return cnt;
}

/**
 * 장르 )장르목록 + 검색(영화제목) + 페이징
 * <Xmp>
 * <select id="main_movie_genre" resultType="MovieVO" parameterType="HashMap">
 * </Xmp>
 * @param hashMap
 * @return
 */
public List<MovieVO> list_search_genre(HashMap hashMap){
  /* 
  페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
  1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
  2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
  3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
  */
 int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Movies.RECORD_PER_PAGE;
 
  // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
 int startNum = beginOfPage + 1; 
 //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
 int endNum = beginOfPage + Movies.RECORD_PER_PAGE;   
 /*
  1 페이지: WHERE r >= 1 AND r <= 10
  2 페이지: WHERE r >= 11 AND r <= 20
  3 페이지: WHERE r >= 21 AND r <= 30
  */
 hashMap.put("startNum", startNum);
 hashMap.put("endNum", endNum);
 
 List<MovieVO> list = movieDAO.list_search_genre(hashMap); 
 Iterator<MovieVO> iter = list.iterator();
 
 while(iter.hasNext() == true) {
   MovieVO movieVO = iter.next();
   String movieNm = Tool.textLength(movieVO.getMovieNm(), 90);
   movieNm = Tool.convertChar(movieNm); // 태그 처리
   movieVO.setMovieNm(movieNm);
   } 
 
 return list;
}

/** 
 * 목록 + 검색(영화장르) + 페이징(메인메뉴)
 * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
 * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
 *
 * @param search_count 검색(전체) 레코드수 
 * @param nowPage     현재 페이지
 * @param genre 검색어
 * @return 페이징 생성 문자열
 */ 
@Override
public String paging_genre(int search_count, int nowPage, String genre){ 
  int totalPage = (int)(Math.ceil((double)search_count/Movies.RECORD_PER_PAGE)); // 전체 페이지  
  int totalGrp = (int)(Math.ceil((double)totalPage/Movies.PAGE_PER_BLOCK));// 전체 그룹 
  int nowGrp = (int)(Math.ceil((double)nowPage/Movies.PAGE_PER_BLOCK));    // 현재 그룹 
  int startPage = ((nowGrp - 1) * Movies.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
  int endPage = (nowGrp * Movies.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
   
  StringBuffer str = new StringBuffer(); 
   
  str.append("<style type='text/css'>"); 
  str.append("  #paging {text-align: center; margin-top: 5px; margin-bottom:5px; font-size: 1.1em;}"); 
  str.append("  #paging A:link {text-decoration:none; color:#aaaaaa; font-size: 1.1em;}"); 
  str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color: #aaaaaa; font-size: 1.1em;}"); 
  str.append("  #paging A:visited {text-decoration:none;color: #aaaaaa; font-size: 1.1em;}"); 
  str.append("  .span_box_1{");  
  str.append("    text-align: center;");    
  str.append("    font-size: 1.1em;"); 
  str.append("    border: 1px;"); 
  str.append("    border-style: solid;"); 
  str.append("    border-color: #aaaaaa;"); 
  str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
  str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
  str.append("  }"); 
  str.append("  .span_box_2{"); //선택
  str.append("    text-align: center;");     
  str.append("    background-color: #31106D;"); 
  str.append("    color: #FFFFFF;"); 
  str.append("    font-size: 1.2em;"); 
  str.append("    border: 1px;");  
  str.append("    border-style: solid;");  
  str.append("    border-color: #31106D;");  
  str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
  str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
  str.append("  }"); 
  str.append("</style>"); 
  str.append("<DIV id='paging'>"); 
 //str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

  // 이전 10개 페이지로 이동 
  //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
  // 현재 2 그룹인 경우 : (2-1)*10 = 1그룹의 10
  // 현재 3 그룹인 경우 : (3-1)*10 = 2 그룹의 10
  int _nowPage = (nowGrp-1) * Movies.PAGE_PER_BLOCK; 
  if (nowGrp >= 2){ 
    str.append("<span class='span_box_1'><A href='./main_movie_genre.do?genre="+genre+"&nowPage="+_nowPage+"'>이전</A></span>"); 
  } 

  for(int i=startPage; i<=endPage; i++){ 
    if (i > totalPage){ 
      break; 
    } 

    if (nowPage == i){ 
      str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
    }else{
      // 현재 페이지가 아닌 페이지
      str.append("<span class='span_box_1'><A href='./main_movie_genre.do?genre="+genre+"&nowPage="+i+"'>"+i+"</A></span>");   
    } 
  } 
   
//10개 다음 페이지로 이동 
  //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
  // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
  // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
  _nowPage = (nowGrp * Movies.PAGE_PER_BLOCK)+1; 
  if (nowGrp < totalGrp){ 
    str.append("<span class='span_box_1'><A href='./main_movie_genre.do?genre="+genre+"&nowPage="+_nowPage+"'>다음</A></span>"); 
  } 
  str.append("</DIV>"); 
   
  return str.toString(); 
}


  //영화별 댓글 갯수
  public int mcc(String movieCd){
    int cnt = movieDAO.mcc(movieCd);
    return cnt;
  }
  
  
  //박스오피스 리스트
  @Override
  public List<BoxOfficeVO> boxOffice_List() {
    List<BoxOfficeVO> boxOffice_List = movieDAO.boxOffice_List();
    return boxOffice_List;
  }
  
  //박스오피스 영화 한 건 조회
  @Override
  public BoxOfficeVO boxOffice_Read(int rank){
    BoxOfficeVO boxOfficeVO = movieDAO.boxOffice_Read(rank);
    return boxOfficeVO;
  }
  
  //박스오피스 업데이트
  @Override
  public int boxOffice_update(BoxOfficeVO boxOfficeVO) {
    int count = movieDAO.boxOffice_update(boxOfficeVO);
    return count;
  }
  
 // 메인 박스오피스 목록
  public List<MainBoxOfficeVO> mainbo_list(){
    List<MainBoxOfficeVO> list = movieDAO.mainbo_list();
    
    Iterator<MainBoxOfficeVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      MainBoxOfficeVO mainBoxOfficeVO = iter.next();
      String actors = Tool.textLength(mainBoxOfficeVO.getActors(), 40); //30자 까지 
      actors = Tool.convertChar(actors); // 태그 처리
      mainBoxOfficeVO.setActors(actors);
     }
    
    return list;
  }

 //좋아요 생성
  public int like_create(HashMap hashMap){
   int count = movieDAO.like_create(hashMap);
   return count;
  }
  
 // 좋아요 누름
  public int like_check(HashMap hashMap){
    int count = movieDAO.like_check(hashMap);
    return count;
  }
  
// 좋아요 취소
  public int like_check_cancel(HashMap hashMap){
    int count = movieDAO.like_check_cancel(hashMap);
    return count;
  }
  
 // 영화별 좋아요 갯수
  public int like_count(String movieCd){
    int count = movieDAO.like_count(movieCd);
    return count;
  }
  
 //좋아요 한 건 조회
  @Override
  public MovielikeVO like_read(HashMap hashMap){
    MovielikeVO movielikeVO = movieDAO.like_read(hashMap);
    return movielikeVO;
  }
  
 // 회원의 영화별 좋아요 체크 확인
  public int a_like_count(HashMap hashMap){
    int count = movieDAO.a_like_count(hashMap);
    return count;
  }
  

  
  //회원별 보고싶어요 카운트
  public int mbc(HashMap hashMap){
    int cnt = movieDAO.mbc(hashMap);
    return cnt;
  }

  //회원별 보고싶어요 목록
  public List<MoviebucketVO> moviebucket(HashMap hashMap){
    
    /*
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Movies.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Movies.RECORD_PER_PAGE;   
   /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   hashMap.put("startNum", startNum);
   hashMap.put("endNum", endNum);
   
    List<MoviebucketVO> list = movieDAO.moviebucket(hashMap);
    return list;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 (전체)
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param mbc 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String mpaging(int mbc, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)mbc/Movies.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Movies.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Movies.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Movies.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Movies.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; margin-bottom:5px; font-size: 1.1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:#31106D; font-size: 1.1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color: #31106D; font-size: 1.1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color: #31106D; font-size: 1.1em;}"); 
    str.append("  .span_box_1{");  
    str.append("    text-align: center;");    
    str.append("    font-size: 1.1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #31106D;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); //선택
    str.append("    text-align: center;");     
    str.append("    background-color: #31106D;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1.2em;"); 
    str.append("    border: 1px;");  
    str.append("    border-style: solid;"); 
    str.append("    border-color: #31106D;");  
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
   //str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동 
    //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
    // 현재 2 그룹인 경우 : (2-1)*10 = 1그룹의 10
    // 현재 3 그룹인 경우 : (3-1)*10 = 2 그룹의 10
    int _nowPage = (nowGrp-1) * Review.PAGE_PER_BLOCK; 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./all_list_search.do?word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./all_list_search.do?word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 
     
 // 10개 다음 페이지로 이동 
    //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
    // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
    // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
    _nowPage = (nowGrp * Movies.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./all_search.do?&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  /**
   * 회원의 영화 댓글 갯수 확인
   * <Xmp>
   * <select id="mc_check" resultType="int"  parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public int mc_check(HashMap hashMap){
    int cnt = movieDAO.mc_check(hashMap);
    return cnt;
  }
  
  /**
   * 영화별 영화평점 합
   *  <Xmp>
   * <select id="grade_sum" resultType="int" parameterType="String">
   *  </Xmp>
   * @param movieCd
   * @return
   */
  public int grade_sum(String movieCd){
    int sum = movieDAO.grade_sum(movieCd);
    return sum;
  }
  
}
