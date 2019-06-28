package dev.mvc.movie;

//회원별 보고싶은 영화
public class MoviebucketVO {
  
  /** 포스터 썸네일 */ 
  private String thumb="";
  /** 영화 제목 */
  private String movieNm;
  /** 좋아요 번호 */
  private int likeno;
  /** 영화 코드 */
  private String movieCd;
  /** 회원 번호 */
  private int memberno;
  /** 좋아요 체크 */
  private int like_check;
  
  public MoviebucketVO(){
    
  }

  public String getThumb() {
    return thumb;
  }
  public void setThumb(String thumb) {
    this.thumb = thumb;
  }
  public String getMovieNm() {
    return movieNm;
  }
  public void setMovieNm(String movieNm) {
    this.movieNm = movieNm;
  }
  public int getLikeno() {
    return likeno;
  }
  public void setLikeno(int likeno) {
    this.likeno = likeno;
  }
  public String getMovieCd() {
    return movieCd;
  }
  public void setMovieCd(String movieCd) {
    this.movieCd = movieCd;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public int getLike_check() {
    return like_check;
  }
  public void setLike_check(int like_check) {
    this.like_check = like_check;
  }
  
  

}
