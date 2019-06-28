package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

import dev.mvc.review.ReviewVO;

public interface MemberDAOInter {
   
    // 회원 등록. ( 성공 시 1, 실패 시 0 반환 )
   public int create(MemberVO memberVO);   
   
   
   // 이메일 중복 체크 ( 중복되는 이메일 개수 반환 , 중복 시 1, 중복 아닐 시 0 반환 )
   public int checkId(String email);
   
   // 회원 전체 목록 출력.
   public List<MemberVO> list();
   
   // 회원 전체 목록 출력 + 검색 + 페이징
   public List<MemberVO> member_list_search(HashMap hashMap);

   //검색된 레코드 갯수
   public int search_count(HashMap hashMap); 
   
   // 회원 1명 조회.
   public MemberVO read(int memberno);
   
   // 회원 1명 조회.
   public MemberVO read(String email);
   
   //login
   public String login(String email);
   
   //회원 정보 수정
   public int member_update(MemberVO memberVO);
   
   //회원 정보 삭제
   public int member_delete(int memberno);
   
   //회원 권한 수정
   public int member_act(MemberVO memberVO);
}
