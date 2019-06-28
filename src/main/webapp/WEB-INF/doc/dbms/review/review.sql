1) 테이블 생성

DROP TABLE review cascade constraints;
/**********************************/
/* Table Name: 영화리뷰 */
/**********************************/
CREATE TABLE review(
    reviewno                          NUMBER    	 NOT NULL,
    title                             VARCHAR(30)    NOT NULL,
    content                           CLOB    		 NOT NULL,
    rdate                             DATE     		 NOT NULL,
    mainimg                        	  VARCHAR(300)    NULL,
    imgsize                           NUMBER(8)  	 DEFAULT 0   NULL,
    youtube                           VARCHAR(500)   NULL,    
    cnt                               NUMBER 		 DEFAULT 0   NOT NULL,
    visible                           CHAR(1)    	 DEFAULT 'Y'  NULL,
    review_rating                     NUMBER    	 NULL,
    memberno                          NUMBER   		 NOT NULL,
    mname                             VARCHAR2(20)   NOT NULL,
    PRIMARY KEY (reviewno),
    FOREIGN KEY (memberno) REFERENCES member(memberno)
);

alter table review MODIFY(mainimg VARCHAR(300));

COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.reviewno is '리뷰 번호';
COMMENT ON COLUMN review.title is '리뷰 제목';
COMMENT ON COLUMN review.content is '리뷰 내용';
COMMENT ON COLUMN review.rdate is '리뷰 등록일';
COMMENT ON COLUMN review.mainimg is '대표사진';
COMMENT ON COLUMN review.youtube is '유튜브 영상';
COMMENT ON COLUMN review.cnt is '조회수';
COMMENT ON COLUMN review.visible is '출력여부';
COMMENT ON COLUMN review.review_rating is '리뷰 평점';
COMMENT ON COLUMN review.memberno is '회원 번호';
COMMENT ON COLUMN review.mname is '회원 이름';

2) 테이블 삭제

DROP TABLE review;

3) 리뷰 등록 

INSERT INTO review(reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible, review_rating, memberno)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review), 
'리뷰테스트2', '테스트2', sysdate, 'img.jpg', 1000, '<iframe width="854" height="480" src="https://www.youtube.com/embed/j6jZIfwioCA" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>', 0 , 'Y', 5, 2);


   
4) 조회
select * from review;

4_1) 1건 조회
SELECT reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible, review_rating, memberno
FROM review
WHERE reviewno = 7;

4_2) 목록 조회
SELECT reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible 
FROM review  
ORDER BY reviewno desc;

5) 수정
UPDATE review
SET title = '리뷰 테스트 수정', content= '내용수정입니다.', youtube='영상이다'
WHERE reviewno = 2;

6) 삭제

6_1) 모든 레코드 삭제
DELETE FROM review;

6_2) 1건 삭제
DELETE FROM review
WHERE reviewno = 2;
 
7) 조회수 증가

UPDATE review
SET cnt = nvl(cnt, 0) + 1
WHERE reviewno = 1;  
 
UPDATE review
SET cnt = cnt + 1
WHERE reviewno = 1; 

-- VISIBLE SHOW
UPDATE review
SET visible='Y'
WHERE reviewno = 3;

-- HIDE
UPDATE review
SET visible='N'
WHERE reviewno = 3;

-- 페이징
SELECT reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible, review_rating, memberno, r
FROM (
          SELECT reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible, review_rating, memberno, rownum as r
          FROM (
                    SELECT reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible, review_rating, memberno
                     FROM review
                     WHERE title LIKE '%독%' AND visible == 'Y'
                     ORDER BY reviewno DESC
          )
)
WHERE r >=1 AND R<=10;

-- 회원별 리뷰 목록
SELECT reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible, review_rating, memberno, r
FROM (
          SELECT reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible, review_rating, memberno, rownum as r
          FROM (
                    SELECT reviewno, title, content, rdate, mainimg, imgsize, youtube, cnt, visible, review_rating, memberno
                     FROM review
                     WHERE memberno = 1 AND title LIKE '%1%'
                     ORDER BY reviewno DESC
          )
)
WHERE r >=1 AND R<=10;

-- 리뷰를 쓴 회원 이름, 메일
select mname, memail
from member
where memberno = (select memberno from review where reviewno = 1);

-- 리뷰별 댓글 갯수
 SELECT count(*) as cnt
 FROM rcomment
 WHERE reviewno=(select reviewno from review where reviewno = 1)

-- 총 평가의 갯수
SELECT count(*)
FROM review;