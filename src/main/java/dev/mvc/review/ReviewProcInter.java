package dev.mvc.review;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;


public interface ReviewProcInter {
  
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
    * </Xmp>
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
    * 목록 +검색(제목)+ 페이징(메인메뉴)
    * <Xmp>
    * <select id="all_list_search" resultType="ReviewVO" parameterType="HashMap">
    * </Xmp>
    * @param hashMap
    * @return
    */
   public List<ReviewVO> all_list_search(HashMap hashMap);
   
   /** 
    * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 (전체)
    * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
    *
    * @param search_count 검색 갯수
    * @param nowPage  현재 페이지
    * @param word 검색어
    * @return 페이징 생성 문자열
    */ 
   public String paging(int search_count, int nowPage, String word); 
   
   
   
   /**
    * 검색된 레코드 갯수
    * <Xmp>
    * <select id="msearch_count" resultType="int" parameterType="HashMap">
    * </Xmp>
    * @return
    */
   public int msearch_count(HashMap hashMap); 
   
   /**
    * 목록 +검색(제목)+ 페이징(회원)
    * <Xmp>
    * <select id="m_list_search" resultType="ReviewVO" parameterType="HashMap">
    * </Xmp>
    * @param hashMap
    * @return
    */
   public List<ReviewVO> m_list_search(HashMap hashMap);
   
   /** 
    * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 (회원별)
    * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
    *
    *@param msearch_count 검색 갯수
    * @param nowPage  현재 페이지
    * @param word 검색어
    * @param memberno 회원번호
    * @return 페이징 생성 문자열
    */ 
   public String mpaging(int msearch_count, int nowPage, String word, int memberno); 
/*   public String mpaging(int msearch_count, int nowPage, String word, HttpSession session); */

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
