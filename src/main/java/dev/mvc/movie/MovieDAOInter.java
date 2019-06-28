package dev.mvc.movie;

import java.util.HashMap;
import java.util.List;

public interface MovieDAOInter {

  /**
   *  영화정보 입력
   * <Xmp>
   *  <insert id="create" parameterType="MovieVO">
   * </Xmp>
   * @param MovieVO
   * @return 처리된 레코드 개수
   */
  public int create(MovieVO movieVO);
  
  
  /**
   * 영화 코드 조회(수정할때 사용)
   * <Xmp>
   * <select id="list" resultType="MovieCdVO">
   * </Xmp>
   * @return
   */
  public List<MovieVO> codeList(); 
  
  /**
   * 영화 추가 정보 등록 
   * <Xmp>
   * <update id="update" parameterType="MovieVO">
   * </Xmp>
   * @param movieVO
   * @return
   */
  public int update(MovieVO movieVO);
  
  /**
   * 관리자 영화 리스트
   * <Xmp>
   * <select id="a_movielist" resultType="MovieVO">
   * </Xmp>
   * @return
   */
  public List<MovieVO> a_movielist();
  
  
  /**
   * 관리자 영화 한 건 조회
   * <Xmp>
   * <select id="a_movieread" resultType="MovieVO" parameterType="String">
   * </Xmp>
   * @param movieCd
   * @return 
   */
  public MovieVO a_movieread(String movieCd);
  
  
  /**
   * 관리자 영화 수정 처리
   * <Xmp>
   * <update id="a_movieupdate"  parameterType="MovieVO">
   * </Xmp>
   * @param movieVO
   * @return 1 or 0
   */
  public int a_movieupdate(MovieVO movieVO);


  /**
   * 관리자) 검색된 레코드 갯수
   * <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int asearch_count(HashMap hashMap); 

  /**
   * 관리자 )목록 + 검색(영화제목) + 페이징
   * <Xmp>
   * <select id="a_list_search" resultType="MovieVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public List<MovieVO> a_list_search(HashMap hashMap);

  /**
   * 메인메뉴) 검색된 레코드 갯수
   * <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int search_count(HashMap hashMap); 
  
  /**
   * 메인메뉴 )목록 + 검색(영화제목) + 페이징
   * <Xmp>
   * <select id="main_movie" resultType="MovieVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public List<MovieVO> main_movie(HashMap hashMap);

  /**
   * 장르) 검색된 레코드 갯수
   * <Xmp>
   * <select id="search_count_genre" resultType="int" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int search_count_genre(HashMap hashMap); 
  
  /**
   * 장르)목록 + 검색(영화장르) + 페이징
   * <Xmp>
   * <select id="list_search_genre" resultType="MovieVO" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public List<MovieVO> list_search_genre(HashMap hashMap);
  
  /**
   * 영화별 댓글 갯수
   * @param movieCd
   * @return
   */
  public int mcc(String movieCd);

  
  /**
   * 박스오피스 영화 리스트
   * <Xmp>
   * <select id="boxOffice_List" resultType="BoxOfficeVO">
   * </Xmp>
   * @return
   */
  public List<BoxOfficeVO> boxOffice_List();
  
  /**
   * 박스오피스 영화 한 건 조회
   * <Xmp>
   * <select id="boxOffice_read" resultType="BoxOfficeVO" parameterType="String">
   * </Xmp>
   * @param rank
   * @return
   */
  public BoxOfficeVO boxOffice_Read(int rank);
  
  /**
   * 박스오피스 업데이트 
   * <Xmp>
   * <update id="boxOffice_update" parameterType="BoxOfficeVO">
   * </Xmp>
   * @param boxOfficeVO
   * @return
   */
  public int boxOffice_update(BoxOfficeVO boxOfficeVO);
  
  /**
   * 메인 박스오피스 목록
   * <Xmp>
   *  <select id="mainbo_list" resultType="MainBoxOfficeVO">
   *  </Xmp>
   * @return
   */
  public List<MainBoxOfficeVO> mainbo_list();
  
  
  /**
   * 좋아요 생성
   * <Xmp>
   * <insert id="like_create" parameterType="MovielikeVO">
   * </Xmp>
   * @return
   */
  public int like_create(HashMap hashMap);
  
  /**
   * 좋아요 누름
   * <Xmp>
   * <update id="like_check" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int like_check(HashMap hashMap);
  
  /**
   * 좋아요 취소
   * <Xmp>
   * update id="like_check_cancel" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int like_check_cancel(HashMap hashMap);
  
  /**
   * 영화별 좋아요 갯수
   * <Xmp>
   * update id="like_count" parameterType="movieCd">
   * </Xmp>
   * @return
   */
  public int like_count(String movieCd);
  
  /**
   * 좋아요 한 건 조회
   * <Xmp>
   * update id="like_read" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public MovielikeVO like_read(HashMap hashMap);
  
  /**
   * 회원의 영화별 좋아요 체크 확인
   * <Xmp>
   * update id="a_like_count" parameterType="HashMap">
   * </Xmp>
   * @return
   */
  public int a_like_count(HashMap hashMap);
  
  /**
   * 회원별 보고싶어요 카운트
   * <Xmp>
   * <select id="mbc" parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public int mbc(HashMap hashMap);

  /**
   * 회원별 보고싶어요 목록
   * <Xmp>
   * <select id="moviebucket" resultType="MoviebucketVO" parameterType="HashMap" >
   *  </Xmp>
   * @return
   */
  public List<MoviebucketVO> moviebucket(HashMap hashMap);
  
  /**
   * 회원의 영화 댓글 갯수 확인
   * <Xmp>
   * <select id="mc_check" resultType="int"  parameterType="HashMap">
   * </Xmp>
   * @param hashMap
   * @return
   */
  public int mc_check(HashMap hashMap);
  
  
  /**
   * 영화별 영화평점 합
   *  <Xmp>
   * <select id="grade_sum" resultType="int" parameterType="String">
   *  </Xmp>
   * @param movieCd
   * @return
   */
  public int grade_sum(String movieCd);
  
}
