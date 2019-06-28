SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';


DROP TABLE MOVIELIKE;

CREATE TABLE movielike(
  likeno        NUMBER(7)        NOT NULL,
  movieCd     VARCHAR2(1000)    NOT NULL,
  memberno  NUMBER(7)        NOT NULL,
  like_check    NUMBER(5) DEFAULT 0 NULL,
  PRIMARY KEY (likeno),
  FOREIGN KEY (movieCd) REFERENCES MOVIE (movieCd),
  FOREIGN KEY (memberno) REFERENCES MEMBER (memberno)
);

COMMENT ON TABLE movielike is '보고싶어요';
COMMENT ON COLUMN movielike.likeno is '좋아요 번호';
COMMENT ON COLUMN movielike.movieCd is '영화 코드';
COMMENT ON COLUMN movielike.memberno is '회원 번호';
COMMENT ON COLUMN movielike.like_check is '보고싶어요 체크 확인';


select * from movielike;

select likeno from movielike where mno =1;

select count(*)
from movielike;

-- 좋아요 생성 (시점생각)
INSERT INTO movielike(likeno, movieCd, memberno, like_check)
VALUES((SELECT NVL(MAX(likeno), 0)+1 as likeno FROM movielike), '20171841', 1, 0);

-- 좋아요를 눌렀을 때
UPDATE movielike
SET like_check = like_check+1
WHERE memberno = 1 AND movieCd = '20171841';

-- 좋아요 취소
UPDATE movielike
SET like_check = 0
WHERE memberno = 1 AND movieCd = '20171841';

-- read
SELECT likeno, movieCd, memberno, like_check
FROM movielike
 WHERE memberno = 1 AND movieCd='20171841'
 
 --영화별 좋아요 갯수
SELECT count(*)
FROM movielike
WHERE movieCd = #{movieCd} AND like_check = 1

-- 회원의 영화별 좋아요 체크 확인
SELECT count(*)
FROM movielike
WHERE movieCd='20171841' and memberno = 1;

-- 회원 보고싶어요 검색 카운트
SELECT count(*)
FROM movie m, movielike ml
WHERE ml.like_check =1 AND m.movieCd =ml.movieCd AND ml.memberno = 2 AND m.movieNm LIKE '%인%';

-- 회원 보고싶어요 목록
    SELECT movieNm, thumb, likeno, movieCd r
    FROM(
             SELECT movieNm, thumb, likeno, movieCd, rownum as r
             FROM(
                     SELECT m.movieNm, m.thumb, m.movieCd, ml.likeno
                     FROM movie m, movielike ml
                     WHERE ml.like_check = 1  AND m.movieCd =ml.movieCd AND ml.memberno = 2 AND m.movieNm LIKE'%인%'
                     ORDER BY likeno DESC
                    )
       )
WHERE  r >=1 AND R<=20;



