package dev.mvc.director;

public class DirectorVO {
  // 감독 번호
  private int directorno;

  // 감독 이름
  private String directorNm;

  // 감독 이름 ( 영문 )
  private String directorEnNm;

  // 감독 코드
  private String dcode;

  public DirectorVO() {
  }

  public int getDirectorno() {
    return directorno;
  }

  public void setDirectorno(int directorno) {
    this.directorno = directorno;
  }

  public String getDirectorNm() {
    return directorNm;
  }

  public void setDirectorNm(String directorNm) {
    this.directorNm = directorNm;
  }

  public String getDirectorEnNm() {
    return directorEnNm;
  }

  public void setDirectorEnNm(String directorEnNm) {
    this.directorEnNm = directorEnNm;
  }

  public String getDcode() {
    return dcode;
  }

  public void setDcode(String dcode) {
    this.dcode = dcode;
  }

}