SELECT CODEMP, CODFUNC, NOMEFUNC, IDENTIDADE, CPF, NOMEMAE, NOMEPAI, DTNASC, PIS, TITELEITORAL
FROM TFPFUN
WHERE DTDEM IS NULL
AND NOMEMAE IS NULL
OR NOMEMAE NOT LIKE '% %'
--OR NOMEPAI IS NULL
OR IDENTIDADE IS NULL
OR DTNASC IS NULL
OR TITELEITORAL IS NULL
 

--UPDATE TFPFUN SET IDENTIDADE = REPLACE (IDENTIDADE, 'J' , '')

