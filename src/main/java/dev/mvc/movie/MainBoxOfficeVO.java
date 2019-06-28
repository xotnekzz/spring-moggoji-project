package dev.mvc.movie;

public class MainBoxOfficeVO {

  /** 포스터 썸네일 */ 
  private String thumb = "";
  /** 상영 시간 */
  private String showTm;
  /** 대표 관람 등급 */ 
  private String watchGradeNm;
  /** 장르 */
  private String genre;
  /** 감독 */
  private String director;
  /** 배우 */
  private String actors;
  
  /** 영화 순위 */
  private int rank;
  /** 영화 코드 */
  private String movieCd;
  /** 영화 제목*/
  private String movieNm;
  /** 개봉 날짜 */
  private String openDt;
  /** 누적 관객수 */
  private String audiAcc;

  
  public MainBoxOfficeVO(){
    
  }
  
  public String getThumb() {
    return thumb;
  }
  public void setThumb(String thumb) {
    this.thumb = thumb;
  }
  public String getShowTm() {
    return showTm;
  }
  public void setShowTm(String showTm) {
    this.showTm = showTm;
  }
  public String getWatchGradeNm() {
    return watchGradeNm;
  }
  public void setWatchGradeNm(String watchGradeNm) {
    this.watchGradeNm = watchGradeNm;
  }
  public String getGenre() {
    return genre;
  }
  public void setGenre(String genre) {
    this.genre = genre;
  }
  public String getDirector() {
    return director;
  }
  public void setDirector(String director) {
    this.director = director;
  }
  public String getActors() {
    return actors;
  }
  public void setActors(String actors) {
    this.actors = actors;
  }
  public int getRank() {
    return rank;
  }
  public void setRank(int rank) {
    this.rank = rank;
  }
  public String getMovieCd() {
    return movieCd;
  }
  public void setMovieCd(String movieCd) {
    this.movieCd = movieCd;
  }
  public String getMovieNm() {
    return movieNm;
  }
  public void setMovieNm(String movieNm) {
    this.movieNm = movieNm;
  }
  public String getOpenDt() {
    return openDt;
  }
  public void setOpenDt(String openDt) {
    this.openDt = openDt;
  }
  public String getAudiAcc() {
    return audiAcc;
  }
  public void setAudiAcc(String audiAcc) {
    this.audiAcc = audiAcc;
  }
  
  
}
