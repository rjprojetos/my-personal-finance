/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     20/08/2013 16:34:07                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_cc_revenda') and o.name = 'FK_tb_cc_revenda_tb_cc')
alter table dbo.tb_cc_revenda
   drop constraint FK_tb_cc_revenda_tb_cc
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_cc_revenda') and o.name = 'FK_tb_cc_revenda_tb_revenda')
alter table dbo.tb_cc_revenda
   drop constraint FK_tb_cc_revenda_tb_revenda
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_cc_revenda') and o.name = 'FK_tb_cc_revenda_tb_vincSeguranca')
alter table dbo.tb_cc_revenda
   drop constraint FK_tb_cc_revenda_tb_vincSeguranca
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_projeto_revenda') and o.name = 'FK_tb_projeto_revenda_tb_projeto')
alter table dbo.tb_projeto_revenda
   drop constraint FK_tb_projeto_revenda_tb_projeto
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_projeto_revenda') and o.name = 'FK_tb_projeto_revenda_tb_revenda')
alter table dbo.tb_projeto_revenda
   drop constraint FK_tb_projeto_revenda_tb_revenda
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_projeto_revenda') and o.name = 'FK_tb_projeto_revenda_tb_vincSeguranca')
alter table dbo.tb_projeto_revenda
   drop constraint FK_tb_projeto_revenda_tb_vincSeguranca
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_subgrupo') and o.name = 'FK_tb_subgrupo_tb_cc')
alter table dbo.tb_subgrupo
   drop constraint FK_tb_subgrupo_tb_cc
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_subgrupo_revenda') and o.name = 'FK_tb_subgrupo_revenda_tb_revenda')
alter table dbo.tb_subgrupo_revenda
   drop constraint FK_tb_subgrupo_revenda_tb_revenda
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.tb_subgrupo_revenda') and o.name = 'FK_tb_subgrupo_revenda_tb_subgrupo')
alter table dbo.tb_subgrupo_revenda
   drop constraint FK_tb_subgrupo_revenda_tb_subgrupo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_cad_cli')
            and   type = 'U')
   drop table dbo.tb_cad_cli
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_cc')
            and   type = 'U')
   drop table dbo.tb_cc
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_cc_revenda')
            and   type = 'U')
   drop table dbo.tb_cc_revenda
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_projeto')
            and   type = 'U')
   drop table dbo.tb_projeto
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_projeto_revenda')
            and   type = 'U')
   drop table dbo.tb_projeto_revenda
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_revenda')
            and   type = 'U')
   drop table dbo.tb_revenda
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_subgrupo')
            and   type = 'U')
   drop table dbo.tb_subgrupo
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_subgrupo_revenda')
            and   type = 'U')
   drop table dbo.tb_subgrupo_revenda
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_usr')
            and   type = 'U')
   drop table dbo.tb_usr
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.tb_vincSeguranca')
            and   type = 'U')
   drop table dbo.tb_vincSeguranca
go

