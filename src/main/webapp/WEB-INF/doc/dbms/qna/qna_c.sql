1. 테이블 생성.

DROP TABLE qna;

CREATE TABLE qna (
    qnano               NUMBER                NOT NULL,
    seqno               NUMBER                default 1             NOT NULL, -- 0-공지글 / 1-일반글
    qnatype             VARCHAR2(20)          NOT NULL,
    title               VARCHAR2(100)         NOT NULL,
    content             CLOB   			      NOT NULL,
    memberno            NUMBER                NOT NULL,
    mname               VARCHAR2(20)          NOT NULL,
    cnt                 NUMBER                default 0             NOT NULL,
    rdate               DATE                  NOT NULL,
    qpasswd    			VARCHAR2(20)          NULL,
    statement           NUMBER          	  NOT NULL,        		-- 0-처리중 / 1- 처리완료   
  	indent   			NUMBER        		  DEFAULT 0       	 	NOT NULL,
  	ansnum   			NUMBER       		  DEFAULT 0       		NOT NULL,
    primary key ( qnano ),
    foreign key ( memberno ) references member ( memberno )
);



COMMENT ON TABLE qna is '질문게시판';
COMMENT ON COLUMN qna.qnano is '질문 게시글 번호';
COMMENT ON COLUMN qna.seqno is '공지글과 일반글 나누는 seqno';
COMMENT ON COLUMN qna.qnatype is '질문 유형';
COMMENT ON COLUMN qna.title is '질문 제목';
COMMENT ON COLUMN qna.content is '질문 내용';
COMMENT ON COLUMN qna.memberno is '회원 번호';
COMMENT ON COLUMN qna.mname is '회원 이름';
COMMENT ON COLUMN qna.cnt is '질문 게시글 조회 수';
COMMENT ON COLUMN qna.rdate is '게시 날짜 및 시간 ';
COMMENT ON COLUMN qna.qpasswd is '질문 게시글 비밀번호';
COMMENT ON COLUMN qna.statement is '답글 여부';
COMMENT ON COLUMN qna.indent is '답변 차수';
COMMENT ON COLUMN qna.ansnum is '답변 순서';


2. 데이터 삽입

INSERT INTO qna(qnano, seqno, qnatype, title, content, memberno, mname, cnt, rdate, qpasswd, statement, indent, ansnum)
        values((select NVL(MAX(qnano),0 ) +1 as qnano from qna),
                        2, '영화추천2', '독전을 추천합니다2', '독전을 추천합니다 올려주세요.2' , 2, 'james9957' , 0, sysdate, '1234', 0,0,0);
                        
           select * from qna;  
        
        
             
3. 목록 출력

select mact
from member
where memberno = (select memberno from qna where memberno=1);

select mact
from member
where memberno=1;

-- 공지글 일반글 구분
select * from qna
order by seqno DESC, qnano DESC;

SELECT qnano, seqno, qnatype, title, content, memberno, mname, cnt, rdate, qpasswd, statement, indent, ansnum
FROM qna
WHERE qnano = 1;

select qnano, qnatype, title, contents, memberno, cnt, rdate, statement from qna order by seqno asc , qnano asc;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     4 공지      웹 퍼블리셔 채용            채용진행중입니다.                                   admin               2018-06-08 16:19:53.0       처리중
     1 계정      비밀번호를 분실             비밀번호를 찾아주세요                             james9957         2018-06-08 16:19:50.0       처리중
     2 영화      영화 정보 수정 문의        주연 배우 이름이 잘못 표기되었습니다.       james9957         2018-06-08 16:19:51.0       처리중
     3 기타      개발자 채용                   신이 개발자는 따로 채용건이 없나요?          james9957         2018-06-08 16:19:52.0       처리중


select qnano, qnatype, title, contents, memberno, cnt, rdate, statement from qna where qnatype='계정' or qnatype='공지' order by seqno asc , qnano asc;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

     4 공지      웹 퍼블리셔 채용        채용진행중입니다.                 admin                 2018-06-08 16:19:53.0               처리중
     1 계정      비밀번호를 분실         비밀번호를 찾아주세요           james9957           2018-06-08 16:19:50.0               처리중


select count(*) as cnt
from qna
where qnano like '%1%';

4. 테이블 수정

-- 조회수 증가
UPDATE qna
SET cnt = cnt + 1
WHERE qnano = 1;

-- 질문 내용 수정
UPDATE qna
SET title='타이틀', content='컨텐츠', qpasswd='1234'
WHERE qnano = 2;

update qna
set seqno = 2
where qnano = 1;

UPDATE qna
SET title='아이디 분실' , contents='비밀번호가 아니라 아이디를 잃어버렸습니다.' , statement='답변 완료'
WHERE qnano = 1;

select qnano, qnatype, title, contents, memberno, cnt, rdate, statement from qna order by seqno asc , qnano asc;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

     4 공지      웹 퍼블리셔 채용   채용진행중입니다.             admin 2018-06-08 16:19:53.0 처리중
     1 계정      아이디 분실      비밀번호가 아니라 아이디를 잃어버렸습니다. james9957 2018-06-08 16:19:50.0 답변 완료
     2 영화      영화 정보 수정 문의 주연 배우 이름이 잘못 표기되었습니다. james9957 2018-06-08 16:19:51.0 처리중
     3 기타      개발자 채용      신이 개발자는 따로 채용건이 없나요?  james9957 2018-06-08 16:19:52.0 처리중

     
5. 삭제

delete from qna where qnano = 2;

select qnano, qnatype, title, contents, memberno , cnt,  rdate, statement from qna order by seqno asc , qnano asc;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

     4 공지      웹 퍼블리셔 채용   채용진행중입니다.             admin 2018-06-08 16:19:53.0 처리중
     1 계정      아이디 분실      비밀번호가 아니라 아이디를 잃어버렸습니다. james9957 2018-06-08 16:19:50.0 답변 완료
     3 기타      개발자 채용      신이 개발자는 따로 채용건이 없나요?  james9957 2018-06-08 16:19:52.0 처리중

 
6. 조회

select qnano, qnatype, title, contents, memberno , cnt, rdate, statement from qna where memberno='4' order by seqno asc, qnano asc;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

     1 계정      아이디 분실      비밀번호가 아니라 아이디를 잃어버렸습니다. james9957   0 2018-06-08 16:19:50.0 답변 완료
     3 기타      개발자 채용      신이 개발자는 따로 채용건이 없나요?  james9957   0 2018-06-08 16:19:52.0 처리중
     
     
     

select * from qna;

