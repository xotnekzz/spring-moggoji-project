package dev.mvc.log;

public interface LogDAOInter {
  
  /**
   * 로그 생성
   * <Xmp>
   * <insert id="log_create" parameterType="LogVO">
   * </Xmp>
   * @return
   */
  public int log_create(LogVO logVO);
  
  
}
