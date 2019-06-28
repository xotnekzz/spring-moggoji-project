package dev.mvc.review.comment;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.movie.MovieVO;
import dev.mvc.movie.Movies;
import dev.mvc.tool.Tool;


@Component("dev.mvc.review.comment.RcommentProc")
public class RcommentProc implements RcommentProcInter {
  
  @Autowired
  @Qualifier("dev.mvc.review.comment.RcommentDAO")
  RcommentDAOInter rcommentDAO = null;
 
  public RcommentProc() {
    //System.out.println("--> ReviewProc Created...");
  }
  
  /**
   * 코멘트 등록
   * <Xmp>
   * <insert id="create" parameterType="RcommentVO">
   * </Xmp>
   *  @param RcommentVO
   *  @return 처리된 레코드 개수
   */
  @Override 
  public int create(RcommentVO rcommentVO){
    int count = rcommentDAO.create(rcommentVO);
    return count;
  }

  /**
   * 코멘트 목록
   * <Xmp>
   * <select id="list" resultType="RcommentVO" parameterType="int">
   * </Xmp>
   * @return
   */
 @Override
  public List<RcommentVO> list(int reviewno){
    List<RcommentVO> list = rcommentDAO.list(reviewno);
    return list;
  }
 
 /**
  * 댓글 삭제
  * <Xmp>
  * <select id="delete" parameterType="hashMap">
  * </Xmp>
  * @param hashMap
  * @return
  */
 @Override
 public int delete(HashMap hashMap){
   int count = rcommentDAO.delete(hashMap);
   return count;
 }
  
 /**
  * 댓글 카운트
  * @param reviewno
  * @return
  */
 @Override
 public int comment_count(int reviewno){
   int count = rcommentDAO.comment_count(reviewno);
   return count;
 }
 
 /**
  * 코멘트 목록 + 페이징
  * <Xmp>
  * <select id="list_paging" resultType="RcommentVO" parameterType="int">
  * </Xmp>
  * @param reviewno
  * @return
  */
 public List<RcommentVO> list_paging(HashMap hashMap){
   /* 
   페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
   1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
   2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
   3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
   */
  int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Rcomment.RECORD_PER_PAGE;
  
   // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
  int startNum = beginOfPage + 1; 
  //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
  int endNum = beginOfPage + Rcomment.RECORD_PER_PAGE;   
  /*
   1 페이지: WHERE r >= 1 AND r <= 10
   2 페이지: WHERE r >= 11 AND r <= 20
   3 페이지: WHERE r >= 21 AND r <= 30
   */
  hashMap.put("startNum", startNum);
  hashMap.put("endNum", endNum);
  
  List<RcommentVO> list = rcommentDAO.list_paging(hashMap);
  
  return list;
 }
 
 /** 
  * 목록 + 검색(영화제목) + 페이징
  * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
  * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
  *
  * @param comment_count 전체 레코드수 
  * @param nowPage     현재 페이지
  * @return 페이징 생성 문자열
  */ 
@Override
 public String paging(int comment_count, int nowPage){ 
   int totalPage = (int)(Math.ceil((double)comment_count/Rcomment.RECORD_PER_PAGE)); // 전체 페이지  
   int totalGrp = (int)(Math.ceil((double)totalPage/Rcomment.PAGE_PER_BLOCK));// 전체 그룹 
   int nowGrp = (int)(Math.ceil((double)nowPage/Rcomment.PAGE_PER_BLOCK));    // 현재 그룹 
   int startPage = ((nowGrp - 1) * Rcomment.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
   int endPage = (nowGrp * Rcomment.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
    
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
   int _nowPage = (nowGrp-1) * Rcomment.PAGE_PER_BLOCK; 
   if (nowGrp >= 2){ 
     str.append("<span class='span_box_1'><A href='./comment/list_search.do?nowPage="+_nowPage+"'>이전</A></span>"); 
   } 

   for(int i=startPage; i<=endPage; i++){ 
     if (i > totalPage){ 
       break; 
     } 
 
     if (nowPage == i){ 
       str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
     }else{
       // 현재 페이지가 아닌 페이지
       str.append("<span class='span_box_1'><A href='./comment/list_search.do?nowPage="+i+"'>"+i+"</A></span>");   
     } 
   } 
    
// 10개 다음 페이지로 이동 
   //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
   // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
   // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
   _nowPage = (nowGrp * Rcomment.PAGE_PER_BLOCK)+1; 
   if (nowGrp < totalGrp){ 
     str.append("<span class='span_box_1'><A href='./comment/list_search.do?nowPage="+_nowPage+"'>다음</A></span>"); 
   } 
   str.append("</DIV>"); 
    
   return str.toString(); 
 }


}
