SET DATEFORMAT DMY
DECLARE 
@DTCONTAGEM DATETIME = '01/02/2020',
@CODEMP INT = 1

EXEC SANKHYA.STP_SET_CODUSULOGADO 0


--SELECT CTE.CODPROD
--     , CTE.QTDEST	
--	 , CB.QTD 
UPDATE CTE SET QTDEST = CB.QTD
  FROM TGFCTE CTE INNER JOIN TGFPRO PRO ON CTE.CODPROD = PRO.CODPROD --AND PRO.ATIVO = 'S' AND PRO.USOPROD IN ('R','V')
                  INNER JOIN CB001 CB ON CTE.CODPROD = CB.CODPROD
  
  
 WHERE CTE.DTCONTAGEM = @DTCONTAGEM
   AND CTE.CODEMP = @CODEMP
   AND CTE.QTDEST > CB.QTD
   AND CTE.SEQUENCIA = 1
   AND CTE.QTDEST > 0
   AND CTE.CODPARC = 0
   --ORDER BY 1



   --UPDATE TGFCTE SET QTDEST = 0
   -- WHERE CODPROD = 28650
	  --AND CODEMP =1 
	  --AND DTCONTAGEM = '30/11/2017'
	  --AND SEQUENCIA = 1