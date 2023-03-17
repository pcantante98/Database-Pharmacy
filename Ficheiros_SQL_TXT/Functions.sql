-- Número de vendas a um utente (parâmetro 1) por avaliação (parâmetro 2)
DELIMITER //
CREATE FUNCTION NumVendasAUtentePorAvaliacao(utId INT, aval VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE numVendas INT;
    
	SELECT COUNT(*) INTO numVendas
	FROM Venda
	WHERE Id_utente_venda = utId AND Avaliacao = aval;
    
	RETURN (numVendas);
END //
DELIMITER ;

-- Teste
SELECT NumVendasAUtentePorAvaliacao(21, 'Excelente') AS 'Número de vendas ao utente 21 com avaliação "Excelente"';



-- Contar vendas a utente
DELIMITER //
CREATE FUNCTION contarVendasAUtente(utId INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE numVendas INT;
    
    SELECT COUNT(*) INTO numVendas
    FROM Venda
    WHERE Id_utente_venda = utId;
    
    RETURN (numVendas);
END //
DELIMITER ;

-- Teste
SELECT contarVendasAUtente(21) AS 'Número de vendas ao utente de com id "21"';



-- Atribuir nível de frequência de vendas
DELIMITER //
CREATE FUNCTION nivelFrequenciaVendasUtente(p_qtdVendas INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE nivelFrequencia VARCHAR(20);
    
    IF p_qtdVendas = 1 THEN 
		SET nivelFrequencia = 'Utente novo';
    ELSEIF (p_qtdVendas > 1 AND p_qtdVendas < 5) THEN 
		SET nivelFrequencia = 'Utente ocasional';
    ELSEIF (p_qtdVendas >= 5) THEN 
		SET nivelFrequencia = 'Utente frequente';
    END IF;

    RETURN (nivelFrequencia);
END //
DELIMITER ;

-- Testando
SELECT Id_utente_venda AS 'ID de Utente', nivelFrequenciaVendasUtente(contarVendasAUtente(Id_utente_venda)) AS 'Nível de frequência de vendas ao utente'
FROM Venda
ORDER BY Id_utente_venda;



-- Contar total de pessoas
DELIMITER //
CREATE FUNCTION contarTotalPessoas()
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE totalPessoas INT;
    SELECT COUNT(*) FROM Pessoa INTO totalPessoas;
    
    RETURN (totalPessoas);
END //
DELIMITER ;

-- Testando
SELECT contarTotalPessoas() AS 'Total de pessoas';



-- Percentagem de pessoas de género dado como parâmetro
DELIMITER //
CREATE FUNCTION totalPessoasPorGenero(p_genero VARCHAR(1))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE totalPessoasGenero INT;
    
    SELECT COUNT(*) FROM Pessoa WHERE Genero = p_genero INTO totalPessoasGenero;
    
    RETURN totalPessoasGenero;
END //
DELIMITER ;

-- Testando
SELECT totalPessoasPorGenero('F') AS 'Total de pessoas do género feminino', totalPessoasPorGenero('M') AS 'Total de pessoas do género masculino';



-- Contar vendas a empregado
DELIMITER //
CREATE FUNCTION contarVendasAEmpregado(empId INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE numVendas INT;
    
    SELECT COUNT(*) INTO numVendas
    FROM Venda
    WHERE Id_empregado_venda = empId;
    
    RETURN (numVendas);
END //
DELIMITER ;

-- Teste
SELECT contarVendasAEmpregado(14) AS 'Número de vendas do empregado com id "14"';



-- Obter nível de objetivo de vendas
DELIMITER //
CREATE FUNCTION nivelObjetivoVendasEmpregado(p_qtdVendas INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	DECLARE nivelVendas VARCHAR(30);
    
    IF p_qtdVendas = 1 THEN 
		SET nivelVendas = 'Nivel baixo de vendas';
    ELSEIF (p_qtdVendas > 1 AND p_qtdVendas < 5) THEN 
		SET nivelVendas = 'Nivel médio de vendas';
    ELSEIF (p_qtdVendas >= 5) THEN 
		SET nivelVendas = 'Nivel alto de vendas';
    END IF;

    RETURN (nivelVendas);
END //
DELIMITER ;

-- Testando
SELECT Id_empregado_venda AS 'ID de Empregado', contarVendasAEmpregado(Id_empregado_venda) AS 'Total de vendas', nivelObjetivoVendasEmpregado(contarVendasAEmpregado(Id_empregado_venda)) AS 'Nível de objetivo de vendas do empregado'
FROM Venda
GROUP BY Id_empregado_venda;