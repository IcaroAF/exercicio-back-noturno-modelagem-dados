CREATE DATABASE exercicio_modelagem_dados;

CREATE TABLE categorias(
	id serial NOT NULL PRIMARY KEY,
  	nome varchar(50)
);

CREATE TABLE produtos(
	id serial NOT NULL PRIMARY KEY,
  	nome varchar(100) NOT NULL,
  	descricao text NOT NULL,
  	preco int NOT NULL,
  	quantidade_em_estoque int NOT NULL,
  	categoria_id int REFERENCES categorias(id)
);

CREATE TABLE clientes(
	cpf char(11) NOT NULL UNIQUE,
  	nome varchar(150) NOT NULL
);

CREATE TABLE vendedores(
	cpf char(11) NOT NULL UNIQUE,
  	nome varchar(150) NOT NULL
);

CREATE TABLE pedidos(
	id serial NOT NULL PRIMARY KEY,
  	valor int NOT NULL,
  	cliente_cpf char(11) REFERENCES clientes(cpf),
  	vendedor_cpf char(11) REFERENCES vendedores(cpf)
);

CREATE TABLE itens_do_pedido(
	id serial NOT NULL PRIMARY KEY,
  	pedido_id int REFERENCES pedidos(id),
  	quantidade int NOT NULL,
  	produto_id int REFERENCES produtos(id)
);

--1
INSERT INTO categorias (nome)
VALUES('frutas'),
('verduras'),
('massas'),
('bebidas'),
('utilidades');

--2
INSERT INTO produtos (nome, descricao, preco, quantidade_em_estoque, categoria_id)
VALUES('Mamão', 'Rico em vitamina A, potássio e vitamina C', 300, 123, 1),
('Maça', 'Fonte de potássio e fibras.', 300, 34, 1),
('Cebola', 'Rico em quercetina, antocianinas, vitaminas do complexo B, C.', 50, 76, 2),
('Abacate', 'NÃO CONTÉM GLÚTEN.', 150, 64, 1),
('Tomate', 'Rico em vitaminas A, B e C.	', 125, 88, 2),
('Acelga', 'NÃO CONTÉM GLÚTEN.', 235, 13, 2),
('Macarrão parafuso', 'Sêmola de trigo enriquecida com ferro e ácido fólico, ovos e corantes naturais', 690, 5, 3),
('Massa para lasanha', 'Uma reunião de família precisa ter comida boa e muita alegria.', 875, 19, 3),
('Refrigerante coca cola lata', 'Sabor original', 350, 189, 4),
('Refrigerante Pepsi 2l', 'NÃO CONTÉM GLÚTEN. NÃO ALCOÓLICO.', 700, 12, 4),
('Cerveja Heineken 600ml', 'Heineken é uma cerveja lager Puro Malte, refrescante e de cor amarelo-dourado', 1200, 500, 4),
('Agua mineral sem gás', 'Smartwater é água adicionado de sais mineirais (cálcio, potássio e magnésio) livre de sódio e com pH neutro.', 130, 478, 4),
('Vassoura', 'Pigmento, matéria sintética e metal.', 2350, 30, 5),
('Saco para lixo', 'Reforçado para garantir mais segurança', 1340, 90, 5),
('Escova dental', 'Faça uma limpeza profunda com a tecnologia inovadora', 1000, 44, 5),
('Balde para lixo 50l', 'Possui tampa e fabricado com material reciclado', 2290, 55, 5),
('Manga', 'Rico em Vitamina A, potássio e vitamina C', 198, 176, 1),
('Uva', 'NÃO CONTÉM GLÚTEN.', 420, 90, 1);

--3
INSERT INTO clientes(cpf, nome)
VALUES('80371350042', 'José Augusto Silva'),
('67642869061', 'Antonio Oliveira'),
('63193310034', 'Ana Rodrigues'),
('75670505018', 'Maria da Conceição');

--4
INSERT INTO vendedores(cpf, nome)
VALUES('82539841031', 'Rodrigo Sampaio'),
('23262546003', 'Beatriz Souza Santos'),
('28007155023', 'Carlos Eduardo');

--5a
INSERT INTO pedidos(valor, cliente_cpf, vendedor_cpf)
VALUES(
	0, '80371350042', '28007155023' 
);

INSERT INTO itens_do_pedido(pedido_id, quantidade, produto_id) 
VALUES(1, 1, 1),
(1, 1, 10),
(1, 6, 11),
(1, 1, 15),
(1, 5, 2);

UPDATE pedidos
SET valor = 300+700+6*1200+1000+5*300 WHERE id = 1;

