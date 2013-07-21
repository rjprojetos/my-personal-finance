/*==============================================================*/
/* Database name:  ODS_PERSONAL_FINANCE                         */
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     21/07/2013 00:24:46                          */
/*==============================================================*/


USE ODS_PERSONAL_FINANCE
go

IF EXISTS (SELECT 1
            FROM  SYSOBJECTS
           WHERE  ID = OBJECT_ID('TB_IMPORTA')
            AND   TYPE = 'U')
   DROP TABLE TB_IMPORTA
go

/*==============================================================*/
/* Table: TB_IMPORTA                                            */
/*==============================================================*/
CREATE TABLE TB_IMPORTA (
   ARQUIVOPATH          VARCHAR(255)         NULL,
   ARQUIVONOME          VARCHAR(50)          NULL,
   ARQUIVOEXTENSAO      VARCHAR(5)           NULL,
   ARQUIVODATACRIACAO   DATETIME             NULL,
   ARQUIVODATACARGA     DATETIME             NULL,
   DATAOCORRENCIA       DATETIME             NULL,
   DESCRICAO            VARCHAR(255)         NULL,
   VALOR                DECIMAL(7,2)         NULL,
   CATEGORIA            VARCHAR(255)         NULL,
   CONTA                VARCHAR(255)         NULL
)
go

