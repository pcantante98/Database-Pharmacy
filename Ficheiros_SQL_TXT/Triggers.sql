USE projetog3;

DROP TABLE IF EXISTS Pessoa_audit;
DROP TRIGGER IF EXISTS before_pessoa_update; 

DROP TABLE IF EXISTS Produto_audit;
DROP TRIGGER IF EXISTS before_produto_update; 

DROP TABLE IF EXISTS Venda_audit;
DROP TRIGGER IF EXISTS before_venda_update; 

DROP TABLE IF EXISTS Item_venda_audit;
DROP TRIGGER IF EXISTS before_item_venda_update;

DROP TABLE IF EXISTS Morada_audit;
DROP TRIGGER IF EXISTS before_morada_update;

DROP TABLE IF EXISTS Prescricao_eletronica_audit;
DROP TRIGGER IF EXISTS before_prescricao_eletronica_update; 

SHOW TRIGGERS;
 
CREATE TABLE Pessoa_audit( 
	Id INT AUTO_INCREMENT PRIMARY KEY,
    
    Nome_old VARCHAR(70) NOT NULL,
    Nome_new VARCHAR(70) NOT NULL,
    Telemovel_old VARCHAR(20),
    Telemovel_new VARCHAR(20),
    Email_old VARCHAR(50),
    Email_new VARCHAR(50),
    Genero_old VARCHAR(1),
    Genero_new VARCHAR(1),
    
    Changedate DATETIME,
    ACTION VARCHAR(50) 
);
DELIMITER //
CREATE TRIGGER before_pessoa_update
BEFORE UPDATE ON Pessoa
FOR EACH ROW
BEGIN
    INSERT INTO Pessoa_audit 
    VALUES(
		NULL, 
        OLD.nome, 
        NEW.nome, 
        OLD.telemovel, 
        NEW.telemovel, 
        OLD.email, 
        NEW.email, 
        OLD.genero, 
        NEW.genero, 
        NOW(), 
        'Update');
END //
DELIMITER ;
-- Teste
SELECT * FROM Pessoa;
SELECT * FROM Pessoa WHERE num_CC = 20221868;
UPDATE Pessoa SET Nome = 'Cosmin Racsan' WHERE num_CC = 20221868;
SELECT * FROM Pessoa_audit;

-- Morada
CREATE TABLE Morada_audit(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Num_cc_morada_old INT NOT NULL,
    Rua_old VARCHAR(50) NOT NULL,
    Rua_new VARCHAR(50) NOT NULL,
    Porta_old VARCHAR(5) NOT NULL,
    Porta_new VARCHAR(5) NOT NULL,
    Codigo_postal1_old VARCHAR(4) NOT NULL,
    Codigo_postal1_new VARCHAR(4) NOT NULL,
    Codigo_postal2_old VARCHAR(3) NOT NULL,
    Codigo_postal2_new VARCHAR(3) NOT NULL,
    Localidade_old VARCHAR(50) NOT NULL,
    Localidade_new VARCHAR(50) NOT NULL,
    Changedate DATETIME,
    ACTION VARCHAR(50)
);
DELIMITER //
CREATE TRIGGER before_morada_update
BEFORE UPDATE ON Morada
FOR EACH ROW
BEGIN
    INSERT INTO Morada_audit 
    VALUES(
		NULL, 
        OLD.Num_cc_morada, 
        OLD.Rua, 
        NEW.Rua, 
        OLD.Porta, 
        NEW.Porta, 
        OLD.Codigo_postal1, 
        NEW.Codigo_postal1, 
        OLD.Codigo_postal2, 
        NEW.Codigo_postal2, 
        OLD.Localidade, 
        NEW.Localidade, 
        NOW(), 
		'Update');
END //
DELIMITER ;
-- Testes
SELECT * FROM Morada;
SELECT * FROM Morada WHERE Num_cc_morada = 81338156;
UPDATE Morada SET Porta = '16' WHERE Num_cc_morada = 81338156;
SELECT * FROM Morada_audit;

-- Prescrição eletrónica
CREATE TABLE Prescricao_eletronica_audit( 
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Id_utente_prescricao_eletronica_old INT NOT NULL,
    Id_produto_old INT NOT NULL,
    Id_produto_new INT NOT NULL,
    Data_validade_old DATE NOT NULL,
    Data_validade_new DATE NOT NULL,
    Data_emissao_old DATE NOT NULL,
    Data_emissao_new DATE NOT NULL,
    Observacoes_old TEXT,
    Observacoes_new TEXT,
    Changedate DATETIME ,
    ACTION VARCHAR(50)
);
DELIMITER //
CREATE TRIGGER before_prescricao_eletronica_update
BEFORE UPDATE ON Prescricao_eletronica
FOR EACH ROW
BEGIN
    INSERT INTO Prescricao_eletronica_audit 
    VALUES(
		NULL, 
        OLD.Id_utente_prescricao_eletronica_old, 
        OLD.Id_produto_old, 
        NEW.Id_produto_new, 
        OLD.Data_validade_old, 
        NEW.Data_validade_new, 
        OLD.Data_emissao_old, 
        NEW.Data_emissao_new, 
        OLD.Observacoes_old, 
        NEW.Observacoes_new, 
        NOW(), 
        'Update');
