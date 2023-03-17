-- INSERT --

#Procedure Pessoa
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_insert_pessoa//
CREATE PROCEDURE sp_insert_pessoa(
									 IN  p_num_cc    INT,
                                     IN  p_nome      VARCHAR(70),
                                     IN  p_dnsc      VARCHAR(10),
                                     IN  p_telemovel VARCHAR(20),
                                     IN  p_email     VARCHAR(50),
                                     IN  p_genero    VARCHAR(1))
BEGIN
  INSERT INTO Pessoa (Num_cc, Nome, Data_nascimento, Telemovel, Email, Genero) 
		VALUES (p_num_cc, p_nome, str_to_date(p_dnsc, '%d.%m.%Y'), p_telemovel, p_email, p_genero);
END//
DELIMITER ;

# call sp_insert_pessoa('78528314', 'Manuel Pires', '22.2.1926', '929269120', 'manuel.pires@gmail.com', 'M');

select *
from Pessoa;

#Procedure Utente
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_insert_utente//
CREATE PROCEDURE sp_insert_utente(
									 IN  p_id_utente   INT,
                                     IN  p_num_cc_utente    INT)
BEGIN
  INSERT INTO Utente (Id_utente, Num_cc_utente) 
		VALUES (p_id_utente, p_num_cc_utente);
END//
DELIMITER ;

call sp_insert_pessoa('78528314', 'Manuel Pires', '22.2.1926', '929269120', 'manuel.pires@gmail.com', 'M');
call sp_insert_Utente('3245','78528314');

select *
from utente;

#Procedure Morada
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_insert_morada//
CREATE PROCEDURE sp_insert_morada(
                                     IN  p_num_cc_morada    INT,
                                     IN  p_rua    VARCHAR(50),
                                     IN  p_porta    VARCHAR(5),
                                     IN  p_codigo_postal1    VARCHAR(4),
                                     IN  p_codigo_postal2    VARCHAR(3),
                                     IN  p_localidade    VARCHAR(50))
BEGIN
  INSERT INTO Morada (Num_cc_morada, Rua, Porta, Codigo_postal1, Codigo_postal2, Localidade) 
		VALUES (p_num_cc_morada, p_rua, p_porta, p_codigo_postal1, p_codigo_postal2, p_localidade);
END//
DELIMITER ;

call sp_insert_morada('81338156', 'Rua de Sérgio Mendes', '149', '1491', '949', 'Olhão');

select *
from morada;

#Procedure Empregado
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_insert_empregado//
CREATE PROCEDURE sp_insert_empregado(
                                     IN  p_num_cc_empregado    INT,
                                     IN  p_cargo    VARCHAR(50))
BEGIN
  INSERT INTO Empregado (Num_cc_empregado, Cargo) 
		VALUES (p_num_cc_empregado, p_cargo);
END//
DELIMITER ;

call sp_insert_Empregado('78528896', 'Estagiário');

select *
from empregado;

#Procedure Prescricao_eletronica
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_insert_prescricao_eletronica//
CREATE PROCEDURE sp_insert_prescricao_eletronica(
                                     IN  p_id_utente_prescricao_eletronica    INT,
                                     IN  p_id_produto    INT,
                                     IN  p_data_validade VARCHAR(10),
                                     IN  p_data_emissao  VARCHAR(10),
                                     IN  p_observacoes  VARCHAR(50))
BEGIN
  INSERT INTO Prescricao_eletronica (Id_utente_prescricao_eletronica, Id_produto, Data_validade, Data_emissao, Observacoes) 
		VALUES (p_id_utente_prescricao_eletronica, p_id_produto, str_to_date(p_data_validade, '%d.%m.%Y'), str_to_date(p_data_emissao, '%d.%m.%Y'), p_observacoes);
END//
DELIMITER ;

call sp_insert_Prescricao_eletronica('21', '2','5.5.2029', '7.8.1999', '2x de manhã e 3x de noite');

