/*
	Criar uma stored procedure "ver_extrato" para fornecer uma visão detalhada do 
	extrato bancário de um cliente, incluindo seu saldo atual e as informações das 
	últimas 10 transações realizadas. Esta operação recebe como entrada o ID do cliente 
	e retorna uma mensagem com o saldo atual do cliente e uma lista das últimas 10 transações, 
	contendo o ID da transação, o tipo de transação (depósito ou retirada), uma breve descrição, 
	o valor da transação e a data em que foi realizada.
*/

CREATE OR REPLACE PROCEDURE ver_extrato(
	IN p_client_id UUID
)

LANGUAGE plpgsql

AS $$
DECLARE
	saldo_atual INTEGER;
	data_atual TIMESTAMP;
	transacao RECORD;
	contador INTEGER :=0;

BEGIN
	SELECT saldo INTO saldo_atual
	FROM clients
	WHERE id = p_client_id;

	SELECT NOW() into data_atual;
	
	RAISE NOTICE 'Saldo atual do cliente em %: %', data_atual, saldo_atual;

	RAISE NOTICE 'Últimas transações do cliente: ';
	FOR transacao IN
		SELECT *
		FROM transactions
		WHERE cliente_id = p_client_id
		ORDER BY realizada_em DESC
		LIMIT 10
	LOOP
		contador := contador + 1;
		RAISE NOTICE 'ID: %, Tipo: %, Descrição: %, Valor: %, Data: %', transacao.id, transacao.tipo, transacao.descricao, transacao.valor, transacao.realizada_em;
        EXIT WHEN contador >= 10;
    END LOOP;
END;
$$;
