CREATE DATABASE maternidade
GO

USE maternidade
Go

CREATE TABLE mae (
id_mae			INT		NOT NULL	IDENTITY(1001, 1),
nome			VARCHAR(60)	NOT NULL,
logradouro_endereco	VARCHAR(100)	NOT NULL,
numero_endereco		INT		NOT NULL	CHECK(numero_endereco >= 0),
cep_endereco		CHAR(8)		NOT NULL,
complemento_endereco	VARCHAR(200)	NOT NULL,
telefone		CHAR(10)	NOT NULL,
data_nasc		DATE		NOT NULL,

PRIMARY KEY(id_mae),

CONSTRAINT chk_cep_endereco CHECK (LEN(cep_endereco) = 8),
CONSTRAINT chk_telefone CHECK (LEN(telefone) = 10)
)

CREATE TABLE medico (
crm_numero		INT		NOT NULL,	
crm_uf			CHAR(2)		NOT NULL,
nome			VARCHAR(60)	NOT NULL,
telefone_celular	CHAR(11)	NOT NULL	UNIQUE,
especialidade		VARCHAR(30)	NOT NULL,

PRIMARY KEY(crm_numero, crm_uf),

CONSTRAINT chk_telefone_celular CHECK (LEN(telefone_celular) = 11)
)

CREATE TABLE bebe (
id_bebe		INT		NOT NULL	IDENTITY(1, 1),
nome		VARCHAR(60)	NOT NULL,
data_nasc	DATE		NOT NULL	DEFAULT(GETDATE()),
altura		DECIMAL(7, 2)	NOT NULL	CHECK(altura >= 0),
peso		DECIMAL(4, 3)	NOT NULL	CHECK(peso >= 0),
mae_id_mae	INT		NOT NULL,

PRIMARY KEY (id_bebe),

FOREIGN KEY (mae_id_mae) 	REFERENCES mae(id_mae)
)

CREATE TABLE bebe_medico (
bebe_id_bebe		INT		NOT NULL,
medico_crm_numero	INT		NOT NULL,
medico_crm_uf		CHAR(2)		NOT NULL,

PRIMARY KEY (bebe_id_bebe, medico_crm_numero, medico_crm_uf),

FOREIGN KEY (bebe_id_bebe) 			REFERENCES bebe(id_bebe),
FOREIGN KEY (medico_crm_numero, medico_crm_uf) 	REFERENCES medico(crm_numero, crm_uf)
)