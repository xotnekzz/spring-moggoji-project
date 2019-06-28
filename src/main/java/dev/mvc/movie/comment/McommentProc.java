package dev.mvc.movie.comment;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.review.Review;
import dev.mvc.review.ReviewVO;
import dev.mvc.tool.Tool;


@Component("dev.mvc.movie.comment.McommentProc")
public class McommentProc implements McommentProcInter{

  @Autowired
  @Qualifier("dev.mvc.movie.comment.McommentDAO")
  McommentDAOInter mcommentDAO = null;
 
  public McommentProc() {
    //System.out.println("--> McommentProc Created...");
  }
  
  /**
   * 댓글 등록
   * <Xmp>
   * <insert id="create" parameterType="McommentVO">
   * </Xmp>
   *  @param RcommentVO
   *  @return 처리된 레코드 개수
   */
  @Override
  public int create(McommentVO mcommentVO){
    int count = mcommentDAO.create(mcommentVO);
    return count;
  }
  
  /**
   * 댓글 목록
   * <Xmp>
   * <select id="list" resultType="McommentVO" parameterType="String">
   * </Xmp>
   * @return
   */
  @Override
  public List<McommentVO> list(String movieCd){
    List<McommentVO> list = mcommentDAO.list(movieCd);
    return list;
  }
  
  /**
   * 영화당 댓글 갯수
   * <Xmp>
   *  <select id="mcc" resultType="int" parameterType="String">
   *  </Xmp>
   * @param movieVO
   * @return
   */
  @Override
  public int mcc(String movieCd){
    int cnt = mcommentDAO.mcc(movieCd);
    return cnt;
  }

  /**
   * 회원별 영화 댓글 갯수
   * <Xmp>
   *  <select id="m_mccount" resultType="int" parameterType="int">
   *  </Xmp>
   * @param movieVO
   * @return
   */
  @Override
  public int m_mccount(HashMap hashMap) {
    int cnt = mcommentDAO.m_mccount(hashMap);
    return cnt;
  }

  /**
   * 회원별 영화 댓글 리스트
   * <select id="m_mclist" resultType="McommentVO" parameterType="HashMap">
   * @param memberno
   * @return
   */
  @Override 
  public List<MovieNmVO> m_mclist(HashMap hashMap) {
     
  /*  페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20*/
    
   int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Mcomment.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Mcomment.RECORD_PER_PAGE;   
   
   /* 1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30*/
    
   hashMap.put("startNum", startNum);
   hashMap.put("endNum", endNum);
   
   List<MovieNmVO> list = mcommentDAO.m_mclist(hashMap);
   Iterator<MovieNmVO> iter = list.iterator();
    
   while(iter.hasNext() == true) {
     MovieNmVO movieNmVO = iter.next();
     String content = Tool.textLength(movieNmVO.getContent(), 80);
     content = Tool.convertChar(content); // 태그 처리
     movieNmVO.setContent(content);
    }
    return list;
  }

  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param m_mccount 댓글 갯수
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String paging(int m_mccount, int nowPage, String word, int memberno) {
    int totalPage = (int)(Math.ceil((double)m_mccount/Mcomment.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Mcomment.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Mcomment.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Mcomment.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Mcomment.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
    int _nowPage = (nowGrp-1) * Mcomment.PAGE_PER_BLOCK; 
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./m_mclist.do?memberno="+memberno+"&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
  
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./m_mclist.do?memberno="+memberno+"&word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 
     
 // 10개 다음 페이지로 이동 
    //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
    // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
    // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
    _nowPage = (nowGrp * Mcomment.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='.m_mclist.do?memberno="+memberno+"&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  /**
   * 회원의 영화 댓글 삭제
   * <Xmp>
   * <delete id="delete" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  @Override
  public int delete (HashMap hashMap){
    int count = mcommentDAO.delete(hashMap);
    return count;
  }
  
  /**
   * 회원의 영화 댓글 한 건 조회
   * <Xmp>
   * <select id="read" resultType="MovieNmVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public MovieNmVO read(HashMap hashMap){
    MovieNmVO movieNmVO = mcommentDAO.read(hashMap);
    return movieNmVO;
  }

  /**
   * 회원의 영화 댓글 수정
   *  <Xmp>
   *  <update id="update" parameterType="movieNmVO">
   *  </Xmp>
   * @param movieNmVO
   * @return
   */
  @Override
  public int update(HashMap hashMap) {
   int count = mcommentDAO.update(hashMap);
   return count;
  }
  
  /*별점 총 갯수*/
  @Override
  public int star_all_count(){
    int count = mcommentDAO.star_all_count();
    return count;
  }
}
