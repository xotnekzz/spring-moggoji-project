/**********************************/
/* Table Name: 영화리뷰 */
/**********************************/

1. 테이블 생성
CREATE TABLE review(
    reviewno INT NOT NULL IDENTITY,
    title VARCHAR2(30) NOT NULL,
    content CLOB NOT NULL,
    rdate DATETIME NOT NULL,
    main_image VARCHAR2(20),
    size VARCHAR2(20),
    thumb_image VARCHAR(20),
    youtube VARCHAR2(500),
    cnt INT NOT NULL,
    visible CHAR(1) DEFAULT Y,
    review_rating INT, 
    member INT,
  PRIMARY KEY (reviewno),
  FOREIGN KEY (reviewno) REFERENCES member(memberno)
);  
 
2) 테이블 삭제
DROP TABLE review;
 
3) 등록
INSERT INTO review(reviewno, title, content, rdate, main_image, youtube, cnt, visible, review_rating)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review),
             '독전 후기', '연기력이랑 전부 재밌었음', sysdate, '이미지.jpg', '유튜브경로' , 0, 'Y', 3);

4) 목록
SELECT reviewno, title, rdate, main_image, cnt, visible, review_rating
FROM review
ORDER BY reviewno ASC;
           
5) 1건의 글 보기(R:Read, PK 사용) 
SELECT reviewno, title, content, rdate, main_image, youtube, cnt, visible, review_rating
FROM review
WHERE reviewno = 1;

6) 조회수 증가 
UPDATE review
SET cnt = cnt + 1
WHERE reviewno=2;

7) 글 수정(U:Update), PK는 레코드를 구분하는 고유 기능을 가지고 있음으로 
   수정하는 것은 권장하지 않음.
UPDATE review
SET title='독전 2번 본 후기', content='두번봐도 너무재밋다하', rdate=sysdate
WHERE reviewno=1;

8) 글 삭제(D:Delete) 
DELETE FROM review
WHERE reviewno = 2;
 

 
7_1) 글만 수정 
UPDATE review
SET title = '블로그 개발이란?', content= 'jsp를 사용한  블로그개발', rdate=sysdate
WHERE reviewno=1;
  
7_2) Visible 수정
UPDATE review
SET visible = 'N'
WHERE reviewno=1;
 
7_3) 유튜브 삭제
UPDATE review
SET youtube = ''
WHERE reviewno=2;
 
7_4) 새로운 유튜브 등록
UPDATE review
SET youtube=''
WHERE reviewno=2;
 
7_5) 파일 교체
UPDATE review
SET file='new.jpg', fstor1='new.jpg', thumb='new_m.jpg', size1=123
WHERE reviewno=2;
  
 
8) 글 삭제(D:Delete) 
DELETE FROM review
WHERE reviewno = 2;
 
 
8. 검색 글 목록(S:Search List) 
    - 목록은 제작시 검색을 기반으로 제작하며 전체 내용은
      전체 검색과도 같습니다.
    - rname, title, content 컬럼 대상
 
8_1) 선언: 
    - WHERE rname LIKE '왕눈이'
       rname 컬럼의 값이 '왕눈이'인 레코드 전부 출력
 
    - WHERE rname LIKE '%왕눈이%'
      rname 컬럼의 값중 '왕눈이'가 들어간 레코드 전부 출력
 
    - WHERE rname LIKE '왕눈이%'
      rname 컬럼의 값중 '왕눈이'로 시작하는 레코드 전부 출력
 
    - WHERE rname LIKE '%왕눈이'
      rname 컬럼의 값중 '왕눈이'로 종료하는 레코드 전부 출력
   
 
8_2) 검색을 하지 않는 경우 모든 레코드 출력 
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM review
ORDER BY reviewno DESC;
 
8_3) 이름 검색
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM review
WHERE rname LIKE '%아로미%'
ORDER BY reviewno DESC;
     
8_4) 메인 제목으로 검색   
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM review
WHERE title_main LIKE '%패신저스%'
ORDER BY reviewno DESC;

8_5) 서브 제목으로 검색   
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb,
          size1, visible
FROM review
WHERE title_sub LIKE '%패신저스%'
ORDER BY reviewno DESC;
    
 
9 페이징
   - 목록은 페이징 구현을 필수로 합니다.
   
9_1) 검색된 전체 레코드 수
SELECT COUNT(reviewno) as cnt 
FROM review
WHERE rname LIKE '%왕눈이%';
 
 cnt
 ---
   1
   
9_2) 페이징
SELECT devcateno, rname, email, title_main, title_sub, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate, file, fstor1, thumb, size1, visible 
FROM review
WHERE rname LIKE '%왕눈이%'
ORDER BY reviewno DESC
LIMIT 0, 5;
 
 pdsno rname email          title content passwd cnt rdate                 web                 file1     size1  thumb       visible
 ----- ----- -------------- ----- ------- ------ --- --------------------- ------------------- --------- ------ ----------- -------
     1 왕눈이   mail1@mail.com 봄     봄 여행    123      2 2016-04-07 12:09:17.0 http://www.daum.net fun04.jpg 106346 fun04_t.jpg Y
 
     