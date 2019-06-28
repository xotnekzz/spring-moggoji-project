package dev.mvc.review;

//리뷰를 쓴 회원 이름
public class MnameVO {

  /** 회원 번호 */
  private int memberno;
  /** 회원 이름 */
  private String mname;
  /** 회원 이메일  */
  private String memail;
  /** 리뷰 번호 */
  private int reviewno;
  
 
  public MnameVO() {
   
  }

  public int getMemberno() {
    return memberno;
  }

  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }

  public String getMname() {
    return mname;
  }

  public void setMname(String mname) {
    this.mname = mname;
  }
 
  public String getMemail() {
    return memail;
  }

  public void setMemail(String memail) {
    this.memail = memail;
  }

  public int getReviewno() {
    return reviewno;
  }

  public void setReviewno(int reviewno) {
    this.reviewno = reviewno;
  }
  
  
}
