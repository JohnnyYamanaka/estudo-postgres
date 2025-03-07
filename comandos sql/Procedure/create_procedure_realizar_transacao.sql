--Procedure são como funções no python, onde é encapsulada uma série de tarefas
CREATE OR REPLACE PROCEDURE realizar_transacao(
	--Em nome da legibilidade, adicionado um p_ de "procedure" na declaração dos parâmetros que serão utilizados
	IN p_tipo CHAR(1), 
	IN p_descricao VARCHAR(10),
	IN p_valor INTEGER,
	IN p_cliente_id UUID
)
--Declaração da linguem utilizada
LANGUAGE plpgsql

--Inicio da Procedure
AS $$
DECLARE
	--declaração das variáveis que serão utilizadas procedure
	saldo_atual INTEGER;
	limite_cliente INTEGER;
	saldo_apos_transacao INTEGER;
	
BEGIN
	--Salvando o resultado da consulta nas variáveis
	SELECT saldo, limite INTO saldo_atual, limite_cliente
	FROM clients
	WHERE id = p_cliente_id;
	
	--Função para imprimir o resultado da consulta
	RAISE NOTICE 'Saldo atual do cliente: %', saldo_atual;
	RAISE NOTICE 'Limite atual do cliente: %', limite_cliente;

	--Verificar se a transação está de acordo com a regra de negócio (se a transação for débito "d" verifica se o saldo final vai ser maior que o limite)
	IF p_tipo = 'd' AND saldo_atual - p_valor < limite_cliente THEN
		RAISE EXCEPTION 'Limite inferior ao necessário da transação';
	END IF;

	UPDATE clients
	SET saldo = saldo + CASE WHEN p_tipo = 'd' THEN -p_valor ELSE p_valor END
	WHERE id = p_cliente_id;

	--Realizar a transação
	INSERT INTO transactions (tipo, descricao, valor, cliente_id)
	VALUES (p_tipo, p_descricao, p_valor, p_cliente);

    
	SELECT saldo INTO saldo_apos_transacao
	FROM clients
	WHERE id = p_cliente_id;
	RAISE NOTICE 'Saldo após a operação: %', saldo_apos_transacao;
	
END;
$$