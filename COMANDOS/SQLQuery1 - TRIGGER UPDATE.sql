SELECT OBJ.NAME 
  FROM SYSOBJECTS  OBJ, 
       SYSCOMMENTS COM 
 WHERE COM.ID=OBJ.ID 
   AND OBJ.XTYPE='TR' 
   AND COM.TEXT LIKE '%ESTOQUE INSUFICIENTE!%'

SELECT *
FROM TGFITE
WHERE NUNOTA = 181342
AND SEQUENCIA = 11

--BEGIN TRANSACTION;
--DISABLE TRIGGER TRG_UPD_TGFEST ON TGFEST;
--BEGIN

--UPDATE TGFITE
--SET CODPROD = 3293
--WHERE NUNOTA = 181342
--AND SEQUENCIA = 11;

--END;
--ENABLE TRIGGER TRG_UPD_TGFEST ON TGFEST;
--COMMIT TRANSACTION;

SELECT *
FROM TGFEST
WHERE CODPROD=3293
