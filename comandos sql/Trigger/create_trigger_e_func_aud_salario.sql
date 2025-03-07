-- Primeiro criamos a função que a qual será acionada quando o trigger for ativado. 
-- Neste Caso, ele recebe os dados que foram modificados na coluna salario da tabela funcionario
-- e popula a tabela auditoria, com os valores antigos e novos.
CREATE OR REPLACE FUNCTION registrar_auditoria_salario()
RETURNS TRIGGER
AS $$
BEGIN
	INSERT INTO funcionario_auditoria(id, salario_antigo, novo_salario)
	VALUES (OLD.id, OLD.salario, NEW.salario);

	RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_salario_modificado
AFTER UPDATE OF salario ON funcionario
FOR EACH ROW 
EXECUTE FUNCTION
registrar_auditoria_salario();

