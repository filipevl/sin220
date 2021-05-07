 -- Quantos países estão na base de dados?
SELECT  COUNT(nome) AS 'Número de paises'
FROM pais;

-- Qual o total de casos para o mundo no dia 14/04/2021?

SELECT  SUM(total_casos)
FROM dados_covid
WHERE dia = '2021-04-14';

-- Quais foram os 10 países com mais casos confirmados no mês de Março/2021（ordem descrescente）? 

SELECT  distinct p.nome
FROM pais AS p, dados_covid AS d
WHERE p.sigla_pais = d.pais_sigla_pais 
AND d.dia < '2021-04-01' 
AND d.dia > '2021-02-29'
ORDER BY d.total_casos desc 
LIMIT 10; 

-- Quais países não possuem informação de pacientes na UTI para o mês de Feve-reiro/2021

SELECT distinct p.nome 
from trabalho_sin_220.pais as p, 
     trabalho_sin_220.dados_covid as d
     where p.sigla_pais = d.pais_sigla_pais
     and d.dia > '2021-01-31'  and d.dia < '2021-03-01'
     and d.pacientes_uti is NULL

-- Qual foi o dia com a maior quantidade de novos casos registrados de COVID-19 no Brasil?

SELECT d.dia
from trabalho_sin_220.pais as p, 
     trabalho_sin_220.dados_covid as d
     where p.sigla_pais = d.pais_sigla_pais
     and p.nome = 'Brazil'
    order by d.novos_casos desc limit 1;

-- Qual foi o dia com a maior quantidade de mortes confirmadas por COVID-19 no mundo?
