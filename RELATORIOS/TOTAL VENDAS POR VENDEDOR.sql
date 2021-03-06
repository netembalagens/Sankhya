SELECT /*TOTAL VENDAS POR VENDEDOR*/
    VEN.APELIDO VENDEDOR,
    SUM((ITE.VLRTOT-ITE.VLRDESC)*CASE WHEN :GERENCIAL = 'N' THEN VGF.INDITENS ELSE 1 END) TOTAL_VENDAS,
	(SUM((ITE.VLRTOT-ITE.VLRDESC)*CASE WHEN :GERENCIAL = 'N' THEN VGF.INDITENS ELSE 1 END)*100/(SELECT /*TOTAL VENDAS POR VENDEDOR*/
      SUM((ITE.VLRTOT-ITE.VLRDESC)*CASE WHEN :GERENCIAL = 'N' THEN VGF.INDITENS ELSE 1 END) TOTAL_VENDAS
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON (ITE.NUNOTA=CAB.NUNOTA)
INNER JOIN TGFPRO PRD ON (PRD.CODPROD=ITE.CODPROD)
INNER JOIN TGFPAR PAR ON (PAR.CODPARC=CAB.CODPARC)
INNER JOIN TGFVEN VEN ON (VEN.CODVEND=CAB.CODVEND)
INNER JOIN TSIUSU USU ON (USU.CODUSU=SANKHYA.STP_GET_CODUSULOGADO())
 LEFT JOIN VGFCAB VGF ON (CAB.NUNOTA=VGF.NUNOTA)
WHERE /*AND (
		(USU.CODEMP IS NULL AND CAB.CODEMP IN :CODEMP) OR
		(USU.CODEMP IS NOT NULL AND CAB.CODEMP = USU.CODEMP)
	)*/
CAB.CODEMP IN :CODEMP
AND CAB.DTNEG BETWEEN :PERIODO.INI AND :PERIODO.FIN
AND CAB.CODTIPOPER IN (900,901,931)
AND CAB.TIPMOV='V'
AND CAB.STATUSNOTA = 'L'
AND (PRD.REFERENCIA LIKE :REFERENCIA+'%' OR :REFERENCIA IS NULL)
AND (
	(:GERENCIAL = 'S' AND ((CAB.CODVEND <> 59 AND CAB.NUNOTA IN (SELECT NUNOTA FROM TGFFIN WHERE ORIGEM = 'E' AND CODTIPTIT <> 69)) OR (CAB.CODTIPOPER <> 931))
	OR :GERENCIAL = 'N'
	)))) AS 'PERC'
FROM TGFCAB CAB
INNER JOIN TGFITE ITE ON (ITE.NUNOTA=CAB.NUNOTA)
INNER JOIN TGFPRO PRD ON (PRD.CODPROD=ITE.CODPROD)
INNER JOIN TGFPAR PAR ON (PAR.CODPARC=CAB.CODPARC)
INNER JOIN TGFVEN VEN ON (VEN.CODVEND=CAB.CODVEND)
INNER JOIN TSIUSU USU ON (USU.CODUSU=SANKHYA.STP_GET_CODUSULOGADO())
 LEFT JOIN VGFCAB VGF ON (CAB.NUNOTA=VGF.NUNOTA)
WHERE /*AND (
		(USU.CODEMP IS NULL AND CAB.CODEMP IN :CODEMP) OR
		(USU.CODEMP IS NOT NULL AND CAB.CODEMP = USU.CODEMP)
	)*/
CAB.CODEMP IN :CODEMP
AND CAB.DTNEG BETWEEN :PERIODO.INI AND :PERIODO.FIN
AND CAB.CODTIPOPER IN (900,901,931)
AND CAB.TIPMOV='V'
AND CAB.STATUSNOTA = 'L'
AND (PRD.REFERENCIA LIKE :REFERENCIA+'%' OR :REFERENCIA IS NULL)
AND (
	(:GERENCIAL = 'S' AND ((CAB.CODVEND <> 59 AND CAB.NUNOTA IN (SELECT NUNOTA FROM TGFFIN WHERE ORIGEM = 'E' AND CODTIPTIT <> 69)) OR (CAB.CODTIPOPER <> 931))
	OR :GERENCIAL = 'N'
	))
GROUP BY VEN.APELIDO
ORDER BY TOTAL_VENDAS DESC