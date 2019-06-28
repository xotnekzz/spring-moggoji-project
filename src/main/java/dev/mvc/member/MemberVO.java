package dev.mvc.member;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
    // 회원 번호.
    private int memberno;   
    
    // 회원 이메일.
    private String memail;
    
    // 회원 비밀번호.
    private String mpasswd;
    
    // 회원 이름.
    private String mname;
    
    // 회원 이미지.
    private String mfile="";
    
    // 회원 이미지 크기.
    private long msize=0;
    
    //회원 권한
    private String mact;
    
    // 회원 등록일
    private String mdate;
    
    /** 
    Spring Framework에서 자동 주입되는 업로드 파일 객체,
    DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
         하나의 파일 업로드
    */
    private MultipartFile fileMF;
    
    
    // VO 생성자.
    public MemberVO() {
        //System.out.println("Member 객체 생성자 실행되었음. ");
    }
    
    
    public int getMemberno() {
        return memberno;
    }
    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }
    public String getMemail() {
        return memail;
    }
    public void setMemail(String memail) {
        this.memail = memail;
    }
    public String getMpasswd() {
        return mpasswd;
    }
    public void setMpasswd(String mpasswd) {
        this.mpasswd = mpasswd;
    }
    public String getMname() {
        return mname;
    }
    public void setMname(String mname) {
        this.mname = mname;
    }
    public String getMfile() {
        return mfile;
    }
    public void setMfile(String mfile) {
        this.mfile = mfile;
    }
    public long getMsize() {
      return msize;
    }
    public void setMsize(long msize) {
      this.msize = msize;
    }
    public String getMact() {
      return mact;
    }
    public void setMact(String mact) {
      this.mact = mact;
    }
    public String getMdate() {
      return mdate;
    }
    public void setMdate(String mdate) {
      this.mdate = mdate;
    }
    public MultipartFile getFileMF() {
      return fileMF;
    }
    public void setFileMF(MultipartFile fileMF) {
      this.fileMF = fileMF;
    }
    
    
}