select *
from Prescricao_eletronica;

#Procedure Produto
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_insert_produto//
CREATE PROCEDURE sp_insert_produto(
                                     IN  p_nome    VARCHAR(100),
                                     IN  p_formato    VARCHAR(50),
                                     IN  p_tipo_tratamento VARCHAR(50),
                                     IN  p_via_administracao  VARCHAR(50),
                                     IN  p_preco_atual  FLOAT,
                                     IN  p_stock  INT)
BEGIN
  INSERT INTO Produto (Nome, Formato, Tipo_tratamento, Via_administracao, Preco_atual, Stock) 
		VALUES (p_nome, p_formato, p_tipo_tratamento, p_via_administracao, p_preco_atual, p_stock);
END//
DELIMITER ;

call sp_insert_Produto('Symbicort', 'Xarope', 'Hidratante', 'Ocular', '17.7', '44');

select *
from Produto;

#Procedure Venda
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_insert_venda//
CREATE PROCEDURE sp_insert_venda(
                                     IN  p_id_prescricao_eletronica_venda    INT,
                                     IN  p_id_empregado_venda    INT,
                                     IN  p_id_utente_venda INT,
                                     IN  p_preco_total  FLOAT,
                                     IN  p_data_emissao  VARCHAR(10),
                                     IN  p_avaliacao  VARCHAR(20))
BEGIN
  INSERT INTO Venda (Id_prescricao_eletronica_venda, Id_empregado_venda, Id_utente_venda, Preco_total, Data_emissao, Avaliacao) 
		VALUES (p_id_prescricao_eletronica_venda, p_id_empregado_venda, p_id_utente_venda, p_preco_total, str_to_date(p_data_emissao, '%d.%m.%Y'), p_avaliacao);
END//
DELIMITER ;

call sp_insert_Venda('20', '4', '20', '102.69','10.1.2019', 'Bom');

select *
from Venda;

#Procedure Item_venda
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_insert_item_venda//
CREATE PROCEDURE sp_insert_item_venda(
                                     IN  p_id_venda_item_venda    INT,
                                     IN  p_n_linha    INT,
                                     IN  p_id_produto_item_venda INT,
                                     IN  p_quantidade  INT,
                                     IN  p_preco_vendido  FLOAT)
BEGIN
  INSERT INTO Item_venda (Id_venda_item_venda, N_linha, Id_produto_item_venda, Quantidade, Preco_vendido) 
		VALUES (p_id_venda_item_venda, p_n_linha, p_id_produto_item_venda, p_quantidade, p_preco_vendido);
END//
DELIMITER ;	

call sp_insert_Item_venda('14', '14', '12', '10', '14.29');

select *
from Item_venda;


-- UPDATE --

#Procedure Pessoa
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_update_pessoa//
CREATE PROCEDURE sp_update_pessoa(IN cc int, IN newName VARCHAR(70),  newDate VARCHAR(10), IN  newPhone VARCHAR(20), IN  newEmail VARCHAR(50), IN  newGenero VARCHAR(1))
BEGIN
  update Pessoa
  set Nome = newName, Data_nascimento = newDate, Telemovel = newPhone, Email = newEmail, Genero = newGenero where Num_cc = cc;
  
END//
DELIMITER ;

call sp_update_pessoa('78528314', 'Miguel Pires', str_to_date('20.2.1926', '%d.%m.%Y'), '919269120', 'miguel.pires@gmail.com', 'M');

select *
from Pessoa;

#Procedure Morada
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_update_morada//
CREATE PROCEDURE sp_update_morada(in id int, in novaRua VARCHAR(50), in novaPorta VARCHAR(5), in cp1 VARCHAR(4), in cp2 VARCHAR(3), IN novaLocalidade VARCHAR(50))
BEGIN
  update Morada
  set Rua = novaRua, Porta = novaPorta, Codigo_postal1 = cp1, Codigo_postal2 = cp2, Localidade = novaLocalidade where Id_morada = id;
  
