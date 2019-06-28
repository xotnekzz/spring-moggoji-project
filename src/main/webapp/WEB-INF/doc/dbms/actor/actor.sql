/**********************************/
/* Table Name: 배우 */
/**********************************/
CREATE TABLE actor(
    acode                            VARCHAR2(1000)     NOT NULL,
    actorno                          NUMBER    NOT NULL,
    actorNm                         VARCHAR2(100)    NOT NULL,
    actorEnNm                      VARCHAR2(100)    NULL,
    PRIMARY KEY (acode)
);  
 
COMMENT ON TABLE actors is '배우';
COMMENT ON COLUMN actors.actorno is '배우번호';
COMMENT ON COLUMN actors.actorNm is '배우명';
COMMENT ON COLUMN actors.actorEnNm is '배우영문명';  
COMMENT ON COLUMN actors.acode is '배우코드';


2) 테이블 삭제
DROP TABLE actor;

3) 등록

INSERT INTO actor(actorno, actorNm, actorEnNm, acode)
VALUES((SELECT NVL(MAX(actorno), 0)+1 as actorno FROM actor), '정현종', 'James', '201231044');

4) 조회
 
SELECT actorno, actorNm, actorEnNm, acode
FROM actor
ORDER BY actorno;
 
SELECT actorno, actorNm, actorEnNm, acode
FROM actor
WHERE  actorno=33700;

SELECT actorno, actorNm, actorEnNm, acode
FROM actor
WHERE  actorNm = '공효진';

SELECT count(*)
FROM actor;


5) 삭제

DELETE FROM actor;
 