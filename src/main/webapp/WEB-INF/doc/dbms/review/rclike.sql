/**********************************/
/* Table Name: ¥Ò±€_¡¡æ∆ø‰ */
/**********************************/
CREATE TABLE rclike(
    rclikeno                          NUMBER     NOT NULL,
    rcno                              NUMBER     NOT NULL,
    memberno                          NUMBER     NOT NULL,
    PRIMARY KEY (rclikeno),
    FOREIGN KEY (rcno) REFERENCES rcomment(rcno) ON DELETE CASCADE,
    FOREIGN KEY (memberno) REFERENCES member(memberno) ON DELETE CASCADE
);
  
DROP TABLE rclike;