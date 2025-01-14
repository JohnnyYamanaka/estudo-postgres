-- Faça uma análise de crescimento mensal e o cálculo de YTD

WITH ReceitasMensais AS (
	SELECT 
		EXTRACT(YEAR FROM o.order_date) AS Ano,
		EXTRACT(MONTH FROM o.order_date) AS Mes,
		SUM((os.unit_price) * os.quantity * (1 - os.discount)) AS Receita_Mensal

	FROM 
		orders o

	INNER JOIN
		order_details os ON o.order_id = os.order_id

	GROUP BY 
		EXTRACT(YEAR FROM o.order_date), 
		EXTRACT(MONTH FROM o.order_date)

),

ReceitasAcumuladas AS (
	SELECT
		Ano,
		Mes,
		Receita_Mensal,
		SUM(Receita_Mensal) OVER (PARTITION BY ANO ORDER BY Mes) AS Receita_YTD

	FROM
		ReceitasMensais
)

SELECT
	Ano,
	Mes,
	Receita_Mensal,
	Receita_Mensal - LAG(Receita_Mensal) OVER (PARTITION BY Ano ORDER BY Mes) AS Diferenca_Mensal,
	(Receita_Mensal - LAG(Receita_Mensal) OVER (PARTITION BY Ano ORDER BY Mes)) / LAG(Receita_Mensal) OVER (PARTITION BY Ano ORDER BY Mes) * 100 AS Percentual_Mudanca_Mensal

FROM
	ReceitasAcumuladas

ORDER BY 
	Ano, Mes;
