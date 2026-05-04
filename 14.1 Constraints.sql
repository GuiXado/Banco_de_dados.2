CREATE DATABASE mecanica
GO

USE mecanica
Go

CREATE TABLE cliente (
id		INT		NOT NULL	IDENTITY(3401, 15),
nome		VARCHAR(100)	NOT NULL,
logradouro	VARCHAR(200)	NOT NULL,
numero		INT		NOT NULL	CHECK(numero >= 0),
cep		CHAR(8)		NOT NULL,
complemento	VARCHAR(255)	NOT NULL,

PRIMARY KEY (id),

CONSTRAINT chk_cep CHECK (LEN(cep) = 8)
)

CREATE TABLE telefone_cliente	(
cliente_id	INT		NOT NULL,
telefone	VARCHAR(11)	NOT NULL,

PRIMARY KEY (cliente_id, telefone),

FOREIGN KEY (cliente_id) 	REFERENCES cliente(id),

CONSTRAINT chk_telefone CHECK (LEN(telefone) = 10 OR LEN(telefone) = 11)
)

CREATE TABLE veiculo (
placa			CHAR(7)		NOT NULL,
marca			VARCHAR(30)	NOT NULL,
modelo			VARCHAR(30)	NOT NULL,
cor			VARCHAR(15)	NOT NULL,
ano_fabricacao		INT		NOT NULL	CHECK(ano_fabricacao >= 1997),
ano_modelo		INT		NOT NULL	CHECK(ano_modelo >= 1997),
data_aquisicao		DATE		NOT NULL,
cliente_id		INT		NOT NULL,

PRIMARY KEY (placa),

FOREIGN KEY (cliente_id)	REFERENCES cliente(id),

CONSTRAINT chk_ano_veiculo CHECK (ano_modelo = ano_fabricacao OR ano_modelo = ano_fabricacao + 1),
CONSTRAINT chk_placa CHECK (LEN(placa) = 7)
)

CREATE TABLE peca (
id		INT		NOT NULL	IDENTITY(3411, 7),
nome		VARCHAR(30)	NOT NULL	UNIQUE,
preco		DECIMAL(4, 2)	NOT NULL	CHECK(preco >= 0),
estoque		INT		NOT NULL,

PRIMARY KEY (id),

CONSTRAINT chk_estoque CHECK (estoque >= 10)
)

CREATE TABLE categoria (
id		INT		NOT NULL	IDENTITY(1, 1),
categoria	VARCHAR(50)	NOT NULL	CHECK(UPPER(categoria) = 'ESTAGIARIO' OR 
						UPPER(categoria) = 'NIVEL 1' OR 
						UPPER(categoria) = 'NIVEL 2' OR 
						UPPER(categoria) = 'NIVEL 3'),
valor_hora	DECIMAL(4,2)	NOT NULL,

PRIMARY KEY(id),

CONSTRAINT chk_categoria_valor CHECK (
        (UPPER(categoria) = 'ESTAGIARIO' AND valor_hora > 15) OR
        (UPPER(categoria) = 'NIVEL 1' AND valor_hora > 25) OR
        (UPPER(categoria) = 'NIVEL 2' AND valor_hora > 35) OR
        (UPPER(categoria) = 'NIVEL 3' AND valor_hora > 50))
)

CREATE TABLE funcionario (
id				INT			NOT NULL	IDENTITY(101, 1),
nome				VARCHAR(100)		NOT NULL,
logradouro			VARCHAR(200)		NOT NULL,
numero				INT			NOT NULL	CHECK(numero >= 0),
telefone			CHAR(11)		NOT NULL,
categoria_habilitacao		CHAR(2)			NOT NULL	CHECK(UPPER(categoria_habilitacao) = 'A' OR 
							UPPER(categoria_habilitacao) = 'B' OR UPPER(categoria_habilitacao) = 'C' OR 
							UPPER(categoria_habilitacao) = 'D' OR UPPER(categoria_habilitacao) = 'E'),
categoria_id			INT			NOT NULL,

PRIMARY KEY (id),

FOREIGN KEY (categoria_id)	REFERENCES categoria(id)
)

CREATE TABLE reparo (
veiculo_placa		char(7)		NOT NULL,
funcionario_id		INT		NOT NULL,
peca_id			INT		NOT NULL,
data			DATE		NOT NULL	DEFAULT(GETDATE()),
custo_total		DECIMAL(4, 2)	NOT NULL	CHECK(custo_total >= 0),
tempo			INT		NOT NULL	CHECK (tempo >= 0),

PRIMARY KEY (veiculo_placa, funcionario_id, peca_id, data),

FOREIGN KEY (veiculo_placa)	REFERENCES veiculo(placa),
FOREIGN KEY (funcionario_id)	REFERENCES funcionario(id),
FOREIGN KEY (peca_id)		REFERENCES peca(id)
)
