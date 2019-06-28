package dev.mvc.movie;

import org.springframework.web.multipart.MultipartFile;

public class MovieVO {
  /** 영화 코드 */
  private String movieCd;
  /** 영화 번호 */
  private int movieno;
  /** 영화 제목 */
  private String movieNm;
  /** 영화 영문제목 */
  private String movieNmEn;
  /** 개봉 일 */
  private String openDt;
  /** 제작연도 */
  private String prdtYear;
  /** 줄거리 */
  private String plot;
  /** 상영 시간 */
  private String showTm;
  /** 국가 */
  private String repNationNm;
  /** 포스터 URL */
  private String movieImg="";
  /** 포스터 썸네일 */ 
  private String thumb = "";
  /** 사이즈 */
  private long imgSize = 0;
  /** 대표 관람 등급 */ 
  private String watchGradeNm;
  /** 키워드 */
  private String keyword;
  /** 영상 */
  private String vodclass;
  /** 장르 */
  private String genre;
  /** 감독 */
  private String director;
  /** 배우 */
  private String actors;
  
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
*/  
private MultipartFile movieImgMF;

/** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
private String size1Label;


public MovieVO(){
  
}

public MultipartFile getMovieImgMF() {
  return movieImgMF;
}
public void setMovieImgMF(MultipartFile movieImgMF) {
  this.movieImgMF = movieImgMF;
}
public String getSize1Label() {
  return size1Label;
}
public void setSize1Label(String size1Label) {
  this.size1Label = size1Label;
}
  public String getMovieCd() {
    return movieCd;
  }
  public void setMovieCd(String movieCd) {
    this.movieCd = movieCd;
  }
  public int getMovieno() {
    return movieno;
  }
  public void setMovieno(int movieno) {
    this.movieno = movieno;
  }
  public String getMovieNm() {
    return movieNm;
  }
  public void setMovieNm(String movieNm) {
    this.movieNm = movieNm;
  }
  public String getMovieNmEn() {
    return movieNmEn;
  }
  public void setMovieNmEn(String movieNmEn) {
    this.movieNmEn = movieNmEn;
  }
  public String getOpenDt() {
    return openDt;
  }
  public void setOpenDt(String openDt) {
    this.openDt = openDt;
  }
  public String getPrdtYear() {
    return prdtYear;
  }
  public void setPrdtYear(String prdtYear) {
    this.prdtYear = prdtYear;
  }
  public String getPlot() {
    return plot;
  }
  public void setPlot(String plot) {
    this.plot = plot;
  }
  public String getShowTm() {
    return showTm;
  }
  public void setShowTm(String showTm) {
    this.showTm = showTm;
  }
  public String getRepNationNm() {
    return repNationNm;
  }
  public void setRepNationNm(String repNationNm) {
    this.repNationNm = repNationNm;
  }
  public String getMovieImg() {
    return movieImg;
  }
  public void setMovieImg(String movieImg) {
    this.movieImg = movieImg;
  }
  public String getThumb() {
    return thumb;
  }
  public void setThumb(String thumb) {
    this.thumb = thumb;
  }
  public long getImgSize() {
    return imgSize;
  }
  public void setImgSize(long imgSize) {
    this.imgSize = imgSize;
  }
  public String getWatchGradeNm() {
    return watchGradeNm;
  }
  public void setWatchGradeNm(String watchGradeNm) {
    this.watchGradeNm = watchGradeNm;
  }
  public String getKeyword() {
    return keyword;
  }
  public void setKeyword(String keyword) {
    this.keyword = keyword;
  }
  public String getVodclass() {
    return vodclass;
  }
  public void setVodclass(String vodclass) {
    this.vodclass = vodclass;
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
}
