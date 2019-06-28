package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import dev.mvc.movie.MainBoxOfficeVO;
import dev.mvc.movie.MovielikeVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ReviewCont {
  
  @Autowired  
  @Qualifier("dev.mvc.review.ReviewProc")
  ReviewProcInter reviewProc = null;

  public ReviewCont() {
    //System.out.println("--> ReviewCont Created... ");
  }
  
  // 리뷰 등록 폼
  @RequestMapping(value="/review/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review/create");
    
    return mav;
  }
  
  // 리뷰 등록 처리
  @RequestMapping(value="/review/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();
    
    //reviewProc.create(reviewVO);
    //mav.setViewName("redirect:/review/list");
    mav.setViewName("/review/message");
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
     
    // ---------------------파일 전송----------------------------------------------
    String upDir = Tool.getRealPath(request, "/review/storage");
    MultipartFile file1MF = reviewVO.getFile1MF();
    String mainimg = ""; // 컬럼에 저장할 파일명
    long imgsize = file1MF.getSize();

    if (imgsize > 0) {
      mainimg = Upload.saveFileSpring(file1MF, upDir);
    }
    reviewVO.setMainimg(mainimg);
    reviewVO.setImgsize(imgsize);
 // ---------------------파일 전송 끝----------------------------------------------

    // DBMS - 등록
    if (reviewProc.create(reviewVO) == 1) {
      //msgs.add("리뷰를 등록했습니다.");
      mav.setViewName("redirect:/review/m_list_search.do?memberno="+reviewVO.getMemberno());
      
    } else {
      msgs.add("리뷰 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
      
      links.add("<button type='button' onclick=\"location.href='./m_list_search.do?memberno="+reviewVO.getMemberno()+"'\">목록</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
 
    return mav;
  }
  
  
  // 리뷰 목록 
  @RequestMapping(value="/review/list.do", method=RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    // DBMS - 목록조회
    List<ReviewVO> list = reviewProc.list();
    mav.addObject("list", list);
    
    mav.setViewName("/review/list");
    return mav;
  }
  
  // 한 건 조회
  @RequestMapping(value="/review/read.do", method=RequestMethod.GET)
  public ModelAndView read(int reviewno) {
    ModelAndView mav = new ModelAndView();
    
    // DBMS - 한 건 조회 
    ReviewVO reviewVO = reviewProc.read(reviewno);
    mav.addObject("reviewVO", reviewVO);
    
    //글을 쓴 회원 정보 가져오기
    MnameVO mnameVO = reviewProc.mname(reviewno);
    mav.addObject("mnameVO", mnameVO);
    
    //리뷰별 댓글 갯수
    int rcc = reviewProc.rcc(reviewno);
    mav.addObject("rcc", rcc);
    
    mav.setViewName("/review/read");
    return mav;
  }
  
  // 수정 폼
  @RequestMapping(value="/review/update.do", method=RequestMethod.GET)
  public ModelAndView update(int reviewno) {
    ModelAndView mav = new ModelAndView();
    
    // DBMS - 한 건 조회 
    ReviewVO reviewVO = reviewProc.update(reviewno);
    mav.addObject("reviewVO", reviewVO);
    
    mav.setViewName("/review/update");
    return mav;
   }
  
  //수정 처리
  @RequestMapping(value="/review/update.do", method=RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes,
      HttpServletRequest request, ReviewVO reviewVO, int nowPage, String word, int memberno, HttpSession session) {
    ModelAndView mav = new ModelAndView();
   //mav.setViewName("/review/message"); 
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    int reviewno = reviewVO.getReviewno();
    
    // ------------------------파일 전송---------------------------------------------------
    String upDir = Tool.getRealPath(request, "/review/storage");
    /*
    <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
    ↓
     name='file1MF'에 해당하는 필드를 찾아서 File 객체를 자동으로 할당
    ↓
    BlogVO.java: private MultipartFile file1MF;
    ↓
     파일 객체 사용: MultipartFile file1MF = blogVO.getFile1MF();          
     */
    MultipartFile file1MF = reviewVO.getFile1MF();
    String mainimg = "";                    // DBMS file1 컬럼의 값
    long imgsize = file1MF.getSize(); // 파일 크기
    
    // 기존에 등록된 글 정보 로딩
    ReviewVO reviewVO_old = reviewProc.read(reviewno);
    
    if (imgsize > 0) { // 등록된 파일이 있다면
      Tool.deleteFile(upDir, reviewVO_old.getMainimg());    // 기존 파일 삭제
      mainimg = Upload.saveFileSpring(file1MF, upDir); // 신규 파일 업로드

    } else {
      // 파일을 변경하지 않는 경우 기존 파일 정보 사용
      mainimg = reviewVO_old.getMainimg();
      imgsize = reviewVO_old.getImgsize();
    }
    reviewVO.setMainimg(mainimg);
    reviewVO.setImgsize(imgsize);
    // ------------------------파일 전송 끝---------------------------------------------------
    
    // 회원 개발 후 session 으로변경
    //int memberno = session.getAttribute("memberno");
    reviewVO.setMemberno(memberno);
    
    
    // DBMS - 수정 
    if (reviewProc.update(reviewVO) == 1) {
      
      //msgs.add("리뷰를 수정했습니다.");
      //links.add("<button type='button' onclick=\"location.href='./read.do?reviewno="+reviewno+"'\">수정 확인</button>");
/*      redirectAttributes.addAttribute("word", word);
      redirectAttributes.addAttribute("nowPage", nowPage);*/
     mav.setViewName("redirect:/review/m_list_search.do?memberno="+reviewVO.getMemberno()+"&word="+word+"&nowPage="+nowPage);
      //mav.setViewName("redirect:/review/read.do?reviewno="+reviewVO.getReviewno()+"&word="+word+"&nowPage="+nowPage); 
    } else {
      msgs.add("리뷰 수정에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
      
      links.add("<button type='button' onclick=\"location.href='./m_list_search.do?memberno="+reviewVO.getMemberno()+"'\">목록</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    return mav;
  } 
  
  //삭제폼
  @RequestMapping(value = "/review/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int reviewno) {
    //System.out.println("--> delete() GET executed!!!!!!!");
    ModelAndView mav = new ModelAndView();

    ReviewVO reviewVO = reviewProc.read(reviewno);
    mav.addObject("reviewVO", reviewVO);
    
    mav.setViewName("/review/delete"); 
    return mav;
  }
   
 //삭제 처리
  @RequestMapping(value="/review/delete.do", method=RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes,
                                         HttpServletRequest request, int reviewno, String word, int nowPage) {
    ModelAndView mav = new ModelAndView();
   
    //mav.setViewName("/review/message"); 
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    ReviewVO reviewVO = reviewProc.read(reviewno);
    
    // -----------------파일 삭제----------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/review/storage");

    Tool.deleteFile(upDir, reviewVO.getMainimg());    // 기존 파일 삭제
      
    // ------------------파일 삭제 끝---------------------------------------------------------
    
   // int count = reviewProc.delete(reviewno);
    
    if ((reviewProc.delete(reviewno)) == 1) {
      
      // 4개의 레코드가 하나의 페이지인경우 5번째 레코드가 삭제되면 페이지수도
      // 2페이지에서 1 페이지로 줄여야합니다. 
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("word", word);                 
      if (reviewProc.search_count(hashMap) % Review.RECORD_PER_PAGE == 0){ 
        nowPage = nowPage - 1;
        if (nowPage < 1){ 
          nowPage = 1; 
        }
      }
 /*     redirectAttributes.addAttribute("count", count); // 1 or 0
      redirectAttributes.addAttribute("word", word);
      System.out.println("nowPage : "+nowPage);
      redirectAttributes.addAttribute("nowPage", nowPage);*/
      mav.setViewName("redirect:/review/m_list_search.do?memberno="+reviewVO.getMemberno()+"&nowPage="+nowPage+"&word="+word);

    } else { 
      msgs.add("리뷰삭제에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요.");
      links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./m_list_search.do?memberno="+reviewVO.getMemberno()+"'\">목록</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    return mav;  
  } 
  
  /**
   * 목록 + 검색 + 페이징 지원(메인메뉴)
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/review/all_list_search.do", method = RequestMethod.GET)
  public ModelAndView all_list_search(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    //System.out.println("--> list_search.do GET called.");
    //System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
     
    // 검색 기능 추가
    mav.setViewName("/review/all_list_search");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("word", word);                  
    hashMap.put("nowPage", nowPage);       
    
    // 검색 목록
    List<ReviewVO> list = reviewProc.all_list_search(hashMap);
    mav.addObject("list", list);
    
    
    // 검색된 레코드 갯수
    int search_count = reviewProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    /* 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param categoryno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = reviewProc.paging(search_count, nowPage, word);
    mav.addObject("paging", paging);
 
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원(회원)
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/review/m_list_search.do", method = RequestMethod.GET)
  public ModelAndView m_list_search(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      HttpSession session
      ) { 
    //System.out.println("--> list_search.do GET called.");
    //System.out.println("--> nowPage: " + nowPage);
    
    int memberno = (int) session.getAttribute("memberno");
    ModelAndView mav = new ModelAndView();
     
    // 검색 기능 추가
    mav.setViewName("/review/m_list_search");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("word", word);                  
    hashMap.put("nowPage", nowPage);       
    hashMap.put("memberno", memberno);       
    
    // 검색 목록
    List<ReviewVO> list = reviewProc.m_list_search(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int msearch_count = reviewProc.msearch_count(hashMap);
    mav.addObject("msearch_count", msearch_count);
    //System.out.println("nowPage : "+nowPage);

     
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 (회원)
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param categoryno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = reviewProc.mpaging(msearch_count, nowPage, word, memberno);
    mav.addObject("paging", paging);
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  
  //리뷰 갯수
  @ResponseBody
  @RequestMapping(value="/review/review_count.do", produces="application/json; charset=utf8", method=RequestMethod.GET)
  public String review_count(){
    
    JSONObject obj = new JSONObject();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    int count = reviewProc.search_count(hashMap);
    
    obj.put("count", count);
    
    return obj.toString();
   }
}
