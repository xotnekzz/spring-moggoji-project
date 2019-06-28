package dev.mvc.review.comment;

import java.util.HashMap;
import java.util.List;

public interface RcommentProcInter {
  
  /**
   * 댓글 등록
   * <Xmp>
   * <insert id="create" parameterType="RcommentVO">
   * </Xmp>
   *  @param RcommentVO
   *  @return 처리된 레코드 개수
   */
  public int create(RcommentVO rcommentVO);
  
  /**
   * 댓글 목록
   * <Xmp>
   * <select id="list" resultType="RcommentVO" parameterType="int">
   * </Xmp>
   * @return
   */
  public List<RcommentVO> list(int reviewno);
  
  /**
   * 댓글 삭제
   * <Xmp>
   * <select id="delete" parameterType="hashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public int delete(HashMap hashMap);
  
  /**
   * 댓글 카운트
   * @param reviewno
   * @return
   */
  public int comment_count(int reviewno);
  
  /**
   * 댓글 목록 + 페이징
   * <Xmp>
   * <select id="list_paging" resultType="RcommentVO" parameterType="hashMap">
   * </Xmp>
   * @param reviewno
   * @return
   */
  public List<RcommentVO> list_paging(HashMap hashMap);
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param nowPage     현재 페이지
   * @return 페이징 생성 문자열
   */ 
  public String paging(int comment_count, int nowPage); 

}
