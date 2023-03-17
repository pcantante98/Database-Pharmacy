INSERT INTO Pessoa (Num_cc, Nome, Data_nascimento, Telemovel, Email, Genero) VALUES ('12345678', 'Nome Teste', str_to_date('3.5.1955', '%d.%m.%Y'), '912345678', 'pedro.cantante@gmail.com', 'Z');
-- Error Code: 3819. Check constraint 'pessoa_chk_1' is violated.

INSERT INTO Prescricao_eletronica (Id_utente_prescricao_eletronica, Id_produto, Data_validade, Data_emissao, Observacoes) VALUES ('1', '1', str_to_date('8.5.2000', '%d.%m.%Y'), str_to_date('21.8.2030', '%d.%m.%Y'), 'Tomar com cuidado!');
-- Error Code: 3819. Check constraint 'prescricao_eletronica_chk_1' is violated.

INSERT INTO Venda (Id_prescricao_eletronica_venda, Id_empregado_venda, Id_utente_venda, Preco_total, Data_emissao, Avaliacao) VALUES ('1', '4', '1', '101.7', str_to_date('2.4.2016', '%d.%m.%Y'), 'Médio');
-- Error Code: 3819. Check constraint 'venda_chk_1' is violated.

INSERT INTO Venda (Id_prescricao_eletronica_venda, Id_empregado_venda, Id_utente_venda, Preco_total, Data_emissao, Avaliacao) VALUES ('1', '4', '1', '0', str_to_date('2.4.2016', '%d.%m.%Y'), 'Bom');
-- Error Code: 3819. Check constraint 'venda_chk_2' is violated.

INSERT INTO Item_venda (Id_venda_item_venda, N_linha, Id_produto_item_venda, Quantidade, Preco_vendido) VALUES ('1', '1', '1', '0', '10.17');
-- Error Code: 3819. Check constraint 'item_venda_chk_1' is violated.

INSERT INTO Item_venda (Id_venda_item_venda, N_linha, Id_produto_item_venda, Quantidade, Preco_vendido) VALUES ('1', '1', '1', '10', '0');
-- Error Code: 3819. Check constraint 'item_venda_chk_2' is violated.

INSERT INTO Produto (Nome, Formato, Tipo_tratamento, Via_administracao, Preco_atual, Stock) VALUES ('Brufen', 'Pomada', 'Antidepressivo', 'Nasal', '17.06', '-10');
-- Error Code: 3819. Check constraint 'produto_chk_1' is violated.

INSERT INTO Produto (Nome, Formato, Tipo_tratamento, Via_administracao, Preco_atual, Stock) VALUES ('Brufen', 'Pomada', 'Antidepressivo', 'Nasal', '-10', '10');
-- Error Code: 3819. Check constraint 'produto_chk_2' is violated.