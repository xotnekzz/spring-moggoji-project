package dev.mvc.movie.comment;

import java.util.HashMap;
import java.util.List;


public interface McommentDAOInter {

  /**
   * 댓글 등록
   * <Xmp>
   * <insert id="create" parameterType="McommentVO">
   * </Xmp>
   *  @param RcommentVO
   *  @return 처리된 레코드 개수
   */
  public int create(McommentVO mcommentVO);
  
  /**
   * 댓글 목록
   * <Xmp>
   * <select id="list" resultType="McommentVO" parameterType="String">
   * </Xmp>
   * @return
   */
  public List<McommentVO> list(String movieCd);
  
  /**
   * 영화당 댓글 갯수
   * <Xmp>
   *  <select id="mcc" resultType="int" parameterType="String">
   *  </Xmp>
   * @param movieVO
   * @return
   */
  public int mcc(String movieCd);
  
  /**
   * 회원별 영화 댓글 갯수
   * <Xmp>
   *  <select id="m_mccount" resultType="int" parameterType="HashMap">
   *  </Xmp>
   * @param movieVO
   * @return
   */
  public int m_mccount(HashMap hashMap);
  
  
  /**
   * 회원별 영화 댓글 리스트 + 검색 + 페이징
   * <Xmp>
   * <select id="m_mclist" resultType="MovieNmVO" parameterType="HashMap">
   * </Xmp>
   * @param memberno
   * @return
   */
  public List<MovieNmVO> m_mclist(HashMap hashMap);
  
  /**
   * 회원의 영화 댓글 삭제
   * <Xmp>
   * <delete id="delete" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public int delete (HashMap hashMap);
  
  /**
   * 회원의 영화 댓글 한 건 조회
   * <Xmp>
   * <select id="read" resultType="MovieNmVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public MovieNmVO read(HashMap hashMap);
  
  /**
   * 회원의 영화 댓글 수정
   *  <Xmp>
   *  <update id="update" parameterType="movieNmVO">
   *  </Xmp>
   * @param movieNmVO
   * @return
   */
  public int update(HashMap hashMap);  
 
  /*별점 총 갯수*/
  public int star_all_count();
}
