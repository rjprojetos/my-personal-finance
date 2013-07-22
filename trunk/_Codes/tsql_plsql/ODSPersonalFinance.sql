/*==============================================================*/
/* Database name:  ODS_PERSONAL_FINANCE                         */
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     22/07/2013 00:59:18                          */
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
           WHERE  ID = OBJECT_ID('TMP_CATEGORIA')
            AND   TYPE = 'U')
   DROP TABLE TMP_CATEGORIA
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TMP_CONTA')
            AND   TYPE = 'U')
   DROP TABLE TMP_CONTA
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TMP_FT_LANCAMENTOS')
            AND   TYPE = 'U')
   DROP TABLE TMP_FT_LANCAMENTOS
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TMP_SUB_CATEGORIA')
            AND   TYPE = 'U')
   DROP TABLE TMP_SUB_CATEGORIA
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TMP_TRANSACAO')
            AND   TYPE = 'U')
   DROP TABLE TMP_TRANSACAO
go

/*==============================================================*/
/* Table: TMP_CATEGORIA                                         */
/*==============================================================*/
CREATE TABLE TMP_CATEGORIA (
   CATEGORIA_COD        INTEGER              NOT NULL,
   CATEGORIA_DESC       VARCHAR(50)          NOT NULL
      CONSTRAINT CKC_CATEGORIA_DESC_TMP_CATE CHECK (CATEGORIA_DESC = UPPER(CATEGORIA_DESC)),
   CATEGORIA_FLAG_ATIVO BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE(),
   CONSTRAINT PK_TMP_CATEGORIA PRIMARY KEY (CATEGORIA_COD)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a categoria estiver ativa, preencher como 1; senao 0',
   'user', @CURRENTUSER, 'table', 'TMP_CATEGORIA', 'column', 'CATEGORIA_FLAG_ATIVO'
go

/*==============================================================*/
/* Table: TMP_CONTA                                             */
/*==============================================================*/
CREATE TABLE TMP_CONTA (
   CONTA_COD            INTEGER              IDENTITY(1,1),
   CONTA_DESCRICAO      VARCHAR(50)          NOT NULL
      CONSTRAINT CKC_CONTA_DESCRICAO_TMP_CONT CHECK (CONTA_DESCRICAO = UPPER(CONTA_DESCRICAO)),
   CONTA_FLAG_ATIVO     BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE(),
   CONSTRAINT PK_TMP_CONTA PRIMARY KEY (CONTA_COD)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a Conta estiver ativa, preencher como 1; senao 0',
   'user', @CURRENTUSER, 'table', 'TMP_CONTA', 'column', 'CONTA_FLAG_ATIVO'
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
   SUB_CATEGORIA_DESC   VARCHAR(50)          NOT NULL
      CONSTRAINT CKC_SUB_CATEGORIA_DES_TMP_SUB_ CHECK (SUB_CATEGORIA_DESC = UPPER(SUB_CATEGORIA_DESC)),
   SUB_CATEGORIA_FLAG_ATIVO BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE(),
   CONSTRAINT PK_TMP_SUB_CATEGORIA PRIMARY KEY (SUB_CATEGORIA_COD)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a categoria estiver ativa, preencher como 1; senao 0',
   'user', @CURRENTUSER, 'table', 'TMP_SUB_CATEGORIA', 'column', 'SUB_CATEGORIA_FLAG_ATIVO'
go

/*==============================================================*/
/* Table: TMP_TRANSACAO                                         */
/*==============================================================*/
CREATE TABLE TMP_TRANSACAO (
   TRANSACAO_COD        INTEGER              IDENTITY(1,1),
   TRANSACAO_DESC       VARCHAR(50)          NOT NULL
      CONSTRAINT CKC_TRANSACAO_DESC_TMP_TRAN CHECK (TRANSACAO_DESC = UPPER(TRANSACAO_DESC)),
   TRANSACAO_FLAG_ATIVO BIT                  NOT NULL DEFAULT 1,
   DATA_CARGA           DATETIME             NOT NULL DEFAULT GETDATE(),
   CONSTRAINT PK_TMP_TRANSACAO PRIMARY KEY (TRANSACAO_COD)
)
go

DECLARE @CURRENTUSER SYSNAME
SELECT @CURRENTUSER = USER_NAME()
EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Se a transacao estiver ativa, preencher como 1, senao 0',
   'user', @CURRENTUSER, 'table', 'TMP_TRANSACAO', 'column', 'TRANSACAO_FLAG_ATIVO'
go

/*==============================================================*/
/* View: TMP_CONTA_DESTINO                                      */
/*==============================================================*/
CREATE VIEW TMP_CONTA_DESTINO AS
SELECT CONTA_COD AS CONTA_DESTINO_COD
      ,CONTA_DESCRICAO
      ,CONTA_FLAG_ATIVO
      ,DATA_CARGA
  FROM DBO.TMP_CONTA
go

/*==============================================================*/
/* View: VW_CATEG_NAO_MAPEADO                                   */
/*==============================================================*/
CREATE VIEW VW_CATEG_NAO_MAPEADO AS
SELECT CATEGORIA_COD, CATEGORIA_DESC, CATEGORIA_NIVEL, CATEGORIA_PAI_COD, FLAG_ATIVO, DATA_CARGA
	FROM CTR_MAPEIA_CATEGORIA
	WHERE	CATEGORIA_NIVEL IS NULL
go

