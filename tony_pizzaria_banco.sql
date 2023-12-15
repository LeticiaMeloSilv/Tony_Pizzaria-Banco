/*Cadastro-Usuario:FK=cadastro
	(um usuario pode ter varias contas, sendo assim, o cadastro deve "direcionar" seu dono)
Usuario-Endereco:FK=usuarios
	(um endereco podem ter varios usuarios cadastrados, mas um usuario não pode ter varios enderecos(nesse caso))
Usuario-Compras:FK=compras
	(um usuario tambem pode realizar varias compras)
Compras-Produtos:FK=Ambos
	(podem haver varias compras de um mesmo produto, assim como podem haver varios produtos em uma compra só, ver com bruno como fica a relacao entre essas tabelas)
Produtos-Favoritas:FK=??
	(Eu não sei nem como funciona esse auto relacionamento, que dirá com quem deve ficar a FK(pelo que eu me lembro, não são usadas duas tabelas para isso)ver com bruno como funciona)
Produtos-Comentarios:FK=comentarios
	(podem ter varios comentarios de um unico produto, e mesmo que existam 2 comentarios iguais, é praticamente impossivel que sejam TOTALMENTE iguais)
Produtos-Categorias:FK=produtos
	(uma categoria pode ter varios produtos, o contrario não)
*/

create database Tony_pizzaria;
use Tony_pizzaria;

CREATE TABLE endereco (
    endereco_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    bairro TEXT,
    cidade TEXT,
    logradouro TEXT,
    numero_casa NUMERIC,
    complemanto VARCHAR(5),
    cep VARCHAR(10)
);
CREATE TABLE usuarios (
    usuario_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_usuario TEXT,
    url_foto_perfil VARCHAR(300),
    cpf VARCHAR(11),
    telefone VARCHAR(14),
	endereco_id INTEGER,
    FOREIGN KEY (endereco_id)
        REFERENCES endereco (endereco_id)
);
CREATE TABLE cadastro (
    cadastro_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_usuario_cadastro TEXT,
    telefone VARCHAR(14),
    email VARCHAR(100),
    senha VARCHAR(100),
    confirmacao_de_senha VARCHAR(100),
    data_cadastro DATE,
    usuario_id INTEGER,
    FOREIGN KEY (usuario_id)
        REFERENCES usuarios (usuario_id)
);

CREATE TABLE categorias (
    categoria_id INTEGER PRIMARY KEY,
    nome_categoria TEXT
);
create table produtos(
	produto_id integer primary key auto_increment,
	avaliacao_geral numeric,
	descricao varchar(500),
	preco numeric,
	url_foto_produto varchar(300),
	nome_produto text,
	categoria_id INTEGER,
    favorito_id integer,
    
    foreign key (favorito_id)
    references produtos(produto_id),
	
	FOREIGN KEY (categoria_id)
        REFERENCES categorias(categoria_id)
);
create table comentarios(
	comentario_id integer primary key AUTO_INCREMENT,
	avaliacao numeric,
	descricao_titulo varchar(100),
	descricao_conteudo varchar(500),
	data_publicacao date,
	url_foto_usuario varchar(300),
	nome_usuario text,
	produto_id integer,

	FOREIGN KEY (produto_id)
        REFERENCES produtos (produto_id)
);

create table compras(
	compra_id integer primary key AUTO_INCREMENT,
	data_hora_compra datetime,
	data_hora_entrega datetime,
	produto_id INTEGER,
	usuario_id integer,
    
	FOREIGN KEY (usuario_id)
        REFERENCES usuarios (usuario_id),
	FOREIGN KEY (produto_id)
        REFERENCES produtos (produto_id)
);

INSERT INTO cadastro(cadastro_id, nome_usuario_cadastro,telefone,email,senha,confirmacao_de_senha,data_cadastro,usuario_id) VALUES
(1,'Letícia','+5511967755089','leticia@gmail.com','H3l10.W0rd','H3l10.W0rd','2023-12-13',1),
(2,'Bruno','+5511949663184','bruno@gmail.com','SQLover','SQLover','2023-12-13',2),
(3,'Leonid','+5511974584380','fernando@gmail.com', 'CSSUser', 'CSSUser','2023-12-13',3),
(4,'Marcel','+5511965820479', 'marcel@gmail.com','EndBack', 'EndBack','2023-12-13',4),
(5,'Vitória','+5511963820467','vitoriaa@gmail.com','D1n0s4ur','D1n0saur','2023-12-13',5),
(6,'Ana Luiza', '+5511962045820','analu@gmail.com','Pre11y','Pretty','2023-12-13',6),
(7,'Vitória','+5511983601673','vitoriac@gmail.com','idk908','idk908','2023-12-13',7);