UPDATE produtos
SET quantidade_em_estoque =  produtos.quantidade_em_estoque - (itens_do_pedido.quantidade)
FROM itens_do_pedido WHERE produtos.id = itens_do_pedido.produto_id AND itens_do_pedido.pedido_id = 1;

--5b
INSERT INTO pedidos(valor, cliente_cpf, vendedor_cpf)
VALUES(
	0, '63193310034', '23262546003' 
);

INSERT INTO itens_do_pedido(pedido_id, quantidade, produto_id) 
VALUES(2, 10, 17),
(2, 3, 18),
(2, 5, 1),
(2, 10, 5),
(2, 2, 6);

UPDATE pedidos
SET valor = 10*198+3*420+5*300+10*125+2*235 WHERE id = 2;

UPDATE produtos
SET quantidade_em_estoque =  produtos.quantidade_em_estoque - (itens_do_pedido.quantidade)
FROM itens_do_pedido WHERE produtos.id = itens_do_pedido.produto_id AND itens_do_pedido.pedido_id = 2;
--5c
INSERT INTO pedidos(valor, cliente_cpf, vendedor_cpf)
VALUES(
	0, '75670505018', '23262546003' 
);

INSERT INTO itens_do_pedido(pedido_id, quantidade, produto_id) 
VALUES(3, 1, 13),
(3, 6, 12),
(3, 5, 17);

UPDATE pedidos
SET valor = 2350+6*130+5*198  WHERE id = 3;

UPDATE produtos
SET quantidade_em_estoque =  produtos.quantidade_em_estoque - (itens_do_pedido.quantidade)
FROM itens_do_pedido WHERE produtos.id = itens_do_pedido.produto_id AND itens_do_pedido.pedido_id = 3;
--5d
INSERT INTO pedidos(valor, cliente_cpf, vendedor_cpf)
VALUES(
	0, '75670505018', '82539841031' 
);

INSERT INTO itens_do_pedido(pedido_id, quantidade, produto_id) 
VALUES(4, 1, 16),
(4, 6, 18),
(4, 1, 7),
(4, 3, 1),
(4, 20, 5),
(4, 2, 6);

UPDATE pedidos
SET valor = 2290+6*420+690+3*300+20*125+2*235 WHERE id = 4;

UPDATE produtos
SET quantidade_em_estoque =  produtos.quantidade_em_estoque - (itens_do_pedido.quantidade)
FROM itens_do_pedido WHERE produtos.id = itens_do_pedido.produto_id AND itens_do_pedido.pedido_id = 4;
--5e
INSERT INTO pedidos(valor, cliente_cpf, vendedor_cpf)
VALUES(
	0, '67642869061', '82539841031' 
);

INSERT INTO itens_do_pedido(pedido_id, quantidade, produto_id) 
VALUES(5, 8, 18),
(5, 1, 8),
(5, 3, 17),
(5, 8, 5),
(5, 2, 11);

UPDATE pedidos
SET valor = 8*420+875+3*198+8*125+2*1200 WHERE id = 5;

UPDATE produtos
SET quantidade_em_estoque =  produtos.quantidade_em_estoque - (itens_do_pedido.quantidade)
FROM itens_do_pedido WHERE produtos.id = itens_do_pedido.produto_id AND itens_do_pedido.pedido_id = 5;

--6a
SELECT
produtos.nome AS nome_do_produto, categorias.nome AS nome_da_categoria
FROM produtos
LEFT JOIN categorias on produtos.categoria_id = categorias.id
ORDER BY produtos.id;

--6b
SELECT
pedidos.id, pedidos.valor, clientes.nome AS nome_do_cliente, vendedores.nome AS nome_do_vendedor
FROM pedidos
LEFT JOIN clientes on pedidos.cliente_cpf = clientes.cpf
LEFT JOIN vendedores on pedidos.vendedor_cpf = vendedores.cpf
ORDER BY pedidos.id;

--6c
SELECT categorias.nome, SUM(produtos.quantidade_em_estoque) AS quant_em_estoque
FROM categorias
LEFT JOIN produtos on categorias.id = produtos.categoria_id
GROUP BY categorias.nome
ORDER BY SUM(produtos.quantidade_em_estoque) DESC;

--6d
SELECT produtos.nome, SUM(itens_do_pedido.quantidade) AS produtos_vendidos
FROM produtos
LEFT JOIN itens_do_pedido ON produtos.id = itens_do_pedido.produto_id
GROUP BY produtos.nome
ORDER BY produtos_vendidos DESC;









