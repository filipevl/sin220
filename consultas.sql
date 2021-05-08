 -- Quantos países estão na base de dados?

use trabalho_sin_220;

SELECT  COUNT(nome) AS 'Número de paises'
FROM pais;

-- Qual o total de casos para o mundo no dia 14/04/2021?

use trabalho_sin_220;

SELECT  SUM(total_casos)
FROM dados_covid
WHERE dia = '2021-04-14';

-- Quais foram os 10 países com mais casos confirmados no mês de Março/2021（ordem descrescente）? 

use trabalho_sin_220;

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

-- 4. Liste os 10 países com maior e os 10 com menor expectativa de vida.

use trabalho_sin_220;

drop temporary table  if exists PAISESMAIOR;
drop temporary table if exists PAISESMENOR;

CREATE TEMPORARY TABLE PAISESMAIOR(
	id integer auto_increment primary key,
    nome varchar(40)
);

INSERT INTO PAISESMAIOR	(nome)
SELECT distinct p.nome 
FROM trabalho_sin_220.pais as p, trabalho_sin_220.dados_covid as d 
where p.sigla_pais = d.pais_sigla_pais
order by p.expectativa_vida desc
limit 10;

CREATE TEMPORARY TABLE PAISESMENOR(
	id integer auto_increment primary key,
    nome varchar(40)
);

INSERT INTO PAISESMENOR	(nome)
SELECT distinct p.nome 
FROM trabalho_sin_220.pais as p, trabalho_sin_220.dados_covid as d 
where p.sigla_pais = d.pais_sigla_pais
order by p.expectativa_vida
limit 10;

select a.id as Ranking, 
       a.nome as 'Paises com maior expectativa de vida', 
       b.nome as 'Paises com menor expectativa de vida'
       
       from PAISESMAIOR as a, PAISESMENOR as b 
       where a.id = b.id;

drop temporary table PAISESMAIOR;
drop temporary table PAISESMENOR;