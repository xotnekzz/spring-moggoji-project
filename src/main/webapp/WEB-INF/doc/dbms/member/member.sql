1. 테이블 생성
DESC member;

CREATE TABLE member(
        memberno                            NUMBER        NOT NULL,
        memail                              VARCHAR2(100)        NOT NULL,
        mname                               VARCHAR2(20)         NOT NULL,
        mpasswd                             VARCHAR2(30)         NULL,
        mfile                               VARCHAR2(100)        NULL,
        msize                               VARCHAR2(20)             NOT NULL,
        mact           						VARCHAR2(1)         DEFAULT 'Y' NOT NULL, -- M OR Y OR N
        mdate								DATE       NOT NULL,
        PRIMARY KEY (memberno)
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원 번호';
COMMENT ON COLUMN member.memail is '회원 이메일';
COMMENT ON COLUMN member.mname is '회원 이름';
COMMENT ON COLUMN member.mpasswd is '회원 비밀번호';
COMMENT ON COLUMN member.mfile is '회원 이미지 파일';
COMMENT ON COLUMN member.msize is '회원 이미지 사이즈';
COMMENT ON COLUMN member.mact is '회원 권한';
COMMENT ON COLUMN member.mdate is '회원 생성 날짜';



2. 테이블 삭제

DROP TABLE member cascade constraints;
3. INSERT, 기초 데이터 추가 

1) 중복 이메일 검사 관련 SQL 
    -- 0: 중복 아님, 1: 중복  
    SELECT COUNT(memail) as cnt
    FROM member
    WHERE memail = 'yeji@naver.com';

2) MASTER 계정의 조회
    SELECT COUNT(memberno) as cnt
    FROM member
    WHERE mact = 'M';

3) 회원 등록

-- 관리자  mact = 'M'
INSERT INTO member(memberno, memail, mname, mpasswd, mfile, msize, mact, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member), 'yeji@naver.com', '예지' ,'1234', 'spring.jpg', 1000, 'Y', SYSDATE);

SELECT COUNT(memail) as cnt
        FROM member
        WHERE memail='yeji@naver.com';

4. 목록

1) 회원 전체 목록 
SELECT memberno, memail, mname, mpasswd, mfile, msize, mact, mdate
FROM member;

 MEMBERNO MEMAIL         MNAME MPASSWD MFILE      MSIZE MACT MDATE
 -------- -------------- ----- ------- ---------- ----- ---- ---------------------
        1 yeji@naver.com 예지    1234    spring.jpg 1000  Y    2018-06-28 10:10:24.0


        
        
2) 권한의 변경
UPDATE member
SET mact = 'Y'
WHERE mname = '예지';


4.회원 정보 보기
SELECT memberno, memail, mname, mpasswd, mfile, msize, mact
FROM member
WHERE memberno = 1;

 MEMBERNO MEMAIL         MNAME MPASSWD MFILE      MSIZE MACT
 -------- -------------- ----- ------- ---------- ----- ----
        1 yeji@naver.com 예지    1234    spring.jpg 1000  Y


SELECT memberno, memail, mname, mpasswd, mfile, msize, mact
FROM member
WHERE mname = '예지';

 MEMBERNO MEMAIL         MNAME MPASSWD MFILE      MSIZE MACT
 -------- -------------- ----- ------- ---------- ----- ----
        1 yeji@naver.com 예지    1234    spring.jpg 1000  Y

        
-- 정보 일부분
SELECT mname, memail
FROM member
ORDER BY memail ASC;

 mname memail         
 ----- -------------- 
 예지    yeji@naver.com
 
5. 패스워드 변경
1) 기존 패스워드 검사
- DAO: public int countmpasswd(int memberno, String mpasswd){ ... }
SELECT count(*) as cnt
FROM member
WHERE memberno = 1 AND mpasswd='123';
 cnt = 0 -> 비밀번호 틀림 / cnt = 1 -> 비밀번호 맞음

 
2) 패스워드 변경
- DAO: public int updatempasswd(int memberno, String mpasswd){ ... }
UPDATE member
SET mpasswd=''
WHERE memberno=1;


6.  회원 정보 수정 
UPDATE member
SET mname='2', mfile = '2', mpasswd = '2', msize = '2'
WHERE memberno = 2;

 
7. 'member' 회원 삭제 
DELETE FROM member;
 
DELETE FROM member
WHERE memberno = 1;
 

8. 로그인 관련 SQL 
- DAO: public int login(String memail, String mpasswd){ ... }
 
- 로그인 체크
SELECT count(*) as cnt
FROM member
WHERE memail = 'yeji@naver.com' AND mpasswd='1234';
 
- memail 정보를 이용한 조회
SELECT memberno, memail, mpasswd, mact
FROM member
WHERE memail = 'yeji@naver.com';

SELECT count(*)
FROM member
WHERE memail = 'yeji@naver.com';
 
     
9. 검색된 전체 레코드 수
   - LIKE    : 정확하게 일치하지 않아도 출력 
   - =(equal): 정확하게 일치해야 출력 
   - 검색을 하지 않는 경우, 전체 목록 출력 
   
- 회원 목록
SELECT memberno, memail, mname, mfile, mact, mdate
FROM member
ORDER BY memberno ASC;W

 MEMBERNO MEMAIL         MNAME MFILE      MACT MDATE
 -------- -------------- ----- ---------- ---- ---------------------
        1 yeji@naver.com 예지    spring.jpg Y    2018-06-28 10:10:24.0
        
        
        
update member
set mact = 'M'
where memberno = 1;

- 검색
select memberno, memail, mname, mfile, mact, mdate
from member
where memberno like '%2%';

select memberno, memail, mname, mfile, mact, mdate
from member
where memail like '%y%';



-- 페이징 + 검색

SELECT memberno, memail, mname, mfile, mact, mdate, r
FROM (
          SELECT memberno, memail, mname, mfile, mact, mdate, rownum as r
          FROM (
                    SELECT memberno, memail, mname, mfile, mact, mdate
                     FROM member
                     WHERE memberno = 1 AND mname LIKE '%예%'
                     ORDER BY memberno DESC
          )
)
WHERE r >=1 AND R<=10;

select *
from member
where memberno = 1;

update member
set mact = 'M'
where memberno = 1;