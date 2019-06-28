package dev.mvc.movie.comment;

//회원 영화 댓글 목록
public class MovieNmVO {
  
  /** 댓글 번호 */
  private int mcno;
  /** 날짜 */
  private String rdate;
  /** 회원 번호 */
  private int memberno;
  /** 댓글 */
  private String content;
  /** 영화 코드*/
  private String movieCd;
  /** 평점 */
  private int grade;
  /** 영화제목 */
  private String movieNm;
  /** 포스터 썸네일 */ 
  private String thumb="";

  public int getMcno() {
    return mcno;
  }
  public void setMcno(int mcno) {
    this.mcno = mcno;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getMovieCd() {
    return movieCd;
  }
  public void setMovieCd(String movieCd) {
    this.movieCd = movieCd;
  }
  public int getGrade() {
    return grade;
  }
  public void setGrade(int grade) {
    this.grade = grade;
  }
  public String getMovieNm() {
    return movieNm;
  }
  public void setMovieNm(String movieNm) {
    this.movieNm = movieNm;
  }
  public String getThumb() {
    return thumb;
  }
  public void setThumb(String thumb) {
    this.thumb = thumb;
  }

}