END //
DELIMITER ;
-- Testes
SELECT * FROM Prescricao_eletronica;
SELECT * FROM Prescricao_eletronica WHERE Id_prescricao_eletronica = 1;
UPDATE Prescricao_eletronica SET Observacoes = 'Tomar à noite' WHERE Id_prescricao_eletronica = 1;
SELECT * FROM Prescricao_eletronica_audit;

-- Venda
CREATE TABLE Venda_audit( 
	Id INT AUTO_INCREMENT PRIMARY KEY,
	Id_prescricao_eletronica_venda_old INT,
	Id_empregado_venda_old INT NOT NULL,
	Id_utente_venda_old INT NOT NULL,
    Id_utente_venda_new INT NOT NULL,
	Preco_total_old FLOAT NOT NULL,
    Preco_total_new FLOAT NOT NULL,
	Data_emissao_old DATE NOT NULL,
    Data_emissao_new DATE NOT NULL,
	Avaliacao_old VARCHAR(20) NOT NULL,
    Avaliacao_new VARCHAR(20) NOT NULL,
	Changedate DATETIME ,
    ACTION VARCHAR(50) 
);
DELIMITER //
CREATE TRIGGER before_venda_update
BEFORE UPDATE ON Venda
FOR EACH ROW
BEGIN
    INSERT INTO Venda_audit 
    VALUES(
		NULL, 
        OLD.Id_prescricao_eletronica_venda_old, 
        OLD.Id_empregado_venda_old, 
        OLD.Id_utente_venda_old,
        NEW.Id_utente_venda_new,
        OLD.Preco_total_old,
        NEW.Preco_total_new,
        OLD.Data_emissao_old,
        NEW.Data_emissao_new,
        OLD.Avaliacao_old,
        NEW.Avaliacao_new,
        NOW(), 
        'Update');
END //
DELIMITER ;
-- Testes
SELECT * FROM Venda;
SELECT * FROM Venda WHERE Id_venda = 1;
UPDATE Venda SET Avalicao = 'Bom' WHERE Id_venda = 1;
SELECT * FROM Venda_audit;

-- Item venda
CREATE TABLE Item_venda_audit( 
	Id_produto_item_venda_old INT NOT NULL,
    Id_produto_item_venda_new INT NOT NULL,
	Quantidade_old INT NOT NULL,
    Quantidade_new INT NOT NULL,
	Preco_vendido_old FLOAT NOT NULL,
    Preco_vendido_new FLOAT NOT NULL,
	Changedate DATETIME ,
    ACTION VARCHAR(50) 
);
DELIMITER //
CREATE TRIGGER before_item_venda_update
BEFORE UPDATE ON Item_venda
FOR EACH ROW
BEGIN
    INSERT INTO Item_venda_audit 
    VALUES(
		NULL, 
        OLD.Id_produto_item_venda_old,
        NEW.Id_produto_item_venda_new,
        OLD.Quantidade_old,
        NEW.Quantidade_new,
        OLD.Preco_vendido_old,
        NEW.Preco_vendido_new,
        NOW(), 
        'Update');
END //
DELIMITER ;
-- Testes
SELECT * FROM Item_venda;
SELECT * FROM Item_venda WHERE Id_venda_item_venda = 1 AND N_linha = 1;
UPDATE Item_venda SET Quantidade = 5 WHERE Id_venda_item_venda = 1 AND N_linha = 1;
SELECT * FROM Item_venda_audit;

-- Produto
CREATE TABLE Produto_audit( 
	Nome_old VARCHAR(100) NOT NULL,
    Nome_new VARCHAR(100) NOT NULL,
	Formato_old VARCHAR(50) NOT NULL,
    Formato_new VARCHAR(50) NOT NULL,
	Tipo_tratamento_old VARCHAR(50) NOT NULL,
    Tipo_tratamento_new VARCHAR(50) NOT NULL,
	Via_administracao_old VARCHAR(50) NOT NULL,
    Via_administracao_new VARCHAR(50) NOT NULL,
	Preco_atual_old FLOAT NOT NULL,
    Preco_atual_new FLOAT NOT NULL,
	Stock_old INT NOT NULL,
    Stock_new INT NOT NULL,
	Changedate DATETIME ,
    ACTION VARCHAR(50) 
);
DELIMITER //
CREATE TRIGGER before_produto_update
BEFORE UPDATE ON Produto
FOR EACH ROW
BEGIN
    INSERT INTO Produto_audit 
    VALUES(
		NULL, 
        OLD.Nome_old,
        NEW.Nome_new,
        OLD.Formato_old,
        NEW.Formato_new,
        OLD.Tipo_tratamento_old,
        NEW.Tipo_tratamento_new,
        OLD.Via_administracao_old,
        NEW.Via_administracao_new,
        OLD.Preco_atual_old,
        NEW.Preco_atual_new,
        OLD.Stock_old,
        NEW.Stock_new,
        NOW(), 
        'Update');
END //
DELIMITER ;
-- Testes
SELECT * FROM Produto;
SELECT * FROM Produto WHERE Id_produto = 1;
UPDATE Produto SET Formato = 'Comprimido' WHERE Id_produto = 1;
SELECT * FROM Produto_audit;