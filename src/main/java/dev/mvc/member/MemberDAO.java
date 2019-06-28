package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

 
@Repository("dev.mvc.member.MemberDAO")
public class MemberDAO implements MemberDAOInter{

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate = null;
    
    public MemberDAO() {
    }

    @Override
    public int create(MemberVO memberVO) {
      int count = sqlSessionTemplate.insert("member.create", memberVO);
      return count;
    }  
    
    @Override
    public int checkId(String email) {
      int count = sqlSessionTemplate.selectOne("member.checkId", email);
      
      return count;
    }
    
    @Override
    public List<MemberVO> list() {
      List<MemberVO> list = sqlSessionTemplate.selectList("member.list");
      
      return list;
    } 
    
    @Override
    public List<MemberVO> member_list_search(HashMap hashMap){
      List<MemberVO> list = null;
      list = sqlSessionTemplate.selectList("member.member_list_search", hashMap);
      return list;
    }
    
    @Override
    public int search_count(HashMap hashMap) {
      int cnt = sqlSessionTemplate.selectOne("member.search_count", hashMap);
      return cnt;
    }
    
    @Override
    public MemberVO read(int memberno) {
      MemberVO memberVO = sqlSessionTemplate.selectOne("member.read", memberno);
      
      return memberVO;
    }
    
    @Override
    public MemberVO read(String email) {
      MemberVO memberVO = sqlSessionTemplate.selectOne("member.read2", email);
      
      return memberVO;
    }
    
    @Override
    public String login(String email) {
      String passwd = sqlSessionTemplate.selectOne("member.login", email);
      return passwd;
    } 
    
    @Override
    public int member_update(MemberVO memberVO){
      int count = sqlSessionTemplate.update("member.update", memberVO);
      return count;
    }
    
    @Override
    public int member_delete(int memberno){
      int count = sqlSessionTemplate.delete("member.delete", memberno);
      return count;
    }
    
    @Override
    public int member_act(MemberVO memberVO){
      int count = sqlSessionTemplate.update("member.act", memberVO);
      return count;
    }
}
