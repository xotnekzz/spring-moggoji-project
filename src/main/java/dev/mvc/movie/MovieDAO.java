package dev.mvc.movie;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.movie.MovieDAO")
public class MovieDAO implements MovieDAOInter{
  
  @Autowired 
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public MovieDAO() {
   //System.out.println("--> MovieDAO create.");
    
    if(sqlSessionTemplate != null) {
      //System.out.println("--> sqlSessionTemplate 할당됨.");
    }
  }
 
  /**
   *  영화정보 입력
   * <Xmp>
   *  <insert id="create" parameterType="MovieVO">
   * </Xmp>
   * @param MovieVO
   * @return 처리된 레코드 개수
   */
  @Override
  public int create(MovieVO movieVO) {
    int count = sqlSessionTemplate.insert("movie.create", movieVO);
    return count; 
  }

  /**
   * 영화 코드 목록
   * <Xmp>
   * <select id="list" resultType="MovieCdVO">
   * </Xmp>
   * @return
   */
  @Override
  public List<MovieVO> codeList() {
    List<MovieVO> codeList = sqlSessionTemplate.selectList("movie.list");
    return codeList;
  }
  
  /**
   * 영화 추가 정보 등록 
   * <Xmp>
   * <update id="update" parameterType="MovieVO">
   * </Xmp>
   * @param movieVO
   * @return
   */
  @Override
  public int update(MovieVO movieVO) {
    int count = sqlSessionTemplate.update("movie.update", movieVO);
    return count; 
  } 
  
  /**
   * 관리자 영화 리스트
   * <Xmp>
   * <select id="a_movielist" resultType="MovieVO">
   * <Xmp>
   * @return
   */
  @Override
  public List<MovieVO> a_movielist(){
    List<MovieVO> list = sqlSessionTemplate.selectList("movie.a_movielist");
    return list;
  }

  /**
   * 관리자 영화 한 건 조회
   * <Xmp>
   * <select id="a_movieread" resultType="movieVO" parameterType="String">
   * </Xmp>
   * @param movieCd
   * @return
   */
  @Override
  public MovieVO a_movieread(String movieCd){
    MovieVO movieVO = sqlSessionTemplate.selectOne("movie.a_movieread", movieCd);
    return movieVO;
  }
  
  /**
   * 관리자 영화 수정 처리
   * <Xmp>
   * <update id="a_movieupdate"  parameterType="MovieVO">
   * </Xmp>
   * @param movieVO
   * @return
   */
  @Override
  public int a_movieupdate(MovieVO movieVO){
    int count = sqlSessionTemplate.update("movie.a_movieupdate", movieVO);
    return count;
  }

  /**
   * 관리자) 검색된 레코드 갯수
   * <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  @Override
  public int asearch_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("movie.asearch_count", hashMap);
    return cnt;
  }
  
  /**
   * 관리자) 목록 + 검색(영화제목) + 페이징
   * <Xmp>
   * <select id="a_list_search" resultType="ReviewVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  @Override
  public List<MovieVO> a_list_search(HashMap hashMap){
    List<MovieVO> list = null;
    list = sqlSessionTemplate.selectList("movie.a_list_search", hashMap);
    return list;
  }
  
  /**
   * 메인메뉴) 검색된 레코드 갯수
   * <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("movie.search_count", hashMap);
    return cnt;
  }
  
  /**
   * 메인메뉴 )목록 + 검색(영화제목) + 페이징
   * <Xmp>
   * <select id="main_movie" resultType="MovieVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  @Override
  public List<MovieVO> main_movie(HashMap hashMap){
    List<MovieVO> list = null;
    list = sqlSessionTemplate.selectList("movie.main_movie", hashMap);
    return list;
  }
  
  /**
   * 장르) 검색된 레코드 갯수
   * <Xmp>
   * <select id="search_count_genre" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  @Override
  public int search_count_genre(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("movie.search_count_genre", hashMap);
    return cnt;
  }
  
  /**
   * 장르) 목록 + 검색(영화제목) + 페이징
   * <Xmp>
   * <select id="a_list_search" resultType="ReviewVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  @Override
  public List<MovieVO> list_search_genre(HashMap hashMap){
    List<MovieVO> list = null;
    list = sqlSessionTemplate.selectList("movie.list_search_genre", hashMap);
    return list;
  }

  /**
   * 영화별 댓글 갯수
   * @param movieCd
   * @return
   */
  public int mcc(String movieCd){
    int cnt = sqlSessionTemplate.selectOne("movie.mcc", movieCd);
    return cnt;
  }
  
