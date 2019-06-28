package dev.mvc.actor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.actor.ActorProc")
public class ActorProc implements ActorProcInter {
  @Autowired
  @Qualifier("dev.mvc.actor.ActorDAO")
  private ActorDAOInter actorDAO = null;
    
  public ActorProc() {
    //System.out.println("--> ActorProc Created.");
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
    int count = actorDAO.create(actorVO);
    return count; 
  }

}
