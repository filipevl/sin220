-- Script de inserção de continente

insert into continente (nome)
select distinct continente from trabalho.covid_data where continente is not NULL;



-- Script de inserção de pais

insert into pais
select distinct 
	p.sigla_pais, p.pais, c.id, p.IDH, p.expectativa_de_vida, p.PIB_per_capita,
	p.idosos_65_anos, p.idosos_70_anos, p.idade_media, p.taxa_de_mortes_cardiovasc,
    p.predominancia_diabetes, p.mulheres_fumantes, p.homens_fumantes, p.instalacoes_de_lavagem,
    p.populacao, p.leitos_por_milhar, p.pobreza_extrema, p.densidade_populacional 
from 
	trabalho.covid_data as p, continente as c
where p.continente is not NULL and p.continente = c.nome;

-- Script de inserção de dados_covid

insert into dados_covid
select
  d.dia,
  p.sigla_pais,
  d.total_de_casos, 
  d.novos_casos, 
  d.novos_casos_suspeitos,
  d.total_de_mortes,
  d.novas_mortes,
  d.novas_mortes_suspeitas,
  d.total_de_casos_por_milhao,
  d.novos_casos_por_milhao,
  d.novos_casos_suspeitos_por_milhao,
  d.total_de_mortes_por_milhao,
  d.novas_mortes_por_milhao,
  d.novas_mortes_suspeitas_por_milhao,
  d.taxa_de_reproducao,
  d.pacientes_uti,
  d.pacientes_uti_por_milhao,
  d.pacientes_hosp,
  d.pacientes_hosp_por_milhao,
  d.uti_admissoes_semanais,
  d.uti_admissoes_semanais_por_milhao,
  d.hosp_admissoes_semanais,
  d.hosp_admissoes_semanais_por_milhao,
  d.novos_testes,
  d.total_testes,
  d.total_testes_por_milhar,
  d.novos_testes_por_milhar,
  d.novos_testes_suspeitos,
  d.novos_testes_suspeitos_por_milhar,
  d.taxa_de_positivos,
  d.testes_por_caso,
  d.testes_unitarios,
  d.total_de_vacinacoes,
  d.pessoas_vacinadas,
  d.pessoas_totalmente_vacinadas,
  d.novas_vacinacoes,
  d.novas_vacinacoes_estimadas,
  d.total_de_vacinacoes_por_cento,
  d.pessoas_vacinadas_por_cento,
  d.pessoas_totalmente_vacinadas_por_cento,
  d.novas_vacinacoes_estimadas_por_milhao,
  d.grau_de_severidade
from trabalho.covid_data as d, trabalho_sin_220.pais as p
where d.continente is not null and d.sigla_pais = p.sigla_pais;

