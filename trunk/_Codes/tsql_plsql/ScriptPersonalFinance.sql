/*==============================================================*/
/* Database name:  DM_PERSONAL_FINANCE                          */
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     25/07/2013 11:28:05                          */
/*==============================================================*/


use DM_PERSONAL_FINANCE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_CATEGORIA')
            and   type = 'U')
   drop table DIM_CATEGORIA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_CONTA_ORIGEM')
            and   type = 'U')
   drop table DIM_CONTA_ORIGEM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_SUB_CATEGORIA')
            and   type = 'U')
   drop table DIM_SUB_CATEGORIA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_TRANSACAO')
            and   type = 'U')
   drop table DIM_TRANSACAO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FT_LANCAMENTO')
            and   name  = 'IX_PK_LANCAMENTOS'
            and   indid > 0
            and   indid < 255)
   drop index FT_LANCAMENTO.IX_PK_LANCAMENTOS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FT_LANCAMENTO')
            and   type = 'U')
   drop table FT_LANCAMENTO
go

/*==============================================================*/
/* Table: DIM_CATEGORIA                                         */
/*==============================================================*/
create table DIM_CATEGORIA (
   SK_CATEGORIA         integer              identity(1,1),
   CATEGORIA_COD        varchar(15)          not null,
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
/* Table: DIM_CONTA_ORIGEM                                      */
/*==============================================================*/
create table DIM_CONTA_ORIGEM (
   SK_CONTA_ORIGEM      int                  identity(1,1),
   CONTA_ORIGEM_COD     int                  not null,
   CONTA_ORIGEM_DESCRICAO varchar(50)          not null
      constraint CKC_CONTA_ORIGEM_DESC_DIM_CONT check (CONTA_ORIGEM_DESCRICAO = upper(CONTA_ORIGEM_DESCRICAO)),
   CONTA_ORIGEM_FLAG_ATIVO bit                  not null default 1,
   DATA_CARGA           datetime             not null default getdate(),
   constraint PK_DIM_CONTA_ORIGEM primary key (SK_CONTA_ORIGEM)
)
go

/*==============================================================*/
/* Table: DIM_SUB_CATEGORIA                                     */
/*==============================================================*/
create table DIM_SUB_CATEGORIA (
   SK_SUB_CATEGORIA     integer              identity(1,1),
   SUB_CATEGORIA_COD    varchar(15)          not null,
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
   TRANSACAO_COD        varchar(15)          not null,
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
   SK_CONTA_ORIGEM      int                  not null,
   SK_CONTA_DESTINO     int                  not null,
   SK_CATEGORIA         int                  not null,
   SK_SUB_CATEGORIA     int                  not null,
   SK_TRANSACAO         int                  not null,
   CATEGORIA_NIVEL      smallint             not null,
   LANCAMENTO_DESC      varchar(255)         not null default 'N/A'
      constraint CKC_LANCAMENTO_DESC_FT_LANCA check (LANCAMENTO_DESC = upper(LANCAMENTO_DESC)),
   PARCELA_ATUAL        smallint             not null default 0,
   PARCELA_TOTAL        smallint             not null default 0,
   VLR_PARCELA          decimal(7,3)         not null default 0,
   FLAG_CONSOLIDADO     bit                  not null default 1,
   DATA_CARGA           datetime             not null default getdate(),
   constraint PK_FT_LANCAMENTO primary key nonclustered (DATA, SK_CONTA_ORIGEM, SK_CONTA_DESTINO, SK_CATEGORIA, SK_SUB_CATEGORIA, SK_TRANSACAO)
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
SK_TRANSACAO ASC
)
go

