-- 6. Cria um relatório que mostra o total de pedidos por cliente desde 31 de dezembro de 1996.
-- O relatório deve retornar apenas linhas para as quais o total de pedidos é maior que 15 (5 linhas)

SELECT 
 o.customer_id,
 COUNT(o.order_id) AS quantidade_pedidos
FROM orders o
WHERE order_date > '1996-12-31'
GROUP BY o.customer_id
HAVING COUNT(o.order_id) > 15
ORDER BY o.customer_id;

