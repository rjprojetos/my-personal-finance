/*==============================================================*/
/* Database name:  ODS_PERSONAL_FINANCE                         */
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     20/07/2013 18:34:04                          */
/*==============================================================*/


DROP DATABASE ODS_PERSONAL_FINANCE
go

/*==============================================================*/
/* Database: ODS_PERSONAL_FINANCE                               */
/*==============================================================*/
CREATE DATABASE ODS_PERSONAL_FINANCE
COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI
go

USE ODS_PERSONAL_FINANCE
go

/*==============================================================*/
/* Table: TBIMPORTA                                             */
/*==============================================================*/
CREATE TABLE TBIMPORTA (
   LINHA                INT                  IDENTITY(1,1),
   ARQUIVONOME          VARCHAR(100)         NOT NULL,
   ARQUIVOEXTENSAO      VARCHAR(5)           NOT NULL,
   ARQUIVODATACRIACAO   DATETIME             NOT NULL,
   ARQUIVODATACARGA     DATETIME             NOT NULL,
   DATAOCORRENCIA       VARCHAR(10)          NOT NULL,
   DESCRICAO            VARCHAR(50)          NOT NULL,
   VALOR                DECIMAL(7,3)         NOT NULL,
   CATEGORIA            VARCHAR(50)          NOT NULL,
   CONTA                VARCHAR(50)          NOT NULL
)
go

