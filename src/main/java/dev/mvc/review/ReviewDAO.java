package dev.mvc.review;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository("dev.mvc.review.ReviewDAO")
public class ReviewDAO implements ReviewDAOInter {
  
  @Autowired 
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public ReviewDAO() {
    //System.out.println("--> ReviewDAO Created...");
    
    if(sqlSessionTemplate != null) {
      //System.out.println("--> sqlSessionTemplate 할당됨.");
    }
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
    int count = sqlSessionTemplate.insert("review.create", reviewVO);
    return count;
  }

  /**
   *  목록 조회
   * <Xmp>
   *  <select id="list" resultType="ReviewVO">
   *  </Xmp>
   * @return 
   */
  @Override
  public List<ReviewVO> list() { 
    List<ReviewVO> list = sqlSessionTemplate.selectList("review.list");
    return list;  
  }

  /** 
   *  1건 조회
   * <Xmp>
   * <select id="read" resultType="ReviewVO" parameterType="int">
   * </Xmp>
   * @param reviewno 
   * @return
   */
  @Override
  public ReviewVO read(int reviewno) {
    ReviewVO reviewVO = sqlSessionTemplate.selectOne("review.read", reviewno);
    return reviewVO;
  }

  /**
  * 조회수 증가
  * <Xmp>
  * <update id="cnt_increase" parameterType="ReviewVO">
  * </Xmp>
  * @param reviewVO
  * @return
  */
  @Override
  public int cnt_increase(ReviewVO reviewVO) {
    int count = sqlSessionTemplate.update("review.cnt_increase", reviewVO);
    return count;
  }
  
  /**
   * 리뷰 수정폼
   * <Xmp>
   * <select id="read" resultType="ReviewVO" parameterType="int">
   * </Xmp> 
   * @param reviewno
   * @return
   */
  public ReviewVO update(int reviewno){
    ReviewVO reviewVO = sqlSessionTemplate.selectOne("review.read", reviewno);
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
    int count = sqlSessionTemplate.update("review.update", reviewVO);   
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
    int count = sqlSessionTemplate.delete("review.delete", reviewno);
    return count;
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
    int cnt = sqlSessionTemplate.selectOne("review.search_count", hashMap);
    return cnt;
  }
  
  /**
   * 목록 + 검색(제목) + 페이징(메인메뉴)
   * <Xmp>
   * <select id="all_list_search" resultType="ReviewVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public List<ReviewVO> all_list_search(HashMap hashMap){
    List<ReviewVO> list = null;
    list = sqlSessionTemplate.selectList("review.all_list_search", hashMap);
    return list;
  }
  
  /**
   * 검색된 레코드 갯수(회원)
   * <Xmp>
   * <select id="msearch_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  @Override
  public int msearch_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("review.msearch_count", hashMap);
    return cnt;
  }
  
  /**
   * 목록 + 검색(제목) + 페이징(회원)
   * <Xmp>
   * <select id="m_list_search" resultType="ReviewVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public List<ReviewVO> m_list_search(HashMap hashMap){
    List<ReviewVO> list = null;
    list = sqlSessionTemplate.selectList("review.m_list_search", hashMap);
    return list;
  }
  
  /**
   * 리뷰를 쓴 회원 이름
   * <Xmp>
   * <select id="mname" resultMap="MemberVO" parameterType="int">
   * </Xmp>
   * @param reviewno
   * @return
   */
  public MnameVO mname(int reviewno){
    MnameVO mnameVO = sqlSessionTemplate.selectOne("review.mname", reviewno);
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
    int cnt = sqlSessionTemplate.selectOne("review.rcc", reviewno);
    return cnt;
  }
    
}
