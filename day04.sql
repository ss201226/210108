--컬럼에 별칭주기
SELECT PLAYER_NAME AS 선수명 FROM PLAYER;
SELECT PLAYER_NAME 선수명 FROM PLAYER;
SELECT PLAYER_NAME "선수 이름" FROM PALYER;

--테이블에 별칭주기
SELECT P.* FROM PLAYER p; 	--p.*:

SELECT * FROM TEAM;

--두 테이블을 참조해서 나올 수 있는 모든 결과가 검색된다
--JOIN 이용해야 정상적인 결과 도출
SELECT p.PLAYER_NAME, t.TEAM_NAME FROM PLAYER p, TEAM t;

--LIKE 조건식
--이씨인 선수 검색
SELECT * FROM PLAYER
WHERE PLAYER_NAME LIKE ('이%');

--이름이 외자인 선수 검색
SELECT * FROM PLAYER
WHERE PLAYER_NAME LIKE ('__');

-----------------정규화-----------------
CREATE TABLE MOVIE(
	TITLE  		VARCHAR2(100) PRIMARY KEY,
	DIRECTOR	VARCHAR2(30),
	ACTOR 		VARCHAR2(1000),
	OPENINGDAY 	DATE
);
SELECT * FROM MOVIE;
DROP TABLE MOVIE;
INSERT INTO MOVIE(TITLE,DIRECTOR,ACTOR)
VALUES('도굴','박정배','이제훈');

INSERT INTO MOVIE(TITLE,DIRECTOR,ACTOR)
VALUES('도굴','박정배','조우진');		--TITLE이 PK이기 때문에 추가할 수 없다

INSERT INTO MOVIE(TITLE,DIRECTOR,ACTOR)
VALUES('도굴','박정배','이제훈,조우진,신혜선,임원희');		--ACTOR를 ',' 기준으로 spilit해서 사용한다

-------------------------------------------------------
--TO_DATE
SELECT 1+1 FROM DUAL;	--DUAL 확인용 테이블
SELECT TO_DATE('2021=01-08','YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE FROM DUAL;	--SYSDATE: 현재시간
-------------------------------------------------------
--NULL 처리 함수
CREATE TABLE TEST_A(
	INTDATA NUMBER(3) PRIMARY KEY,
	STRDATA VARCHAR2(1000)
);
INSERT INTO TEST_A VALUES (1,'A');
INSERT INTO TEST_A (INTDATA) VALUES (2);

SELECT * FROM TEST_A;

SELECT INTDATA, NVL(STRDATA,'등록안됨') STRDATA FROM TEST_A;
SELECT INTDATA, NVL2(STRDATA,'등록됨','등록안됨') STRDATA FROM TEST_A;
----------------------------------------------------------
--그룹함수
--그룹함수는 NULL값들을 제외하고 연산을 한다
SELECT COUNT(HEIGHT) FROM PLAYER;
SELECT COUNT(NVL(HEIGHT,0)) FROM PLAYER;

--GROUP BY: ~별 (ex. 포지션별 평균키)
SELECT "POSITION", AVG(HEIGHT) FROM PLAYER
GROUP BY "POSITION";

--HAVING조건식: 각 그룹에 조건을 주는 경우
SELECT "POSITION", AVG(HEIGHT) FROM PLAYER
GROUP BY "POSITION" HAVING AVG(HEIGHT)>=180;

--ORDER BY(DESC): 컬럼을 기주으로 오름차순(내림차순)
--EMPLOYEES 테이블에서 JOB_ID 별로 평균 SALARY가 10000미만인 JOB_ID 검색(JOB_ID 알파벳순으로 정렬)
SELECT JOB_ID,AVG(SALARY) FROM EMPLOYEES 
GROUP BY JOB_ID HAVING AVG(SALARY)<10000
ORDER BY JOB_ID;

--선수들 중 소속팀이 K01~K10인 선수들을 포지션별로 평균키가 175 이상인 포지션들만 검색
SELECT "POSITION",AVG(HEIGHT) FROM PLAYER 
WHERE TEAM_ID >='K01' AND TEAM_ID<= 'K10'
GROUP BY "POSITION" HAVING AVG(HEIGHT)>=175;

SELECT * FROM PLAYER;
---------------------------------------------------
SELECT p.PLAYER_NAME,t.TEAM_NAME 
FROM PLAYER p 
	INNER JOIN TEAM t ON p.TEAM_ID=t.TEAM_ID;

--각 사원의 이름과 사원의 부서번호, 부서의 지역 검색
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT e.ENAME, e.DEPTNO, d.LOC
FROM EMP e
	INNER JOIN DEPT d ON e.DEPTNO=d.DEPTNO;

--송종국 선수가 속한 팀의 전화번호 검색
SELECT * FROM PLAYER;
SELECT * FROM TEAM;

--ON, WHERE를 같이 사용할 때와 ON만 사용할 떄의 결과가 같다면 ON만 사용하는 것이 좋다(속도 차이 발생)
SELECT t.TEL, p.PLAYER_NAME
FROM TEAM t
	INNER JOIN PLAYER p ON p.TEAM_ID=t.TEAM_ID AND p.PLAYER_NAME='송종국';
	
SELECT t.TEL, p.PLAYER_NAME
FROM TEAM t
	INNER JOIN PLAYER p ON p.TEAM_ID=t.TEAM_ID 
WHERE p.PLAYER_NAME='송종국';


--비등가 조인(ON절에 등호가 아닌 다른 조건식이 쓰이는 경우)
--1998~2000년 고용인들의 이름, 고용일, 부서명 검색
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT e.FIRST_NAME,e.HIRE_DATE, d.DEPARTMENT_NAME  FROM EMPLOYEES e
	INNER JOIN DEPARTMENTS d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID AND 
	TO_CHAR(e.HIRE_DATE,'YYYY')>='1998' AND TO_CHAR(e.HIRE_DATE,'YYYY')<='2000';

--OUTER JOIN
SELECT * FROM STADIUM;
SELECT * FROM TEAM;

SELECT s.STADIUM_NAME, NVL(t.TEAM_NAME,'홈팀없음') FROM STADIUM s
	LEFT OUTER JOIN TEAM t ON s.HOMETEAM_ID=t.TEAM_ID;

SELECT s.STADIUM_NAME, NVL(t.TEAM_NAME,'홈팀없음') FROM STADIUM s
	RIGHT OUTER JOIN TEAM t ON s.HOMETEAM_ID=t.TEAM_ID;
	

SELECT s.STADIUM_NAME 경기장이름, NVL(t.TEAM_NAME,'홈팀없음') 팀이름 FROM STADIUM s
	FULL OUTER JOIN TEAM t ON s.HOMETEAM_ID=t.TEAM_ID;
	
--서브쿼리
--선수들 중 평균키보다 키가 큰 선수들 검색
SELECT * FROM PLAYER WHERE HEIGHT> AVG(HEIGHT); --사용불가: 그룹함수는 WEHRE절에 사용불가. AVG가 하나의 값이어야 사용가능
	
SELECT * FROM PLAYER WHERE HEIGHT>
	(SELECT AVG(HEIGHT) FROM PLAYER); --(SELECT AVG(HEIGHT) FROM PLAYER): 하나의 값
	
	
SELECT "POSITION", 
		AVG(HEIGHT),			--AVG(HEIGHT): 그룹에 대한 평균키 
		(SELECT AVG(HEIGHT) FROM PLAYER)
FROM PLAYER GROUP BY "POSITION";


SELECT * 
FROM 
	(SELECT * FROM PLAYER WHERE TEAM_ID='K04')
WHERE HEIGHT<180;

