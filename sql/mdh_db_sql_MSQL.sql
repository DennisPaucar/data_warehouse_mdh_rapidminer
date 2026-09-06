/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2016                    */
/* Created on:     13/5/2026 1:34:42                            */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FACT_CREDITO') and o.name = 'FK_FACT_CRE_RELATIONS_DIM_ACTI')
alter table FACT_CREDITO
   drop constraint FK_FACT_CRE_RELATIONS_DIM_ACTI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FACT_CREDITO') and o.name = 'FK_FACT_CRE_RELATIONS_DIM_BENE')
alter table FACT_CREDITO
   drop constraint FK_FACT_CRE_RELATIONS_DIM_BENE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FACT_CREDITO') and o.name = 'FK_FACT_CRE_RELATIONS_DIM_SUBS')
alter table FACT_CREDITO
   drop constraint FK_FACT_CRE_RELATIONS_DIM_SUBS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FACT_CREDITO') and o.name = 'FK_FACT_CRE_RELATIONS_DIM_TIEM')
alter table FACT_CREDITO
   drop constraint FK_FACT_CRE_RELATIONS_DIM_TIEM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FACT_CREDITO') and o.name = 'FK_FACT_CRE_RELATIONS_DIM_UBIC')
alter table FACT_CREDITO
   drop constraint FK_FACT_CRE_RELATIONS_DIM_UBIC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_ACTIVIDAD')
            and   type = 'U')
   drop table DIM_ACTIVIDAD
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_BENEFICIARIO')
            and   type = 'U')
   drop table DIM_BENEFICIARIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_SUBSIDIO')
            and   type = 'U')
   drop table DIM_SUBSIDIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_TIEMPO')
            and   type = 'U')
   drop table DIM_TIEMPO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_UBICACION')
            and   type = 'U')
   drop table DIM_UBICACION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FACT_CREDITO')
            and   name  = 'RELATIONSHIP_6_FK'
            and   indid > 0
            and   indid < 255)
   drop index FACT_CREDITO.RELATIONSHIP_6_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FACT_CREDITO')
            and   name  = 'RELATIONSHIP_5_FK'
            and   indid > 0
            and   indid < 255)
   drop index FACT_CREDITO.RELATIONSHIP_5_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FACT_CREDITO')
            and   name  = 'RELATIONSHIP_4_FK'
            and   indid > 0
            and   indid < 255)
   drop index FACT_CREDITO.RELATIONSHIP_4_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FACT_CREDITO')
            and   name  = 'RELATIONSHIP_3_FK'
            and   indid > 0
            and   indid < 255)
   drop index FACT_CREDITO.RELATIONSHIP_3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FACT_CREDITO')
            and   name  = 'RELATIONSHIP_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index FACT_CREDITO.RELATIONSHIP_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FACT_CREDITO')
            and   type = 'U')
   drop table FACT_CREDITO
go

/*==============================================================*/
/* Table: DIM_ACTIVIDAD                                         */
/*==============================================================*/
create table DIM_ACTIVIDAD (
   CODIGO_ACTIVIDAD     int                  not null,
   NOMBRE_ACTIVIDAD     varchar(128)         not null,
   TIPO_ACTIVIDAD       varchar(128)         not null,
   constraint PK_DIM_ACTIVIDAD primary key nonclustered (CODIGO_ACTIVIDAD)
)
go

/*==============================================================*/
/* Table: DIM_BENEFICIARIO                                      */
/*==============================================================*/
create table DIM_BENEFICIARIO (
   CODIGO_BENIEFICIARIO int                  not null,
   GENERO               varchar(9)           not null,
   EDAD                 int                  not null,
   ETNIA                varchar(48)          not null,
   constraint PK_DIM_BENEFICIARIO primary key nonclustered (CODIGO_BENIEFICIARIO)
)
go

