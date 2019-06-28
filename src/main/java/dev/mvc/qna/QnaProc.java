package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.member.Member;
import dev.mvc.member.MemberVO;

@Component("dev.mvc.qna.QnaProc")
public class QnaProc implements QnaProcInter{
  
  @Autowired
  @Qualifier("dev.mvc.qna.QnaDAO")
  QnaDAOInter qnaDAO = null;
  
  public QnaProc(){
    
  }
  //질문 등록
  @Override
  public int create(QnaVO qnaVO) {
    int count = qnaDAO.create(qnaVO);
    return count;
  }
  
  //QnA 전체 목록 조회
  @Override
  public List<QnaVO> list() {
    List<QnaVO> list = qnaDAO.list();
    return list;
  }

  //QnA 전체 목록 조회 + 페이징  + 검색
  @Override
  public List<QnaVO> list(HashMap hashMap) {
    /* 페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Qna.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Qna.RECORD_PER_PAGE;   
   
/*    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   hashMap.put("startNum", startNum);
   hashMap.put("endNum", endNum);
   
   List<QnaVO> list = qnaDAO.list(hashMap); 
   
   return list;
  }

  //검색된 레코드 갯수
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = qnaDAO.search_count(hashMap);
    return cnt;
  }
  
  //페이징
  @Override
  public String paging(int search_count, int nowPage, String col, String word) {
    int totalPage = (int)(Math.ceil((double)search_count/Qna.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Qna.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Qna.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Qna.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Qna.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
      str.append("<span class='span_box_1'><A href='./list.do?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./list.do?col="+col+"&word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 
     
    // 10개 다음 페이지로 이동 
    //nowGrp : 1(1~10 page), nowGrp : 2(11~20 page), nowGrp : 3(21~30 page) 
    // 현재 1 그룹인 경우 : (1*10)+1 = 2 그룹의 11
    // 현재 2 그룹인 경우 : (2*10)*+1 = 3 그룹의 21
    _nowPage = (nowGrp * Member.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list.do?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

  //한 건 조회
  @Override
  public QnaVO read(int qnano) {
    QnaVO qnaVO = qnaDAO.read(qnano);
    return qnaVO;
  }
  
  //조회수 증가
  @Override
  public int cnt(int qnano) {
    int count = qnaDAO.cnt(qnano);
    return count;
  }
  
  //질문 수정
  @Override
  public int update(QnaVO qnaVO) {
    int count = qnaDAO.update(qnaVO);
    return count;
  }
  //질문 삭제
  @Override
  public int delete(int qnano) {
    int count = qnaDAO.delete(qnano);
    return count;
  }
  
  //관리자 & 회원 구분
  @Override
  public String act(int memberno) {
    String act = qnaDAO.act(memberno);
    return act;
  }

  //답변 등록 ( 성공 시 1 , 실패 시 0 반환 ) 
  public int reply(QnaVO qnaVO){
    int count = qnaDAO.reply(qnaVO);
    return count;
  }
  
  //처리 변경
  @Override
  public int update_statement(int qnano){
    int count = qnaDAO.update_statement(qnano);
    return count;
  }
}
