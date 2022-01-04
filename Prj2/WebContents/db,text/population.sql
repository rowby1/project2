CREATE TABLE POPULATION (
    SEQ NUMBER(10) PRIMARY KEY,
    SIDO VARCHAR(26),
    POPULATION NUMBER(10)
);



INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '전국', 51667688);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '경기도', 13542284);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '서울특별시', 9542256);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '부산광역시', 3358763);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '경상남도', 3319271);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '인천광역시', 2941795);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '경상북도', 2628344);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '대구광역시', 2392787);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '충청남도', 2118098);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '전라남도', 1835690);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '전라북도', 1791110);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '충청북도', 1596765);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '강원도', 1536765);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '대전광역시', 1455058);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '광주광역시', 1442827);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '울산광역시', 1123236);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '제주특별자치도', 676079);
INSERT INTO POPULATION 
VALUES ((SELECT NVL(MAX(SEQ), 0) + 1 FROM POPULATION), '세종특별자치시', 366560);
COMMIT;





DROP TABLE POPULATION;