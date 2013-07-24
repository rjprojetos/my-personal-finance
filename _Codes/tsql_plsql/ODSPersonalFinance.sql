/*==============================================================*/
/* Database name:  ODS_PERSONAL_FINANCE                         */
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     23/07/2013 07:26:37                          */
/*==============================================================*/


USE ODS_PERSONAL_FINANCE
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TMP_CONTA_DESTINO')
            AND   TYPE = 'V')
   DROP VIEW TMP_CONTA_DESTINO
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('VW_CATEG_NAO_MAPEADO')
            AND   TYPE = 'V')
   DROP VIEW VW_CATEG_NAO_MAPEADO
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('LOG_CAT_SUBCAT_NO_MATCH')
            AND   TYPE = 'U')
   DROP TABLE LOG_CAT_SUBCAT_NO_MATCH
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('LOG_CONTA_NO_MATCH')
            AND   TYPE = 'U')
   DROP TABLE LOG_CONTA_NO_MATCH
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('LOG_TRANSACAO_NO_MATCH')
            AND   TYPE = 'U')
   DROP TABLE LOG_TRANSACAO_NO_MATCH
go

ALTER TABLE TB_CONTA
   DROP CONSTRAINT PK_TB_CONTA
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TB_CONTA')
            AND   TYPE = 'U')
   DROP TABLE TB_CONTA
go

ALTER TABLE TB_TRANSACAO
   DROP CONSTRAINT PK_TB_TRANSACAO
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TB_TRANSACAO')
            AND   TYPE = 'U')
   DROP TABLE TB_TRANSACAO
go

ALTER TABLE TMP_CATEGORIA
   DROP CONSTRAINT PK_TMP_CATEGORIA
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TMP_CATEGORIA')
            AND   TYPE = 'U')
   DROP TABLE TMP_CATEGORIA
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TMP_FT_LANCAMENTOS')
            AND   TYPE = 'U')
   DROP TABLE TMP_FT_LANCAMENTOS
go

ALTER TABLE TMP_SUB_CATEGORIA
   DROP CONSTRAINT PK_TMP_SUB_CATEGORIA
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TMP_SUB_CATEGORIA')
            AND   TYPE = 'U')
   DROP TABLE TMP_SUB_CATEGORIA
go

/*==============================================================*/
/* Table: LOG_CAT_SUBCAT_NO_MATCH                               */
/*==============================================================*/
CREATE TABLE LOG_CAT_SUBCAT_NO_MATCH (
   NMC_CATEGORIA_DESC   VARCHAR(50)          NOT NULL,
   NMC_CATEGORIA_NIVEL  SMALLINT             NOT NULL DEFAULT -1,
   NMC_CATEGORIA_PAI_COD SMALLINT             NOT NULL DEFAULT -1,
   NMC_FLAG_ATIVO       BIT                  NOT NULL DEFAULT 1,
   NMC_DATA_CARGA       DATETIME             NOT NULL DEFAULT CURRENT_TIMESTAMP
)
go

ALTER TABLE LOG_CAT_SUBCAT_NO_MATCH
   ADD CONSTRAINT CKC_NMC_CATEGORIA_DES_LOG_CAT_ CHECK (NMC_CATEGORIA_DESC = UPPER(NMC_CATEGORIA_DESC))
go

