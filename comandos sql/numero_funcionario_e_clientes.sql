-- 2. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem funcionários (5 linhas)

SELECT 
	e.city,
	COUNT(DISTINCT e.employee_id) AS qtd_funcionarios,
	COUNT(DISTINCT c.customer_id) AS qtd_clientes
FROM employees e
LEFT JOIN customers c
	ON e.city = c.city
GROUP BY e.city;