SELECT * FROM TDDPER1 WHERE CODGRUPO IN (34) ORDER BY IDACESSO

SELECT * INTO TDDPER1 FROM TDDPER WHERE CODGRUPO IN (1)

UPDATE TDDPER1 SET CODGRUPO = 34 WHERE CODGRUPO IN (1)

INSERT INTO TDDPER SELECT * FROM TDDPER1 WHERE CODGRUPO IN (34)

/*--------------------------*/

select * from TGFREP where CODCOLREST = 1

SELECT * INTO TDDPER1 FROM TGFREP WHERE CODCOLREST = 1

UPDATE TDDPER1 SET CODCOLREST = 4 WHERE CODCOLREST = 1

INSERT INTO TGFREP SELECT * FROM TDDPER1 WHERE CODCOLREST = 4

SELECT * delete FROM TDDPER1 where CODTIPOPER = 900


--select len (descrprodarq) as 'aa', descrprodarq, seq
--from AD_ITEMCOTVEND 
--where NUIMP = 232
--order by aa desc

--update AD_ITEMCOTVEND 
--set descrprodarq = 'REPARO FLEX.CUICA TRAS.935152 555230001000 935152                  6739970145 UN'
--where NUIMP = 232
--and seq = 14