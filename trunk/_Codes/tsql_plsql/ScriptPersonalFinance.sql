/*==============================================================*/
/* Database name:  DM_PERSONAL_FINANCE                          */
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     18/07/2013 22:52:16                          */
/*==============================================================*/


drop database DM_PERSONAL_FINANCE
go

/*==============================================================*/
/* Database: DM_PERSONAL_FINANCE                                */
/*==============================================================*/
create database DM_PERSONAL_FINANCE
go

use DM_PERSONAL_FINANCE
go

/*==============================================================*/
/* Table: DIM_CATEGORIA                                         */
/*==============================================================*/
create table DIM_CATEGORIA (
   SK_CATEGORIA         TINYINT              identity(1,1),
   CATEGORIA_COD        VARCHAR(10)          not null default newid(),
   CATEGORIA_DESC       VARCHAR(100)         not null
      constraint CKC_CATEGORIA_DESC_DIM_CATE check (CATEGORIA_DESC = upper(CATEGORIA_DESC)),
   CATEGORIA_FLAG_ATIVO BIT                  not null default 1,
   DATA_CARGA           SMALLDATETIME        not null default getdate(),
   constraint PK_DIM_CATEGORIA primary key nonclustered (SK_CATEGORIA)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a categoria estiver ativa, preencher como 1; senao 0',
   'user', @CurrentUser, 'table', 'DIM_CATEGORIA', 'column', 'CATEGORIA_FLAG_ATIVO'
go

/*==============================================================*/
/* Index: IX_PK_CATEGORIA                                       */
/*==============================================================*/
create clustered index IX_PK_CATEGORIA on DIM_CATEGORIA (
SK_CATEGORIA ASC
)
go

/*==============================================================*/
/* Table: DIM_CONTA_DESTINO                                     */
/*==============================================================*/
create table DIM_CONTA_DESTINO (
   SK_CONTA_DESTINO     TINYINT              identity(1,1),
   CONTA_DESTINO_COD    VARCHAR(10)          not null default newid(),
   CONTA_DESTINO_DESC   VARCHAR(50)          not null
      constraint CKC_CONTA_DESTINO_DES_DIM_CONT check (CONTA_DESTINO_DESC = upper(CONTA_DESTINO_DESC)),
   CONTA_DESTINO_FLAG_ATIVO BIT                  not null default 1,
   DATA_CARGA           SMALLDATETIME        not null default getdate(),
   constraint PK_DIM_CONTA_DESTINO primary key nonclustered (SK_CONTA_DESTINO)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a Conta estiver ativa, preencher como 1; senao 0',
   'user', @CurrentUser, 'table', 'DIM_CONTA_DESTINO', 'column', 'CONTA_DESTINO_FLAG_ATIVO'
go

/*==============================================================*/
/* Index: IX_PK_CONTA_DESTINO                                   */
/*==============================================================*/
create clustered index IX_PK_CONTA_DESTINO on DIM_CONTA_DESTINO (
SK_CONTA_DESTINO ASC
)
go

/*==============================================================*/
/* Table: DIM_CONTA_ORIGEM                                      */
/*==============================================================*/
create table DIM_CONTA_ORIGEM (
   SK_CONTA_ORIGEM      TINYINT              identity(1,1),
   CONTA_ORIGEM_COD     VARCHAR(10)          not null default newid(),
   CONTA_ORIGEM_DESCRICAO VARCHAR(50)          not null
      constraint CKC_CONTA_ORIGEM_DESC_DIM_CONT check (CONTA_ORIGEM_DESCRICAO = upper(CONTA_ORIGEM_DESCRICAO)),
   CONTA_ORIGEM_FLAG_ATIVO BIT                  not null default 1,
   DATA_CARGA           SMALLDATETIME        not null default getdate(),
   constraint PK_DIM_CONTA_ORIGEM primary key nonclustered (SK_CONTA_ORIGEM)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a Conta estiver ativa, preencher como 1; senao 0',
   'user', @CurrentUser, 'table', 'DIM_CONTA_ORIGEM', 'column', 'CONTA_ORIGEM_FLAG_ATIVO'
go

/*==============================================================*/
/* Index: IX_PK_CONTA_ORIGEM                                    */
/*==============================================================*/
create clustered index IX_PK_CONTA_ORIGEM on DIM_CONTA_ORIGEM (
SK_CONTA_ORIGEM ASC
)
go

/*==============================================================*/
/* Table: DIM_SUB_CATEGORIA                                     */
/*==============================================================*/
create table DIM_SUB_CATEGORIA (
   SK_SUB_CATEGORIA     SMALLINT             identity(1,1),
   SUB_CATEGORIA_COD    VARCHAR(10)          not null default newid(),
   SUB_CATEGORIA_DESC   VARCHAR(100)         not null
      constraint CKC_SUB_CATEGORIA_DES_DIM_SUB_ check (SUB_CATEGORIA_DESC = upper(SUB_CATEGORIA_DESC)),
   SUB_CATEGORIA_FLAG_ATIVO BIT                  not null default 1,
   DATA_CARGA           SMALLDATETIME        not null default getdate(),
   constraint PK_DIM_SUB_CATEGORIA primary key nonclustered (SK_SUB_CATEGORIA)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a categoria estiver ativa, preencher como 1; senao 0',
   'user', @CurrentUser, 'table', 'DIM_SUB_CATEGORIA', 'column', 'SUB_CATEGORIA_FLAG_ATIVO'
go

/*==============================================================*/
/* Index: IX_PK_SUB_CATEGORIA                                   */
/*==============================================================*/
create clustered index IX_PK_SUB_CATEGORIA on DIM_SUB_CATEGORIA (
SK_SUB_CATEGORIA ASC
)
go

/*==============================================================*/
/* Table: DIM_TRANSACAO                                         */
/*==============================================================*/
create table DIM_TRANSACAO (
   SK_TRANSACAO         TINYINT              identity(1,1),
   TRANSACAO_COD        VARCHAR(10)          not null default newid(),
   TRANSACAO_DESC       VARCHAR(50)          not null
      constraint CKC_TRANSACAO_DESC_DIM_TRAN check (TRANSACAO_DESC = upper(TRANSACAO_DESC)),
   TRANSACAO_FLAG_ATIVO BIT                  not null default 1,
   DATA_CARGA           SMALLDATETIME        not null default getdate(),
   constraint PK_DIM_TRANSACAO primary key nonclustered (SK_TRANSACAO)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a transacao estiver ativa, preencher como 1, senao 0',
   'user', @CurrentUser, 'table', 'DIM_TRANSACAO', 'column', 'TRANSACAO_FLAG_ATIVO'
go

/*==============================================================*/
/* Index: IX_PK_TRANSACAO                                       */
/*==============================================================*/
create clustered index IX_PK_TRANSACAO on DIM_TRANSACAO (
SK_TRANSACAO ASC
)
go

/*==============================================================*/
/* Table: FT_LANCAMENTO                                         */
/*==============================================================*/
create table FT_LANCAMENTO (
   DATA                 DATETIME             not null,
   SK_CONTA_ORIGEM      TINYINT              not null,
   SK_CONTA_DESTINO     TINYINT              not null,
   SK_CATEGORIA         TINYINT              not null,
   SK_SUB_CATEGORIA     SMALLINT             not null,
   SK_TRANSACAO         TINYINT              not null,
   LANCAMENTO_COD       INT                  identity(1,1),
   LANCAMENTO_DESC      VARCHAR(255)         not null,
   QTD_PARCELA          TINYINT              not null,
   VLR_PARCELA          DECIMAL(7,3)         not null,
   NOTA_DESC            VARCHAR(255)         not null,
   FLAG_CONSOLIDADO     BIT                  not null,
   FLAG_REPET_INDEF     BIT                  not null,
   DATA_CARGA           SMALLDATETIME        not null default getdate(),
   constraint PK_FT_LANCAMENTO primary key nonclustered (DATA, SK_CONTA_ORIGEM, SK_CATEGORIA, SK_SUB_CATEGORIA, SK_TRANSACAO, LANCAMENTO_COD)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Caso a Data do Lancamento seja menor que a data atual, recebe 1, senao 0',
   'user', @CurrentUser, 'table', 'FT_LANCAMENTO', 'column', 'FLAG_CONSOLIDADO'
go

/*==============================================================*/
/* Index: IX_PK_LANCAMENTOS                                     */
/*==============================================================*/
create clustered index IX_PK_LANCAMENTOS on FT_LANCAMENTO (
DATA DESC,
SK_CONTA_ORIGEM ASC,
SK_CATEGORIA ASC,
SK_SUB_CATEGORIA ASC,
SK_TRANSACAO ASC,
LANCAMENTO_COD ASC
)
go

/*==============================================================*/
/* View: DIM_TEMPO                                              */
/*==============================================================*/
create view DIM_TEMPO as
select
   DATA
from
   master.dbo.DIM_TEMPO
go

alter table FT_LANCAMENTO
   add constraint FK_FT_LANCA_FK_CONTA__DIM_CONT foreign key (SK_CONTA_DESTINO)
      references DIM_CONTA_DESTINO (SK_CONTA_DESTINO)
go

alter table FT_LANCAMENTO
   add constraint FK_FT_LANCA_FK_DM_CAT_DIM_CATE foreign key (SK_CATEGORIA)
      references DIM_CATEGORIA (SK_CATEGORIA)
go

alter table FT_LANCAMENTO
   add constraint FK_FT_LANCA_FK_DM_CON_DIM_CONT foreign key (SK_CONTA_ORIGEM)
      references DIM_CONTA_ORIGEM (SK_CONTA_ORIGEM)
go

alter table FT_LANCAMENTO
   add constraint FK_FT_LANCA_FK_DM_TRA_DIM_TRAN foreign key (SK_TRANSACAO)
      references DIM_TRANSACAO (SK_TRANSACAO)
go

alter table FT_LANCAMENTO
   add constraint FK_FT_LANCA_FK_SUB_CA_DIM_SUB_ foreign key (SK_SUB_CATEGORIA)
      references DIM_SUB_CATEGORIA (SK_SUB_CATEGORIA)
go