/*==============================================================*/
/* Table: tb_cad_cli                                            */
/*==============================================================*/
create table dbo.tb_cad_cli (
   cd_codigoExtendido   varchar(6)           collate Latin1_General_CI_AI null,
   cd_bacCode           int                  null,
   nu_cnpj              varchar(15)          collate Latin1_General_CI_AI null,
   nu_ie                varchar(20)          collate Latin1_General_CI_AI null,
   nm_razaoSocial       varchar(500)         collate Latin1_General_CI_AI null,
   nm_nomeFantasia      varchar(500)         collate Latin1_General_CI_AI null,
   nm_grupo             varchar(125)         collate Latin1_General_CI_AI null,
   cd_canal             varchar(10)          collate Latin1_General_CI_AI null,
   cd_matriz            varchar(6)           collate Latin1_General_CI_AI null,
   nm_endereco          varchar(255)         collate Latin1_General_CI_AI null,
   nm_bairro            varchar(255)         collate Latin1_General_CI_AI null,
   nm_cidade            varchar(255)         collate Latin1_General_CI_AI null,
   uf                   varchar(2)           collate Latin1_General_CI_AI null,
   nu_cep               varchar(255)         collate Latin1_General_CI_AI null,
   nu_fone              varchar(255)         collate Latin1_General_CI_AI null,
   nu_fax               varchar(255)         collate Latin1_General_CI_AI null,
   email                varchar(255)         collate Latin1_General_CI_AI null,
   cd_municipio         int                  null,
   nm_areaOperacional   varchar(255)         collate Latin1_General_CI_AI null,
   cd_distrito          int                  null,
   cd_regiao            int                  null,
   nm_divisao           varchar(255)         collate Latin1_General_CI_AI null,
   dt_nomeacao          datetime             null,
   dt_cancelamento      datetime             null,
   nm_operador          varchar(255)         collate Latin1_General_CI_AI null,
   nu_foneOperador      varchar(255)         collate Latin1_General_CI_AI null,
   emailOperador        varchar(255)         collate Latin1_General_CI_AI null,
   status_sigaCertificada char(2)              collate Latin1_General_CI_AI null,
   status_showRoomServico char(2)              collate Latin1_General_CI_AI null,
   status_corporateDealer char(2)              collate Latin1_General_CI_AI null,
   status_distribuidorDeBaterias char(2)              collate Latin1_General_CI_AI null,
   status_unidadeDeServico varchar(255)         collate Latin1_General_CI_AI null,
   nu_grupoDeServico    int                  null,
   nu_grupoDeVendas     int                  null,
   desc_Complemento     varchar(255)         collate Latin1_General_CI_AI null,
   nu_foneAdicional     varchar(255)         collate Latin1_General_CI_AI null,
   cd_tipoDescricaoDealer varchar(10)          collate Latin1_General_CI_AI null,
   id_audit_usuario     int                  not null constraint DF_tb_revenda_id_audit_usuario default (0),
   dt_audit_create      datetime             not null constraint DF__tb_revend__dt_au__37A5467C default getdate(),
   dt_audit_alter       datetime             not null constraint DF_tb_revenda_dt_audit_alter default getdate(),
   status_ativo         bit                  not null constraint DF__tb_revend__statu__398D8EEE default (0)
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_cc                                                 */
/*==============================================================*/
create table dbo.tb_cc (
   id_cc                int                  identity(1, 1),
   nm_cc                varchar(255)         collate Latin1_General_CI_AI not null,
   id_revenda_matriz    int                  not null,
   id_audit_usuario     int                  not null,
   dt_audit_create      datetime             not null constraint DF__tb_cc__dt_audit___30F848ED default getdate(),
   dt_audit_alter       datetime             not null,
   constraint PK_tb_cc primary key (id_cc)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_cc_revenda                                         */
/*==============================================================*/
create table dbo.tb_cc_revenda (
   id_cc_revenda        int                  not null,
   id_cc                int                  not null,
   id_revenda           int                  not null,
   id_audit_usuario     int                  not null,
   dt_audit_create      datetime             not null constraint DF__tb_cc_rev__dt_au__31EC6D26 default getdate(),
   dt_audit_alter       datetime             not null,
   status_ativo         bit                  not null constraint DF_tb_cc_revenda_status_ativo default (0),
   constraint PK_tb_cc_revenda primary key (id_cc_revenda)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_projeto                                            */
/*==============================================================*/
create table dbo.tb_projeto (
   id_projeto           int                  identity(1, 1),
   desc_projeto         varchar(255)         collate Latin1_General_CI_AI not null,
   cd_projeto954        varchar(50)          collate Latin1_General_CI_AI not null,
   id_audit_usuario     int                  not null,
   dt_audit_create      datetime             not null constraint DF__tb_projet__dt_au__33D4B598 default getdate(),
   dt_audit_alter       datetime             not null,
   constraint PK_tb_projeto primary key (id_projeto)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_projeto_revenda                                    */
/*==============================================================*/
create table dbo.tb_projeto_revenda (
   id_projeto_revenda   int                  not null,
   id_projeto           int                  not null,
   id_revenda           int                  not null,
   id_audit_usuario     int                  not null,
   dt_audit_create      datetime             not null constraint DF__tb_projet__dt_au__34C8D9D1 default getdate(),
   dt_audit_alter       datetime             not null,
   status_ativo         bit                  not null constraint DF_tb_projeto_revenda_status_ativo default (0),
   constraint PK_tb_projeto_revenda primary key (id_projeto_revenda)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_revenda                                            */
/*==============================================================*/
create table dbo.tb_revenda (
   id_revenda           int                  identity(1, 1),
   cd_codigoExtendido   varchar(6)           collate Latin1_General_CI_AI null,
   cd_bacCode           int                  null,
   nu_cnpj              varchar(15)          collate Latin1_General_CI_AI null,
   nu_ie                varchar(20)          collate Latin1_General_CI_AI null,
   nm_razaoSocial       varchar(500)         collate Latin1_General_CI_AI null,
   nm_nomeFantasia      varchar(500)         collate Latin1_General_CI_AI null,
   nm_grupo             varchar(125)         collate Latin1_General_CI_AI null,
   cd_canal             varchar(10)          collate Latin1_General_CI_AI null,
   cd_matriz            varchar(6)           collate Latin1_General_CI_AI null,
   nm_endereco          varchar(255)         collate Latin1_General_CI_AI null,
   nm_bairro            varchar(255)         collate Latin1_General_CI_AI null,
   nm_cidade            varchar(255)         collate Latin1_General_CI_AI null,
   uf                   varchar(2)           collate Latin1_General_CI_AI null,
   nu_cep               varchar(255)         collate Latin1_General_CI_AI null,
   nu_fone              varchar(255)         collate Latin1_General_CI_AI null,
   nu_fax               varchar(255)         collate Latin1_General_CI_AI null,
   email                varchar(255)         collate Latin1_General_CI_AI null,
   cd_municipio         int                  null,
   nm_areaOperacional   varchar(255)         collate Latin1_General_CI_AI null,
   cd_distrito          int                  null,
   cd_regiao            int                  null,
   nm_divisao           varchar(255)         collate Latin1_General_CI_AI null,
   dt_nomeacao          datetime             null,
   dt_cancelamento      datetime             null,
   nm_operador          varchar(255)         collate Latin1_General_CI_AI null,
   nu_foneOperador      varchar(255)         collate Latin1_General_CI_AI null,
   emailOperador        varchar(255)         collate Latin1_General_CI_AI null,
   status_sigaCertificada char(2)              collate Latin1_General_CI_AI null,
   status_showRoomServico char(2)              collate Latin1_General_CI_AI null,
   status_corporateDealer char(2)              collate Latin1_General_CI_AI null,
   status_distribuidorDeBaterias char(2)              collate Latin1_General_CI_AI null,
   status_unidadeDeServico varchar(255)         collate Latin1_General_CI_AI null,
   nu_grupoDeServico    int                  null,
   nu_grupoDeVendas     int                  null,
   desc_Complemento     varchar(255)         collate Latin1_General_CI_AI null,
   nu_foneAdicional     varchar(255)         collate Latin1_General_CI_AI null,
   cd_tipoDescricaoDealer varchar(10)          collate Latin1_General_CI_AI null,
   id_audit_usuario     int                  not null constraint DF_tb_revenda_id_audit_usuario default (0),
   dt_audit_create      datetime             not null constraint DF__tb_revend__dt_au__37A5467C default getdate(),
   dt_audit_alter       datetime             not null constraint DF_tb_revenda_dt_audit_alter default getdate(),
   status_ativo         bit                  not null constraint DF__tb_revend__statu__398D8EEE default (0),
   constraint PK_tb_revenda primary key (id_revenda)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_subgrupo                                           */
/*==============================================================*/
create table dbo.tb_subgrupo (
   id_subgrupo          int                  not null,
   id_cc                int                  not null,
   desc_subgrupo        varchar(255)         collate Latin1_General_CI_AI not null,
   id_audit_usuario     int                  not null,
   dt_audit_create      datetime             not null constraint DF__tb_subgru__dt_au__3A81B327 default getdate(),
   dt_audit_alter       datetime             not null,
   constraint PK_tb_subgrupo primary key (id_subgrupo)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_subgrupo_revenda                                   */
/*==============================================================*/
create table dbo.tb_subgrupo_revenda (
   id_subgrupo_revenda  int                  not null,
   id_subgrupo          int                  not null,
   id_revenda           int                  not null,
   id_audit_usuario     int                  not null,
   dt_audit_create      datetime             not null constraint DF__tb_subgru__dt_au__3B75D760 default getdate(),
   dt_audit_alter       datetime             not null,
   status_ativo         bit                  not null constraint DF_tb_subgrupo_revenda_status_ativo default (0),
   constraint PK_tb_subgrupo_revenda primary key (id_subgrupo_revenda)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_usr                                                */
/*==============================================================*/
create table dbo.tb_usr (
   id_usr               int                  identity(1, 1),
   nm_usr               varchar(255)         collate Latin1_General_CI_AI not null,
   status_usuario       int                  not null constraint DF_tb_usr_status_usuario default (0),
   id_audit_usuario     int                  not null constraint DF_tb_usr_id_audit_usuario default (0),
   dt_audit_create      datetime             not null constraint DF_tb_usr_dt_audit_create default getdate(),
   dt_audit_alter       datetime             not null constraint DF_tb_usr_dt_audit_alter default getdate(),
   constraint PK_tb_usr primary key (id_usr)
         on "PRIMARY"
)
on "PRIMARY"
go

/*==============================================================*/
/* Table: tb_vincSeguranca                                      */
/*==============================================================*/
create table dbo.tb_vincSeguranca (
   id_vincSeguraca      int                  identity(1, 1),
   id_usuario           int                  not null,
   id_revenda           int                  not null,
   id_audit_usuario     int                  not null,
   dt_audit_create      datetime             not null,
   dt_audit_alter       datetime             not null,
   status_ativo         bit                  not null,
   constraint PK_tb_vincSeguranca primary key (id_vincSeguraca)
         on "PRIMARY"
)
on "PRIMARY"
go

alter table dbo.tb_cc_revenda
   add constraint FK_tb_cc_revenda_tb_cc foreign key (id_cc)
      references dbo.tb_cc (id_cc)
go

alter table dbo.tb_cc_revenda
   add constraint FK_tb_cc_revenda_tb_revenda foreign key (id_revenda)
      references dbo.tb_revenda (id_revenda)
go

alter table dbo.tb_cc_revenda
   add constraint FK_tb_cc_revenda_tb_vincSeguranca foreign key (id_revenda)
      references dbo.tb_vincSeguranca (id_vincSeguraca)
go

alter table dbo.tb_projeto_revenda
   add constraint FK_tb_projeto_revenda_tb_projeto foreign key (id_projeto)
      references dbo.tb_projeto (id_projeto)
go

alter table dbo.tb_projeto_revenda
   add constraint FK_tb_projeto_revenda_tb_revenda foreign key (id_revenda)
      references dbo.tb_revenda (id_revenda)
go

alter table dbo.tb_projeto_revenda
   add constraint FK_tb_projeto_revenda_tb_vincSeguranca foreign key (id_revenda)
      references dbo.tb_vincSeguranca (id_vincSeguraca)
go

alter table dbo.tb_subgrupo
   add constraint FK_tb_subgrupo_tb_cc foreign key (id_cc)
      references dbo.tb_cc (id_cc)
go

alter table dbo.tb_subgrupo_revenda
   add constraint FK_tb_subgrupo_revenda_tb_revenda foreign key (id_revenda)
      references dbo.tb_revenda (id_revenda)
go

alter table dbo.tb_subgrupo_revenda
   add constraint FK_tb_subgrupo_revenda_tb_subgrupo foreign key (id_subgrupo)
      references dbo.tb_subgrupo (id_subgrupo)
go

