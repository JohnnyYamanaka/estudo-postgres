CREATE OR REPLACE FUNCTION verifica_estoque()
RETURNS TRIGGER
AS
$$
DECLARE 
	qtde_saldo INTEGER;
BEGIN
	SELECT qtde_disponivel INTO qtde_saldo
	FROM produto
	WHERE cod_prod = NEW.cod_prod;
	IF qtde_saldo < NEW.qtde_vendida THEN
		RAISE EXCEPTION 'Quantidade indisponível no estoque';
	ELSE
		UPDATE produto
			SET qtde_disponivel = qtde_disponivel - NEW.qtde_vendida
		WHERE cod_prod = NEW.cod_prod;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tgr_verifica_saldo
BEFORE INSERT ON registrovendas
FOR EACH ROW
EXECUTE FUNCTION verifica_estoque();