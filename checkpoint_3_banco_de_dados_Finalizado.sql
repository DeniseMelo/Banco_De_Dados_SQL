DROP DATABASE IF EXISTS Calcados;
CREATE DATABASE Calcados;
USE Calcados;

DROP TABLE IF EXISTS Detalhes_Faturas;
DROP TABLE IF EXISTS Produtos;
DROP TABLE IF EXISTS Categoria_Calcados;
DROP TABLE IF EXISTS Fornecedores;
DROP TABLE IF EXISTS Faturas;
DROP TABLE IF EXISTS Transportadoras;
DROP TABLE IF EXISTS Funcionarios;
DROP TABLE IF EXISTS Endereco;
DROP TABLE IF EXISTS Usuarios;


CREATE TABLE IF NOT EXISTS Usuarios
(
    id INT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    telefone1 VARCHAR(24) NOT NULL,
    telefone2 VARCHAR(24),
    email VARCHAR(45) NOT NULL UNIQUE,
    senha VARCHAR(45) NOT NULL,
    cpf VARCHAR(45) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    CONSTRAINT PK_Usuarios_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Enderecos
(
    id INT UNSIGNED AUTO_INCREMENT, 
    logradouro VARCHAR(45) NOT NULL,
    numero SMALLINT NOT NULL,
    complemento VARCHAR(45) NULL,
    cidade VARCHAR(45) NOT NULL,
    cep VARCHAR (10),
    uf CHAR(2) NOT NULL,
    idUsuarios INT UNSIGNED,
    CONSTRAINT PK_Enderecos_id PRIMARY KEY (id),
	CONSTRAINT FK_Enderecos_Usuarios_idUsuarios FOREIGN KEY (idUsuarios) REFERENCES Usuarios (id)
);

CREATE TABLE IF NOT EXISTS Funcionarios
(
    id INT UNSIGNED AUTO_INCREMENT,
    idDepartamento INT UNSIGNED,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    telefone VARCHAR(24) NOT NULL,
    cpf VARCHAR(12) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    data_contratacao DATE,
    foto LONGBLOB,
    url_foto VARCHAR(255),
    CONSTRAINT PK_Funcionarios_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Gestores
(
    id INT UNSIGNED AUTO_INCREMENT,
    nome_gestor VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    telefone VARCHAR(24) NOT NULL,
    cpf VARCHAR(12) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    data_contratacao DATE,
    foto LONGBLOB,
    url_foto VARCHAR(255),
    CONSTRAINT PK_Gestor_id PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS Departamento
(
    id INT UNSIGNED AUTO_INCREMENT,
    nome_departamento VARCHAR(45) NOT NULL,
    idGestor INT UNSIGNED,
    CONSTRAINT PK_Departamento_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Transportadoras
(
id INT UNSIGNED AUTO_INCREMENT,
empresa VARCHAR(45) NOT NULL,
telefone VARCHAR(24) NOT NULL,
CONSTRAINT PK_Transportadoras_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Fornecedores
(
    id INT UNSIGNED AUTO_INCREMENT,
    empresa VARCHAR(45) NOT NULL,
    endereco VARCHAR(45) NOT NULL,
	cidade VARCHAR(45) NOT NULL,
    cep VARCHAR(10),
	uf CHAR(2),
    pais VARCHAR(15),
    telefone VARCHAR(25) NOT NULL,
	CONSTRAINT PK_Fornecedores_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Categoria_Calcados
(
id INT UNSIGNED AUTO_INCREMENT,
nome_cat VARCHAR(45) NOT NULL,
descricao TEXT,
imagem LONGBLOB,
CONSTRAINT PK_Categoria_Calcados_id PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Produtos
(
id INT UNSIGNED AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
quantidade_por_unidade INT NOT NULL,
preco_unitario DOUBLE,
unidades_estoque SMALLINT NOT NULL,
unidades_solicitadas SMALLINT,
idCategoria_Calcados INT UNSIGNED,
idFornecedores INT UNSIGNED,
CONSTRAINT PK_PRODUTOS_id PRIMARY KEY (id),
CONSTRAINT FK_Produtos_Categoria_Calcados_idCategoria_Calcados FOREIGN KEY (IdCategoria_Calcados) REFERENCES Categoria_Calcados (id),
CONSTRAINT FK_Produtos_Fornecedores_idFornecedores FOREIGN KEY (idFornecedores) REFERENCES Fornecedores (id)
);

CREATE TABLE IF NOT EXISTS Faturas
(
    id INT UNSIGNED AUTO_INCREMENT,
    data_fatura DATETIME NOT NULL,
    data_envio DATETIME,
    endereco_envio VARCHAR(45),
	cidade_envio VARCHAR(45),
    cep_envio VARCHAR(10),
	uf_envio CHAR(2),
    pais_envio VARCHAR(15),
    idTransportadoras INT UNSIGNED,
    idFuncionarios INT UNSIGNED,
    idUsuarios INT UNSIGNED,
	CONSTRAINT PK_Faturas_id PRIMARY KEY (id),
    CONSTRAINT FK_Faturas_Transportadoras_idTransportadoras FOREIGN KEY (IdTransportadoras) REFERENCES Transportadoras (id),
	CONSTRAINT FK_Faturas_Funcionarios_idFuncionarios FOREIGN KEY (idFuncionarios) REFERENCES Funcionarios (id),
    CONSTRAINT FK_Faturas_Usuarios_idUsuarios FOREIGN KEY (idUsuarios) REFERENCES Usuarios (id)
);

CREATE TABLE IF NOT EXISTS Detalhes_Faturas
(
preco_unitario FLOAT,
quantidade SMALLINT,
desconto FLOAT,
faturas_id INT, 
produtos_id INT,
CONSTRAINT PK_Detalhes_Faturas_id PRIMARY KEY (faturas_id, produtos_id)
);

ALTER TABLE Departamento ADD CONSTRAINT FK_Departamento_Gestores_ FOREIGN KEY (idGestor) REFERENCES Gestores (id);
ALTER TABLE Funcionarios ADD CONSTRAINT FK_Funcionarios_Departamento_idDepartamento FOREIGN KEY (idDepartamento) REFERENCES Departamento(id);

INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (1, 'Havaianas', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (2, 'Tamanco', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (3, 'Chuteira', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (4, 'Tenis', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (5, 'Meia', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (6, 'Sapatiha', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (7, 'Salto Alto', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (8, 'Salto BAixo', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (9, 'Sem Salto', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);
INSERT INTO Categoria_Calcados (Id, nome_cat, descricao, imagem) VALUES (10, 'Sandalia', 'Lorem Ipsum Lorem Ipsum Lorem Ipsum', NULL);


INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (1, 'Calcadista', 'Rua Oliveira, 435/514', 'Santa Cruz', '90630526', 'RS', 'Brasil', '5551996644367');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (2, 'Sapateira', 'Rua Pinheiro, 435/514', 'Cruz Alta', '92630526', 'RS', 'Brasil', '5551996644368');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (3, 'Caruanda', 'Rua Caruanda, 435/514', 'Santa Antonio da Patrulha', '93630526', 'RS', 'Brasil', '5551996644369');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (4, 'Camelia', 'Rua Camelia, 435/514', 'Santa Rosa', '94630526', 'RS', 'Brasil', '5551996644366');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (5, 'Calcados LTDA', 'Rua Calcados, 435/514', 'Santa Catarina', '95630526', 'RS', 'Brasil', '5551996644365');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (6, 'Sapatilhas LTDA', 'Rua Sapatilhas, 435/514', 'Santa Monica', '96630526', 'RS', 'Brasil', '5551996644364');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (7, 'Tenis LTDA', 'Rua Tenis, 435/514', 'Santa Rita', '97630526', 'RS', 'Brasil', '5551996644363');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (8, 'Havaianas LTDA', 'Rua Havaianas, 435/514', 'Santa Ana', '99630526', 'RS', 'Brasil', '5551996644362');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (9, 'Ilha Bela', 'Rua Ilha Bela, 435/514', 'Santa Paz', '94630526', 'RS', 'Brasil', '5551996644361');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (10, 'Sapatos lindos', 'Rua Sapatos, 435/514', 'Santa Vida', '98630526', 'RS', 'Brasil', '5551996644370');
INSERT INTO Fornecedores (id, empresa, endereco, cidade, cep, uf, pais, telefone)
VALUES (11, 'Sapatos Delicados', 'Rua Delicados, 435/514', 'Santa Casa', '98630526', 'RS', 'Brasil', '5551996644311');


INSERT INTO Produtos ( nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ( 'Fluffy', '10', 19.99, 59, 27, 1,1);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Mavis', '5', 69.99, 19, 47, 2,2);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Fofao', '20', 100.99, 30, 0, 3,3);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Muquinho', '10', 39.99, 29, 15, 1,4);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Mushu', '10', 200.99, 50, 8, 1,1);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Chuchu', '10', 259.99, 40, 37, 1,1);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Gordo', '10', 399.99, 30, 30, 1,1);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Blue', '10', 25.99, 100, 10, 1,1);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Jesse', '10', 49.99, 150, 120, 1,1);
INSERT INTO Produtos (nome, quantidade_por_unidade, preco_unitario, unidades_estoque, unidades_solicitadas, idCategoria_Calcados, idFornecedores) 
VALUES ('Romeu', '10', 36.99, 90, 88, 1,1);

INSERT INTO Transportadoras (empresa,telefone) VALUES('Aba','5551996644370');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Voa','5551996644341');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Transporte','5551996644330');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Transul','5551996644320');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Transportation','5551996644310');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Azul Transportes','5551996644311');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Fast Transporte','5551996644331');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Transportando','5551996644351');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Super Fast','5551996644310');
INSERT INTO Transportadoras (empresa,telefone) VALUES('Indo Rapido','5551996644333');


INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Carolina', '5551996644351', '02002012002', '2000-02-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Paula', '5551996644352', '02002012003', '2001-03-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Catarina', '5551996644353', '02002012004', '2002-04-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Julia', '5551996644354', '02002012005', '2003-05-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Beatriz', '5551996644355', '02002012006', '2004-06-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Guilhermina', '5551996644356', '02002012007', '2001-07-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Carla', '5551996644357', '02002012008', '2002-08-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Cabreira', '5551996644358', '02002012009', '2003-09-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'Nordica', '5551996644359', '02002012000', '2004-11-01','2022-10-01');
INSERT INTO Funcionarios (nome, sobrenome, telefone, cpf, data_nascimento, data_contratacao) 
VALUES ('Ana', 'perfeita', '5551996644350', '02002012001', '2001-12-01','2022-10-01');

INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Toninho', 'da Lua', '551134843722', NULL, 'tonho@email.com.br', '12345678', '83792699032', '1996-03-22');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Toni', 'of the Moon', '5551999992020', '5551999992121', 'tonimoon@email.com.br', '87654321', '78499378244', '1991-07-10');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Antonio', 'Moonson', '5521667839990', NULL, 'moonson@email.com.br', '09876543', '87559884323', '1982-09-29');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Zezé', 'de Camargo', '551147850013', NULL, 'favodemel@email.com.br', '77644883299', 'sertanejo123', '1976-01-03');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('João', 'das Neves', '5531938774618', '553134897763', 'winteriscomming@email.com.br', 'ygritteSelvagem', '01019283755', '2000-06-21');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Demogorgon', 'do DeD', '5551748893903', NULL, 'hawkins@email.com.br', 'closeyoureyes', '74748383992', '1822-03-15');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Luna', 'Lovegood', '551185499937', NULL, 'edwiges@email.com.br', 'avadakevara', '75883974722', '2000-06-18');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Capitão', 'Patria', '5531984778891', NULL, 'homelander@email.com.br', 'herogasm', '77783399900', '1985-09-11');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Pato', 'Donald', '55217778905', '5521877997762', 'valdisnei@email.com.br', 'animalkingdon', '89889847366', '1950-11-22');
INSERT INTO Usuarios (nome, sobrenome, telefone1, telefone2, email, senha, cpf, data_nascimento)
VALUES ('Batman', 'Wayneson', '5551888939097', NULL, 'batmail@email.com.br', 'eusouavingaca', '898909228829', '1996-09-01');

INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('rua das estrelas', 171, NULL, 'Natal', '89999111', 'RN', 1);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('rua da Lua', 131, NULL, 'Vitória', '78371898', 'ES', 2);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('rua dos Céus', 1010, NULL, 'São Paulo','78932444', 'SP', 3);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('rua dos irmãos', 2, NULL, 'Goiania','89102166', 'GO', 4);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('Avenida Entre Reinos', 100, NULL, 'Stark', '74898322', 'WS', 5);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('Vila invertida', 57, NULL, 'Mundo Invertido', '74822900', 'HK', 6);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('Rua dos Alfenieros', 4, NULL, 'Hogwarts', '73788200', 'UK', 7);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('Quinta Avenida', 7, 'Torre dos 7', '89843757', 'New York', 'NY', 8);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('Main Street', 90, NULL, 'Disney', '78921464', 'US', 9);
INSERT INTO Enderecos (logradouro, numero, complemento, cidade, cep, uf, idUsuarios)
VALUES ('Waynes Street', 666, 'Cavernas da mansão Wayne', '78790123', 'Gothan', 'US', 10);

INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2022-06-20 11:10:00', '2022-06-21 08:04:00', 'Rua do Sortudo', 'São Paulo', '94135000', 'SP', 'Brasil', 1, 2, 3);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2022-05-18 10:10:00', '2022-05-21 03:09:10', 'Rua do Sol', 'São Paulo', '99185120', 'SP', 'Brasil', 2, 3, 4);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2020-03-11 19:20:13', '2020-03-11 20:09:00', 'Rua do Maluco', 'Rio de Janeiro', '89490232', 'RJ', 'Brasil', 3, 4, 5);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2021-09-20 22:18:00', '2022-09-16 08:04:00', 'Rua do Abajur', 'São Luiz', '78782909', 'MG', 'Brasil', 4, 5, 6);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2019-06-18 16:29:00', '2019-06-21 19:02:00', 'Avenida do Rei', 'Reino do Norte', '27929371', 'WE', 'Westeros', 5, 6, 7);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2015-01-01 11:11:11', '2015-02-21 04:04:00', 'Rua Estranha', 'Hawkins', '89891002', 'OH', 'Estados Unidos', 6, 7, 8);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2018-03-28 17:07:12', '2018-03-30 18:09:00', 'Rua dos Supers', 'Manhatan', '90201883', 'NY', 'Estados Unidos', 7, 8, 9);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2019-06-09 15:15:00', '2019-06-11 06:09:00', 'Avenida dos Testralhos', 'Londres', '89839173', 'UK', 'Reino Unido', 8, 9, 10);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2020-03-01 12:11:12', '2020-03-03 04:05:00', 'Rua do Palhaço', 'Gothan', '17839902', 'US', 'Estados Unidos', 9, 10, 1);
INSERT INTO Faturas (data_fatura, data_envio, endereco_envio, cidade_envio, cep_envio, uf_envio, pais_envio, idTransportadoras, idFuncionarios, idUsuarios)
VALUES ('2022-01-04 18:23:11', '2022-01-07 21:09:00', 'Rua dos Ratinhos', 'Orlando', '18922323', 'US', 'Estados Unidos', 10, 1, 2);

INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (19.99, 5, NULL, 1, 1);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (69.99, 2, NULL, 2, 2);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (100.99, 2, NULL, 4, 4);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (39.99, 1, NULL, 3, 4);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (200.99, 10, 20.99, 5, 5);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (259.99, 10, NULL, 6, 6);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (399.99, 8, NULL, 7, 7);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (25.99, 2, NULL, 8, 8);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (49.99, 8, NULL, 9, 9);
INSERT INTO Detalhes_Faturas(preco_unitario, quantidade, desconto, faturas_id, produtos_id)
VALUES (36.99, 5, NULL, 10, 10);


SELECT * FROM Calcados.Produtos;
SELECT * FROM Calcados.Fornecedores;
SELECT * FROM Calcados.Categoria_Calcados;
SELECT * FROM Calcados.Transportadoras;
SELECT * FROM Usuarios;
SELECT * FROM Enderecos;
SELECT * FROM Faturas;
SELECT * FROM Detalhes_Faturas;

CREATE VIEW vw_visaoEstoque AS
SELECT 
p.nome, 
SUM(quantidade_por_unidade * unidades_estoque * preco_unitario) AS "Valor total em Estoque", 
CONCAT(f.id, ' - ', empresa, ' - ', endereco, ' - ', cidade, ' - ', cep, ' - ', pais) AS "Endereço Completo", 
f.telefone, 
c.nome_cat, 
c.descricao, 
c.imagem 
FROM Produtos as p
INNER JOIN  Fornecedores as f
ON p.id = f.id
INNER JOIN Categoria_Calcados as c
on p.idCategoria_Calcados = c.id
GROUP BY 
p.nome,
p.id,
f.id,
"Valor total em Estoque",
"Endereço Completo",
f.telefone, 
c.nome_cat, 
c.descricao, 
c.imagem;

SELECT * FROM vw_visaoEstoque;

DELIMITER $$
CREATE PROCEDURE selecionarTabela(IN p_id SMALLINT)
BEGIN
SELECT
p.nome,
p.preco_unitario,
f.empresa,
f.cidade
FROM
Produtos as p
INNER JOIN
Fornecedores as f
ON
p.id = f.id;
END $$
DELIMITER  ;

CALL selecionarTabela(1);
