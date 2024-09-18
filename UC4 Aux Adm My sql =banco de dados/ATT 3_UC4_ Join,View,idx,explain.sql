
use `uc4atividades`
/***
consulta para um relatório de todas as vendas pagas em dinheiro. 
Necessários para o relatório data da venda, valor total; produtos vendidos, quantidade e valor unitário; nome do cliente, cpf e telefone.
Ordena-se pela data de venda, as mais recentes primeiro.
**/
 EXPLAIN SELECT * FROM venda v, item_venda iv, produto p, cliente c, funcionario f
WHERE v.id = iv.venda_id AND c.id = v.cliente_id AND p.id = iv.produto_id AND f.id = v.funcionario_id and tipo_pagamento = 'D'


-- AQ fiz o Inner join, assim dando o resultado correto . Ulitzando 3 tabelas. + os indx para melhorar o desempenho.Asssim fiz todos os selects 
-- com inner join , e criei as views .

SELECT 
	v.tipo_pagamento,
	v.data,
    v.valor_total,
    c.nome,
	c.cpf,
    c.telefone,
	it.valor_unitario,
	it.quantidade
FROM
venda AS V 
INNER JOIN cliente AS C
  ON c.id = v.cliente_id
  
  INNER JOIN item_venda AS it
	ON it.venda_id = v.id

-------
CREATE INDEX idx_tipo_pag ON venda(tipo_pagamento);
CREATE INDEX idx_id_venda ON venda(id);
---------------------------------------------


CREATE VIEW relatorio_todas_vendas AS
SELECT 
	v.tipo_pagamento,
	v.data,
    v.valor_total,
    c.nome,
	c.cpf,
    c.telefone,
	it.valor_unitario,
	it.quantidade
FROM
venda AS V 
INNER JOIN cliente AS C
  ON c.id = v.cliente_id
  
  INNER JOIN item_venda AS it
	ON it.venda_id = v.id







EXPLAIN SELECT * FROM venda WHERE tipo_pagamento = 'D'
EXPLAIN SELECT * FROM venda WHERE id = 53 ;

/***
consulta para encontrar todas as vendas de produtos de um dado fabricante
Mostrar dados do produto, quantidade vendida, data da venda.
Ordena-se pelo nome do produto.
***/
EXPLAIN SELECT * 
FROM produto p, item_venda iv, venda v
WHERE p.id = iv.produto_id AND v.id = iv.venda_id AND p.fabricante like '%lar%'


SELECT 
v.data,
v.status,
v.valor_total,
it.quantidade,
it.nome_produto

FROM 
    item_venda AS it

INNER JOIN 
	venda AS v
		ON it.venda_id = v.id
        
        -----------------------

CREATE INDEX idx_fabricante ON produto(fabricante);

--------------------------------------------------

CREATE VIEW todas_vendas AS
SELECT 
v.data,
v.status,
v.valor_total,
it.quantidade,
it.nome_produto

FROM 
    item_venda AS it

INNER JOIN 
	venda AS v
		ON it.venda_id = v.id
















EXPLAIN SELECT * FROM produto WHERE fabricante = 'Mundiale';
 
/***
Relatório de vendas de produto por cliente.
Mostrar dados do cliente, dados do produto e valor e quantidade totais de venda ao cliente de cada produto.
*/
EXPLAIN SELECT SUM(iv.subtotal), SUM(iv.quantidade)
FROM produto p, item_venda iv, venda v, cliente c
WHERE p.id = iv.produto_id AND v.id = iv.venda_id AND c.id = v.cliente_id /*f.id = v.funcionario_id*/
GROUP BY c.nome, p.nome


SELECT 
	c.nome,
    c.cpf,
    c.endereco,
    c.telefone,
    v.status,
    v.tipo_pagamento,
	v.data,
    it.valor_unitario,
    it.subtotal,
    it.nome_produto,
	it.quantidade
FROM 
	venda AS v
INNER JOIN 
	cliente AS c ON v.cliente_id = c.id

INNER JOIN 
	item_venda AS it ON it.venda_id = v.id;

---------------------------------------------------
CREATE INDEX idx_subtotal ON item_venda(subtotal);
CREATE INDEX idx_quantidade ON item_venda(quantidade);
CREATE INDEX idx_nome_cliente ON cliente(nome);
CREATE INDEX idx_venda_id ON item_venda(venda_id);
CREATE INDEX idx_produto_id ON item_venda(produto_id);
CREATE INDEX idx_cliente_id ON venda(cliente_id);
CREATE INDEX idx_produto_id ON produto(id);
CREATE INDEX idx_venda_id ON venda(id);
CREATE INDEX idx_cliente_id ON cliente(id);

------------
CREATE VIEW relatorio_vendas AS 
SELECT 
	c.nome,
    c.cpf,
    c.endereco,
    c.telefone,
    v.status,
    v.tipo_pagamento,
	v.data,
    it.valor_unitario,
    it.subtotal,
    it.nome_produto,
	it.quantidade
FROM 
	venda AS v
INNER JOIN 
	cliente AS c ON v.cliente_id = c.id

INNER JOIN 
	item_venda AS it ON it.venda_id = v.id;



