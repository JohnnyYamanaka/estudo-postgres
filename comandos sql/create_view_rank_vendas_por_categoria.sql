-- Criação de view para tabela com total de vendas por categoria.

CREATE OR REPLACE VIEW RankVendasPorCategoria AS
(
	WITH info_produto AS (
		SELECT 
			p.product_id,
			p.product_name,
			c.category_name
		
		FROM products p
		JOIN categories c
			ON c.category_id = p.category_id
	),
	
	tb_produto_preco AS (
		SELECT
			o.order_id,
			i.product_id,
			i.product_name,
			i.category_name,
			o.unit_price,
			o.quantity,
			ROUND(CAST((o.unit_price * o.quantity) AS DECIMAL), 2) AS total_value
		FROM info_produto i
		JOIN order_details o
			ON o.product_id = i.product_id
	),
	
	tb_vendas AS (
		SELECT
			-- p.product_id,
			-- p.product_name,
			p.category_name,
			SUM(p.total_value) AS category_total_sell,
			-- s.order_date,
			EXTRACT(YEAR FROM s.order_date) AS ano,
			EXTRACT(MONTH FROM s.order_date) AS mes
			
		FROM tb_produto_preco p
		RIGHT JOIN orders s
			ON p.order_id = s.order_id 
	
		GROUP BY category_name, ano, mes	
		ORDER BY ano, mes
	)
	
	SELECT
		t.category_name,
		t.category_total_sell,
		CONCAT(CAST(t.mes AS TEXT), '-', CAST(t.ano AS TEXT)) AS mes_ano,
		t.ano,
		t.mes,
		RANK() OVER (ORDER BY t.category_total_sell DESC) AS rank_periodo
		
	FROM tb_vendas t
	ORDER BY ano, mes
)
