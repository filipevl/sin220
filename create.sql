DROP SCHEMA IF EXISTS `6310_6320`;

CREATE SCHEMA IF NOT EXISTS `6310_6320` DEFAULT CHARACTER SET utf8;

USE `6310_6320`;

CREATE TABLE IF NOT EXISTS `6310_6320`.`continente` (
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(45) NOT NULL
)
ENGINE = innodb;

CREATE TABLE IF NOT EXISTS `6310_6320`.`pais` (
    `continente_id` INTEGER NOT NULL,
    `sigla_pais` VARCHAR(25) NOT NULL PRIMARY KEY,
    `nome` VARCHAR(45) NOT NULL,
    `idh` FLOAT NULL,
    `expectativa_vida` FLOAT NULL,
    `pib_per_capta` FLOAT NULL,
    `idosos_65` INT NULL,
    `idosos_70` INT NULL,
    `idade_media` FLOAT NULL,
    `taxa_morte_cardiovascular` FLOAT NULL,
    `predominancia_diabetes` FLOAT NULL,
    `taxa_mulheres_fumantes` FLOAT NULL,
    `taxa_homens_fumantes` FLOAT NULL,
    `instalacoes_lavagem` INT NULL,
    `populacao` INT NULL,
    `leitos_milhar` FLOAT NULL,
    `taxa_pobreza_extrema` FLOAT NULL,
    `densidade_populacional` FLOAT NULL
)
ENGINE = innodb;

CREATE TABLE IF NOT EXISTS `6310_6320`.`dados_covid` (
    `dia` DATE NOT NULL,
    `sigla_pais` VARCHAR(25) NOT NULL,
    `total_casos` FLOAT DEFAULT NULL,
    `novos_casos` FLOAT DEFAULT NULL,
    `novos_casos_estimados` FLOAT DEFAULT NULL,
    `total_mortes` FLOAT DEFAULT NULL,
    `novas_mortes` FLOAT DEFAULT NULL,
    `novas_mortes_estimadas` FLOAT DEFAULT NULL,
    `total_casos_milhao` FLOAT DEFAULT NULL,
    `novos_casos_milhao` FLOAT DEFAULT NULL,
    `novos_casos_estimados_milhao` FLOAT DEFAULT NULL,
    `total_mortes_milhao` FLOAT DEFAULT NULL,
    `novas_mortes_milhao` FLOAT DEFAULT NULL,
    `novas_mortes_estimadas_milhao` FLOAT DEFAULT NULL,
    `taxa_reproducao` FLOAT DEFAULT NULL,
    `pacientes_uti` FLOAT DEFAULT NULL,
    `pacientes_uti_milhao` FLOAT DEFAULT NULL,
    `pacientes_hospital` FLOAT DEFAULT NULL,
    `pacientes_hospital_milhao` FLOAT DEFAULT NULL,
    `uti_admissoes_semanais` FLOAT DEFAULT NULL,
    `uti_admissoes_semanais_milhao` FLOAT DEFAULT NULL,
    `hospital_admissoes_semanais` FLOAT DEFAULT NULL,
    `hospital_admissoes_semanal_milhao` FLOAT DEFAULT NULL,
    `novos_testes` FLOAT DEFAULT NULL,
    `total_testes` FLOAT DEFAULT NULL,
    `total_testes_milhar` FLOAT DEFAULT NULL,
    `novos_testes_milhar` FLOAT DEFAULT NULL,
    `novos_testes_estimados` FLOAT DEFAULT NULL,
    `novos_testes_estimados_milhar` FLOAT DEFAULT NULL,
    `taxa_positivos` FLOAT DEFAULT NULL,
    `testes_caso` FLOAT DEFAULT NULL,
    `testes_unitarios` VARCHAR(25) NULL,
    `total_vacinacoes` FLOAT DEFAULT NULL,
    `pessoas_vacinadas` FLOAT DEFAULT NULL,
    `pessoas_totalmente_vacinadas` FLOAT DEFAULT NULL,
    `novas_vacinacoes` FLOAT DEFAULT NULL,
    `novas_vacinacoes_estimadas` FLOAT DEFAULT NULL,
    `total_vacinacoes_%` FLOAT DEFAULT NULL,
    `pessoas_vacinadas_%` FLOAT DEFAULT NULL,
    `pessoas_totalmente_vacinadas_%` FLOAT DEFAULT NULL,
    `novas_vacinacoes_estimadas_milhao` FLOAT DEFAULT NULL,
    `grau_severidade` FLOAT DEFAULT NULL,
    PRIMARY KEY(dia,sigla_pais)
)
ENGINE = innodb;

ALTER TABLE `6310_6320`.`pais`
    ADD FOREIGN KEY (continente_id) REFERENCES continente(id);

ALTER TABLE `6310_6320`.`dados_covid`
    ADD FOREIGN KEY (sigla_pais) REFERENCES pais(sigla_pais);