/*==============================================================*/
/* Table: LOG_CONTA_NO_MATCH                                    */
/*==============================================================*/
CREATE TABLE LOG_CONTA_NO_MATCH (
   NMC_CONTA_DESC       VARCHAR(50)          NOT NULL,
   NMC_CONTA_FLAG_ATIVO BIT                  NOT NULL DEFAULT 1,
   NMC_DATA_CARGA       DATETIME             NOT NULL DEFAULT GETDATE()
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a Conta estiver ativa, preencher como 1; senao 0',
   'user', @CURRENTUSER, 'table', 'LOG_CONTA_NO_MATCH', 'column', 'NMC_CONTA_FLAG_ATIVO'
go

ALTER TABLE LOG_CONTA_NO_MATCH
   ADD CONSTRAINT CKC_NMC_CONTA_DESC_LOG_CONT CHECK (NMC_CONTA_DESC = UPPER(NMC_CONTA_DESC))
go

/*==============================================================*/
/* Table: LOG_TRANSACAO_NO_MATCH                                */
/*==============================================================*/
CREATE TABLE LOG_TRANSACAO_NO_MATCH (
   TRANSACAO_DESC       VARCHAR(50)          NOT NULL,
   FLAG_ATIVO           BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE()
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a transacao estiver ativa, preencher como 1, senao 0',
   'user', @CURRENTUSER, 'table', 'LOG_TRANSACAO_NO_MATCH', 'column', 'FLAG_ATIVO'
go

ALTER TABLE LOG_TRANSACAO_NO_MATCH
   ADD CONSTRAINT CKC_TRANSACAO_DESC_LOG_TRAN CHECK (TRANSACAO_DESC = UPPER(TRANSACAO_DESC))
go

/*==============================================================*/
/* Table: TB_CONTA                                              */
/*==============================================================*/
CREATE TABLE TB_CONTA (
   CONTA_COD            INTEGER              IDENTITY(1,1),
   CONTA_DESC           VARCHAR(50)          NOT NULL,
   FLAG_ATIVO           BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE()
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a Conta estiver ativa, preencher como 1; senao 0',
   'user', @CURRENTUSER, 'table', 'TB_CONTA', 'column', 'FLAG_ATIVO'
go

ALTER TABLE TB_CONTA
   ADD CONSTRAINT CKC_CONTA_DESC_TB_CONTA CHECK (CONTA_DESC = UPPER(CONTA_DESC))
go

ALTER TABLE TB_CONTA
   ADD CONSTRAINT PK_TB_CONTA PRIMARY KEY (CONTA_COD)
go

/*==============================================================*/
/* Table: TB_TRANSACAO                                          */
/*==============================================================*/
CREATE TABLE TB_TRANSACAO (
   TRANSACAO_COD        INTEGER              IDENTITY(1,1),
   TRANSACAO_DESC       VARCHAR(50)          NOT NULL,
   FLAG_ATIVO           BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE()
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a transacao estiver ativa, preencher como 1, senao 0',
   'user', @CURRENTUSER, 'table', 'TB_TRANSACAO', 'column', 'FLAG_ATIVO'
go

ALTER TABLE TB_TRANSACAO
   ADD CONSTRAINT CKC_TRANSACAO_DESC_TB_TRANS CHECK (TRANSACAO_DESC = UPPER(TRANSACAO_DESC))
go

ALTER TABLE TB_TRANSACAO
   ADD CONSTRAINT PK_TB_TRANSACAO PRIMARY KEY (TRANSACAO_COD)
go

/*==============================================================*/
/* Table: TMP_CATEGORIA                                         */
/*==============================================================*/
CREATE TABLE TMP_CATEGORIA (
   CATEGORIA_COD        INTEGER              NOT NULL,
   CATEGORIA_DESC       VARCHAR(50)          NOT NULL,
   FLAG_ATIVO           BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE()
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a categoria estiver ativa, preencher como 1; senao 0',
   'user', @CURRENTUSER, 'table', 'TMP_CATEGORIA', 'column', 'FLAG_ATIVO'
go

ALTER TABLE TMP_CATEGORIA
   ADD CONSTRAINT CKC_CATEGORIA_DESC_TMP_CATE CHECK (CATEGORIA_DESC = UPPER(CATEGORIA_DESC))
go

ALTER TABLE TMP_CATEGORIA
   ADD CONSTRAINT PK_TMP_CATEGORIA PRIMARY KEY (CATEGORIA_COD)
go

/*==============================================================*/
/* Table: TMP_FT_LANCAMENTOS                                    */
/*==============================================================*/
CREATE TABLE TMP_FT_LANCAMENTOS (
   CONTA_ORIGEM_COD     INTEGER              NOT NULL,
   CONTA_DESTINO_CO     INTEGER              NOT NULL,
   CATEGORIA_COD        INTEGER              NOT NULL,
   SUB_CATEGORIA_COD    INTEGER              NOT NULL,
   TRANSACAO_COD        INTEGER              NOT NULL,
   DATA                 DATETIME             NOT NULL,
   LANCAMENTO_DESC      VARCHAR(100)         NOT NULL,
   QTD_PARCELA          TINYINT              NOT NULL DEFAULT 0,
   VLR_PARCELA          DECIMAL(7,2)         NOT NULL DEFAULT 0,
   NOTA_DESC            VARCHAR(255)         NOT NULL,
   FLAG_CONSOLIDADO     BIT                  NOT NULL DEFAULT 1,
   FLAG_REPET_INDEF     BIT                  NOT NULL DEFAULT 0,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE()
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Caso a Data do Lancamento seja menor que a data atual, recebe 1, senao 0',
   'user', @CURRENTUSER, 'table', 'TMP_FT_LANCAMENTOS', 'column', 'FLAG_CONSOLIDADO'
go

/*==============================================================*/
/* Table: TMP_SUB_CATEGORIA                                     */
/*==============================================================*/
CREATE TABLE TMP_SUB_CATEGORIA (
   SUB_CATEGORIA_COD    INTEGER              NOT NULL,
   SUB_CATEGORIA_DESC   VARCHAR(50)          NOT NULL,
   FLAG_ATIVO           BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE()
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a categoria estiver ativa, preencher como 1; senao 0',
   'user', @CURRENTUSER, 'table', 'TMP_SUB_CATEGORIA', 'column', 'FLAG_ATIVO'
go

ALTER TABLE TMP_SUB_CATEGORIA
   ADD CONSTRAINT CKC_SUB_CATEGORIA_DES_TMP_SUB_ CHECK (SUB_CATEGORIA_DESC = UPPER(SUB_CATEGORIA_DESC))
go

ALTER TABLE TMP_SUB_CATEGORIA
   ADD CONSTRAINT PK_TMP_SUB_CATEGORIA PRIMARY KEY (SUB_CATEGORIA_COD)
go

/*==============================================================*/
/* View: TMP_CONTA_DESTINO                                      */
/*==============================================================*/
CREATE VIEW TMP_CONTA_DESTINO AS
SELECT
   CONTA_COD AS CONTA_DESTINO_COD,
   CONTA_DESC,
   FLAG_ATIVO,
   DATA_CARGA
FROM
   TB_CONTA
go

/*==============================================================*/
/* View: VW_CATEG_NAO_MAPEADO                                   */
/*==============================================================*/
CREATE VIEW VW_CATEG_NAO_MAPEADO AS
SELECT
   CATEGORIA_COD,
   CATEGORIA_DESC,
   CATEGORIA_NIVEL,
   CATEGORIA_PAI_COD,
   FLAG_ATIVO,
   DATA_CARGA
FROM
   TB_CATEG_SUBCATEG
WHERE
   CATEGORIA_NIVEL = '-1'
go