/*==============================================================*/
/* Table: DIM_SUBSIDIO                                          */
/*==============================================================*/
create table DIM_SUBSIDIO (
   CODIGO_CREDITO       int                  not null,
   CLASE_CREDITO        varchar(48)          not null,
   TIPO_SUBSIDIO        varchar(48)          not null,
   FECHA_PRIMERA_CUOTA  datetime             not null,
   constraint PK_DIM_SUBSIDIO primary key nonclustered (CODIGO_CREDITO)
)
go

/*==============================================================*/
/* Table: DIM_TIEMPO                                            */
/*==============================================================*/
create table DIM_TIEMPO (
   CODIGO_TIEMPO        int                  not null,
   FECHA_ANIO           int                  not null,
   constraint PK_DIM_TIEMPO primary key nonclustered (CODIGO_TIEMPO)
)
go

/*==============================================================*/
/* Table: DIM_UBICACION                                         */
/*==============================================================*/
create table DIM_UBICACION (
   CODIGO_UBICACION     int                  not null,
   ZONA                 varchar(48)          null,
   DISTRITO_MIES        varchar(128)         not null,
   PROVINCIA            varchar(48)          not null,
   CANTON               varchar(48)          not null,
   PARROQUIA            varchar(48)          not null,
   TIPO_ZONA            varchar(6)           not null,
   REGION               varchar(6)           not null,
   constraint PK_DIM_UBICACION primary key nonclustered (CODIGO_UBICACION)
)
go

/*==============================================================*/
/* Table: FACT_CREDITO                                          */
/*==============================================================*/
create table FACT_CREDITO (
   CODIGO_FACT_CREDITO  int                  not null,
   CODIGO_TIEMPO        int                  null,
   CODIGO_ACTIVIDAD     int                  null,
   CODIGO_UBICACION     int                  null,
   CODIGO_CREDITO       int                  null,
   CODIGO_BENIEFICIARIO int                  null,
   CUOTAS_CANCELADAS2   int                  not null,
   NUMERO_CUOTAS        int                  not null,
   NUMERO_CDH           int                  not null,
   CANTIDAD_REGISTROS   int                  not null,
   constraint PK_FACT_CREDITO primary key nonclustered (CODIGO_FACT_CREDITO)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/




create nonclustered index RELATIONSHIP_1_FK on FACT_CREDITO (CODIGO_TIEMPO ASC)
go

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/




create nonclustered index RELATIONSHIP_3_FK on FACT_CREDITO (CODIGO_ACTIVIDAD ASC)
go

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/




create nonclustered index RELATIONSHIP_4_FK on FACT_CREDITO (CODIGO_UBICACION ASC)
go

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/




create nonclustered index RELATIONSHIP_5_FK on FACT_CREDITO (CODIGO_CREDITO ASC)
go

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/




create nonclustered index RELATIONSHIP_6_FK on FACT_CREDITO (CODIGO_BENIEFICIARIO ASC)
go

alter table FACT_CREDITO
   add constraint FK_FACT_CRE_RELATIONS_DIM_ACTI foreign key (CODIGO_ACTIVIDAD)
      references DIM_ACTIVIDAD (CODIGO_ACTIVIDAD)
go

alter table FACT_CREDITO
   add constraint FK_FACT_CRE_RELATIONS_DIM_BENE foreign key (CODIGO_BENIEFICIARIO)
      references DIM_BENEFICIARIO (CODIGO_BENIEFICIARIO)
go

alter table FACT_CREDITO
   add constraint FK_FACT_CRE_RELATIONS_DIM_SUBS foreign key (CODIGO_CREDITO)
      references DIM_SUBSIDIO (CODIGO_CREDITO)
go

alter table FACT_CREDITO
   add constraint FK_FACT_CRE_RELATIONS_DIM_TIEM foreign key (CODIGO_TIEMPO)
      references DIM_TIEMPO (CODIGO_TIEMPO)
go

alter table FACT_CREDITO
   add constraint FK_FACT_CRE_RELATIONS_DIM_UBIC foreign key (CODIGO_UBICACION)
      references DIM_UBICACION (CODIGO_UBICACION)
go

