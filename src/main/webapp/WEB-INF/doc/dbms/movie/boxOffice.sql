
DROP TABLE boxOffice;

CREATE TABLE boxOffice(
	rank NUMBER NOT NULL,
	movieCd VARCHAR2(1000) NOT NULL,
	movieNm VARCHAR2(300) NOT NULL,
	openDt VARCHAR2(10) NOT NULL,
	audiAcc VARCHAR2(10) NOT NULL,
	PRIMARY KEY(rank)
);

COMMENT ON TABLE boxOffice is '박스오피스';
COMMENT ON COLUMN boxOffice.rank is '영화순위';
COMMENT ON COLUMN boxOffice.movieCd is '영화코드';
COMMENT ON COLUMN boxOffice.movieNm is '영화제목';
COMMENT ON COLUMN boxOffice.openDt is '개봉날짜';
COMMENT ON COLUMN boxOffice.audiAcc is '누적관객수';


INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (1, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (2, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (3, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (4, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (5, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (6, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (7, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (8, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (9, '202020', '독전', '2018-06-27', '958795');
INSERT INTO boxOffice (rank, movieCd, movieNm, openDt, audiAcc)
VALUES (10, '202020', '독전', '2018-06-27', '958795');


SELECT * from BOXOFFICE;


SELECT m.thumb, m.genre, m.showTm, m.watchGradeNm, m.director, m.actors, mc.rank, mc.movieCd, mc.movieNm, mc.openDt, mc.audiAcc
FROM movie m, boxOffice mc
WHERE mc.movieCd = m.movieCd;