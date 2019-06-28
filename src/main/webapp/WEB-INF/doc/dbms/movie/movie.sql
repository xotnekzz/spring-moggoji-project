SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';


1) 테이블 삭제

DROP TABLE movie;
DROP TABLE movie CASCADE CONSTRAINTS;


2) 테이블 생성
/**********************************/
/* Table Name: 영화 */
/**********************************/
CREATE TABLE movie(
    movieCd                           VARCHAR2(1000)    NOT NULL,
    movieno                           NUMBER     		NOT NULL,
    movieNm                           VARCHAR2(300)     NULL ,
    movieNmEn                         VARCHAR2(300)     NULL ,
    prdtYear                          VARCHAR2(300)     NULL ,
    openDt                            VARCHAR2(300)     NULL ,
    repNationNm                       VARCHAR2(300)     NULL ,
    plot                              CLOB   			NULL ,
    showTm                            VARCHAR2(100)     NULL ,
    watchGradeNm                      VARCHAR2(300)     NULL ,
    keyword                           VARCHAR2(1000)    NULL ,
    movieImg                          VARCHAR2(300)     NULL ,
    thumb                             VARCHAR2(300)     NULL ,
    imgSize                           NUMBER(9)   		DEFAULT 0  NULL,
    vodclass                          VARCHAR2(2000)    NULL,   
    genre               			  VARCHAR2(100) 	NULL,
    director             			  VARCHAR2(100) 	NULL,
    actors               			  VARCHAR2(4000) 	NULL,
    PRIMARY KEY(movieCd)
);

COMMENT ON TABLE movie is '영화';
COMMENT ON COLUMN movie.movieCd is '영화코드';
COMMENT ON COLUMN movie.movieno is '영화번호';
COMMENT ON COLUMN movie.movieNm is '영화명';
COMMENT ON COLUMN movie.movieNmEn is '영화영문명';
COMMENT ON COLUMN movie.prdtYear is '제작연도';
COMMENT ON COLUMN movie.openDt is '개봉연도';
COMMENT ON COLUMN movie.repNationNm is '국가명';
COMMENT ON COLUMN movie.plot is '줄거리';
COMMENT ON COLUMN movie.showTm is '상영시간';
COMMENT ON COLUMN movie.watchGradeNm is '대표관람등급';
COMMENT ON COLUMN movie.keyword is '키워드';
COMMENT ON COLUMN movie.movieImg is '영화이미지';
COMMENT ON COLUMN movie.thumb is '썸네일';
COMMENT ON COLUMN movie.imgSize is '이미지사이즈';
COMMENT ON COLUMN movie.genre is '장르';
COMMENT ON COLUMN movie.director is '감독';
COMMENT ON COLUMN movie.actors is '배우들';


select * from movie;

-- 전체 목록
SELECT movieCd, movieno, movieNm, movieNmEn, prdtYear, openDt, repNationNm, 
          plot, showTm, watchGradeNm,
          keyword, movieImg, thumb, imgSize, vodclass, genre, director, actors
FROM movie
ORDER BY movieno ASC;

-- 검색
SELECT movieCd, movieno, movieNm, movieNmEn, prdtYear, openDt, repNationNm, 
          plot, showTm, watchGradeNm,
          keyword, movieImg, thumb, imgSize, vodclass, genre, director, actors
FROM movie
WHERE movieNm LIKE '%인크레더블%'
ORDER BY movieno ASC;

-- 한 건 조회
SELECT movieCd, movieno, movieNm, movieNmEn, prdtYear, openDt, repNationNm, 
          plot, showTm, watchGradeNm,
          keyword, movieImg, thumb, imgSize, vodclass, genre, director, actors
FROM movie
WHERE movieCd = '20148879';


-- 수정
update movie 
set plot = '',  keyword='', movieImg='', 
      imgSize=0, thumb='', vodclass=''
WHERE movieno = 1;

-- 수정
UPDATE movie
SET plot = '줄거리 줄거리',  keyword='#배두나', movieImg='post.jpg', 
      imgSize=1000, thumb='poster_t.jpg', vodclass='예고편'
WHERE movieCd = '20184383';


-- 전체 삭제
DELETE FROM movie;

-- 조회
select * from movie;

SELECT * FROM movie
WHERE movieNm='독전';

-- 코비스 영화 수정할 떄 영역지정
select movieCd
from movie
where movieno BETWEEN 295 AND 2700

-- 영역별 검사
 select movieno, movieCd, actors
 from movie
 where movieno BETWEEN 290 AND 300;
 
-- 무비 갯수
SELECT count(*)
FROM movie;

-- 검색어 무비 갯수
SELECT COUNT(*) as cnt
FROM movie
WHERE movieNm like '%한나%';


-- 검색, 페이징
SELECT movieCd, movieno, movieNm, movieNmEn, prdtYear, openDt, 
          repNationNm, plot, showTm, watchGradeNm,
          keyword, movieImg, thumb, imgSize, vodclass, r
FROM (
          SELECT movieCd, movieno, movieNm, movieNmEn, prdtYear, openDt, 
                    repNationNm, plot, showTm, watchGradeNm,
                    keyword, movieImg, thumb, imgSize, vodclass, rownum as r
          FROM (
                    SELECT movieCd, movieno, movieNm, movieNmEn, prdtYear, openDt, 
                              repNationNm, plot, showTm, watchGradeNm,
                              keyword, movieImg, thumb, imgSize, vodclass
                     FROM movie
                     WHERE movieNm LIKE '%한나%'
                     ORDER BY movieno ASC
          )
)
WHERE r >=1 AND R<=20;

-- 영화코드 확인
SELECT movieCd
FROM movie;
    
-- 영화코드별 코멘트 갯수
  SELECT count(*)
  FROM mcomment
  WHERE movieCd=(SELECT movieCd FROM movie WHERE movieCd='20171841')  AND memberno = 2
  
  
-- 한 영화에 남긴 평점 

SELECT sum(grade)
FROM mcomment
WHERE movieCd =(select movieCd from movie where movieCd='20171841')
  

-- 별점 평가 갯수
SELECT sum(GRADE)
FROM mcomment;

-- 64958 -> 20400
 delete from movie
 where openDt is null;
 
 
 select count(*)
 from movie
 where actors is null;
 
  delete from movie
 where actors is null;
 
 select watchGradeNm
 from movie
 where movieno = 10363;
  
 
 select *
 from movie
 where movieNm = '%미션%';