package dev.mvc.movie;

public class BoxOfficeVO {

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
  
  public BoxOfficeVO(){
    
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
