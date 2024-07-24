1
/*Consulta de Funcionários: Escreva uma query para listar todos os funcionários ativos, mostrando as colunas id, nome, salario. Ordene o resultado pelo nome em ordem ascendente.*/

SELECT 
id_vendedor, nome, salario
from vendedores
order by nome ASC

2
/*Consulta de Funcionários: Escreva uma query para listar todos os funcionários ativos, mostrando as colunas id, nome, salario. Ordene o resultado pelo nome em ordem ascendente.*/

SELECT 
id_vendedor, nome, salario
FROM VENDEDORES
WHERE salario > (SELECT AVG(salario) FROM VENDEDORES)
ORDER BY salario DESC;


/*Resumo por cliente: Escreva uma query para listar todos os clientes e o valor total de pedidos já transmitidos. A consulta deve retornar as colunas id, razao_social, total, ordenadas pelo total em ordem descendente.*/

SELECT c.id_cliente, c.razao_social, SUM(p.valor_total) AS total
FROM CLIENTES c
JOIN PEDIDO p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.razao_social
ORDER BY total DESC;

/*
Situação por pedido: Escreva uma query que retorne a situação atual de cada pedido da base. A consulta deve retornar as colunas id, valor, data e situacao. A situacao deve obedecer a seguinte regra:
Se possui data de cancelamento preenchido: CANCELADO
Se possui data de faturamento preenchido: FATURADO
Caso não possua data de cancelamento e nem faturamento: PENDENTE
*/

SELECT 
id_pedido AS id,
valor_total AS valor,
data_emissao AS data,
CASE
    WHEN data_cancelamento IS NOT NULL THEN 'CANCELADO'
    WHEN data_faturamento IS NOT NULL THEN 'FATURADO'
    ELSE 'PENDENTE'
    END AS situacao
FROM PEDIDO;
SELECT 
id_pedido AS id,
valor_total AS valor,
data_emissao AS data,
CASE
    WHEN data_cancelamento IS NOT NULL THEN 'CANCELADO'
    WHEN data_faturamento IS NOT NULL THEN 'FATURADO'
    ELSE 'PENDENTE'
    END AS situacao
FROM PEDIDO;

/*
Produtos mais vendidos: Escreva uma query que retorne o produto mais vendido ( em quantidade ), incluindo o valor total vendido deste produto, quantidade de pedidos em que ele apareceu e para quantos clientes diferentes ele foi vendido. A consulta deve retornar as colunas id_produto, quantidade_vendida, total_vendido, clientes, pedidos. Caso haja empate em quantidade de vendas, utilizar o total vendido como critério de desempate.
*/


SELECT 
    ip.id_produto,
    SUM(ip.quantidade) AS quantidade_vendida,
    SUM(ip.preco_praticado * ip.quantidade) AS total_vendido,
    COUNT(DISTINCT p.id_pedido) AS pedidos,
    COUNT(DISTINCT p.id_cliente) AS clientes
FROM ITENS_PEDIDO ip
JOIN PEDIDO p ON ip.id_pedido = p.id_pedido
GROUP BY ip.id_produto
ORDER BY quantidade_vendida DESC, total_vendido DESC
LIMIT 1;
