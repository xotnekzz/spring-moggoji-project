package dev.mvc.review;

import java.util.HashMap;
import java.util.List;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.review.ReviewProc")
public class ReviewProc implements ReviewProcInter {
  
  @Autowired
  @Qualifier("dev.mvc.review.ReviewDAO")
  ReviewDAOInter reviewDAO = null;
 
  public ReviewProc() {
    //System.out.println("--> ReviewProc Created...");
  }
  
  /**
   *  리뷰 등록
   * <Xmp>
   *  <insert id="create" parameterType="ReviewVO">
   * </Xmp>
   * @param ReviewVO
   * @return 처리된 레코드 개수
   */
  @Override
  public int create(ReviewVO reviewVO) {
    int count = reviewDAO.create(reviewVO);
    return count;
  }
  
  /**
   *  목록 조회
   * <Xmp>
   *  <select id="list" resultType="ReviewVO">
   * </Xmp>
   * @return 
   */
  @Override
  public List<ReviewVO> list() {
    List<ReviewVO> list = reviewDAO.list();
    return list; 
  }

  /**
   *  한 건 조회
   * <Xmp>
   * <select id="read" resultType="ReviewVO" parameterType="int">
   * </Xmp>
   * @param reviewno 
   * @return
   */
  @Override
  public ReviewVO read(int reviewno) {
    ReviewVO reviewVO = reviewDAO.read(reviewno);
    if(reviewVO != null) { // 글을 조회했다면
      int count = reviewDAO.cnt_increase(reviewVO); // 조회수 증가
    }
    return reviewVO;
  }

  //수정폼
  @Override
  public ReviewVO update(int reviewno){
    ReviewVO reviewVO = reviewDAO.update(reviewno);
    return reviewVO;
  }
  
  /**
   * 리뷰 수정
   * <Xmp>
   * <update id="update" parameterType="ReviewVO">
   * </Xmp> 
   * @param reviewVO
   * @return
   */
  @Override
  public int update(ReviewVO reviewVO) {
    int count = reviewDAO.update(reviewVO);
    return count;
  }
  
  /**
   * 리뷰 삭제
   * <Xmp>
   * <delete id="delete" parameterType="int">
   * </Xmp>
   * @param reviewno
   * @return
   */
  @Override
  public int delete(int reviewno) {
    int count = reviewDAO.delete(reviewno);
    return count;
  } 
  
  /**
   * 목록 +검색(제목)+ 페이징(메인메뉴)
   * <Xmp>
   * <select id="all_list_search" resultType="ReviewVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  @Override
  public List<ReviewVO> all_list_search(HashMap hashMap) {
    
    /*
     페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
     1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
     2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
     3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Review.RECORD_PER_PAGE;
    
     // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
    int endNum = beginOfPage + Review.RECORD_PER_PAGE;   
    /*
     1 페이지: WHERE r >= 1 AND r <= 10
     2 페이지: WHERE r >= 11 AND r <= 20
     3 페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<ReviewVO> list = reviewDAO.all_list_search(hashMap); 
    Iterator<ReviewVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      ReviewVO reviewVO = iter.next();
      String title = Tool.textLength(reviewVO.getTitle(), 90);
      title = Tool.convertChar(title); // 태그 처리
      reviewVO.setTitle(title);
    }
    
    return list;
  }
 
  
  /**
   * 검색된 레코드 갯수
   * <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = reviewDAO.search_count(hashMap);
    return cnt;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 (전체)
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String paging(int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Review.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Review.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Review.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Review.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Review.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
    _nowPage = (nowGrp * Review.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./all_search.do?&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  
  /**
   * 목록 +검색(제목)+ 페이징(회원)
   * <Xmp>
   * <select id="m_list_search" resultType="ReviewVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  @Override
  public List<ReviewVO> m_list_search(HashMap hashMap) {
    /* 
     페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
     1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
     2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
     3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Review.RECORD_PER_PAGE;
    
     // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
    int endNum = beginOfPage + Review.RECORD_PER_PAGE;   
    /*
     1 페이지: WHERE r >= 1 AND r <= 10
     2 페이지: WHERE r >= 11 AND r <= 20
     3 페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<ReviewVO> list = reviewDAO.m_list_search(hashMap); 
    Iterator<ReviewVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      ReviewVO reviewVO = iter.next();
      String title = Tool.textLength(reviewVO.getTitle(), 90);
      title = Tool.convertChar(title); // 태그 처리
      reviewVO.setTitle(title);
    }
    
    return list;
  }
  
  /**
   * 검색된 레코드 갯수
   * <Xmp>
   * <select id="msearch_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  @Override
  public int msearch_count(HashMap hashMap) {
    int cnt = reviewDAO.msearch_count(hashMap);
    return cnt;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 (회원)
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String mpaging(int msearch_count, int nowPage, String word, int memberno){ 
    /*int memberno = (int) session.getAttribute("memberno");*/
    
    int totalPage = (int)(Math.ceil((double)msearch_count/Review.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Review.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Review.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Review.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Review.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
      str.append("<span class='span_box_1'><A href='./m_list_search.do?memberno="+memberno+"&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./m_list_search.do?memberno="+memberno+"&word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 
     
 // 10개 다음 페이지로 이동 
    //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
    // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
    // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
    _nowPage = (nowGrp * Review.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./m_list_search.do?memberno="+memberno+"&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  /**
   * 리뷰를 쓴 회원 이름
   * <Xmp>
   * <select id="mname" resultMap="MnameVO" parameterType="int">
   * </Xmp>
   * @param reviewno
   * @return
   */
  public MnameVO mname(int reviewno){
    MnameVO mnameVO = reviewDAO.mname(reviewno);
    return mnameVO;
  }

  /**
   * 리뷰별 댓글 갯수
   * <Xmp>
   * <select id="rcc" resultType="int" parameterType="int">
   * <Xmp>
   * @param reviewno
   * @return
   */
  @Override
  public int rcc(int reviewno) {
    int cnt = reviewDAO.rcc(reviewno);
    return cnt;
  }
  
}
