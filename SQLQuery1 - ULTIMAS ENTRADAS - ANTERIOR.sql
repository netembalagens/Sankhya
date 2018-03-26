SELECT * FROM (
	SELECT row_number() OVER (ORDER BY PRODUTO ASC,DATA_ENTRADA DESC,NUNOTA DESC) AS row_number, *
	FROM (

		SELECT
			PRO.REFERENCIA AS 'PRODUTO',
			CAB.NUNOTA AS 'NUNOTA',
			RTRIM(LTRIM(PAR.NOMEPARC)) AS 'FORNECEDOR',
			CAB.DTENTSAI AS 'DATA_ENTRADA',
			CAB.NUMNOTA AS 'NOTA',
			ITE.QTDNEG AS 'QTDE',
			ITE.VLRUNIT AS 'VLR_UNIT',
			ALIQIPI AS 'ALIQ_IPI',
			CASE WHEN CAB.VLRFRETE = 0 THEN 0 WHEN CAB.VLRFRETE > 0 THEN (CAB.VLRFRETE / (SELECT SUM(I.VLRTOT) FROM TGFITE I WHERE I.NUNOTA = CAB.NUNOTA) * 100) END AS 'PERC_FRETE'

		FROM TGFCAB CAB
		INNER JOIN TGFITE ITE ON (ITE.NUNOTA = CAB.NUNOTA)
		INNER JOIN TGFPAR PAR ON (PAR.CODPARC = CAB.CODPARC)
		INNER JOIN TGFPRO PRO ON (PRO.CODPROD = ITE.CODPROD)

		WHERE CAB.TIPMOV = 'C'
		AND CAB.STATUSNOTA = 'L'
		AND CAB.CODEMP = :EMPRESA
		AND (
			(LEN(:GRUPO) > 4 AND PRO.REFERENCIA LIKE :GRUPO) OR
			(LEN(:GRUPO) <= 4 AND PRO.REFERENCIA LIKE :GRUPO+'%')
		)
		AND CAB.CODVEND <> 59 AND CAB.NUNOTA IN (SELECT NUNOTA FROM TGFFIN WHERE ORIGEM = 'E' AND CODTIPTIT <> 69)

	) SUB
) TabelaNumerada
WHERE row_number BETWEEN 0 AND 10