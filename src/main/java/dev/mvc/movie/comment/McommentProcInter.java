package dev.mvc.movie.comment;

import java.util.HashMap;
import java.util.List;

public interface McommentProcInter {
  
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
   * 영화 상세 댓글 갯수
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
   * <select id="m_mclist" resultType="MovieNmVO" parameterType="int">
   * @param memberno
   * @return
   */
  public List<MovieNmVO> m_mclist(HashMap hashMap);
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param m_mccount 댓글 갯수
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @param memberno 회원번호
   * @return 페이징 생성 문자열
   */ 
  public String paging(int m_mccount, int nowPage, String word, int memberno); 
  
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
