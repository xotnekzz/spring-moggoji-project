package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



@Controller
public class QnaCont {
  
  @Autowired
  @Qualifier("dev.mvc.qna.QnaProc")
  QnaProcInter qnaProc = null;
  
  public QnaCont(){
    
  }

  //QnA 등록 폼
  @RequestMapping(value="/qna/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/create");
    return mav;
  }
  
  //QnA 등록 처리
  @RequestMapping(value="/qna/create.do", method=RequestMethod.POST)
  public ModelAndView create(RedirectAttributes redirectAttributes,
                        HttpServletRequest request, QnaVO qnaVO){
    ModelAndView mav = new ModelAndView();
   
    //관리자인지 회원인지 구분
    
    String act = qnaProc.act(qnaVO.getMemberno());
    
    if(act.equals("M")){
      qnaVO.setSeqno(2);
    }else{
      qnaVO.setSeqno(1);
    }
    
    //글 등록이니 답변 없음
    qnaVO.setAnsnum(0);
    
    qnaProc.create(qnaVO); // 등록

    mav.setViewName("redirect:/qna/list.do");
   
    return mav;
  }
  
  //QnA 목록 
  @RequestMapping(value="/qna/list.do", method=RequestMethod.GET)
  public ModelAndView list(
      @RequestParam(value="col", defaultValue="") String col,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
   ModelAndView mav = new ModelAndView();
   
   // 검색 기능 추가
   mav.setViewName("/qna/list"); 
   
   // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
   HashMap<String, Object> hashMap = new HashMap<String, Object>();
   hashMap.put("col", col);                  
   hashMap.put("word", word);                  
   hashMap.put("nowPage", nowPage);    
   
   // DBMS - 목록조회
   List<QnaVO> list = qnaProc.list(hashMap);
   mav.addObject("list", list);
   
   // 검색된 레코드 갯수
   int search_count = qnaProc.search_count(hashMap);
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
     
   String paging = qnaProc.paging(search_count, nowPage, col, word);
   mav.addObject("paging", paging);

   mav.addObject("nowPage", nowPage);
   return mav;
 }
  
  //한 건 조회
  @RequestMapping(value="/qna/read.do", method=RequestMethod.GET)
  public ModelAndView read(int qnano) {
    ModelAndView mav = new ModelAndView();
    
    // 조회수 증가
    qnaProc.cnt(qnano);
    
    // DBMS - 한 건 조회 
    QnaVO qnaVO = qnaProc.read(qnano);
    mav.addObject("qnaVO", qnaVO);
    
    
    mav.setViewName("/qna/read");
    return mav;
  }
  
  //질문 수정 폼
  @RequestMapping(value="/qna/update.do", method=RequestMethod.GET)
  public ModelAndView update(int qnano){
    ModelAndView mav = new ModelAndView();
    
    // DBMS - 한 건 조회 
    QnaVO qnaVO = qnaProc.read(qnano);
    mav.addObject("qnaVO", qnaVO);
    
    mav.setViewName("/qna/update");
    
    return mav;
  }
  
  //질문 수정 처리
  @RequestMapping(value="/qna/update.do", method=RequestMethod.POST)
  public ModelAndView update(QnaVO qnaVO){
    ModelAndView mav = new ModelAndView();
    
    //제목 내용 패스워드 타입
    
    qnaProc.update(qnaVO); // 수정

    mav.setViewName("redirect:/qna/list.do");
    return mav;
  }
  
  //질문 삭제 폼
  @RequestMapping(value="/qna/delete.do", method=RequestMethod.GET)
  public ModelAndView delete(int qnano){
    ModelAndView mav = new ModelAndView();
    
    // DBMS - 한 건 조회 
    QnaVO qnaVO = qnaProc.read(qnano);
    mav.addObject("qnaVO", qnaVO);
    
    mav.setViewName("/qna/delete");
    return mav;
  }
  
  //질문 삭제 처리
  @RequestMapping(value="/qna/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_1(int qnano, String qpasswd){
    ModelAndView mav = new ModelAndView();
    
    QnaVO qnaVO = qnaProc.read(qnano);
    
    if(qnaVO.getQpasswd().equals(qpasswd)){
      qnaProc.delete(qnano);
    } 
    mav.setViewName("redirect:/qna/list.do");
    return mav;
  }
  
  
//관리자) 질문 삭제 처리
  @RequestMapping(value="/qna/admin_delete.do", method=RequestMethod.POST)
  public ModelAndView admin_delete_1(String mact, int qnano){
    ModelAndView mav = new ModelAndView();
    
    qnaProc.delete(qnano);
    
    mav.setViewName("redirect:/qna/list.do");
    return mav;
  }
  
//QnA 답글 폼
  @RequestMapping(value="/qna/reply.do", method=RequestMethod.GET)
  public ModelAndView reply() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/reply");
    return mav;
  }
  
  //QnA 답글 처리
  @RequestMapping(value="/qna/reply.do", method=RequestMethod.POST)
  public ModelAndView reply(RedirectAttributes redirectAttributes,
                        HttpServletRequest request, QnaVO qnaVO, int qnano){
    ModelAndView mav = new ModelAndView();
   
    
    //답변 등록이니
    qnaVO.setQnatype("답글");
    qnaVO.setIndent(qnano);
    qnaVO.setAnsnum(1);
    qnaVO.setSeqno(1);
    
    qnaProc.reply(qnaVO); // 등록
    
    
    //statement 변경
    qnaProc.update_statement(qnano);
    

    mav.setViewName("redirect:/qna/list.do");
    return mav;
  }
}