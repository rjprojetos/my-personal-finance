/*==============================================================*/
/* Database name:  DM_PERSONAL_FINANCE                          */
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     19/07/2013 12:04:03                          */
/*==============================================================*/


drop database DM_PERSONAL_FINANCE
go

/*==============================================================*/
/* Database: DM_PERSONAL_FINANCE                                */
/*==============================================================*/
create database DM_PERSONAL_FINANCE
collate SQL_Latin1_General_CP1_CI_AI
go

use DM_PERSONAL_FINANCE
go

/*==============================================================*/
/* Table: DIM_CATEGORIA                                         */
/*==============================================================*/
create table DIM_CATEGORIA (
   SK_CATEGORIA         integer              identity(1,1),
   CATEGORIA_COD        varchar(15)          not null default newid(),
   CATEGORIA_DESC       varchar(100)         not null
      constraint CKC_CATEGORIA_DESC_DIM_CATE check (CATEGORIA_DESC = upper(CATEGORIA_DESC)),
   CATEGORIA_FLAG_ATIVO bit                  not null default 1,
   DATA_CARGA           datetime             not null default getdate(),
   constraint PK_DIM_CATEGORIA primary key (SK_CATEGORIA)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a categoria estiver ativa, preencher como 1; senao 0',
   'user', @CurrentUser, 'table', 'DIM_CATEGORIA', 'column', 'CATEGORIA_FLAG_ATIVO'
go

/*==============================================================*/
/* Table: DIM_CONTA_DESTINO                                     */
/*==============================================================*/
create table DIM_CONTA_DESTINO (
   SK_CONTA_DESTINO     integer              identity(1,1),
   CONTA_DESTINO_COD    varchar(15)          not null default newid(),
   CONTA_DESTINO_DESC   varchar(50)          not null
      constraint CKC_CONTA_DESTINO_DES_DIM_CONT check (CONTA_DESTINO_DESC = upper(CONTA_DESTINO_DESC)),
   CONTA_DESTINO_FLAG_ATIVO bit                  not null default 1,
   DATA_CARGA           datetime             not null default getdate(),
   constraint PK_DIM_CONTA_DESTINO primary key (SK_CONTA_DESTINO)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a Conta estiver ativa, preencher como 1; senao 0',
   'user', @CurrentUser, 'table', 'DIM_CONTA_DESTINO', 'column', 'CONTA_DESTINO_FLAG_ATIVO'
go

/*==============================================================*/
/* Table: DIM_CONTA_ORIGEM                                      */
/*==============================================================*/
create table DIM_CONTA_ORIGEM (
   SK_CONTA_ORIGEM      integer              identity(1,1),
   CONTA_ORIGEM_COD     varchar(15)          not null default newid(),
   CONTA_ORIGEM_DESCRICAO varchar(50)          not null
      constraint CKC_CONTA_ORIGEM_DESC_DIM_CONT check (CONTA_ORIGEM_DESCRICAO = upper(CONTA_ORIGEM_DESCRICAO)),
   CONTA_ORIGEM_FLAG_ATIVO bit                  not null default 1,
   DATA_CARGA           datetime             not null default getdate(),
   constraint PK_DIM_CONTA_ORIGEM primary key (SK_CONTA_ORIGEM)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a Conta estiver ativa, preencher como 1; senao 0',
   'user', @CurrentUser, 'table', 'DIM_CONTA_ORIGEM', 'column', 'CONTA_ORIGEM_FLAG_ATIVO'
go

/*==============================================================*/
/* Table: DIM_SUB_CATEGORIA                                     */
/*==============================================================*/
create table DIM_SUB_CATEGORIA (
   SK_SUB_CATEGORIA     integer              identity(1,1),
   SUB_CATEGORIA_COD    varchar(15)          not null default newid(),
   SUB_CATEGORIA_DESC   varchar(100)         not null
      constraint CKC_SUB_CATEGORIA_DES_DIM_SUB_ check (SUB_CATEGORIA_DESC = upper(SUB_CATEGORIA_DESC)),
   SUB_CATEGORIA_FLAG_ATIVO bit                  not null default 1,
   DATA_CARGA           datetime             not null default getdate(),
   constraint PK_DIM_SUB_CATEGORIA primary key (SK_SUB_CATEGORIA)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a categoria estiver ativa, preencher como 1; senao 0',
   'user', @CurrentUser, 'table', 'DIM_SUB_CATEGORIA', 'column', 'SUB_CATEGORIA_FLAG_ATIVO'
go

/*==============================================================*/
/* Table: DIM_TRANSACAO                                         */
/*==============================================================*/
create table DIM_TRANSACAO (
   SK_TRANSACAO         integer              identity(1,1),
   TRANSACAO_COD        varchar(15)          not null default newid(),
   TRANSACAO_DESC       varchar(50)          not null
      constraint CKC_TRANSACAO_DESC_DIM_TRAN check (TRANSACAO_DESC = upper(TRANSACAO_DESC)),
   TRANSACAO_FLAG_ATIVO bit                  not null default 1,
   DATA_CARGA           datetime             not null default getdate(),
   constraint PK_DIM_TRANSACAO primary key (SK_TRANSACAO)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'Se a transacao estiver ativa, preencher como 1, senao 0',
   'user', @CurrentUser, 'table', 'DIM_TRANSACAO', 'column', 'TRANSACAO_FLAG_ATIVO'
go

/*==============================================================*/
/* Table: FT_LANCAMENTO                                         */
/*==============================================================*/
create table FT_LANCAMENTO (
   DATA                 datetime             not null,
   SK_CONTA_ORIGEM      integer              not null,
   SK_CONTA_DESTINO     integer              not null,
   SK_CATEGORIA         integer              not null,
   SK_SUB_CATEGORIA     integer              not null,
   SK_TRANSACAO         integer              not null,
   LANCAMENTO_COD       numeric              identity,
   LANCAMENTO_DESC      varchar(255)         not null,
   QTD_PARCELA          tinyint              not null default 0,
   VLR_PARCELA          decimal(7,3)         not null default 0,
   NOTA_DESC            varchar(255)         not null,
   FLAG_CONSOLIDADO     bit                  not null default 1,
   FLAG_REPET_INDEF     bit                  not null default 0,
   DATA_CARGA           datetime             not null default getdate(),
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
SELECT Data
      ,Data_Nome
      ,Ano
      ,Ano_Nome
      ,Semestre
      ,Semestre_Nome
      ,Trimestre
      ,Trimestre_Nome
      ,Quadrimestre
      ,Quadrimestre_Nome
      ,Mes
      ,Mes_Nome
      ,Dez_Dias
      ,Dez_Dias_Nome
      ,Semana
      ,Semana_Nome
      ,Dia_do_Ano
      ,Dia_do_Ano_Nome
      ,Dia_do_Semestre
      ,Dia_do_Semestre_Nome
      ,Dia_do_Quadrimestre
      ,Dia_do_Quadrimestre_Nome
      ,Dia_do_Trimestre
      ,Dia_do_Trimestre_Nome
      ,Dia_do_Mes
      ,Dia_do_Mes_Nome
      ,Dia_De_Dez_Dias
      ,Dia_De_Dez_Dias_Nome
      ,Dia_Da_Semana
      ,Dia_Da_Semana_Nome
      ,Semana_do_Ano
      ,Semana_do_Ano_Nome
      ,Dez_Dias_do_Ano
      ,Dez_Dias_do_Ano_Nome
      ,Dez_Dias_do_Semestre
      ,Dez_Dias_do_Semestre_Nome
      ,Dez_Dias_do_Quadrimestre
      ,Dez_Dias_do_Quadrimestre_Nome
      ,Dez_Dias_do_Trimestre
      ,Dez_Dias_do_Trimestre_Nome
      ,Dez_Dias_do_Mes
      ,Dez_Dias_do_Mes_Nome
      ,Mes_do_Ano
      ,Mes_do_Ano_Nome
      ,Mes_do_Semestre
      ,Mes_do_Semestre_Nome
      ,Mes_do_Quadrimestre
      ,Mes_do_Quadrimestre_Nome
      ,Mes_do_Trimestre
      ,Mes_do_Trimestre_Nome
      ,Trimestre_do_Ano
      ,Trimestre_do_Ano_Nome
      ,Trimestre_do_Semestre
      ,Trimestre_do_Semestre_Nome
      ,Quadrimestre_do_Ano
      ,Quadrimestre_do_Ano_Nome
      ,Semestre_do_Ano
      ,Semestre_do_Ano_Nome
  
  FROM master.dbo.DIM_TEMPO
go

