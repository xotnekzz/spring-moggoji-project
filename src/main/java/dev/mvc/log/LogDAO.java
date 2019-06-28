package dev.mvc.log;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.log.LogDAO")
public class LogDAO implements LogDAOInter {
  
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public LogDAO(){
    
  }
  
  /**
   * 로그 생성
   * <Xmp>
   * <insert id="log_create" parameterType="LogVO">
   * </Xmp>
   * @return
   */
  @Override
  public int log_create(LogVO logVO){
    int count = sqlSessionTemplate.insert("log.log_create", logVO);
    return count;
  }

}