  /**
   * 박스오피스 리스트
   * <Xmp>
   * <select id="boxOffice_List" resultType="BoxOfficeVO">
   * <Xmp>
   * @return
   */
  @Override
  public List<BoxOfficeVO> boxOffice_List(){
    List<BoxOfficeVO> boxOffice_List  = sqlSessionTemplate.selectList("movie.boxOffice_List");
    return boxOffice_List;
  }
  
  /**
   * 박스오피스 영화 한 건 조회
   * <Xmp>
   * <select id="boxOffice_Read" resultType="boxOfficeVO" parameterType="String">
   * </Xmp>
   * @param movieCd
   * @return
   */
  @Override
  public BoxOfficeVO boxOffice_Read(int rank){
    BoxOfficeVO boxOfficeVO = sqlSessionTemplate.selectOne("movie.boxOffice_Read", rank);
    return boxOfficeVO;
  }
  
  /**
   * 박스오피스 영화 수정 처리
   * <Xmp>
   * <update id="boxOffice_update"  parameterType="BoxOfficeVO">
   * </Xmp>
   * @param movieVO
   * @return
   */
  @Override
  public int boxOffice_update(BoxOfficeVO boxOfficeVO){
    int count = sqlSessionTemplate.update("movie.boxOffice_update", boxOfficeVO);
    return count;
  }
  
  /**
   * 메인 박스오피스 목록
   * <Xmp>
   *  <select id="mainbo_list" resultType="MainBoxOfficeVO">
   *  </Xmp>
   * @return
   */
  public List<MainBoxOfficeVO> mainbo_list(){
    List<MainBoxOfficeVO> list = sqlSessionTemplate.selectList("movie.mainbo_list");
    return list;
  }
  
  
  /**
   * 좋아요 생성
   * <Xmp>
   * <insert id="like_create" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int like_create(HashMap hashMap){
   int count = sqlSessionTemplate.insert("movie.like_create",hashMap);
   return count;
  }
  
  /**
   * 좋아요 누름
   * <Xmp>
   * <update id="like_check" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int like_check(HashMap hashMap){
    int count = sqlSessionTemplate.update("movie.like_check", hashMap);
    return count;
  }
  
  /**
   * 좋아요 취소
   * <Xmp>
   * update id="like_check_cancel" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int like_check_cancel(HashMap hashMap){
    int count = sqlSessionTemplate.update("movie.like_check_cancel", hashMap);
    return count;
  }
  
  /**
   * 영화별 좋아요 갯수
   * <Xmp>
   * update id="like_count" parameterType="movieCd">
   * </Xmp>
   * @return
   */
  public int like_count(String movieCd){
    int count = sqlSessionTemplate.selectOne("movie.like_count", movieCd);
    return count;
  }
  
  /**
   * 좋아요 한 건 조회
   * <Xmp>
   * update id="like_read" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public MovielikeVO like_read(HashMap hashMap){
    MovielikeVO movielikeVO = sqlSessionTemplate.selectOne("movie.like_read", hashMap);
    return movielikeVO;
  }
  
  /**
   * 회원의 영화별 좋아요 체크 확인
   * <Xmp>
   * update id="a_like_count" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int a_like_count(HashMap hashMap){
    int count = sqlSessionTemplate.selectOne("movie.a_like_count", hashMap);
    return count;
  }
  
  /**
   * 회원별 보고싶어요 카운트
   * <Xmp>
   * <select id="mbc" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public int mbc(HashMap hashMap){
    int cnt = sqlSessionTemplate.selectOne("movie.mbc", hashMap);
    return cnt;
  }
  
  /**
   * 회원별 보고싶어요 목록
   * <Xmp>
   * <select id="moviebucket" resultType="MoviebucketVO" parameterType="HashMap" >
   *  </Xmp>
   * @return
   */
  public List<MoviebucketVO> moviebucket(HashMap hashMap){
    List<MoviebucketVO> list = sqlSessionTemplate.selectList("movie.moviebucket",hashMap);
    return list;
  }
  
  /**
   * 회원의 영화 댓글 갯수 확인
   * <Xmp>
   * <select id="mc_check" resultType="int"  parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public int mc_check(HashMap hashMap){
    int cnt = sqlSessionTemplate.selectOne("movie.mc_check", hashMap);
    return cnt;
  }
  
  /**
   * 영화별 영화평점 합
   *  <Xmp>
   * <select id="grade_sum" resultType="int" parameterType="String">
   *  </Xmp>
   * @param movieCd
   * @return
   */
  public int grade_sum(String movieCd){
    int sum = sqlSessionTemplate.selectOne("movie.grade_sum", movieCd);
    return sum;
  }
}