END//
DELIMITER ;

call sp_update_morada('61', 'Rua de Miguel Velez', '148', '2850', '357', 'Faro');

select *
from Morada;

#Procedure Empregado
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_update_empregado//
CREATE PROCEDURE sp_update_empregado(in cc int, in novoCargo VARCHAR(50))
BEGIN
  update Empregado
  set Cargo = novoCargo where Num_cc_empregado = cc;
  
END//
DELIMITER ;

call sp_update_empregado('37100076', 'Farmacêutico');

select *
from Empregado;

#Procedure Prescricao_eletronica
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_update_prescricao_eletronica//
CREATE PROCEDURE sp_update_prescricao_eletronica(IN  novoId_prescricao_eletronica    INT,
                                     IN  novoId_produto    INT,
                                     IN  novaData_validade VARCHAR(10),
                                     IN  novaData_emissao  VARCHAR(10),
                                     IN  novasObservacoes  VARCHAR(50))
BEGIN
  update Prescricao_eletronica
  set Id_produto = novoId_produto, Data_validade = novaData_validade, Data_emissao = novaData_emissao, Observacoes = novasObservacoes where novoId_prescricao_eletronica = Id_prescricao_eletronica;
  
END//
DELIMITER ;

call sp_update_prescricao_eletronica('20', '3', str_to_date('5.5.2028', '%d.%m.%Y'), str_to_date('7.8.2000', '%d.%m.%Y'), '1x de manhã e 1x de noite');

select *
from Prescricao_eletronica;

#Procedure Produto
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_update_produto//
CREATE PROCEDURE sp_update_produto(in id int, in novoNome VARCHAR(100), in novoFormato VARCHAR(50), in novoTipo_tratamento VARCHAR(50), in novaVia_administracao VARCHAR(50), in novoPreco_atual FLOAT, IN newStock INT)
BEGIN
  update Produto
  set Nome = novoNome, Formato = novoFormato, Tipo_tratamento = novoTipo_tratamento, Via_administracao = novaVia_administracao, Preco_atual = novoPreco_atual, Stock = newStock where Id_produto = id;
  
END//
DELIMITER ;

call sp_update_produto('2','Symbicort', 'Xarope', 'Hidratante', 'Ocular', '17.7', '44');

select *
from Produto;

#Procedure Venda
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_update_venda//
CREATE PROCEDURE sp_update_venda(in id int, in novoId_empregado_venda int, in novoId_utente_venda int, in novoPreco_total FLOAT, in novaData_emissao VARCHAR(10), in novaAvaliacao VARCHAR(20))
BEGIN
  update Venda
  set Id_empregado_venda = novoId_empregado_venda, Id_utente_venda = novoId_utente_venda, Preco_total = novoPreco_total, Data_emissao = novaData_emissao, Avaliacao = novaAvaliacao where Id_venda = id;
  
END//
DELIMITER ; 

call sp_update_venda('2','14', '40', '35.44', str_to_date('20.6.2015', '%d.%m.%Y'), 'Excelente');

select *
from Venda;

#Procedure Item_venda
DELIMITER //    
DROP PROCEDURE IF EXISTS sp_update_item_venda//
CREATE PROCEDURE sp_update_item_venda(in novoId_venda_item_venda int, in novoN_linha int, in novoId_produto_item_venda int, in novaQuantidade int, in novoPreco_vendido FLOAT)
BEGIN
  update Item_venda
  set Id_venda_item_venda = novoId_venda_item_venda, N_linha = novoN_linha, Id_produto_item_venda = novoId_produto_item_venda, Quantidade = novaQuantidade, Preco_vendido = novoPreco_vendido where Id_venda_item_venda = novoId_venda_item_venda and N_linha = novoN_linha;
  
END//
DELIMITER ; 

call sp_update_item_venda('14', '1', '7', '2', '14.99');

select *
from Item_venda;

