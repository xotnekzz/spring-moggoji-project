package dev.mvc.log;

public class LogVO {
  
  private int logno;
  private String menail;
  private String ip;
  private String uri;
  private String logdate;

  public LogVO(){
    
  }
  
  public int getLogno() {
    return logno;
  }
  public void setLogno(int logno) {
    this.logno = logno;
  }
  public String getMenail() {
    return menail;
  }
  public void setMenail(String menail) {
    this.menail = menail;
  }
  public String getIp() {
    return ip;
  }
  public void setIp(String ip) {
    this.ip = ip;
  }
  public String getUri() {
    return uri;
  }
  public void setUri(String uri) {
    this.uri = uri;
  }
  public String getLogdate() {
    return logdate;
  }
  public void setLogdate(String logdate) {
    this.logdate = logdate;
  }
  
  

}
