package dev.mvc.director;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.director.DirectorDAO")
public class DirectorDAO implements DirectorDAOInter{
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate = null;
    
    @Override
    public int create(DirectorVO directorVO) {
      int count = sqlSessionTemplate.insert("director.create", directorVO);
      return count;
    }  
}
