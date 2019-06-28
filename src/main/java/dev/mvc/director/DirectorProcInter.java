package dev.mvc.director;


public interface DirectorProcInter {
    
    // 회원 등록. ( 성공 시 1 , 실패 시 0 반환 ) 
    public int create(DirectorVO directorVO);   
}
