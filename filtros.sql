-- Criação das tabelas
CREATE TABLE produtos (
id INT PRIMARY KEY,
nome VARCHAR(50),
categoria VARCHAR(30),
preco DECIMAL(10, 2),
em_estoque BOOLEAN
);

CREATE TABLE vendas (
id INT PRIMARY KEY,
produto_id INT,
quantidade INT,
data_venda DATE,
FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Inserindo dados
INSERT INTO produtos
VALUES (1, 'Notebook', 'Informática', 3500.00, TRUE),
(2, 'Mouse', 'Informática', 45.00, TRUE),
(3, 'Cadeira', 'Móveis', 850.00, FALSE),
(4, 'Teclado', 'Informática', 120.00, TRUE);

INSERT INTO vendas
VALUES (101, 1, 2, '2023-10-01'),
(102, 2, 15, '2023-10-02'),
(103, 3, 1, '2023-10-02');

-- Consulta simples
SELECT *
FROM produtos;

-- Cláusula WHERE
SELECT nome, preco
FROM produtos
WHERE preco < 50;

-- Filtrando por texto
SELECT nome FROM produtos
WHERE categoria = 'Informática';

-- Filtrando por booleanos
SELECT nome FROM produtos
WHERE em_estoque = TRUE;

-- Filtrando por números
SELECT nome, preco
FROM produtos
WHERE preco < 50.00;

-- Combinando regras com AND
SELECT nome, preco
FROM produtos
WHERE preco < 50.00 AND em_estoque = TRUE;

-- Ampliando buscas com OR
SELECT nome, categoria
FROM produtos
WHERE categoria = 'Informática' OR
categoria = 'Móveis';

-- Consulta com JOIN
SELECT p.nome, v.quantidade
FROM vendas v
INNER JOIN produtos p ON v.produto_id = p.id
WHERE v.quantidade > 5;

-- Filtros avançados em múltiplas tabelas
SELECT p.nome, v.data_venda, p.preco
FROM vendas v
INNER JOIN produtos p ON v.produto_id = p.id
WHERE p.categoria = 'Informática' AND p.preco > 1000.00;
