package dev.mvc.qna;

/*
 *  qnano               NUMBER                NOT NULL,
    seqno               NUMBER                default 2             NOT NULL, -- 1-공지글 / 2-일반글
    qnatype             VARCHAR2(20)          NOT NULL,
    title               VARCHAR2(100)         NOT NULL,
    content             CLOB              NOT NULL,
    memberno            NUMBER                NOT NULL,
    mname               VARCHAR2(20)          NOT NULL,
    cnt                 NUMBER                default 0             NOT NULL,
    rdate               DATE                  NOT NULL,
    qpasswd             VARCHAR2(20)          NULL,
    statement           NUMBER              NOT NULL,           -- 0-처리중 / 1-처리완료
    indent        NUMBER              DEFAULT 0           NOT NULL,
    ansnum        NUMBER            DEFAULT 0           NOT NULL,
 * */

public class QnaVO {

   private int qnano;
   private int seqno;
   private String qnatype;
   private String title;
   private String content;
   private int memberno;
   private String mname;
   private int cnt;
   private String rdate;
   private String qpasswd;
   private int statement;
   private int indent;
   private int ansnum;
   
   public QnaVO(){
     
   }

  public int getQnano() {
    return qnano;
  }

  public void setQnano(int qnano) {
    this.qnano = qnano;
  }

  public int getSeqno() {
    return seqno;
  }

  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }

  public String getQnatype() {
    return qnatype;
  }

  public void setQnatype(String qnatype) {
    this.qnatype = qnatype;
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

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  public String getQpasswd() {
    return qpasswd;
  }

  public void setQpasswd(String qpasswd) {
    this.qpasswd = qpasswd;
  }

  public int getStatement() {
    return statement;
  }

  public void setStatement(int statement) {
    this.statement = statement;
  }

  public int getIndent() {
    return indent;
  }

  public void setIndent(int indent) {
    this.indent = indent;
  }

  public int getAnsnum() {
    return ansnum;
  }

  public void setAnsnum(int ansnum) {
    this.ansnum = ansnum;
  }
   
   
}
