package dev.mvc.director;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;

@Controller
public class DirectorCont {

    @Autowired
    @Qualifier("dev.mvc.director.DirectorProc") // 할당되는 Class 객체의 이름.
    private DirectorProcInter directorProc;
    
    
    public DirectorCont() {
        //System.out.println("DirectorCont 실행되었음.");
    }
    
    
    // 빅데이터에서 감독 DB에 저장하는 컨트롤러 부분. 
/*  @RequestMapping(value="/director/create.do", method=RequestMethod.GET)
    public ModelAndView create() throws OpenAPIFault, Exception {
    ModelAndView mav = new ModelAndView();

    String curPage = "5"; // 몇번 째 데이터 묶음을 가져 올 것인지?
    String itemPerPage = "34000"; // 17만개의 데이터를 몇개씩 묶을 것인지?
    String peopleNm = "";
    String filmoNames = "";

    String key = "e9d0301005f12bb578caf805757ad88f";

    KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);

    String peopleList = "";

    peopleList = service.getPeopleList(true, curPage, itemPerPage, peopleNm, filmoNames);
    peopleList = "{ " + peopleList.substring(37, peopleList.length() - 22) + " } ";
 
    JSONParser parser = new JSONParser();
    JSONObject jsonobj = null;
    jsonobj = (JSONObject) parser.parse(peopleList);

    JSONArray jsonarray = (JSONArray) jsonobj.get("peopleList");

    DirectorVO directorVO;
    
    for (int i = 0; i < jsonarray.size(); i++) {
      JSONObject peopleObj = (JSONObject) jsonarray.get(i);
      if (peopleObj.get("repRoleNm").equals("감독")) {

        directorVO = new DirectorVO();

        directorVO.setDirectorNm(peopleObj.get("peopleNm").toString());

        if (peopleObj.get("peopleNmEn") != null) {
          directorVO.setDirectorEnNm(peopleObj.get("peopleNmEn").toString());
        } else {
          directorVO.setDirectorEnNm("");
        }
        directorVO.setDcode(peopleObj.get("peopleCd").toString());

        directorProc.create(directorVO);
      } 
    }
    System.out.println("json호출5");
    mav.setViewName("");
    return mav; 
  }*/
}
