1) 테이블 생성
/**********************************/
/* Table Name: 감독 */
/**********************************/
CREATE TABLE director(
    directorno                        NUMBER    NOT NULL,
    directorNm                        VARCHAR2(100)    NOT NULL,
    directorEnNm                      VARCHAR2(100)    NULL,
    dcode                             VARCHAR2(1000)    NOT NULL,
    PRIMARY KEY (dcode) 
);

COMMENT ON TABLE directors is '감독';
COMMENT ON COLUMN directors.directorno is '감독번호';
COMMENT ON COLUMN directors.directorNm is '감독명';
COMMENT ON COLUMN directors.directorEnNm is '감독영문명';
COMMENT ON COLUMN directors.dcode is '감독코드';

2) 테이블 삭제

DROP TABLE director;
 
3) 등록 

INSERT INTO director(directorno, directorNm, directorEnNm, dcode)
VALUES((SELECT NVL(MAX(directorno), 0)+1 as directorno FROM director), '정현종', 'James', '201231044');

4) 조회

SELECT directorno, directorNm, directorEnNm, dcode
FROM director;
 
SELECT directorno, directorNm, directorEnNm, dcode
FROM director
WHERE  directorno=3000;

SELECT directorno, directorNm, directorEnNm, dcode
FROM director
WHERE  directorNm='봉준호';

SELECT count(*)
FROM director;


5) 삭제

DELETE FROM director;