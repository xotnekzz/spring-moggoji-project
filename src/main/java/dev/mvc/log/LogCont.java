package dev.mvc.log;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

@Controller
public class LogCont {
  
  @Autowired

  @Qualifier("dev.mvc.log.LogProc") // 할당되는 Class 객체의 이름.
  private LogProcInter logProc;
  
  public LogCont() {
      //System.out.println("LogCont 실행되었음.");
  }

}
