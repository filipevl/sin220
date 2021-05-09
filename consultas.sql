-- 1. Quantos países estão na base de dados?

use trabalho_sin_220;

SELECT  COUNT(nome) AS 'Número de paises'
FROM pais;

-- 2. Qual o total de casos para o mundo no dia 14/04/2021?

use trabalho_sin_220;

SELECT  SUM(total_casos)
FROM dados_covid
WHERE dia = '2021-04-14';

-- 3. Quais foram os 10 países com mais casos confirmados no mês de Março/2021（ordem descrescente）? 

use trabalho_sin_220;

SELECT  distinct p.nome
FROM pais AS p, dados_covid AS d
WHERE p.sigla_pais = d.pais_sigla_pais 
AND d.dia < '2021-04-01' 
AND d.dia > '2021-02-29'
ORDER BY d.total_casos desc 
LIMIT 10; 

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

-- 5. Liste os continentes contendo o total de casos de cada um em 2021

use trabalho_sin_220;

drop table if exists CasosContinente;

create temporary table CasosContinente
select p.continente_id,
    sum(d.novos_casos) as total
from pais as p,
    dados_covid as d
where p.sigla_pais = d.pais_sigla_pais
    and d.dia > '2020-12-31'
    and d.dia < '2022-01-01'
group by p.continente_id;
select c.nome,
    t.total
from continente as c,
    CasosContinente as t
where c.id = t.continente_id
order by nome;
drop table CasosContinente;

-- 6. Liste os países da América do Sul e inclua as informações do total de pessoas total-mente vacinadas em 2021,
-- em valores absolutos e percentual. Ordene o resultadoem ordem decrescente pelo percentual de vacinados.

use trabalho_sin_220;

drop table if exists aux;

create temporary table aux 
select p.nome, p.sigla_pais,
    max(d.`pessoas_totalmente_vacinadas`) as vac
from dados_covid as d,
    paisesASul as p
where d.pais_sigla_pais = p.sigla_pais
group by p.nome
order by p.nome,
    d.dia desc;
    
select a.nome, a.vac, d.`pessoas_totalmente_vacinadas_%`

	   from aux as a, dados_covid as d
       where a.vac = d.pessoas_totalmente_vacinadas and a.sigla_pais = d.pais_sigla_pais
       order by nome;
       
drop table if exists aux;


-- 7. Liste os países informando o grau de restrições
-- que foram aplicadas à população(há um atributo com este índice (stringency)
-- que engloba várias medidas como fechamento de escolas, proibição de viagens, . . . )
-- e o total de novos casos por milhão de habitantes confirmados para o mês de Março/2021

use trabalho_sin_220;

select p.nome, avg(d.grau_severidade) as 'Grau de severidade', sum(d.novos_casos_milhao) as 'Total de casos por milhao'
  from pais as p, dados_covid as d
 where p.sigla_pais = d.pais_sigla_pais and d.dia > '2021-02-28' and d.dia < '2021-04-01'
 group by p.nome


-- 8. Quais países não possuem informação de pacientes na UTI para o mês de Feve-reiro/2021

use trabalho_sin_220;

SELECT distinct p.nome 
from trabalho_sin_220.pais as p, 
     trabalho_sin_220.dados_covid as d
     where p.sigla_pais = d.pais_sigla_pais
     and d.dia > '2021-01-31'  and d.dia < '2021-03-01'
     and d.pacientes_uti is NULL

-- 9. Qual foi o dia com a maior quantidade de novos casos registrados de COVID-19 no Brasil?

use trabalho_sin_220;

SELECT d.dia
from trabalho_sin_220.pais as p, 
     trabalho_sin_220.dados_covid as d
     where p.sigla_pais = d.pais_sigla_pais
     and p.nome = 'Brazil'
    order by d.novos_casos desc limit 1;

-- 10. Qual foi o dia com a maior quantidade de mortes confirmadas por COVID-19 no mundo?

use trabalho_sin_220;

drop temporary table if exists totalMortes

create temporary table totalMortes
select dia, sum(novas_mortes) as t_mortes 
from dados_covid 
where dia > 0
group by dia;

select dia as 'Dia com mais mortes'
from totalMortes
order by t_mortes desc limit 1;
