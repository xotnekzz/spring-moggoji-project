package dev.mvc.review;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
  /* 리뷰 번호 */
  private int reviewno;
  /* 글 제목 */
  private String title;
  /* 내용 */
  private String content;
  /* 등록일 */
  private String rdate;
  /* 대표 이미지 */
  private String mainimg="";
  /* 사이즈 */
  private long imgsize=0;
  /* 참고 영상 */
  private String youtube;
  /* 조회수 */
  private int cnt; 
  /* 출력 여부 */
  private char visible;
  /* 리뷰 평점 */
  private String review_rating;
  /* 회원 번호(FK) */
  private int memberno;
  /* 회원 이름*/
  private String mname;
  
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
*/  
private MultipartFile file1MF;

/** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
private String size1Label;



public MultipartFile getFile1MF() {
  return file1MF;
}
public void setFile1MF(MultipartFile file1mf) {
  file1MF = file1mf;
}
public String getSize1Label() {
  return size1Label;
}
public void setSize1Label(String size1Label) {
  this.size1Label = size1Label;
}


  public int getReviewno() {
    return reviewno;
  }
  public void setReviewno(int reviewno) {
    this.reviewno = reviewno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getMainimg() {
    return mainimg;
  }
  public void setMainimg(String mainimg) {
    this.mainimg = mainimg;
  }
  public long getImgsize() {
    return imgsize;
  }
  public void setImgsize(long imgsize) {
    this.imgsize = imgsize;
  }
  public String getYoutube() {
    return youtube;
  }
  public void setYoutube(String youtube) {
    this.youtube = youtube;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public char getVisible() {
    return visible;
  }
  public void setVisible(char visible) {
    this.visible = visible;
  }
  public String getReview_rating() {
    return review_rating;
  }
  public void setReview_rating(String review_rating) {
    this.review_rating = review_rating;
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
   
  
}
