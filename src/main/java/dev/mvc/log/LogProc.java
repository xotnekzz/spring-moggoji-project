package dev.mvc.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;


@Component("dev.mvc.log.LogProc")    
public class LogProc implements LogProcInter {

  @Autowired
  @Qualifier("dev.mvc.log.LogDAO")
  private LogDAOInter logDAO = null;
  
  public LogProc(){
    
  }
  /**
   * 로그 생성
   * <Xmp>
   * <insert id="log_create" parameterType="LogVO">
   * </Xmp>
   * @return
   */
  @Override
  public int log_create(LogVO logVO) {
    int count = logDAO.log_create(logVO);
    return count;
  }
  
}
