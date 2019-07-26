SELECT /* INFORME FUNCIONARIOS*/ * 
  FROM (
SELECT *
    FROM (

SELECT 
DISTINCT 
EMP.CODEMP,EMP.NOMEFANTASIA AS 'EMPRESA', FUN.NOMEFUNC AS 'NOME', FUN.DTNASC AS 'DATA_NASCIMENTO', FUN.SEXO AS 'SEXO', 
FUN.PIS AS 'PIS', FUN.NUMCPS, FUN.SERIECPS,FUN.DTADM, UFS.UF ,FUN.IDENTIDADE, FUN.ORGAORG,FUN.DTRG, FUN.CPF, FUN.MATRICULA, 
EN.NOMEEND, CID.NOMECID, BAI.NOMEBAI, FUN.CEP, FUN.NOMEMAE, FUN.TITELEITORAL, DEP.DESCRDEP AS DEPARTAMENTO, 
CAR.DESCRCARGO AS CARGO, CAR.CODCBO,  DEP.CODDEP, FUN.ESTADOCIVIL, CGH.DESCRCARGAHOR, FUN.TELEFONE, FUN.CELULAR
/*, VAL.QTDDIAS, VAL.VALOR*/ ,DTDEM AS 'DEMITIDO'
FROM TFPDEP DEP
	INNER JOIN TFPFUN FUN ON (DEP.CODDEP=FUN.CODDEP)
	INNER JOIN TFPCAR CAR ON (CAR.CODCARGO=FUN.CODCARGO)
	INNER JOIN TFPCBO CBO ON (CAR.CODCBO=CBO.CODCBO)
	INNER JOIN TSIEMP EMP ON (EMP.CODEMP=FUN.CODEMP)
	INNER JOIN TSIBAI BAI ON (BAI.CODBAI=FUN.CODBAI)
	INNER JOIN TSICID CID ON (CID.CODCID=FUN.CODCID)
	INNER JOIN TSIEND EN ON (EN.CODEND=FUN.CODEND)
	INNER JOIN TSIUFS UFS ON (UFS.CODUF=FUN.UFCPS)
	INNER JOIN TFPCGH CGH ON (CGH.CODCARGAHOR=FUN.CODCARGAHOR)
	INNER JOIN TSIUSU USU ON (USU.CODUSU=SANKHYA.STP_GET_CODUSULOGADO())
	--INNER JOIN TFPVAL VAL ON (VAL.CODFUNC = FUN.CODFUNC)

WHERE --DTDEM IS NULL AND 
(
	(USU.CODEMP IS NULL AND FUN.CODEMP IN :CODEMP) OR
	(USU.CODEMP IS NOT NULL AND FUN.CODEMP = USU.CODEMP)
)
AND :TIPO = 'T'
--ORDER BY EMP.CODEMP,FUN.NOMEFUNC

UNION ALL

SELECT 
DISTINCT 
EMP.CODEMP,EMP.NOMEFANTASIA AS 'EMPRESA', FUN.NOMEFUNC AS 'NOME', FUN.DTNASC AS 'DATA_NASCIMENTO', FUN.SEXO AS 'SEXO', 
FUN.PIS AS 'PIS', FUN.NUMCPS, FUN.SERIECPS,FUN.DTADM, UFS.UF ,FUN.IDENTIDADE, FUN.ORGAORG,FUN.DTRG, FUN.CPF, FUN.MATRICULA, 
EN.NOMEEND, CID.NOMECID, BAI.NOMEBAI, FUN.CEP, FUN.NOMEMAE, FUN.TITELEITORAL, DEP.DESCRDEP AS DEPARTAMENTO, 
CAR.DESCRCARGO AS CARGO, CAR.CODCBO,  DEP.CODDEP, FUN.ESTADOCIVIL, CGH.DESCRCARGAHOR, FUN.TELEFONE, FUN.CELULAR
/*, VAL.QTDDIAS, VAL.VALOR*/ ,DTDEM AS 'DEMITIDO'
FROM TFPDEP DEP
	INNER JOIN TFPFUN FUN ON (DEP.CODDEP=FUN.CODDEP)
	INNER JOIN TFPCAR CAR ON (CAR.CODCARGO=FUN.CODCARGO)
	INNER JOIN TFPCBO CBO ON (CAR.CODCBO=CBO.CODCBO)
	INNER JOIN TSIEMP EMP ON (EMP.CODEMP=FUN.CODEMP)
	INNER JOIN TSIBAI BAI ON (BAI.CODBAI=FUN.CODBAI)
	INNER JOIN TSICID CID ON (CID.CODCID=FUN.CODCID)
	INNER JOIN TSIEND EN ON (EN.CODEND=FUN.CODEND)
	INNER JOIN TSIUFS UFS ON (UFS.CODUF=FUN.UFCPS)
	INNER JOIN TFPCGH CGH ON (CGH.CODCARGAHOR=FUN.CODCARGAHOR)
	INNER JOIN TSIUSU USU ON (USU.CODUSU=SANKHYA.STP_GET_CODUSULOGADO())
	--INNER JOIN TFPVAL VAL ON (VAL.CODFUNC = FUN.CODFUNC)

WHERE DTDEM IS NULL 
AND 
(
	(USU.CODEMP IS NULL AND FUN.CODEMP IN :CODEMP) OR
	(USU.CODEMP IS NOT NULL AND FUN.CODEMP = USU.CODEMP)
)
AND :TIPO = 'A'
--ORDER BY EMP.CODEMP,FUN.NOMEFUNC

UNION ALL

SELECT 
DISTINCT 
EMP.CODEMP,EMP.NOMEFANTASIA AS 'EMPRESA', FUN.NOMEFUNC AS 'NOME', FUN.DTNASC AS 'DATA_NASCIMENTO', FUN.SEXO AS 'SEXO', 
FUN.PIS AS 'PIS', FUN.NUMCPS, FUN.SERIECPS,FUN.DTADM, UFS.UF ,FUN.IDENTIDADE, FUN.ORGAORG,FUN.DTRG, FUN.CPF, FUN.MATRICULA, 
EN.NOMEEND, CID.NOMECID, BAI.NOMEBAI, FUN.CEP, FUN.NOMEMAE, FUN.TITELEITORAL, DEP.DESCRDEP AS DEPARTAMENTO, 
CAR.DESCRCARGO AS CARGO, CAR.CODCBO,  DEP.CODDEP, FUN.ESTADOCIVIL, CGH.DESCRCARGAHOR, FUN.TELEFONE, FUN.CELULAR
/*, VAL.QTDDIAS, VAL.VALOR*/ ,DTDEM AS 'DEMITIDO'
FROM TFPDEP DEP
	INNER JOIN TFPFUN FUN ON (DEP.CODDEP=FUN.CODDEP)
	INNER JOIN TFPCAR CAR ON (CAR.CODCARGO=FUN.CODCARGO)
	INNER JOIN TFPCBO CBO ON (CAR.CODCBO=CBO.CODCBO)
	INNER JOIN TSIEMP EMP ON (EMP.CODEMP=FUN.CODEMP)
	INNER JOIN TSIBAI BAI ON (BAI.CODBAI=FUN.CODBAI)
	INNER JOIN TSICID CID ON (CID.CODCID=FUN.CODCID)
	INNER JOIN TSIEND EN ON (EN.CODEND=FUN.CODEND)
	INNER JOIN TSIUFS UFS ON (UFS.CODUF=FUN.UFCPS)
	INNER JOIN TFPCGH CGH ON (CGH.CODCARGAHOR=FUN.CODCARGAHOR)
	INNER JOIN TSIUSU USU ON (USU.CODUSU=SANKHYA.STP_GET_CODUSULOGADO())
	--INNER JOIN TFPVAL VAL ON (VAL.CODFUNC = FUN.CODFUNC)

WHERE DTDEM IS NOT NULL 
AND 
(
	(USU.CODEMP IS NULL AND FUN.CODEMP IN :CODEMP) OR
	(USU.CODEMP IS NOT NULL AND FUN.CODEMP = USU.CODEMP)
)
AND :TIPO = 'D'
--ORDER BY EMP.CODEMP,FUN.NOMEFUNC

) SUB) X
--ORDER BY EMP.CODEMP,FUN.NOMEFUNC