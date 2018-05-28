SELECT DISTINCT PAR.CODPARC, PAR.NOMEPARC, PAR.CODCID, PAR.CODEND, CID.CODCID, CID.NOMECID, E.CODEND, E.NOMEEND
FROM TGFPAR PAR
INNER JOIN TSICID CID ON (PAR.CODCID = CID.CODCID)
INNER JOIN TSIEND E ON (PAR.CODEND = E.CODEND)
--INNER JOIN TGFCAB CAB ON (PAR.CODPARC = CAB.CODPARC)
WHERE CID.NOMECID = E.NOMEEND
AND PAR.TIPPESSOA = 'J'
AND PAR.ATIVO = 'S'
--AND PAR.CODPARC NOT IN
AND PAR.CODPARC IN 
(SELECT DISTINCT CODPARC
FROM TGFCAB 
WHERE EXISTS (SELECT DISTINCT CODPARC FROM TGFPAR))
ORDER BY PAR.CODPARC






