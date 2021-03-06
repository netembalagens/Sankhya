SELECT /*LIBERA��O DE PRE�O*/
PRO.CODPROD, DE.CODEMP, PRODUTO.REFERENCIA, PRODUTO.DESCRICAO, LTRIM(RTRIM(PRODUTO.UNIDADE)) AS 'UNIDADE',
E1.VLRVENDA  AS 'PRINCIPAL', (E1.VLRVENDA - (E1.VLRVENDA / DE.VLRDESC))  AS 'DES_PRINCIPAL',
(E1.VLRVENDA * 0.18 + E1.VLRVENDA)  AS 'filial/balcao', ((E1.VLRVENDA * 0.18 + E1.VLRVENDA) - (E1.VLRVENDA * 0.18 + E1.VLRVENDA)/ DE.VLRDESC)  AS 'DES_filial/balcao',
(E1.VLRVENDA * 0.36 + E1.VLRVENDA)  AS 'especial', ((E1.VLRVENDA * 0.36 + E1.VLRVENDA) - (E1.VLRVENDA * 0.32 + E1.VLRVENDA)/ DE.VLRDESC) AS 'DES_especial'
FROM TGFEXC E1 
	INNER JOIN TGFPRO PRO ON (E1.CODPROD = PRO.CODPROD)
	INNER JOIN TGFTAB TAB ON (E1.NUTAB = TAB.NUTAB)
	INNER JOIN AD_DESCEMP DE ON (PRO.CODPROD = DE.CODPROD)
CROSS APPLY (

    SELECT DISTINCT MAX(TAB.DTVIGOR) AS 'DTVIGOR', 
	MAX(E1.NUTAB) AS 'TAB', 
	PRO1.CODPROD,
	PRO1.REFERENCIA AS 'REFERENCIA',
	PRO1.DESCRPROD AS 'DESCRICAO',
	PRO1.CODVOL AS 'UNIDADE'
FROM TGFEXC E1 
	INNER JOIN TGFPRO PRO1 ON (E1.CODPROD = PRO1.CODPROD)
	INNER JOIN TGFTAB TAB ON (E1.NUTAB = TAB.NUTAB)
	INNER JOIN AD_DESCEMP DE ON (PRO1.CODPROD = DE.CODPROD)
WHERE PRO1.ATIVO = 'S' AND PRO1.USOPROD = 'R' AND TAB.CODTAB = 0 
AND (
	:REFERENCIA IS NULL OR :REFERENCIA IS NOT NULL AND (
	(LEN(:REFERENCIA) > 4 AND PRO1.REFERENCIA LIKE :REFERENCIA) OR
	(LEN(:REFERENCIA) <= 4 AND PRO1.REFERENCIA LIKE :REFERENCIA+'%')
))
GROUP BY PRO1.CODPROD,PRO1.REFERENCIA, PRO1.DESCRPROD, PRO1.CODVOL
--ORDER BY REFERENCIA, DTVIGOR

) PRODUTO
WHERE PRO.ATIVO = 'S' AND PRO.USOPROD = 'R' AND  TAB.CODTAB = 0 
AND TAB.NUTAB = PRODUTO.TAB AND PRO.CODPROD = PRODUTO.CODPROD
AND (
	:REFERENCIA IS NULL OR :REFERENCIA IS NOT NULL AND (
	(LEN(:REFERENCIA) > 4 AND PRO.REFERENCIA LIKE :REFERENCIA) OR
	(LEN(:REFERENCIA) <= 4 AND PRO.REFERENCIA LIKE :REFERENCIA+'%')
))
ORDER BY REFERENCIA

--SELECT * FROM AD_DESCEMP WHERE CODPROD = 2859


