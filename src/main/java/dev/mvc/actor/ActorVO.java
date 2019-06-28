package dev.mvc.actor;

public class ActorVO {
  /* 배우번호 */
  private int actorno;
  /* 배우명 */
  private String actorNm;
  /* 배우 영문명 */
  private String actorEnNm;
  /* 배우 코드명 */
  private String acode; 
  
  public int getActorno() {
    return actorno;
  }
  public void setActorno(int actorno) {
    this.actorno = actorno;
  }
  public String getActorNm() {
    return actorNm;
  }
  public void setActorNm(String actorNm) {
    this.actorNm = actorNm;
  }
  public String getActorEnNm() {
    return actorEnNm;
  }
  public void setActorEnNm(String actorEnNm) {
    this.actorEnNm = actorEnNm;
  }
  public String getAcode() {
    return acode;
  } 
  public void setAcode(String acode) {
    this.acode = acode;
  }
  
}
