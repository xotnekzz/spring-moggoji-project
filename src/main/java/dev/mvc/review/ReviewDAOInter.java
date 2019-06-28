package dev.mvc.review;

import java.util.HashMap;
import java.util.List;


public interface ReviewDAOInter {
  
  /**
   *  리뷰 등록
   * <Xmp>
   *  <insert id="create" parameterType="ReviewVO">
   * </Xmp>
   * @param ReviewVO
   * @return 처리된 레코드 개수
   */ 
  public int create(ReviewVO reviewVO);
  
  /**
   *  목록 조회
   * <Xmp>
   *  <select id="list" resultType="ReviewVO">
   * </Xmp>
   * @return 
   */ 
  public List<ReviewVO> list(); 
  
 /**
  *  한 건 조회
  * <Xmp>
  * <select id="read" resultType="ReviewVO" parameterType="int">
  * </Xmp>
  * @param reviewno 
  * @return
  */
  public ReviewVO read(int reviewno);
  
 /**
  * 조회수 증가
  * <Xmp>
  * <update id="cnt_increase" parameterType="ReviewVO">
  * </Xmp>
  * @param reviewVO
  * @return
  */
  public int cnt_increase(ReviewVO reviewVO);
  
  /**
   * 리뷰 수정폼
   * <Xmp>
   * <select id="read" resultType="ReviewVO" parameterType="int">
   * </Xmp> 
   * @param reviewno
   * @return
   */
  public ReviewVO update(int reviewno);
  
  /**
   * 리뷰 수정
   * <Xmp>
   * <update id="update" parameterType="ReviewVO">
   * </Xmp> 
   * @param reviewVO
   * @return
   */
  public int update(ReviewVO reviewVO);
  
  /**
   * 리뷰 삭제
   * <Xmp>
   * <delete id="delete" parameterType="int">
   * <Xmp>
   * @param reviewno
   * @return
   */
  public int delete(int reviewno);
  
  /**
   * 검색된 레코드 갯수
   * <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int search_count(HashMap hashMap); 
  
  /**
   * 리스트 + 검색(리뷰제목) + 페이징(메인메뉴)
   * <Xmp>
   * <select id="all_list_search" resultType="ReviewVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public List<ReviewVO> all_list_search(HashMap hashMap);
  
  /**
   * 검색된 레코드 갯수(회원)
   * <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int msearch_count(HashMap hashMap); 
  
  /**
   * 리스트 + 검색(리뷰제목) + 페이징(회원)
   * <Xmp>
   * <select id="m_list_search" resultType="ReviewVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public List<ReviewVO> m_list_search(HashMap hashMap);
  
  /**
   * 리뷰를 쓴 회원 이름
   * <Xmp>
   * <select id="mname" resultMap="MnameVO" parameterType="int">
   * </Xmp>
   * @param reviewno
   * @return
   */
  public MnameVO mname(int reviewno);
  
  /**
   * 리뷰별 댓글 갯수
   * <Xmp>
   * <select id="rcc" resultType="int" parameterType="int">
   * <Xmp>
   * @param reviewno
   * @return
   */
  public int rcc(int reviewno);
  
} 
