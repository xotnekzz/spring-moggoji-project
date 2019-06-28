package dev.mvc.review.comment;

import java.util.HashMap;
import java.util.List;

public interface RcommentDAOInter {
  
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
   * <select id="list_paging" resultType="RcommentVO" parameterType="HashMap">
   * </Xmp>
   * @param reviewno
   * @return
   */
  public List<RcommentVO> list_paging(HashMap hashMap);

}
