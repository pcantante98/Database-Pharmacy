CREATE DATABASE IF NOT EXISTS projetoG3;
USE projetoG3;

CREATE TABLE IF NOT EXISTS Pessoa(
	Num_cc INT NOT NULL UNIQUE,
    Nome VARCHAR(70) NOT NULL,
    Data_nascimento DATE NOT NULL,
    Telemovel VARCHAR(20),
    Email VARCHAR(50),
    Genero VARCHAR(1),
    CHECK (Genero = 'M' OR Genero = 'F'),
    PRIMARY KEY (Num_cc));

CREATE TABLE IF NOT EXISTS Morada(
	Id_morada INT NOT NULL AUTO_INCREMENT,
    Num_cc_morada INT NOT NULL UNIQUE,
    Rua VARCHAR(50) NOT NULL,
    Porta VARCHAR(5) NOT NULL,
    Codigo_postal1 VARCHAR(4) NOT NULL,
    Codigo_postal2 VARCHAR(3) NOT NULL,
    Localidade VARCHAR(50) NOT NULL,
    PRIMARY KEY (Id_morada));

CREATE TABLE IF NOT EXISTS Utente(
	Id_utente INT NOT NULL AUTO_INCREMENT UNIQUE,
    Num_cc_utente INT NOT NULL,
    PRIMARY KEY (Id_utente));

CREATE TABLE IF NOT EXISTS Empregado(
	Id_empregado INT NOT NULL AUTO_INCREMENT UNIQUE,
    Num_cc_empregado INT NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    PRIMARY KEY (Id_empregado));

CREATE TABLE IF NOT EXISTS Prescricao_eletronica(
	Id_prescricao_eletronica INT NOT NULL AUTO_INCREMENT,
    Id_utente_prescricao_eletronica INT NOT NULL,
    Id_produto INT NOT NULL,
    Data_validade DATE NOT NULL,
    Data_emissao DATE NOT NULL,
    Observacoes TEXT,
	CHECK (Data_validade>Data_emissao),
    PRIMARY KEY (Id_prescricao_eletronica));

CREATE TABLE IF NOT EXISTS Venda(
	Id_venda INT NOT NULL AUTO_INCREMENT,
	Id_prescricao_eletronica_venda INT,
	Id_empregado_venda INT NOT NULL,
	Id_utente_venda INT NOT NULL,
	Preco_total FLOAT NOT NULL,
	Data_emissao DATE NOT NULL,
	Avaliacao VARCHAR(20) NOT NULL,
    CHECK (Avaliacao = 'Mau' OR Avaliacao = 'Bom' OR Avaliacao = 'Excelente'),
    CHECK (Preco_total>0),
    PRIMARY KEY (Id_venda));

CREATE TABLE IF NOT EXISTS Item_venda(
	Id_venda_item_venda INT NOT NULL,
	N_linha INT NOT NULL,
	Id_produto_item_venda INT NOT NULL,
	Quantidade INT NOT NULL,
	Preco_vendido FLOAT NOT NULL,
    CHECK (Quantidade>0),
    CHECK (Preco_vendido>0),
    PRIMARY KEY (Id_venda_item_venda, N_linha));

CREATE TABLE IF NOT EXISTS Produto(
	Id_produto INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(100) NOT NULL,
	Formato VARCHAR(50) NOT NULL,
	Tipo_tratamento VARCHAR(50) NOT NULL,
	Via_administracao VARCHAR(50) NOT NULL,
	Preco_atual FLOAT NOT NULL,
	Stock INT NOT NULL,
    CHECK (Stock>=0),
    CHECK (Preco_atual>=0),
    PRIMARY KEY (Id_produto));

-- Chaves estrangeiras
ALTER TABLE Morada ADD CONSTRAINT morada_fk_pessoa
            FOREIGN KEY (Num_cc_morada) REFERENCES Pessoa(Num_cc);

ALTER TABLE Utente ADD CONSTRAINT utente_fk_pessoa
            FOREIGN KEY (Num_cc_utente) REFERENCES Pessoa(Num_cc);

ALTER TABLE Empregado ADD CONSTRAINT empregado_fk_pessoa
            FOREIGN KEY (Num_cc_empregado) REFERENCES Pessoa(Num_cc);

ALTER TABLE Prescricao_eletronica ADD CONSTRAINT Prescricao_eletronica_fk_utente
            FOREIGN KEY (Id_utente_prescricao_eletronica) REFERENCES Utente(Id_utente);

ALTER TABLE Venda ADD CONSTRAINT Venda_fk_prescricao_eletronica
            FOREIGN KEY (Id_prescricao_eletronica_venda) REFERENCES Prescricao_eletronica(Id_prescricao_eletronica);

ALTER TABLE Venda ADD CONSTRAINT Venda_fk_empregado
            FOREIGN KEY (Id_empregado_venda) REFERENCES Empregado(Id_empregado);

ALTER TABLE Venda ADD CONSTRAINT Venda_fk_utente
            FOREIGN KEY (Id_utente_venda) REFERENCES Utente(Id_utente);

ALTER TABLE Item_venda ADD CONSTRAINT Item_venda_fk_venda
            FOREIGN KEY (Id_venda_item_venda) REFERENCES Venda(Id_venda)
				ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Item_venda ADD CONSTRAINT Item_venda_fk_produto
            FOREIGN KEY (Id_produto_item_venda) REFERENCES Produto(Id_produto);