package dev.mvc.movie.comment;

public class McommentVO {

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
  private String grade;
  /** 회원 이름 */
  private String mname;

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
  public String getGrade() {
    return grade;
  }
  public void setGrade(String grade) {
    this.grade = grade;
  }
  public String getMname() {
    return mname;
  }
  public void setMname(String mname) {
    this.mname = mname;
  }
  
  
  
}
