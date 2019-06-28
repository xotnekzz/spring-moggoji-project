drop table log;

create table log(
  logno     NUMBER    NOT NULL,
  memail    VARCHAR2(100)     DEFAULT 'guest'  NOT NULL,
  ip            VARCHAR(15)                 NOT NULL, 
  uri         VARCHAR(100)                 NOT NULL, -- URI 주소
  logdate   VARCHAR(19)                 NOT NULL, -- 접속 날짜
  PRIMARY KEY(logno)
);

COMMENT ON TABLE log is '로그';
COMMENT ON COLUMN log.logno is '로그 번호';
COMMENT ON COLUMN log.memail is '회원 메일';
COMMENT ON COLUMN log.ip is 'ip';
COMMENT ON COLUMN log.uri is 'URI 주소';
COMMENT ON COLUMN log.logdate is '접속 날짜';


INSERT INTO log(logno, memail, ip, uri, logdate)
VALUES(SELECT NVL(MAX(logno), 0)+1 AS logno FROM log), 'test@naver.com', '10.0.0.1', '/index', sysdate());

select memail, ip, uri, logdate
from log
order by logdate desc;

