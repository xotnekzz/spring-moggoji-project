1) 테이블 생성

CREATE TABLE rcomment_reply(
    rcrno NUMBER NOT NULL,
    rcrdate DATE NOT NULL,
    content VARCHAR(400) NOT NULL,
    rcno NUMBER NOT NULL, 
    memberno NUMBER NOT NULL, 
    PRIMARY KEY (rcrno),
    FOREIGN KEY (rcno) REFERENCES rcomment(rcno) ON DELETE CASCADE,
    FOREIGN KEY (memberno) REFERENCES member(memberno) ON DELETE CASCADE
);         
     
2) 테이블 삭제     

DROP TABLE rcomment_reply;

3) 댓글 등록  

INSERT INTO rcomment_reply(rcrno, rcrdate, content, rcno, memberno)
VALUES((SELECT NVL(MAX(rcrno), 0)+1 as rcrno FROM rcomment_reply), sysdate, '리뷰테스트1', 1, 1);
  
4) 조회

SELECT rcrno, rcrdate, content, rcno, memberno
FROM rcomment_reply
WHERE rcno = 1; 
 

5) 댓글 갯수 구하기
  
 SELECT count(*) as cnt
 FROM rcomment_reply
 WHERE rcno=1;
