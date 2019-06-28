package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

public interface QnaProcInter {

  //질문 등록 ( 성공 시 1 , 실패 시 0 반환 ) 
  public int create(QnaVO qnaVO);
  
  //QnA 전체 목록 조회
  public List<QnaVO> list();
  
  //QnA 전체 목록 조회 + 페이징  + 검색
  public List<QnaVO> list(HashMap hashMap);
  
  //검색된 레코드 갯수
  public int search_count(HashMap hashMap); 
  
  //페이징
  public String paging(int search_count, int nowPage,String col, String word);
  
  //한 건 조회
  public QnaVO read(int qnano);
  
  //조회수 증가
  public int cnt(int qnano);
  
  //질문 수정
  public int update(QnaVO qnaVO);
  
  //질문 삭제
  public int delete(int qnano);
  
  //관리자 & 회원 구분
  public String act(int memberno);
  
  //답변 등록 ( 성공 시 1 , 실패 시 0 반환 ) 
  public int reply(QnaVO qnaVO);
  
  //처리 변경
  public int update_statement(int qnano);
}
