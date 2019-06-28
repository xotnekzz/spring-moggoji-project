package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.member.MemberProc")    
public class MemberProc implements MemberProcInter{
    
    
    @Autowired
    @Qualifier("dev.mvc.member.MemberDAO")
    private MemberDAOInter memberDAO = null;
    
    public MemberProc() {
    }

    @Override // 회원 등록. ( 성공 시 1 , 실패 시 0 반환 ) 
    public int create(MemberVO memberVO) {
        int count = memberDAO.create(memberVO);
        return count;
    }
    
    @Override // 이메일 중복 체크 ( 중복되는 이메일 개수 반환 , 중복 시 1, 중복 아닐 시 0 반환 )
    public int checkId(String email) {
      int count = memberDAO.checkId(email); 
      return count;
    }
    
    @Override   // 회원 전체를 출력함.
    public List<MemberVO> list() {
      List<MemberVO> list = memberDAO.list();
        
      return list;
    }
    
    /**
     * 목록 +검색(제목)+ 페이징(메인메뉴)
     * <Xmp>
     * <select id="member_list_search" resultType="MemberVO" parameterType="HashMap">
     * </Xmp>
     * @param hashMap
     * @return
     */
    @Override
    public List<MemberVO> member_list_search(HashMap hashMap) {
      
      /* 페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
       1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
       2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
       3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
       */
      int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Member.RECORD_PER_PAGE;
      
       // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
      int startNum = beginOfPage + 1; 
      //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
      int endNum = beginOfPage + Member.RECORD_PER_PAGE;   
      
   /*    1 페이지: WHERE r >= 1 AND r <= 10
       2 페이지: WHERE r >= 11 AND r <= 20
       3 페이지: WHERE r >= 21 AND r <= 30
       */
      hashMap.put("startNum", startNum);
      hashMap.put("endNum", endNum);
      
      List<MemberVO> list = memberDAO.member_list_search(hashMap); 
      
      return list;
    }
    
    
    @Override   // 회원 전체 리스트 중 한명의 회원 정보를 출력.
    public MemberVO read(int memberno) {
      MemberVO memberVO = memberDAO.read(memberno);
      return memberVO;
    }
    
    @Override   // 회원 전체 리스트 중 한명의 회원 정보를 출력.
    public MemberVO read(String email) {
      MemberVO memberVO = memberDAO.read(email);
      
      return memberVO;
    }
    
    @Override // login 
    public String login(String email) {
        String passwd = memberDAO.login(email);
        return passwd;
    }
    
    //회원 수정 폼
    @Override
    public MemberVO member_update(int memberno){
      MemberVO memberVO = memberDAO.read(memberno);
      return memberVO;
    }
    
    //회원 수정 처리
    @Override
    public int member_update(MemberVO memberVO){
      int count = memberDAO.member_update(memberVO);
      return count;
    }
    
    //회원 정보 삭제
    public int member_delete(int memberno){
      int count = memberDAO.member_delete(memberno);
      return count;
    }
    
    //회원 권한 수정
    public int member_act(MemberVO memberVO){
      int count = memberDAO.member_act(memberVO);
      return count;
    }
    
    /**
     * 검색된 레코드 갯수
     * <Xmp>
     * <select id="search_count" resultType="int" parameterType="HashMap">
     * </Xmp>
     * @return
     */
    @Override
    public int search_count(HashMap hashMap) {
      int cnt = memberDAO.search_count(hashMap);
      return cnt;
    }
    
    /** 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param title 검색어
     * @return 페이징 생성 문자열
     */ 
    public String paging(int search_count, int nowPage, String word){ 
      int totalPage = (int)(Math.ceil((double)search_count/Member.RECORD_PER_PAGE)); // 전체 페이지  
      int totalGrp = (int)(Math.ceil((double)totalPage/Member.PAGE_PER_BLOCK));// 전체 그룹 
      int nowGrp = (int)(Math.ceil((double)nowPage/Member.PAGE_PER_BLOCK));    // 현재 그룹 
      int startPage = ((nowGrp - 1) * Member.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
      int endPage = (nowGrp * Member.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
       
      StringBuffer str = new StringBuffer(); 
       
      str.append("<style type='text/css'>"); 
      str.append("  #paging {text-align: center; margin-top: 5px; margin-bottom:5px; font-size: 1.1em;}"); 
      str.append("  #paging A:link {text-decoration:none; color:#31106D; font-size: 1.1em;}"); 
      str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color: #31106D; font-size: 1.1em;}"); 
      str.append("  #paging A:visited {text-decoration:none;color: #31106D; font-size: 1.1em;}"); 
      str.append("  .span_box_1{");  
      str.append("    text-align: center;");    
      str.append("    font-size: 1.1em;"); 
      str.append("    border: 1px;"); 
      str.append("    border-style: solid;"); 
      str.append("    border-color: #31106D;"); 
      str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("  }"); 
      str.append("  .span_box_2{"); //선택
      str.append("    text-align: center;");     
      str.append("    background-color: #31106D;"); 
      str.append("    color: #FFFFFF;"); 
      str.append("    font-size: 1.2em;"); 
      str.append("    border: 1px;");  
      str.append("    border-style: solid;"); 
      str.append("    border-color: #31106D;");  
      str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("  }"); 
      str.append("</style>"); 
      str.append("<DIV id='paging'>"); 
     //str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
   
      // 이전 10개 페이지로 이동 
      //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
      // 현재 2 그룹인 경우 : (2-1)*10 = 1그룹의 10
      // 현재 3 그룹인 경우 : (3-1)*10 = 2 그룹의 10
      int _nowPage = (nowGrp-1) * Member.PAGE_PER_BLOCK; 
      if (nowGrp >= 2){ 
        str.append("<span class='span_box_1'><A href='./member_list_search.do?&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
      } 
   
      for(int i=startPage; i<=endPage; i++){ 
        if (i > totalPage){ 
          break; 
        } 
    
        if (nowPage == i){ 
          str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
        }else{
          // 현재 페이지가 아닌 페이지
          str.append("<span class='span_box_1'><A href='./member_list_search.do?word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
        } 
      } 
       
   // 10개 다음 페이지로 이동 
      //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
      // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
      // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
      _nowPage = (nowGrp * Member.PAGE_PER_BLOCK)+1; 
      if (nowGrp < totalGrp){ 
        str.append("<span class='span_box_1'><A href='./member_list_search.do?&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
      } 
      str.append("</DIV>"); 
       
      return str.toString(); 
    }
}
