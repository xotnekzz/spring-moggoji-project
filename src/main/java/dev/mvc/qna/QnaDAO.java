package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.member.MemberVO;

@Repository("dev.mvc.qna.QnaDAO")
public class QnaDAO implements QnaDAOInter{

  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public QnaDAO(){
    
    if(sqlSessionTemplate != null){
      
    }
  }

  //질문 등록
  @Override
  public int create(QnaVO qnaVO) {
    int count = sqlSessionTemplate.insert("qna.create", qnaVO);
    return count;
  }
  
  //QnA 전체 목록 조회
  @Override
  public List<QnaVO> list() {
    List<QnaVO> list = sqlSessionTemplate.selectList("qna.list");
    return list;
  }
  
  //QnA 전체 목록 조회 + 페이징  + 검색
  @Override
  public List<QnaVO> list(HashMap hashMap) {
    List<QnaVO> list = null;
    list = sqlSessionTemplate.selectList("qna.list2", hashMap);
    return list;
  }

  //검색된 레코드 갯수
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("qna.search_count", hashMap);
    return cnt;
  }

  //한 건 조회
  @Override
  public QnaVO read(int qnano) {
    QnaVO qnaVO = sqlSessionTemplate.selectOne("qna.read", qnano);
    return qnaVO;
  }

  //조회수 증가
  @Override
  public int cnt(int qnano) {
    int count = sqlSessionTemplate.update("qna.cnt", qnano);
    return count;
  }

  //질문 수정
  @Override
  public int update(QnaVO qnaVO) {
    int count = sqlSessionTemplate.update("qna.update", qnaVO);
    return count;
  }

  //질문 삭제
  @Override
  public int delete(int qnano) {
    int count = sqlSessionTemplate.delete("qna.delete", qnano);
    return count;
  }

  //관리자 & 회원 구분
  @Override
  public String act(int memberno) {
    String act = sqlSessionTemplate.selectOne("qna.act", memberno);
    return act;
  }
  
  //질문 등록
  @Override
  public int reply(QnaVO qnaVO) {
    int count = sqlSessionTemplate.insert("qna.reply", qnaVO);
    return count;
  }
  
  //처리 변경
  @Override
  public int update_statement(int qnano){
    int count = sqlSessionTemplate.update("qna.update_statement", qnano);
    return count;
  }
}
