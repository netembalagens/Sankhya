SELECT CAST(VEN.CODVEND AS VARCHAR) + ' - ' + VEN.APELIDO VENDEDOR, 
	   CAST(FUN.CODFUNC AS VARCHAR) + ' - ' + FUN.NOMEFUNC FUNCIONARIO,
	   COM.NUNOTAORIG NUNOTA,
	   CAB.NUMNOTA NOTA,
	   CAST(CAB.CODEMP AS VARCHAR) + ' - ' + EMP.NOMEFANTASIA EMPRESA,
	   CAB.DTNEG DATA,
	   COM.VLRCOM COMISSAO,
	   COM.CODFORM FORMULA,
	   CASE WHEN CAB.TIPMOV = 'V' THEN 'VENDA' ELSE 'DEVOLUCAO' END TIPO
FROM TGFCOM COM
INNER JOIN TGFVEN VEN ON COM.CODVEND = VEN.CODVEND
INNER JOIN TGFCAB CAB ON CAB.NUNOTA = COM.NUNOTAORIG
INNER JOIN TSIEMP EMP ON EMP.CODEMP = CAB.CODEMP
LEFT JOIN TFPFUN FUN ON FUN.CODFUNC = VEN.CODFUNC
WHERE (VEN.CODEMP = 1 OR 1 IS NULL)
  AND CAST(CAB.DTNEG AS DATE) BETWEEN CAST('25/02/2018' AS DATE) AND CAST('24/03/2018' AS DATE)
  AND (VEN.CODVEND = 4 OR 4 IS NULL)
  AND (FUN.CODEMP = 1 OR 1 IS NULL)
