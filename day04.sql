--�÷��� ��Ī�ֱ�
SELECT PLAYER_NAME AS ������ FROM PLAYER;
SELECT PLAYER_NAME ������ FROM PLAYER;
SELECT PLAYER_NAME "���� �̸�" FROM PALYER;

--���̺� ��Ī�ֱ�
SELECT P.* FROM PLAYER p; 	--p.*:

SELECT * FROM TEAM;

--�� ���̺��� �����ؼ� ���� �� �ִ� ��� ����� �˻��ȴ�
--JOIN �̿��ؾ� �������� ��� ����
SELECT p.PLAYER_NAME, t.TEAM_NAME FROM PLAYER p, TEAM t;

--LIKE ���ǽ�
--�̾��� ���� �˻�
SELECT * FROM PLAYER
WHERE PLAYER_NAME LIKE ('��%');

--�̸��� ������ ���� �˻�
SELECT * FROM PLAYER
WHERE PLAYER_NAME LIKE ('__');

-----------------����ȭ-----------------
CREATE TABLE MOVIE(
	TITLE  		VARCHAR2(100) PRIMARY KEY,
	DIRECTOR	VARCHAR2(30),
	ACTOR 		VARCHAR2(1000),
	OPENINGDAY 	DATE
);
SELECT * FROM MOVIE;
DROP TABLE MOVIE;
INSERT INTO MOVIE(TITLE,DIRECTOR,ACTOR)
VALUES('����','������','������');

INSERT INTO MOVIE(TITLE,DIRECTOR,ACTOR)
VALUES('����','������','������');		--TITLE�� PK�̱� ������ �߰��� �� ����

INSERT INTO MOVIE(TITLE,DIRECTOR,ACTOR)
VALUES('����','������','������,������,������,�ӿ���');		--ACTOR�� ',' �������� spilit�ؼ� ����Ѵ�

