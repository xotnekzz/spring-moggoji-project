package dev.mvc.member;
 
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class MemberCont {
    @Autowired

    @Qualifier("dev.mvc.member.MemberProc") // 할당되는 Class 객체의 이름.
    private MemberProcInter memberProc;
    
    public MemberCont() {
        //System.out.println("MemberController 실행되었음.");
    }
    
    // 회원가입 페이지 호출.
    @RequestMapping(value = "/member/create.do", method = RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/member_create"); // /webapp/member/member_create.jsp

      return mav;
    }
    
    
    // 회원가입 페이지에서 email중복 확인을 클릭하였을때 AJAX통신으로 email 조회.
    @ResponseBody
    @RequestMapping(value = "/member/checkId.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
    public String checkId(String memail) {
      
      
      JSONObject obj = new JSONObject();
      
      int cnt = memberProc.checkId(memail);
      obj.put("cnt", cnt);

      return obj.toJSONString();
    }
    
    // 회원가입 페이지 -> DB입력.
    @RequestMapping(value="/member/create.do", method=RequestMethod.POST)
    public ModelAndView create(RedirectAttributes redirectAttributes,
                          HttpServletRequest request, MemberVO memberVO){
      ModelAndView mav = new ModelAndView();
      
      int count = memberProc.checkId(memberVO.getMemail());
      
      if (count == 1) { // ID 중복시 메시지 출력
        redirectAttributes.addAttribute("email", memberVO.getMemail());
        // ex) 'james9957@naver.com 은 중복된 이메일입니다.' 을 view쪽에서 받아서 출력.
         
      } else {
        
        // -------------------------------------------------------------------
        // 파일 전송 코드 시작
        // -------------------------------------------------------------------
        
        String upDir = Tool.getRealPath(request, "/member/storage"); //경로설정
        
        MultipartFile fileMF = memberVO.getFileMF(); // jsp파일 name이랑 같게 해야함.
        String file = ""; // 컬럼에 저장할 파일명
        long imgsize = fileMF.getSize();

        if (imgsize > 0) { // 파일이 있다면
          file = Upload.saveFileSpring(fileMF, upDir); 
        }
        memberVO.setMfile(file);
        memberVO.setMsize(imgsize);    
        
        // -------------------------------------------------------------------
        // 파일 전송 코드 종료
        // -------------------------------------------------------------------

        // DBMS - 등록
        
        count = memberProc.create(memberVO); // 등록

        redirectAttributes.addAttribute("sw", "create");    // 중복은 되지 않으나 회원가입 실패/성공을 구분하기 위한 변수.
        redirectAttributes.addAttribute("count", count); // 0 또는 1 반환으로 0은 실패/ 1은 성공.
      }
      System.out.println("저장됨");
      mav.setViewName("redirect:/index.jsp");
     
      return mav;
    }
    
   /* // (현재) session값을 통하여 로그인 상태인지 확인 후 출력.
    // (예상 진행) Tool.java에서 session 값을 이용하여 session id값이 관리자 인지 확인 후 출력.
    @RequestMapping(value="/member/member_list.do", method=RequestMethod.GET)
    public ModelAndView member_list(){
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/member_list"); // webapp/member/list.jsp
      
      List<MemberVO> list = memberProc.list();
      mav.addObject("list", list);
   
      return mav;
    }   */   
    
    
    /**
     * 목록 + 검색 + 페이징 지원(메인메뉴)
     * @param word
     * @param nowPage
     * @return
     */
    @RequestMapping(value = "/member/member_list_search.do", method = RequestMethod.GET)
    public ModelAndView member_list_search(
        @RequestParam(value="col", defaultValue="") String col,
        @RequestParam(value="word", defaultValue="") String word,
        @RequestParam(value="nowPage", defaultValue="1") int nowPage) { 
      
      ModelAndView mav = new ModelAndView();
       
      // 검색 기능 추가
      mav.setViewName("/member/member_list"); 
      
      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("col", col);                  
      hashMap.put("word", word);                  
      hashMap.put("nowPage", nowPage);       
      
      // 검색 목록
      List<MemberVO> list = memberProc.member_list_search(hashMap);
      mav.addObject("list", list);
      
      // 검색된 레코드 갯수
      int search_count = memberProc.search_count(hashMap);
      mav.addObject("search_count", search_count);
   
      
       /*
       * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
       * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
       *
       * @param categoryno 카테고리번호 
       * @param search_count 검색(전체) 레코드수 
       * @param nowPage     현재 페이지
       * @param title 검색어
       * @return 페이징 생성 문자열*/
        
      String paging = memberProc.paging(search_count, nowPage, word);
      mav.addObject("paging", paging);
   
      mav.addObject("nowPage", nowPage);
      
      return mav;
    }
    
    // (현재)회원 목록 -> 회원 조회를 함. 사실 페이지만 변하는 것이지 list와 별 다를 것이 없음.
    // (예상 진행) 수정, 삭제 기능을 추가하여 관리자가 직접 계정에 대한 제어를 할 수 있도록 진행.
    @RequestMapping(value="/member/read.do", method=RequestMethod.GET)
    public ModelAndView read(int memberno){
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/read"); // webapp/member/read.jsp
      
      MemberVO memberVO = memberProc.read(memberno);
      mav.addObject("memberVO", memberVO);
      
      return mav;
    }  
    
    // 비밀번호 변경 페이지로 이동.
    @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.GET)
    public ModelAndView passwd_update(){
      
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/passwd_update"); // webapp/member/passwd_update.jsp
      
      return mav;
    }
    
    // 로그인 페이지로 이동.
    @RequestMapping(value="/member/login_form.do", method=RequestMethod.GET)
    public ModelAndView login(){
      
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/login_form"); // webapp/member/passwd_update.jsp
      
      return mav;
    }
    
    //로그인 처리
    @RequestMapping(value="/member/login_check.do", method=RequestMethod.POST)
    public ModelAndView login(RedirectAttributes redirectAttributes, HttpSession session, String email, String passwd, HttpServletRequest request){
     
      ModelAndView mav = new ModelAndView();
      
      int count = memberProc.checkId(email);
      
      if(count == 1){ //로그인 성공
        if(memberProc.login(email).equals(passwd)){ // 패스워드 체크
          
          MemberVO memberVO = memberProc.read(email);
          
          String mname = memberVO.getMname();
          int memberno = memberVO.getMemberno();
          String mact = memberVO.getMact();
          
          /*세션에 저장*/
          session.setAttribute("memberno", memberno);
          session.setAttribute("email", email);
          session.setAttribute("passwd", passwd);
          session.setAttribute("mname", mname);
          session.setAttribute("mact", mact);
          
          session.setMaxInactiveInterval(500*60);
          mav.setViewName("redirect:/");
          
        }else{ //로그인 실패
          count = 0;
          mav.setViewName("redirect:./login_form.do");
        }
      }else{
        count = 0;
        mav.setViewName("redirect:./login_form.do");
      }
      mav.addObject("count", count); 
      return mav;
      
    }
    
  //로그아웃
    @RequestMapping(value="/member/logout.do", method=RequestMethod.GET)
    public ModelAndView logout(HttpSession session){
     
      ModelAndView mav = new ModelAndView();
      session.invalidate();
      mav.setViewName("redirect:/index.jsp");
      return mav;
    }
    
    //관리자 회원 수정 폼
    @RequestMapping(value="/member/member_update.do", method = RequestMethod.GET)
    public ModelAndView update(int memberno) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/member_update"); 
      
      MemberVO memberVO = memberProc.member_update(memberno);
      mav.addObject("memberVO", memberVO);

      return mav;
    }
    
    
    //회원 수정 처리
    @RequestMapping(value="/member/member_update.do", method=RequestMethod.POST)
    public ModelAndView update(RedirectAttributes redirectAttributes,
                          HttpServletRequest request, MemberVO memberVO, String col, String word, int nowPage){
      ModelAndView mav = new ModelAndView();
      
      
       // System.out.println("수정파일전송");
        // -------------------------------------------------------------------
        // 파일 전송 코드 시작
        // -------------------------------------------------------------------
        
        String upDir = Tool.getRealPath(request, "/member/storage"); //경로설정
        
        MultipartFile fileMF = memberVO.getFileMF(); // jsp파일 name이랑 같게 해야함.
        String file = ""; // 컬럼에 저장할 파일명
        long imgsize = fileMF.getSize();

        //기존 등록 정보 읽어옴.
        MemberVO memberVO_old = memberProc.read(memberVO.getMemberno());
        
        if (imgsize > 0) { // 전송할 파일이 있다면
          
          Tool.deleteFile(memberVO_old.getMfile()); // 기존파일 삭제
          Tool.deleteFile(upDir, memberVO_old.getMfile());
          
          file = Upload.saveFileSpring(fileMF, upDir); //신규 업로드
        }else{
          file = memberVO_old.getMfile();
          imgsize = memberVO_old.getMsize();
        }
        memberVO.setMfile(file);
        memberVO.setMsize(imgsize);    
        
        // -------------------------------------------------------------------
        // 파일 전송 코드 종료
        // -------------------------------------------------------------------

        // DBMS - 등록
        int count = memberProc.member_update(memberVO); // 수정

        redirectAttributes.addAttribute("sw", "update");    // 중복은 되지 않으나 회원가입 실패/성공을 구분하기 위한 변수.
        redirectAttributes.addAttribute("count", count); // 0 또는 1 반환으로 0은 실패/ 1은 성공.
      
      System.out.println("저장됨");
      mav.setViewName("redirect:/member/member_list_search.do?col="+col+"&word="+word+"&nowPage="+nowPage);
     
      return mav;
    }
    
    //회원 수정 폼(마이페이지)
    @RequestMapping(value="/member/mupdate.do", method = RequestMethod.GET)
    public ModelAndView mupdate(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/myinfo"); 
      
      int memberno = (int) session.getAttribute("memberno"); 
      
      MemberVO memberVO = memberProc.member_update(memberno);
      mav.addObject("memberVO", memberVO);

      return mav;
    }
    
  //회원 수정 처리(마이페이지)
    @RequestMapping(value="/member/mupdate.do", method=RequestMethod.POST)
    public ModelAndView mupdate(RedirectAttributes redirectAttributes,
                          HttpServletRequest request, MemberVO memberVO){
      ModelAndView mav = new ModelAndView();
      
      
       // System.out.println("수정파일전송");
        // -------------------------------------------------------------------
        // 파일 전송 코드 시작
        // -------------------------------------------------------------------
        
        String upDir = Tool.getRealPath(request, "/member/storage"); //경로설정
        
        MultipartFile fileMF = memberVO.getFileMF(); // jsp파일 name이랑 같게 해야함.
        String mfile = ""; // 컬럼에 저장할 파일명
        long imgsize = fileMF.getSize();

        //기존 등록 정보 읽어옴.
        MemberVO memberVO_old = memberProc.read(memberVO.getMemberno());
        
        if (imgsize > 0) { // 전송할 파일이 있다면
          
          Tool.deleteFile(memberVO_old.getMfile()); // 기존파일 삭제
          Tool.deleteFile(upDir, memberVO_old.getMfile());
          
          mfile = Upload.saveFileSpring(fileMF, upDir); //신규 업로드
          
        }else{ //파일을 변경하지 않는 경우
          mfile = memberVO_old.getMfile();
          imgsize = memberVO_old.getMsize();
        }
        memberVO.setMfile(mfile);
        memberVO.setMsize(imgsize);    
        
        // -------------------------------------------------------------------
        // 파일 전송 코드 종료
        // -------------------------------------------------------------------

        // DBMS - 등록
        memberProc.member_update(memberVO); // 수정
        mav.setViewName("redirect:/member/mupdate.do");
     
      return mav;
    }
    
    
    //회원 정보 삭제 폼
    @RequestMapping(value = "/member/member_delete.do", method = RequestMethod.GET)
    public ModelAndView delete(int memberno) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/delete"); // /webapp/member/delete.jsp

      MemberVO memberVO = memberProc.read(memberno);
      mav.addObject("memberVO", memberVO);
      
      return mav;
    }
    
    
    //회원 정보 삭제 처리
    @RequestMapping(value="/member/member_delete.do", method=RequestMethod.POST)
    public ModelAndView delete(HttpServletRequest request, int memberno){
      ModelAndView mav = new ModelAndView();
      
      MemberVO memberVO = memberProc.read(memberno);
      
      // -----------------파일 삭제----------------------------------------------------------
      String upDir = Tool.getRealPath(request, "/member/storage");

      Tool.deleteFile(upDir, memberVO.getMfile());    // 기존 파일 삭제
        
      // ------------------파일 삭제 끝---------------------------------------------------------
      
      int count = memberProc.member_delete(memberno);
      System.out.println("count : " + count);
      
      mav.setViewName("redirect:/member/member_list_search.do");
      
      return mav;
    }
    
    //회원 권한 폼
    @RequestMapping(value = "/member/act_form.do", method = RequestMethod.GET)
    public ModelAndView act(int memberno) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/member/act_form"); // /webapp/member/act_form.jsp

      MemberVO memberVO = memberProc.read(memberno);
      mav.addObject("memberVO", memberVO);
      
      return mav;
    }
    
  //회원 권한 처리
    @RequestMapping(value="/member/act_proc.do", method=RequestMethod.POST)
    public ModelAndView act(RedirectAttributes redirectAttributes,
                          HttpServletRequest request, MemberVO memberVO, String mact){
      ModelAndView mav = new ModelAndView();
      
        // DBMS - 등록
        int count = memberProc.member_act(memberVO); // 수정

        redirectAttributes.addAttribute("sw", "update");    // 중복은 되지 않으나 회원가입 실패/성공을 구분하기 위한 변수.
        redirectAttributes.addAttribute("count", count); // 0 또는 1 반환으로 0은 실패/ 1은 성공.
      
      System.out.println("저장됨");
      mav.setViewName("redirect:/member/act_proc.jsp");
     
      return mav;
    }
    
    // //비밀번호 찾기/ email중복 확인을 클릭하였을때 AJAX통신으로 email 조회.
    @ResponseBody
    @RequestMapping(value = "/member/forgot_password.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
    public String forgot_password(String memail){
      
      JSONObject obj = new JSONObject();
      
      int cnt = memberProc.checkId(memail);
      
      if(cnt == 1){
        
        /*메일 발송 시작*/
        class MyAuthentication extends Authenticator {
          PasswordAuthentication pa; 
          public MyAuthentication(){ 
            pa = new PasswordAuthentication("test@nulunggi.pe.kr", "test2016");
          } 
         
          public PasswordAuthentication getPasswordAuthentication() {
            return pa;
          }
        }
         
        String subject = "[moggoji] 회원님의 비밀번호 메일입니다.";  // 제목
        
        MemberVO memberVO = memberProc.read(memail);
        
        String content = "비밀번호 : ";  // 내용
        content += memberVO.getMpasswd()+"<br><br>";
         
         
        // mw-002.cafe24.com, Cafe24
        String host = "mw-002.cafe24.com";    // smtp mail server(서버관리자)     
        String from = "moggoji@gmail.com";   // 보내는 주소, 블로그 관리자 주소 
        String to = memail;    // 받는 사람
         
        Properties props = new Properties();  // SMTP 프로토콜 사용, port 25
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.auth","true");
         
        Authenticator authenticator = new MyAuthentication();
        Session sess = Session.getInstance(props, authenticator);   // 계정 인증 검사
         
        try { 
          Message msg = new MimeMessage(sess);   // 메일 내용 객체 생성
          msg.setFrom(new InternetAddress(from));   // 보내는 사람 설정
                 
          // 한명에게만 보냄 
          InternetAddress[] address = {new InternetAddress(to)}; // 받는 사람 설정
          
          msg.setRecipients(Message.RecipientType.TO, address); // 수령인 주소 설정
                
          msg.setSubject(subject);                  // 제목 설정 
          msg.setSentDate(new Date());          // 보낸 날짜 설정
                
         
          // 보내는 내용으로 HTML 형식으로 보낼 경우
          msg.setContent(content, "text/html;charset=utf-8");
                
          Transport.send(msg);  // 메일 전송
         
          
        } catch (MessagingException mex) { 
          System.out.println(mex.getMessage());
          // out.println(mex.getMessage()+"<br><br>");
          // out.println(to + "님에게 메일 발송을 실패 했습니다.");
        }
        /*메일 발송 끝*/
      }
      
      obj.put("cnt", cnt);

      return obj.toJSONString();
    }

}