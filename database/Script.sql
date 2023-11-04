SET SQL DIALECT 3;

SET NAMES NONE;

SET CLIENTLIB 'C:\Projetos\posto_combustivel\bin\fbclient.dll';

CREATE DATABASE 'C:\Projetos\posto_combustivel\database\posto.fdb'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 16384
DEFAULT CHARACTER SET NONE COLLATION NONE;



/******************************************************************************/
/*                                 Generators                                 */
/******************************************************************************/

CREATE GENERATOR GEN_ABASTECIMENTO_ID;
SET GENERATOR GEN_ABASTECIMENTO_ID TO 0;

CREATE GENERATOR GEN_BOMBA_ID;
SET GENERATOR GEN_BOMBA_ID TO 4;

CREATE GENERATOR GEN_TANQUE_ID;
SET GENERATOR GEN_TANQUE_ID TO 2;

CREATE GENERATOR GEN_TIPOCOMBUSTIVEL_ID;
SET GENERATOR GEN_TIPOCOMBUSTIVEL_ID TO 2;



/******************************************************************************/
/*                                   Tables                                   */
/******************************************************************************/



CREATE TABLE ABASTECIMENTO (
    ID_ABASTECIMENTO    INTEGER NOT NULL,
    ID_BOMBA            INTEGER NOT NULL,
    DATA_HORA           TIMESTAMP,
    QUANTIDADE          DECIMAL(15,3),
    VALOR               DECIMAL(15,2),
    PERCENTUAL_IMPOSTO  DECIMAL(8,2),
    VALOR_IMPOSTO       DECIMAL(15,2)
);

CREATE TABLE BOMBA (
    ID_BOMBA   INTEGER NOT NULL,
    NUMERO     SMALLINT,
    ID_TANQUE  INTEGER
);

CREATE TABLE TANQUE (
    ID_TANQUE            INTEGER NOT NULL,
    NUMERO               SMALLINT,
    ID_TIPO_COMBUSTIVEL  INTEGER
);

CREATE TABLE TIPOCOMBUSTIVEL (
    ID_TIPO_COMBUSTIVEL  INTEGER NOT NULL,
    DESCRICAO            VARCHAR(30)
);

INSERT INTO TIPOCOMBUSTIVEL (ID_TIPO_COMBUSTIVEL, DESCRICAO) VALUES (1, 'Gasolina');
INSERT INTO TIPOCOMBUSTIVEL (ID_TIPO_COMBUSTIVEL, DESCRICAO) VALUES (2, 'Óleo Diesel');


COMMIT WORK;

INSERT INTO TANQUE (ID_TANQUE, NUMERO, ID_TIPO_COMBUSTIVEL) VALUES (1, 1, 1);
INSERT INTO TANQUE (ID_TANQUE, NUMERO, ID_TIPO_COMBUSTIVEL) VALUES (2, 2, 2);


COMMIT WORK;

INSERT INTO BOMBA (ID_BOMBA, NUMERO, ID_TANQUE) VALUES (1, 1, 1);
INSERT INTO BOMBA (ID_BOMBA, NUMERO, ID_TANQUE) VALUES (2, 2, 1);
INSERT INTO BOMBA (ID_BOMBA, NUMERO, ID_TANQUE) VALUES (3, 3, 2);
INSERT INTO BOMBA (ID_BOMBA, NUMERO, ID_TANQUE) VALUES (4, 4, 2);


COMMIT WORK;



/******************************************************************************/
/*                                Primary keys                                */
/******************************************************************************/

ALTER TABLE ABASTECIMENTO ADD CONSTRAINT PK_ABASTECIMENTO PRIMARY KEY (ID_ABASTECIMENTO);
ALTER TABLE BOMBA ADD CONSTRAINT PK_BOMBA PRIMARY KEY (ID_BOMBA);
ALTER TABLE TANQUE ADD CONSTRAINT PK_TANQUE PRIMARY KEY (ID_TANQUE);
ALTER TABLE TIPOCOMBUSTIVEL ADD CONSTRAINT PK_TIPOCOMBUSTIVEL PRIMARY KEY (ID_TIPO_COMBUSTIVEL);


/******************************************************************************/
/*                                Foreign keys                                */
/******************************************************************************/

ALTER TABLE BOMBA ADD CONSTRAINT FK_BOMBA_TANQUE FOREIGN KEY (ID_TANQUE) REFERENCES TANQUE (ID_TANQUE);
ALTER TABLE TANQUE ADD CONSTRAINT FK_TANQUE_TIPO_COMBUSTIVEL FOREIGN KEY (ID_TIPO_COMBUSTIVEL) REFERENCES TIPOCOMBUSTIVEL (ID_TIPO_COMBUSTIVEL);


/******************************************************************************/
/*                                  Triggers                                  */
/******************************************************************************/



SET TERM ^ ;



/******************************************************************************/
/*                            Triggers for tables                             */
/******************************************************************************/



/* Trigger: ABASTECIMENTO_BI */
CREATE TRIGGER ABASTECIMENTO_BI FOR ABASTECIMENTO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id_abastecimento is null) then
    new.id_abastecimento = gen_id(gen_abastecimento_id,1);
end
^

/* Trigger: BOMBA_BI */
CREATE TRIGGER BOMBA_BI FOR BOMBA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id_bomba is null) then
    new.id_bomba = gen_id(gen_bomba_id,1);
end
^

/* Trigger: TANQUE_BI */
CREATE TRIGGER TANQUE_BI FOR TANQUE
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id_tanque is null) then
    new.id_tanque = gen_id(gen_tanque_id,1);
end
^

/* Trigger: TIPOCOMBUSTIVEL_BI */
CREATE TRIGGER TIPOCOMBUSTIVEL_BI FOR TIPOCOMBUSTIVEL
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id_tipo_combustivel is null) then
    new.id_tipo_combustivel = gen_id(gen_tipocombustivel_id,1);
end
^
SET TERM ; ^