package dev.mvc.actor;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.actor.ActorDAO")
public class ActorDAO implements ActorDAOInter {

  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
   
  public ActorDAO() {
    //System.out.println("--> ActorDAO create.");
    
    if(sqlSessionTemplate != null) {
      System.out.println("--> sqlSessionTemplate 할당됨.");
    }
  }
  
  /**
   * <Xmp>
   *  배우정보 입력
   *  <insert id="create" parameterType="ActorVO">
   * </Xmp>
   * @param ActorVO
   * @return 처리된 레코드 개수
   */
  @Override
  public int create(ActorVO actorVO) {
    int count = sqlSessionTemplate.insert("actor.create", actorVO);
    return count; 
  }
 
}
