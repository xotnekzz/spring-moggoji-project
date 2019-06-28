package dev.mvc.review.comment;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class RcommentCont {
  
  @Autowired
  @Qualifier("dev.mvc.review.comment.RcommentProc")
  RcommentProcInter rcommnetProc = null;

  public RcommentCont(){
  }
  
  //댓글 등록
  @ResponseBody
  @RequestMapping(value="/rcomment/create.do", method=RequestMethod.POST, produces = "text/json;charset=UTF-8")
  public String create(RcommentVO rcommentVO){
    
    //System.out.println("댓글 등록");
    
    JSONObject obj = new JSONObject();
    JSONArray msgs = new JSONArray();
    
    if(rcommnetProc.create(rcommentVO) == 1){
      msgs.put("success");
    }else{
      msgs.put("fail");
    }
   obj.put("msgs", msgs);
   
    return obj.toString();
  }

  //댓글 목록
  @ResponseBody
  @RequestMapping(value="/rcomment/list.do", produces="application/json; charset=utf8", method=RequestMethod.GET)
  public ResponseEntity list(int reviewno) {
    //ResponseEntity : 응답 + 응답 코드
    
    //System.out.println("댓글 목록"); 
    
    
    HttpHeaders responseHeaders = new HttpHeaders();

    List<RcommentVO> list = rcommnetProc.list(reviewno);
    
    //int comment_count = rcommnetProc.comment_count(reviewno);
    //System.out.println("댓글 갯수 : "+comment_count);  
    
    JSONArray json = new JSONArray(list);

    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }

  
  //댓글 삭제
  @ResponseBody
  @RequestMapping(value="/rcomment/deleteco.do", method=RequestMethod.POST, produces="application/json; charset=utf8")
  public String delete(int rcno, int memberno) {

    JSONObject obj = new JSONObject();
    JSONArray msgs = new JSONArray();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("memberno", memberno);
    hashMap.put("rcno", rcno);
     
    //System.out.println(hashMap.toString()); 
    
    int count = rcommnetProc.delete(hashMap); 
    //System.out.println("count : "+count);
    
    if(count == 1){
      msgs.put("success");
    }else{
      msgs.put("fail");
    }
   obj.put("msgs", msgs);
   
    return obj.toString();

  }
  
//목록+ 페이징
/*  @ResponseBody
  @RequestMapping(value="/comment/list_paging.do", produces="application/json; charset=utf8", method=RequestMethod.GET)
  public ResponseEntity list_paging(
      int reviewno, HttpServletRequest request,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      )
  { 

    HttpHeaders responseHeaders = new HttpHeaders();
    ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
    
    // 숫자와 문자열 타입을 저장해야함으로 Object 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("nowPage", nowPage);       
    
    // 검색된 레코드 갯수
    int comment_count =rcommnetProc.comment_count(reviewno);
    
    // 목록
    List<RcommentVO> list = rcommnetProc.list_paging(hashMap);
    
    if(list.size() >0){
      for(int i = 0; i<list.size(); i++){
        RcommentVO rcommentVO = list.get(i);
        HashMap hm = new HashMap();
        //hm.put("rcno", rcommentVO.getRcno());
        hm.put("mname", rcommentVO.getMname());
        hm.put("content", rcommentVO.getContent());
        hm.put("rcdate", rcommentVO.getRcdate());
        
        hmlist.add(hm);
      }
    }
    
    
    String paging = rcommnetProc.paging(comment_count, nowPage);
   
    
    JSONArray json = new JSONArray(hmlist);
    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
    

  }
  */
}
