1) 테이블 생성
/**********************************/
/* Table Name: 장르 */
/**********************************/
CREATE TABLE genre(
    genreno                           NUMBER    NOT NULL,
    genreNm                           VARCHAR2(30)     NOT NULL,
    PRIMARY KEY (genreno)
);

COMMENT ON TABLE genre is '장르'; 
COMMENT ON COLUMN genre.genreno is '장르번호';
COMMENT ON COLUMN genre.genreNm is '장르명';

2) 테이블 삭제

DROP TABLE genre;

3) 장르 추가
INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '멜로');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '액션');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '코미디');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '호러');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '공포');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '스릴러');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), 'SF');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '다큐멘터리');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '판타지');

INSERT INTO genre(genreno, genreNm) 
VALUES((SELECT NVL(MAX(genreno), 0) + 1 as genreno FROM genre), '모험');

4) 장르 목록
SELECT * FROM genre;

