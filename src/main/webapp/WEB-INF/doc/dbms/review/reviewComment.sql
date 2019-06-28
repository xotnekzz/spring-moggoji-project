1) Å×ÀÌºí »ý¼º

drop table rcomment;

CREATE TABLE rcomment(
    rcno NUMBER NOT NULL, -- ÄÚ¸àÆ® ¹øÈ£
    rcdate DATE NOT NULL, -- ³¯Â¥
    content VARCHAR(400) NOT NULL, -- ³»¿ë
    reviewno NUMBER NOT NULL,  -- ¸®ºä¹øÈ£
    memberno NUMBER  NULL, -- ¸â¹ö¹øÈ£
    mname      VARCHAR2(20)         NOT NULL, --¸â¹ö ÀÌ¸§
    PRIMARY KEY (rcno),
    FOREIGN KEY (reviewno) REFERENCES review(reviewno) ON DELETE CASCADE,
    FOREIGN KEY (memberno) REFERENCES member(memberno) ON DELETE CASCADE
);        

COMMENT ON TABLE rcomment is '¸®ºä ÄÚ¸àÆ®';
COMMENT ON COLUMN rcomment.rcno is '¸®ºä ÄÚ¸àÆ® ¹øÈ£';
COMMENT ON COLUMN rcomment.reviewno is '¸®ºä ¹øÈ£';
COMMENT ON COLUMN rcomment.content is 'ÄÚ¸àÆ® ³»¿ë';
COMMENT ON COLUMN rcomment.rcdate is 'ÄÚ¸àÆ® ÀÛ¼º ³¯Â¥';
COMMENT ON COLUMN rcomment.memberno is 'ÄÚ¸àÆ®¸¦ ¾´ È¸¿ø ¹øÈ£';
COMMENT ON COLUMN rcomment.mname is 'ÄÚ¸àÆ®¸¦ ¾´ È¸¿ø ÀÌ¸§';
     
2) Å×ÀÌºí »èÁ¦     
 
DROP TABLE rcomment;

3) ´ñ±Û µî·Ï  

INSERT INTO rcomment(rcno, rcdate, content, reviewno, memberno, mname)
VALUES((SELECT NVL(MAX(rcno), 0)+1 as rcno FROM rcomment), sysdate, '¸®ºäÄÚ¸àÆ®1', 1, 1,'È¸¿ø');
  
  
4) Á¶È¸

select * from rcomment;

SELECT rcno, rcdate, content, reviewno, memberno, mname
FROM rcomment
where reviewno = 4
ORDER BY rcno DESC;

SELECT rcno, rcdate, content, reviewno, memberno, mname
FROM rcomment
WHERE reviewno = 1; 


5) ´ñ±Û °¹¼ö ±¸ÇÏ±â
  
 SELECT count(*) as cnt
 FROM rcomment
 WHERE reviewno=1;
 
 6) ´ñ±Û ÆäÀÌÂ¡
 SELECT  rcno, rcdate, content, reviewno, memberno, mname, r
 FROM (
            SELECT rcno, rcdate, content, reviewno, memberno, mname, rownum as r
             FROM (
                        SELECT rcno, rcdate, content, reviewno, memberno, mname
                        FROM rcomment
                        WHERE reviewno = 4
                        ORDER BY rcno DESC
            )
 )
 WHERE r >= 0 AND r <= 10;
 
 7) ´ñ±Û »èÁ¦
 DELETE FROM rcomment
 WHERE reviewno = 4 AND rcno = 2 AND memberno = 1;