INSERT INTO usuarios(nome_usuario,url_foto_perfil,cpf,telefone,endereco_id) VALUES
('Letícia','https://exemplo.com/leticia.jpg','12345678910','+5511967755089',1),
('Bruno','https://exemplo.com/bruno.jpg','49729052789','+5511949663184',3),
('Leonid','https://exemplo.com/fernando.jpg','62946920789','+5511974584380',2),
('Marcel',null,'258215408294','+5511965820479',4),
('Vitória','https://exemplo.com/vitoriaa.jpg','19040264982','+5511963820467',1),
('Ana Luiza', 'https://exemplo.com/analu.jpg','73064920673','+5511962045820',1),
('Vitória','https://exemplo.com/vitoriac.jpg','62097820216','+5511983601673',5);

INSERT INTO endereco (bairro, cidade, logradouro, numero_casa, complemanto, cep)
VALUES
    ('Centro', 'Sao Paulo', 'Rua D', 456, 'Apto 4', '04567-890'),
    ('Ipanema', 'Rio de Janeiro', 'Rua E', 789, 'Casa 5', '22345-678'),
    ('Pinheiros', 'Sao Paulo', 'Rua G', 567, 'Apto 7', '05432-109'),
    ('Lourdes', 'Belo Horizonte', 'Avenida I', 234, 'Apto 9', '33456-789'),
    ('Vila Mariana', 'Sao Paulo', 'Rua J', 678, 'Casa 10', '05432-109');

INSERT INTO compras (data_hora_compra, data_hora_entrega, produto_id,usuario_id)
VALUES
    ('2023-01-25 10:20:00', '2023-01-25 10:30:45', 1,1),
    ('2023-01-27 02:00:00', '2023-01-27 02:15:30', 3,5),
    ('2023-07-18 03:58:30','2023-07-18 04:19:40',3,1),
    ('2023-02-02 08:07:07', '2023-02-02 08:45:20', 2,2);

INSERT INTO produtos (avaliacao_geral, descricao, preco, url_foto_produto, nome_produto,categoria_id)
VALUES
    (4.7, 'Pizza de Chocolate com cobertura de morango.', 35.00, 'https://exemplo.com/pizza_chocolate.jpg', 'Pizza de Chocolate',3),
    (4.2, 'Sorvete de creme com calda de chocolate e amendoim.', 15.00, 'https://exemplo.com/sorvete_chocolate.jpg', 'Sorvete de Chocolate',1),
    (4.5, 'Brownie de chocolate com sorvete de baunilha e calda de caramelo.', 25.00, 'https://exemplo.com/brownie_sorvete.jpg', 'Brownie com Sorvete',1);

INSERT INTO categorias (categoria_id,nome_categoria)
VALUES
    (1,'Sobremesas'),
    (2,'Bebidas'),
    (3,'Pizzas');

INSERT INTO comentarios (avaliacao, descricao_titulo, descricao_conteudo, data_publicacao, url_foto_usuario, nome_usuario, produto_id)
VALUES
    (4.8, 'Divino!', 'A pizza de Chocolate é um verdadeiro deleite. Recomendo!', '2023-01-28', 'https://exemplo.com/foto_leticia.jpg', 'Letícia', 1),
    (4.1, 'Gostoso demais!', 'O sorvete de Chocolate é cremoso e saboroso. Adorei!', '2023-01-30', 'https://exemplo.com/foto_bruno.jpg', 'Bruno', 2),
    (4.6, 'Irresistível!', 'O brownie com sorvete é uma explosão de sabores. Sensacional!', '2023-02-05', 'https://exemplo.com/foto_vitoria.jpg', 'Vitória', 3),
    (4.4, 'Perfeito para os chocólatras!', 'O brownie com sorvete é um verdadeiro sonho para os amantes de chocolate. Recomendo muito!', '2023-02-10', 'https://exemplo.com/foto_leticia.jpg', 'Letícia', 3);




/*//selects
	-pegar os usuarios cadastrados com o mesmo nome que podem entrar em conflito
	-pegar os usuarios que não estão cadastrados
	-pegar usuarios que nao compraram nada
	-pegar usuarios cadastrados antes do dia 13
	-pegar todos os produtos
    */