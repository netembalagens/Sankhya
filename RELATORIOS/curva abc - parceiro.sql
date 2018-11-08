SELECT /*CURVA ABC - VALOR ACUMULADO PARCEIRO*/

	LOJA,
	COD_PARCEIRO,
	PARCEIRO,
	TOTAL_VENDA_PARCEIRO_AC AS ACUMULADO,
 TOTAL_VENDA_GERAL_AC AS VALOR_TOTAL,
	(TOTAL_VENDA_PARCEIRO_AC*100/TOTAL_VENDA_GERAL_AC) AS 'PORC',
	SUM(TOTAL_VENDA_PARCEIRO_AC*100/TOTAL_VENDA_GERAL_AC) OVER (PARTITION BY LOJA ORDER BY TOTAL_VENDA_PARCEIRO_AC DESC) 'PORC_AC'

FROM (

SELECT TOP 100
:CODEMP LOJA,
PAR.CODPARC COD_PARCEIRO,
LTRIM(RTRIM(PAR.NOMEPARC)) PARCEIRO,

(SELECT
SUM(I.VLRTOT) VLRTOT
FROM TGFITE I
INNER JOIN TGFCAB C ON (C.NUNOTA=I.NUNOTA)
WHERE C.TIPMOV='V' AND C.STATUSNFE = 'A'
AND C.CODEMP =  :CODEMP
AND C.CODTIPOPER IN (900,901)
AND ((CONVERT(DATE,C.DTNEG) BETWEEN DATEADD(MONTH, -3, DateAdd(mm, DateDiff(mm,0,GETDATE()) - 0, 0)) AND DATEADD(DAY, -1, DateAdd(mm, DateDiff(mm,0,GETDATE()) - 0, 0)) AND :PERIODO.INI IS NULL)
 OR (CONVERT(DATE,C.DTNEG) BETWEEN :PERIODO.INI AND :PERIODO.FIN AND :PERIODO.INI IS NOT NULL))
) TOTAL_VENDA_GERAL_AC,

(SELECT
SUM(I.VLRTOT) VLRTOT
FROM TGFITE I
INNER JOIN TGFCAB C ON (C.NUNOTA=I.NUNOTA)
WHERE C.TIPMOV='V' AND C.STATUSNFE = 'A'
AND C.CODPARC= PAR.CODPARC
AND C.CODEMP= :CODEMP
AND C.CODTIPOPER IN (900,901)
AND ((CONVERT(DATE,C.DTNEG) BETWEEN DATEADD(MONTH, -3, DateAdd(mm, DateDiff(mm,0,GETDATE()) - 0, 0)) AND DATEADD(DAY, -1, DateAdd(mm, DateDiff(mm,0,GETDATE()) - 0, 0)) AND :PERIODO.INI IS NULL)
 OR (CONVERT(DATE,C.DTNEG) BETWEEN :PERIODO.INI AND :PERIODO.FIN AND :PERIODO.INI IS NOT NULL))
) TOTAL_VENDA_PARCEIRO_AC

FROM TGFPAR PAR 
WHERE EXISTS (SELECT 1 FROM TGFCAB CAB 
               WHERE CAB.TIPMOV='V' 
			     AND CAB.STATUSNFE = 'A' 
			     AND CAB.CODEMP = :CODEMP
                       AND CAB.CODTIPOPER IN (900,901)
                       AND CAB.CODVEND <> 59 
			     AND EXISTS (SELECT 1 FROM TGFFIN WHERE ORIGEM = 'E' AND CODTIPTIT <> 69 AND NUNOTA = CAB.NUNOTA))

GROUP BY PAR.NOMEPARC, PAR.CODPARC, PAR.CODPARC, PAR.CODEMP
ORDER BY TOTAL_VENDA_PARCEIRO_AC DESC

) SUB