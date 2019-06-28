
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

DROP TABLE mcomment;

CREATE TABLE mcomment(
  mcno  NUMBER(7)        NOT NULL    PRIMARY KEY,
  rdate          DATE                 NOT NULL,
  memberno   NUMBER(7)        NOT NULL,
  content       VARCHAR(300)    NOT NULL,
  movieCd     VARCHAR2(1000)     NOT NULL,
  grade         NUMBER(5)   DEFAULT 0 NOT NULL,
  mname      VARCHAR2(20)         NOT NULL, 
  FOREIGN KEY (memberno) REFERENCES MEMBER (memberno),
  FOREIGN KEY (movieCd) REFERENCES MOVIE (movieCd)
);

ALTER TABLE mcomment MODIFY(grade NUMBER(5));


COMMENT ON TABLE mcomment is '영화 코멘트';
COMMENT ON COLUMN mcomment.mcno is '코멘트 번호';
COMMENT ON COLUMN mcomment.movieCd is '영화 코드';
COMMENT ON COLUMN mcomment.content is '코멘트 내용';
COMMENT ON COLUMN mcomment.grade is '영화 등급';
COMMENT ON COLUMN mcomment.rdate is '코멘트 작성 날짜';
COMMENT ON COLUMN mcomment.memberno is '코멘트를 쓴 회원 번호';
COMMENT ON COLUMN mcomment.mname is '코멘트를 쓴 회원 이름';

-- 조회
select * from mcomment;

SELECT mcno, rdate, grade, content, movieCd, memberno, mname
FROM mcomment
WHERE movieCd = '20171841'
ORDER BY mcno DESC;

-- 등록
INSERT INTO mcomment(mcno, rdate, grade, content, movieCd, memberno, mname )
VALUES((SELECT NVL(MAX(mcno), 0)+1 as mcno FROM mcomment), sysdate, 3,
            '감동적이었다.', '20171841', 1, '회원' );

-- 수정
UPDATE mcomment
SET content = '재미없다.' , grade = '1'
WHERE movieCd = '20171841' AND memberno = 1 AND mcno = 1;

-- 삭제

delete from mcomment;

DELETE FROM mcomment
WHERE movieCd = '20171841'  AND memberno = 1 AND mcno = 1;

-- 영화당 댓글 갯수
select count(*) as cnt
from mcomment
where movieCd = '20171841'


-- 회원별 영화 댓글 갯수
    SELECT count(*) as cnt
    FROM movie m, mcomment mc
    WHERE m.movieCd = mc.movieCd AND memberno = 2 AND m.movieNm LIKE '%햄%';
    
    
-- 회원별 영화 댓글 목록
    SELECT mcno, movieCd, content, grade, rdate, r
    FROM (
              SELECT mcno, movieCd, content, grade, rdate, rownum as r
               FROM (
                          SELECT mcno, movieCd, content, grade, rdate
                          FROM  mcomment
                          WHERE memberno = 2
                          ORDER BY mcno DESC
              )
    )
    where r >=1 and r<=10;
    

-- 회원별 영화 댓글 영화제목(join) + 페이징
SELECT mcno, movieCd, movieNm, content, grade, rdate, memberno, thumb, r
FROM(
       SELECT  mcno, movieCd, movieNm, content, grade, rdate, memberno, thumb, rownum as r
       FROM(
               SELECT mc.mcno, mc.movieCd, m.movieNm, mc.content, mc.grade, mc.rdate, mc.memberno, m.thumb
               FROM movie m, mcomment mc
               WHERE m.movieCd = mc.movieCd AND memberno = 3 AND m.movieNm LIKE '%헤%'
               ORDER BY mc.mcno DESC
        )
  )
WHERE r >=1 AND r<=10;


-- 회원별 영화 댓글 영화제목(join)
select mc.mcno, mc.movieCd, m.movieNm, mc.content, mc.grade, mc.rdate, rownum
from movie m, mcomment mc
where m.movieCd = mc.movieCd and memberno = 2
order by mc.mcno desc;

-- 댓글 삭제
DELETE FROM mcomment
WHERE movieCd='20185568' AND memberno = 2;

-- 댓글 수정
UPDATE mcomment
SET grade=4, content='ss'
WHERE movieCd='20171841' AND memberno = 2;

-- 댓글 한 건 조회
select mcno, movieCd, grade, content
from MCOMMENT
where movieCd='20171841' AND memberno = 2;

    SELECT mc.mcno, mc.movieCd, m.movieNm, mc.grade, mc.content
    FROM mcomment mc, movie m
    where m.movieCd = mc.movieCd AND mc.movieCd = '20171841' AND mc.memberno = 2;

-- 영화당 회원의 댓글 갯수
SELECT count(*)
FROM mcomment
WHERE movieCd='20171841' and memberno=2;


-- 한 영화에 남긴 평점 
SELECT sum(grade)
FROM mcomment
WHERE movieCd='20171841';