-------------------------------------------------------
--TO_DATE
SELECT 1+1 FROM DUAL;	--DUAL Ȯ�ο� ���̺�
SELECT TO_DATE('2021=01-08','YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE FROM DUAL;	--SYSDATE: ����ð�
-------------------------------------------------------
--NULL ó�� �Լ�
CREATE TABLE TEST_A(
	INTDATA NUMBER(3) PRIMARY KEY,
	STRDATA VARCHAR2(1000)
);
INSERT INTO TEST_A VALUES (1,'A');
INSERT INTO TEST_A (INTDATA) VALUES (2);

SELECT * FROM TEST_A;

SELECT INTDATA, NVL(STRDATA,'��Ͼȵ�') STRDATA FROM TEST_A;
SELECT INTDATA, NVL2(STRDATA,'��ϵ�','��Ͼȵ�') STRDATA FROM TEST_A;
----------------------------------------------------------
--�׷��Լ�
--�׷��Լ��� NULL������ �����ϰ� ������ �Ѵ�
SELECT COUNT(HEIGHT) FROM PLAYER;
SELECT COUNT(NVL(HEIGHT,0)) FROM PLAYER;

--GROUP BY: ~�� (ex. �����Ǻ� ���Ű)
SELECT "POSITION", AVG(HEIGHT) FROM PLAYER
GROUP BY "POSITION";

--HAVING���ǽ�: �� �׷쿡 ������ �ִ� ���
SELECT "POSITION", AVG(HEIGHT) FROM PLAYER
GROUP BY "POSITION" HAVING AVG(HEIGHT)>=180;

--ORDER BY(DESC): �÷��� �������� ��������(��������)
--EMPLOYEES ���̺��� JOB_ID ���� ��� SALARY�� 10000�̸��� JOB_ID �˻�(JOB_ID ���ĺ������� ����)
SELECT JOB_ID,AVG(SALARY) FROM EMPLOYEES 
GROUP BY JOB_ID HAVING AVG(SALARY)<10000
ORDER BY JOB_ID;

--������ �� �Ҽ����� K01~K10�� �������� �����Ǻ��� ���Ű�� 175 �̻��� �����ǵ鸸 �˻�
SELECT "POSITION",AVG(HEIGHT) FROM PLAYER 
WHERE TEAM_ID >='K01' AND TEAM_ID<= 'K10'
GROUP BY "POSITION" HAVING AVG(HEIGHT)>=175;

SELECT * FROM PLAYER;
---------------------------------------------------
SELECT p.PLAYER_NAME,t.TEAM_NAME 
FROM PLAYER p 
	INNER JOIN TEAM t ON p.TEAM_ID=t.TEAM_ID;

--�� ����� �̸��� ����� �μ���ȣ, �μ��� ���� �˻�
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT e.ENAME, e.DEPTNO, d.LOC
FROM EMP e
	INNER JOIN DEPT d ON e.DEPTNO=d.DEPTNO;

--������ ������ ���� ���� ��ȭ��ȣ �˻�
SELECT * FROM PLAYER;
SELECT * FROM TEAM;

--ON, WHERE�� ���� ����� ���� ON�� ����� ���� ����� ���ٸ� ON�� ����ϴ� ���� ����(�ӵ� ���� �߻�)
SELECT t.TEL, p.PLAYER_NAME
FROM TEAM t
	INNER JOIN PLAYER p ON p.TEAM_ID=t.TEAM_ID AND p.PLAYER_NAME='������';
	
SELECT t.TEL, p.PLAYER_NAME
FROM TEAM t
	INNER JOIN PLAYER p ON p.TEAM_ID=t.TEAM_ID 
WHERE p.PLAYER_NAME='������';


--�� ����(ON���� ��ȣ�� �ƴ� �ٸ� ���ǽ��� ���̴� ���)
--1998~2000�� ����ε��� �̸�, �����, �μ��� �˻�
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT e.FIRST_NAME,e.HIRE_DATE, d.DEPARTMENT_NAME  FROM EMPLOYEES e
	INNER JOIN DEPARTMENTS d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID AND 
	TO_CHAR(e.HIRE_DATE,'YYYY')>='1998' AND TO_CHAR(e.HIRE_DATE,'YYYY')<='2000';

--OUTER JOIN
SELECT * FROM STADIUM;
SELECT * FROM TEAM;

SELECT s.STADIUM_NAME, NVL(t.TEAM_NAME,'Ȩ������') FROM STADIUM s
	LEFT OUTER JOIN TEAM t ON s.HOMETEAM_ID=t.TEAM_ID;

SELECT s.STADIUM_NAME, NVL(t.TEAM_NAME,'Ȩ������') FROM STADIUM s
	RIGHT OUTER JOIN TEAM t ON s.HOMETEAM_ID=t.TEAM_ID;
	

SELECT s.STADIUM_NAME ������̸�, NVL(t.TEAM_NAME,'Ȩ������') ���̸� FROM STADIUM s
	FULL OUTER JOIN TEAM t ON s.HOMETEAM_ID=t.TEAM_ID;
	
--��������
--������ �� ���Ű���� Ű�� ū ������ �˻�
SELECT * FROM PLAYER WHERE HEIGHT> AVG(HEIGHT); --���Ұ�: �׷��Լ��� WEHRE���� ���Ұ�. AVG�� �ϳ��� ���̾�� ��밡��
	
SELECT * FROM PLAYER WHERE HEIGHT>
	(SELECT AVG(HEIGHT) FROM PLAYER); --(SELECT AVG(HEIGHT) FROM PLAYER): �ϳ��� ��
	
	
SELECT "POSITION", 
		AVG(HEIGHT),			--AVG(HEIGHT): �׷쿡 ���� ���Ű 
		(SELECT AVG(HEIGHT) FROM PLAYER)
FROM PLAYER GROUP BY "POSITION";


SELECT * 
FROM 
	(SELECT * FROM PLAYER WHERE TEAM_ID='K04')
WHERE HEIGHT<180;

