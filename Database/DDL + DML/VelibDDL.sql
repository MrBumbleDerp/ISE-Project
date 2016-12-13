/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     12/12/2016 13:40:49                          */
/*==============================================================*/

USE master
IF EXISTS(select * from sys.databases where name='VelibDB')
DROP DATABASE VelibDB
GO
CREATE DATABASE VelibDB
GO
USE VelibDB
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BIKE') and o.name = 'FK_BIKE_RT_BIKE_E_EMPLOYEE')
alter table BIKE
   drop constraint FK_BIKE_RT_BIKE_E_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BIKE') and o.name = 'FK_BIKE_RT_BIKE_W_WORKSHOP')
alter table BIKE
   drop constraint FK_BIKE_RT_BIKE_W_WORKSHOP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('EMPLOYEE') and o.name = 'FK_EMPLOYEE_RT_EMPLOY_WORKSHOP')
alter table EMPLOYEE
   drop constraint FK_EMPLOYEE_RT_EMPLOY_WORKSHOP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('INVOICE') and o.name = 'FK_INVOICE_RT_INVOIC_USER')
alter table INVOICE
   drop constraint FK_INVOICE_RT_INVOIC_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDEREDPARTS') and o.name = 'FK_ORDEREDP_RT_SUPPLI_SUPPLIER')
alter table ORDEREDPARTS
   drop constraint FK_ORDEREDP_RT_SUPPLI_SUPPLIER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDEREDPARTS') and o.name = 'FK_RT_SUPPL_RT_SUPPLI_SUPPLIER2')
alter table ORDEREDPARTS
   drop constraint FK_RT_SUPPL_RT_SUPPLI_SUPPLIER2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PARTS_IN_WORKSHOP') and o.name = 'FK_PARTS_IN_RT_PART_P_PART')
alter table PARTS_IN_WORKSHOP
   drop constraint FK_PARTS_IN_RT_PART_P_PART
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PARTS_IN_WORKSHOP') and o.name = 'FK_PARTS_IN_WORKSHOP_WORKSHOP')
alter table PARTS_IN_WORKSHOP
   drop constraint FK_PARTS_IN_WORKSHOP_WORKSHOP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PARTS_IN_WORKSHOPORDER') and o.name = 'FK_PARTS_IN_RT_WORKSH_PART')
alter table PARTS_IN_WORKSHOPORDER
   drop constraint FK_PARTS_IN_RT_WORKSH_PART
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PARTS_IN_WORKSHOPORDER') and o.name = 'FK_PARTS_IN_WORKSHOP_WORKSHOPORDER')
alter table PARTS_IN_WORKSHOPORDER
   drop constraint FK_PARTS_IN_WORKSHOP_WORKSHOPORDER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('POST') and o.name = 'FK_POST_RT_POST_B_BIKE')
alter table POST
   drop constraint FK_POST_RT_POST_B_BIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('POST') and o.name = 'FK_POST_RT_POST_S_STATION')
alter table POST
   drop constraint FK_POST_RT_POST_S_STATION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RENTAL') and o.name = 'FK_RENTAL_RT_RENTAL_BEGINSTATION')
alter table RENTAL
   drop constraint FK_RENTAL_RT_RENTAL_BEGINSTATION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RENTAL') and o.name = 'FK_RENTAL_RT_RENTAL_BIKE')
alter table RENTAL
   drop constraint FK_RENTAL_RT_RENTAL_BIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RENTAL') and o.name = 'FK_RENTAL_RT_RENTAL_ENDSTATION')
alter table RENTAL
   drop constraint FK_RENTAL_RT_RENTAL_ENDSTATION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RENTAL') and o.name = 'FK_RENTAL_RT_RENTAL_INVOICE')
alter table RENTAL
   drop constraint FK_RENTAL_RT_RENTAL_INVOICE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RENTAL') and o.name = 'FK_RENTAL_RT_RENTAL_USER')
alter table RENTAL
   drop constraint FK_RENTAL_RT_RENTAL_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REPAIRLOG') and o.name = 'FK_REPAIRLO_RT_REPAIR_BIKE')
alter table REPAIRLOG
   drop constraint FK_REPAIRLO_RT_REPAIR_BIKE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REPAIRLOG') and o.name = 'FK_REPAIRLO_RT_REPAIR_EMPLOYEE')
alter table REPAIRLOG
   drop constraint FK_REPAIRLO_RT_REPAIR_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('REPAIRLOG') and o.name = 'FK_REPAIRLO_RT_REPAIR_REPAIRLO')
alter table REPAIRLOG
   drop constraint FK_REPAIRLO_RT_REPAIR_REPAIRLO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RT_ORDEREDPARTS_PART') and o.name = 'FK_RT_ORDER_RT_ORDERE_PART')
alter table RT_ORDEREDPARTS_PART
   drop constraint FK_RT_ORDER_RT_ORDERE_PART
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RT_ORDEREDPARTS_PART') and o.name = 'FK_RT_ORDER_RT_ORDERE_ORDEREDP')
alter table RT_ORDEREDPARTS_PART
   drop constraint FK_RT_ORDER_RT_ORDERE_ORDEREDP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RT_PARTSINWORKSHOP_REPAIRLOG') and o.name = 'FK_RT_PARTS_RT_PARTSI_REPAIRLO')
alter table RT_PARTSINWORKSHOP_REPAIRLOG
   drop constraint FK_RT_PARTS_RT_PARTSI_REPAIRLO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RT_PARTSINWORKSHOP_REPAIRLOG') and o.name = 'FK_RT_PARTS_RT_PARTSI_PARTS_IN')
alter table RT_PARTSINWORKSHOP_REPAIRLOG
   drop constraint FK_RT_PARTS_RT_PARTSI_PARTS_IN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SUPPLIERORDER') and o.name = 'FK_SUPPLIER_RT_SUPPLI_EMPLOYEE')
alter table SUPPLIERORDER
   drop constraint FK_SUPPLIER_RT_SUPPLI_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('"USER"') and o.name = 'FK_USER_RT_USER_S_SUBSCRIP')
alter table "USER"
   drop constraint FK_USER_RT_USER_S_SUBSCRIP
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WORKSHOP') and o.name = 'FK_WORKSHOP_RT_MANAGE_EMPLOYEE')
alter table WORKSHOP
   drop constraint FK_WORKSHOP_RT_MANAGE_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WORKSHOPORDER') and o.name = 'FK_WORKSHOP_RT_WORKSH_SUPPLIER')
alter table WORKSHOPORDER
   drop constraint FK_WORKSHOP_RT_WORKSH_SUPPLIER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('WORKSHOPORDER') and o.name = 'FK_WORKSHOP_RT_WORKSH_WORKSHOP')
alter table WORKSHOPORDER
   drop constraint FK_WORKSHOP_RT_WORKSH_WORKSHOP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BIKE')
            and   name  = 'RT_BIKE_WORKSHOP_FK'
            and   indid > 0
            and   indid < 255)
   drop index BIKE.RT_BIKE_WORKSHOP_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BIKE')
            and   type = 'U')
   drop table BIKE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('EMPLOYEE')
            and   name  = 'RT_EMPLOYEE_WORKSHOP_FK'
            and   indid > 0
            and   indid < 255)
   drop index EMPLOYEE.RT_EMPLOYEE_WORKSHOP_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EMPLOYEE')
            and   type = 'U')
   drop table EMPLOYEE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('INVOICE')
            and   name  = 'RT_INVOICE_USER_FK'
            and   indid > 0
            and   indid < 255)
   drop index INVOICE.RT_INVOICE_USER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('INVOICE')
            and   type = 'U')
   drop table INVOICE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ORDEREDPARTS')
            and   name  = 'RT_SUPPLIERORDER_SUPPLIER2_FK'
            and   indid > 0
            and   indid < 255)
   drop index ORDEREDPARTS.RT_SUPPLIERORDER_SUPPLIER2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ORDEREDPARTS')
            and   name  = 'RT_SUPPLIERORDER_SUPPLIER3_FK'
            and   indid > 0
            and   indid < 255)
   drop index ORDEREDPARTS.RT_SUPPLIERORDER_SUPPLIER3_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ORDEREDPARTS')
            and   type = 'U')
   drop table ORDEREDPARTS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PART')
            and   type = 'U')
   drop table PART
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PARTS_IN_WORKSHOP')
            and   name  = 'RT_PART_PARTSINWORKSHOP_FK'
            and   indid > 0
            and   indid < 255)
   drop index PARTS_IN_WORKSHOP.RT_PART_PARTSINWORKSHOP_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PARTS_IN_WORKSHOP')
            and   name  = 'RT_WORKSHOP_PARTSINWORKSHOP_FK'
            and   indid > 0
            and   indid < 255)
   drop index PARTS_IN_WORKSHOP.RT_WORKSHOP_PARTSINWORKSHOP_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PARTS_IN_WORKSHOP')
            and   type = 'U')
   drop table PARTS_IN_WORKSHOP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PARTS_IN_WORKSHOPORDER')
            and   name  = 'RT_WORKSHOPORDER_PART3_FK'
            and   indid > 0
            and   indid < 255)
   drop index PARTS_IN_WORKSHOPORDER.RT_WORKSHOPORDER_PART3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PARTS_IN_WORKSHOPORDER')
            and   name  = 'RT_WORKSHOPORDER_PART4_FK'
            and   indid > 0
            and   indid < 255)
   drop index PARTS_IN_WORKSHOPORDER.RT_WORKSHOPORDER_PART4_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PARTS_IN_WORKSHOPORDER')
            and   type = 'U')
   drop table PARTS_IN_WORKSHOPORDER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('POST')
            and   type = 'U')
   drop table POST
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RENTAL')
            and   name  = 'RT_RENTAL_ENDSTATION_FK'
            and   indid > 0
            and   indid < 255)
   drop index RENTAL.RT_RENTAL_ENDSTATION_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RENTAL')
            and   name  = 'RT_RENTAL_BEGINSTATION_FK'
            and   indid > 0
            and   indid < 255)
   drop index RENTAL.RT_RENTAL_BEGINSTATION_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RENTAL')
            and   name  = 'RT_RENTAL_USER_FK'
            and   indid > 0
            and   indid < 255)
   drop index RENTAL.RT_RENTAL_USER_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RENTAL')
            and   name  = 'RT_RENTAL_BIKE_FK'
            and   indid > 0
            and   indid < 255)
   drop index RENTAL.RT_RENTAL_BIKE_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RENTAL')
            and   name  = 'RT_RENTAL_INVOICE_FK'
            and   indid > 0
            and   indid < 255)
   drop index RENTAL.RT_RENTAL_INVOICE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RENTAL')
            and   type = 'U')
   drop table RENTAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RENTALPRICE')
            and   type = 'U')
   drop table RENTALPRICE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REPAIRLOG')
            and   name  = 'RT_REPAIRLOG_REPAIRLOG_FK'
            and   indid > 0
            and   indid < 255)
   drop index REPAIRLOG.RT_REPAIRLOG_REPAIRLOG_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REPAIRLOG')
            and   name  = 'RT_REPAIRLOG_BIKE_FK'
            and   indid > 0
            and   indid < 255)
   drop index REPAIRLOG.RT_REPAIRLOG_BIKE_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('REPAIRLOG')
            and   name  = 'RT_REPAIRLOG_EMPLOYEE_FK'
            and   indid > 0
            and   indid < 255)
   drop index REPAIRLOG.RT_REPAIRLOG_EMPLOYEE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('REPAIRLOG')
            and   type = 'U')
   drop table REPAIRLOG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RT_ORDEREDPARTS_PART')
            and   name  = 'RT_ORDEREDPARTS_PART2_FK'
            and   indid > 0
            and   indid < 255)
   drop index RT_ORDEREDPARTS_PART.RT_ORDEREDPARTS_PART2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RT_ORDEREDPARTS_PART')
            and   name  = 'RT_ORDEREDPARTS_PART_FK'
            and   indid > 0
            and   indid < 255)
   drop index RT_ORDEREDPARTS_PART.RT_ORDEREDPARTS_PART_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RT_ORDEREDPARTS_PART')
            and   type = 'U')
   drop table RT_ORDEREDPARTS_PART
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RT_PARTSINWORKSHOP_REPAIRLOG')
            and   name  = 'RT_PARTSINWORKSHOP_REPAIRLOG2_FK'
            and   indid > 0
            and   indid < 255)
   drop index RT_PARTSINWORKSHOP_REPAIRLOG.RT_PARTSINWORKSHOP_REPAIRLOG2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RT_PARTSINWORKSHOP_REPAIRLOG')
            and   name  = 'RT_PARTSINWORKSHOP_REPAIRLOG_FK'
            and   indid > 0
            and   indid < 255)
   drop index RT_PARTSINWORKSHOP_REPAIRLOG.RT_PARTSINWORKSHOP_REPAIRLOG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RT_PARTSINWORKSHOP_REPAIRLOG')
            and   type = 'U')
   drop table RT_PARTSINWORKSHOP_REPAIRLOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('STATION')
            and   type = 'U')
   drop table STATION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SUBSCRIPTION')
            and   type = 'U')
   drop table SUBSCRIPTION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SUPPLIER')
            and   type = 'U')
   drop table SUPPLIER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SUPPLIERORDER')
            and   name  = 'RT_SUPPLIERORDER_EMPLOYEE_FK'
            and   indid > 0
            and   indid < 255)
   drop index SUPPLIERORDER.RT_SUPPLIERORDER_EMPLOYEE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SUPPLIERORDER')
            and   type = 'U')
   drop table SUPPLIERORDER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('"USER"')
            and   name  = 'RT_USER_SUBSCRIPTION_FK'
            and   indid > 0
            and   indid < 255)
   drop index "USER".RT_USER_SUBSCRIPTION_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"USER"')
            and   type = 'U')
   drop table "USER"
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WORKSHOP')
            and   type = 'U')
   drop table WORKSHOP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('WORKSHOPORDER')
            and   name  = 'RT_WORKSHOPORDER_SUPPLIERORDER_FK'
            and   indid > 0
            and   indid < 255)
   drop index WORKSHOPORDER.RT_WORKSHOPORDER_SUPPLIERORDER_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('WORKSHOPORDER')
            and   name  = 'RT_WORKSHOP_WORKSHOPORDER_FK'
            and   indid > 0
            and   indid < 255)
   drop index WORKSHOPORDER.RT_WORKSHOP_WORKSHOPORDER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WORKSHOPORDER')
            and   type = 'U')
   drop table WORKSHOPORDER
go

if exists(select 1 from systypes where name='ADDRESS')
   drop type ADDRESS
go

if exists(select 1 from systypes where name='CASHMONEY')
   drop type CASHMONEY
go

if exists(select 1 from systypes where name='CREDITCARD')
   drop type CREDITCARD
go

if exists(select 1 from systypes where name='EMAIL')
   drop type EMAIL
go

if exists(select 1 from systypes where name='FUNCTIONEMPLOYEE')
   execute sp_unbindrule FUNCTIONEMPLOYEE
go

if exists(select 1 from systypes where name='FUNCTIONEMPLOYEE')
   drop type FUNCTIONEMPLOYEE
go

if exists(select 1 from systypes where name='IDENTIFIER')
   drop type IDENTIFIER
go

if exists(select 1 from systypes where name='NAME')
   drop type NAME
go

if exists(select 1 from systypes where name='PASSWORD')
   drop type PASSWORD
go

if exists(select 1 from systypes where name='PHONENUMBER')
   drop type PHONENUMBER
go

if exists(select 1 from systypes where name='TOWN')
   drop type TOWN
go

if exists(select 1 from systypes where name='TYPEBIKE')
   drop type TYPEBIKE
go

if exists(select 1 from systypes where name='TYPEREPAIR')
   execute sp_unbindrule TYPEREPAIR
go

if exists(select 1 from systypes where name='TYPEREPAIR')
   drop type TYPEREPAIR
go

if exists(select 1 from systypes where name='TYPESTATION')
   execute sp_unbindrule TYPESTATION
go

if exists(select 1 from systypes where name='TYPESTATION')
   drop type TYPESTATION
go

if exists(select 1 from systypes where name='ZIPCODE')
   drop type ZIPCODE
go

if exists (select 1 from sysobjects where id=object_id('R_FUNCTIONEMPLOYEE') and type='R')
   drop rule  R_FUNCTIONEMPLOYEE
go

if exists (select 1 from sysobjects where id=object_id('R_TYPEREPAIR') and type='R')
   drop rule  R_TYPEREPAIR
go

if exists (select 1 from sysobjects where id=object_id('R_TYPESTATION') and type='R')
   drop rule  R_TYPESTATION
go

create rule R_FUNCTIONEMPLOYEE as
      @column in ('Transporter','Technician','Marketing')
go

create rule R_TYPEREPAIR as
      @column in ('Onground','Workshop')
go

create rule R_TYPESTATION as
      @column in ('V+','Normal')
go

/*==============================================================*/
/* Domain: ADDRESS                                              */
/*==============================================================*/
create type ADDRESS
   from varchar(50)
go

/*==============================================================*/
/* Domain: CASHMONEY                                            */
/*==============================================================*/
create type CASHMONEY
   from decimal(19,4)
go

/*==============================================================*/
/* Domain: CREDITCARD                                           */
/*==============================================================*/
create type CREDITCARD
   from char(16)
go

/*==============================================================*/
/* Domain: EMAIL                                                */
/*==============================================================*/
create type EMAIL
   from varchar(50)
go

/*==============================================================*/
/* Domain: FUNCTIONEMPLOYEE                                     */
/*==============================================================*/
create type FUNCTIONEMPLOYEE
   from varchar(20)
go

execute sp_bindrule R_FUNCTIONEMPLOYEE, FUNCTIONEMPLOYEE
go

/*==============================================================*/
/* Domain: IDENTIFIER                                           */
/*==============================================================*/
create type IDENTIFIER
   from int
go

/*==============================================================*/
/* Domain: NAME                                                 */
/*==============================================================*/
create type NAME
   from varchar(50)
go

/*==============================================================*/
/* Domain: PASSWORD                                             */
/*==============================================================*/
create type PASSWORD
   from varchar(1024)
go

/*==============================================================*/
/* Domain: PHONENUMBER                                          */
/*==============================================================*/
create type PHONENUMBER
   from char(12)
go

/*==============================================================*/
/* Domain: TOWN                                                 */
/*==============================================================*/
create type TOWN
   from varchar(50)
go

/*==============================================================*/
/* Domain: TYPEBIKE                                             */
/*==============================================================*/
create type TYPEBIKE
   from varchar(20)
go

/*==============================================================*/
/* Domain: TYPEREPAIR                                           */
/*==============================================================*/
create type TYPEREPAIR
   from varchar(20)
go

execute sp_bindrule R_TYPEREPAIR, TYPEREPAIR
go

/*==============================================================*/
/* Domain: TYPESTATION                                          */
/*==============================================================*/
create type TYPESTATION
   from varchar(20)
go

execute sp_bindrule R_TYPESTATION, TYPESTATION
go

/*==============================================================*/
/* Domain: ZIPCODE                                              */
/*==============================================================*/
create type ZIPCODE
   from varchar(6)
go

/*==============================================================*/
/* Table: BIKE                                                  */
/*==============================================================*/
create table BIKE (
   BIKEID               IDENTIFIER           not null,
   EMPLOYEEID           IDENTIFIER           null,
   WORKSHOPID           IDENTIFIER           null,
   TYPE                 TYPEBIKE             not null,
   constraint PK_BIKE primary key (BIKEID)
)
go

/*==============================================================*/
/* Index: RT_BIKE_WORKSHOP_FK                                   */
/*==============================================================*/




create nonclustered index RT_BIKE_WORKSHOP_FK on BIKE (WORKSHOPID ASC)
go

/*==============================================================*/
/* Table: EMPLOYEE                                              */
/*==============================================================*/
create table EMPLOYEE (
   EMPLOYEEID           IDENTIFIER           not null,
   WORKSHOPID           IDENTIFIER           null,
   FIRSTNAME            NAME                 not null,
   LASTNAME             NAME                 not null,
   EMAIL                EMAIL                not null,
   ZIPCODE              ZIPCODE              not null,
   ADDRESS              ADDRESS              not null,
   TOWN                 TOWN                 not null,
   "FUNCTION"           FUNCTIONEMPLOYEE     not null,
   PHONENUMBER          PHONENUMBER          not null,
   constraint PK_EMPLOYEE primary key (EMPLOYEEID),
   constraint AK_AK_EMAIL_EMPLOYEE unique (EMAIL)
)
go

/*==============================================================*/
/* Index: RT_EMPLOYEE_WORKSHOP_FK                               */
/*==============================================================*/




create nonclustered index RT_EMPLOYEE_WORKSHOP_FK on EMPLOYEE (WORKSHOPID ASC)
go

/*==============================================================*/
/* Table: INVOICE                                               */
/*==============================================================*/
create table INVOICE (
   INVOICEID            IDENTIFIER           not null,
   USERID               IDENTIFIER           not null,
   DATE                 DATETIME             not null,
   TOTALPRICE           CASHMONEY            not null,
   constraint PK_INVOICE primary key (INVOICEID),
   constraint AK_AK_USERID_DATE_INVOICE unique (USERID, DATE)
)
go

/*==============================================================*/
/* Index: RT_INVOICE_USER_FK                                    */
/*==============================================================*/




create nonclustered index RT_INVOICE_USER_FK on INVOICE (USERID ASC)
go

/*==============================================================*/
/* Table: ORDEREDPARTS                                          */
/*==============================================================*/
create table ORDEREDPARTS (
   ORDEREDPARTSID       IDENTIFIER           not null,
   SUPPLIERID           IDENTIFIER           not null,
   SUPPLIERORDERID      IDENTIFIER           not null,
   PRICE                CASHMONEY            not null,
   DELIVERED            bit                  not null,
   QUANTITY             int                  not null,
   constraint PK_ORDEREDPARTS primary key (ORDEREDPARTSID),
   constraint AK_AK_SUPPLIERORDERID_ORDEREDP unique (SUPPLIERORDERID, SUPPLIERID)
)
go

/*==============================================================*/
/* Index: RT_SUPPLIERORDER_SUPPLIER3_FK                         */
/*==============================================================*/




create nonclustered index RT_SUPPLIERORDER_SUPPLIER3_FK on ORDEREDPARTS (SUPPLIERORDERID ASC)
go

/*==============================================================*/
/* Index: RT_SUPPLIERORDER_SUPPLIER2_FK                         */
/*==============================================================*/




create nonclustered index RT_SUPPLIERORDER_SUPPLIER2_FK on ORDEREDPARTS (SUPPLIERID ASC)
go

/*==============================================================*/
/* Table: PART                                                  */
/*==============================================================*/
create table PART (
   PARTID               IDENTIFIER           not null,
   NAME                 NAME                 not null,
   constraint PK_PART primary key (PARTID)
)
go

/*==============================================================*/
/* Table: PARTS_IN_WORKSHOP                                     */
/*==============================================================*/
create table PARTS_IN_WORKSHOP (
   WORKSHOPID           IDENTIFIER           not null,
   PARTID               IDENTIFIER           not null,
   QUANTITY             int                  not null,
   constraint PK_PARTS_IN_WORKSHOP primary key (WORKSHOPID, PARTID)
)
go

/*==============================================================*/
/* Index: RT_WORKSHOP_PARTSINWORKSHOP_FK                        */
/*==============================================================*/




create nonclustered index RT_WORKSHOP_PARTSINWORKSHOP_FK on PARTS_IN_WORKSHOP (WORKSHOPID ASC)
go

/*==============================================================*/
/* Index: RT_PART_PARTSINWORKSHOP_FK                            */
/*==============================================================*/




create nonclustered index RT_PART_PARTSINWORKSHOP_FK on PARTS_IN_WORKSHOP (PARTID ASC)
go

/*==============================================================*/
/* Table: PARTS_IN_WORKSHOPORDER                                */
/*==============================================================*/
create table PARTS_IN_WORKSHOPORDER (
   ORDERID              IDENTIFIER           not null,
   PARTID               IDENTIFIER           not null,
   QUANTITY             int                  not null,
   constraint PK_PARTS_IN_WORKSHOPORDER primary key (PARTID, ORDERID)
)
go

/*==============================================================*/
/* Index: RT_WORKSHOPORDER_PART4_FK                             */
/*==============================================================*/




create nonclustered index RT_WORKSHOPORDER_PART4_FK on PARTS_IN_WORKSHOPORDER (ORDERID ASC)
go

/*==============================================================*/
/* Index: RT_WORKSHOPORDER_PART3_FK                             */
/*==============================================================*/




create nonclustered index RT_WORKSHOPORDER_PART3_FK on PARTS_IN_WORKSHOPORDER (PARTID ASC)
go

/*==============================================================*/
/* Table: POST                                                  */
/*==============================================================*/
create table POST (
   STATIONID            IDENTIFIER           not null,
   POSTID               IDENTIFIER           not null,
   BIKEID               IDENTIFIER           null,
   LOCKED               bit                  not null,
   constraint PK_POST primary key (STATIONID, POSTID)
)
go

/*==============================================================*/
/* Table: RENTAL                                                */
/*==============================================================*/
create table RENTAL (
   RENTALID             IDENTIFIER           not null,
   BIKEID               IDENTIFIER           not null,
   USERID               IDENTIFIER           not null,
   STATIONID            IDENTIFIER           not null,
   STA_STATIONID        IDENTIFIER           null,
   INVOICEID            IDENTIFIER           null,
   BEGINTIME            DATETIME             null,
   ENDTIME              DATETIME             null,
   PRICE                CASHMONEY            null,
   EXTENDEDTIME         int                  null,
   PAID                 bit                  null,
   constraint PK_RENTAL primary key (RENTALID)
)
go

/*==============================================================*/
/* Index: RT_RENTAL_INVOICE_FK                                  */
/*==============================================================*/




create nonclustered index RT_RENTAL_INVOICE_FK on RENTAL (INVOICEID ASC)
go

/*==============================================================*/
/* Index: RT_RENTAL_BIKE_FK                                     */
/*==============================================================*/




create nonclustered index RT_RENTAL_BIKE_FK on RENTAL (BIKEID ASC)
go

/*==============================================================*/
/* Index: RT_RENTAL_USER_FK                                     */
/*==============================================================*/




create nonclustered index RT_RENTAL_USER_FK on RENTAL (USERID ASC)
go

/*==============================================================*/
/* Index: RT_RENTAL_BEGINSTATION_FK                             */
/*==============================================================*/




create nonclustered index RT_RENTAL_BEGINSTATION_FK on RENTAL (STATIONID ASC)
go

/*==============================================================*/
/* Index: RT_RENTAL_ENDSTATION_FK                               */
/*==============================================================*/




create nonclustered index RT_RENTAL_ENDSTATION_FK on RENTAL (STA_STATIONID ASC)
go

/*==============================================================*/
/* Table: RENTALPRICE                                           */
/*==============================================================*/
create table RENTALPRICE (
   TIME                 int                  not null,
   PRICE                CASHMONEY            not null,
   constraint PK_RENTALPRICE primary key (TIME)
)
go

/*==============================================================*/
/* Table: REPAIRLOG                                             */
/*==============================================================*/
create table REPAIRLOG (
   REPAIRID             IDENTIFIER           not null,
   REP_REPAIRID         IDENTIFIER           null,
   EMPLOYEEID           IDENTIFIER           not null,
   BIKEID               IDENTIFIER           not null,
   TYPEREPAIR           TYPEREPAIR           not null,
   DATE                 DATETIME             not null,
   DESCRIPTION          text                 not null,
   "OPEN"               bit                  not null,
   constraint PK_REPAIRLOG primary key (REPAIRID)
)
go

/*==============================================================*/
/* Index: RT_REPAIRLOG_EMPLOYEE_FK                              */
/*==============================================================*/




create nonclustered index RT_REPAIRLOG_EMPLOYEE_FK on REPAIRLOG (EMPLOYEEID ASC)
go

/*==============================================================*/
/* Index: RT_REPAIRLOG_BIKE_FK                                  */
/*==============================================================*/




create nonclustered index RT_REPAIRLOG_BIKE_FK on REPAIRLOG (BIKEID ASC)
go

/*==============================================================*/
/* Index: RT_REPAIRLOG_REPAIRLOG_FK                             */
/*==============================================================*/




create nonclustered index RT_REPAIRLOG_REPAIRLOG_FK on REPAIRLOG (REP_REPAIRID ASC)
go

/*==============================================================*/
/* Table: RT_ORDEREDPARTS_PART                                  */
/*==============================================================*/
create table RT_ORDEREDPARTS_PART (
   PARTID               IDENTIFIER           not null,
   ORDEREDPARTSID       IDENTIFIER           not null,
   constraint PK_RT_ORDEREDPARTS_PART primary key (PARTID, ORDEREDPARTSID)
)
go

/*==============================================================*/
/* Index: RT_ORDEREDPARTS_PART_FK                               */
/*==============================================================*/




create nonclustered index RT_ORDEREDPARTS_PART_FK on RT_ORDEREDPARTS_PART (PARTID ASC)
go

/*==============================================================*/
/* Index: RT_ORDEREDPARTS_PART2_FK                              */
/*==============================================================*/




create nonclustered index RT_ORDEREDPARTS_PART2_FK on RT_ORDEREDPARTS_PART (ORDEREDPARTSID ASC)
go

/*==============================================================*/
/* Table: RT_PARTSINWORKSHOP_REPAIRLOG                          */
/*==============================================================*/
create table RT_PARTSINWORKSHOP_REPAIRLOG (
   WORKSHOPID           IDENTIFIER           not null,
   PARTID               IDENTIFIER           not null,
   REPAIRID             IDENTIFIER           not null,
   constraint PK_RT_PARTSINWORKSHOP_REPAIRLO primary key (WORKSHOPID, PARTID, REPAIRID)
)
go

/*==============================================================*/
/* Index: RT_PARTSINWORKSHOP_REPAIRLOG_FK                       */
/*==============================================================*/




create nonclustered index RT_PARTSINWORKSHOP_REPAIRLOG_FK on RT_PARTSINWORKSHOP_REPAIRLOG (REPAIRID ASC)
go

/*==============================================================*/
/* Index: RT_PARTSINWORKSHOP_REPAIRLOG2_FK                      */
/*==============================================================*/




create nonclustered index RT_PARTSINWORKSHOP_REPAIRLOG2_FK on RT_PARTSINWORKSHOP_REPAIRLOG (WORKSHOPID ASC,
  PARTID ASC)
go

/*==============================================================*/
/* Table: STATION                                               */
/*==============================================================*/
create table STATION (
   STATIONID            IDENTIFIER           not null,
   STATIONNR            IDENTIFIER           not null,
   ZONE                 IDENTIFIER           not null,
   NAME                 varchar(50)          not null,
   MAXPOSTS             int                  not null,
   LOCATION             text                 not null,
   constraint PK_STATION primary key (STATIONID),
   constraint AK_AK_STATIONNR_ZONE_STATION unique (STATIONNR, ZONE)
)
go

/*==============================================================*/
/* Table: SUBSCRIPTION                                          */
/*==============================================================*/
create table SUBSCRIPTION (
   SUBSCRIPTIONID       IDENTIFIER           identity,
   NAME                 varchar(50)          not null,
   PRICE                CASHMONEY            not null,
   MAXFREETIME          int                  not null,
   LONGTERM             bit                  not null,
   DURATION             int                  not null,
   constraint PK_SUBSCRIPTION primary key (SUBSCRIPTIONID),
   constraint AK_AK_NAME_SUBSCRIP unique (NAME)
)
go

/*==============================================================*/
/* Table: SUPPLIER                                              */
/*==============================================================*/
create table SUPPLIER (
   SUPPLIERID           IDENTIFIER           not null,
   NAME                 NAME                 not null,
   PHONENUMBER          PHONENUMBER          not null,
   constraint PK_SUPPLIER primary key (SUPPLIERID),
   constraint AK_AK_NAME_PHONENUMBE_SUPPLIER unique (NAME, PHONENUMBER)
)
go

/*==============================================================*/
/* Table: SUPPLIERORDER                                         */
/*==============================================================*/
create table SUPPLIERORDER (
   SUPPLIERORDERID      IDENTIFIER           not null,
   EMPLOYEEID           IDENTIFIER           not null,
   ORDERDATE            DATE                 not null,
   constraint PK_SUPPLIERORDER primary key (SUPPLIERORDERID),
   constraint AK_AK_ORDERDATE_SUPPLIER unique (ORDERDATE)
)
go

/*==============================================================*/
/* Index: RT_SUPPLIERORDER_EMPLOYEE_FK                          */
/*==============================================================*/




create nonclustered index RT_SUPPLIERORDER_EMPLOYEE_FK on SUPPLIERORDER (EMPLOYEEID ASC)
go

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" (
   USERID               IDENTIFIER           not null,
   SUBSCRIPTIONID       IDENTIFIER           not null,
   FIRSTNAME            NAME                 not null,
   LASTNAME             NAME                 not null,
   EMAIL                EMAIL                not null,
   PASSWORD             varchar(1024)        not null,
   DATEOFBIRTH          DATE                 not null,
   ZIPCODE              ZIPCODE              not null,
   ADDRESS              ADDRESS              not null,
   TOWN                 TOWN                 not null,
   CREDITCARD           CREDITCARD           not null,
   PHONENUMBER          PHONENUMBER          not null,
   VPOINTS              int                  not null,
   DISCOUNT             CASHMONEY            not null,
   SUBSCRIPTIONSTART    datetime             not null,
   SUBSCRIPTIONREFRESH  bit                  not null,
   PREPAIDCARD          bit                  not null,
   constraint PK_USER primary key (USERID),
   constraint AK_AK_EMAIL_USER unique (EMAIL)
)
go

/*==============================================================*/
/* Index: RT_USER_SUBSCRIPTION_FK                               */
/*==============================================================*/




create nonclustered index RT_USER_SUBSCRIPTION_FK on "USER" (SUBSCRIPTIONID ASC)
go

/*==============================================================*/
/* Table: WORKSHOP                                              */
/*==============================================================*/
create table WORKSHOP (
   WORKSHOPID           IDENTIFIER           not null,
   EMPLOYEEID           IDENTIFIER           not null,
   ADDRESS              ADDRESS              not null,
   constraint PK_WORKSHOP primary key (WORKSHOPID)
)
go

/*==============================================================*/
/* Table: WORKSHOPORDER                                         */
/*==============================================================*/
create table WORKSHOPORDER (
   ORDERID              IDENTIFIER           not null,
   WORKSHOPID           IDENTIFIER           not null,
   SUPPLIERORDERID      IDENTIFIER           null,
   DATE                 DATETIME             not null,
   DELIVERED            bit                  not null,
   constraint PK_WORKSHOPORDER primary key (ORDERID),
   constraint AK_AK_WORKSHOPID_DATE_WORKSHOP unique (WORKSHOPID, DATE)
)
go

/*==============================================================*/
/* Index: RT_WORKSHOP_WORKSHOPORDER_FK                          */
/*==============================================================*/




create nonclustered index RT_WORKSHOP_WORKSHOPORDER_FK on WORKSHOPORDER (WORKSHOPID ASC)
go

/*==============================================================*/
/* Index: RT_WORKSHOPORDER_SUPPLIERORDER_FK                     */
/*==============================================================*/




create nonclustered index RT_WORKSHOPORDER_SUPPLIERORDER_FK on WORKSHOPORDER (SUPPLIERORDERID ASC)
go

alter table BIKE
   add constraint FK_BIKE_RT_BIKE_E_EMPLOYEE foreign key (EMPLOYEEID)
      references EMPLOYEE (EMPLOYEEID)
go

alter table BIKE
   add constraint FK_BIKE_RT_BIKE_W_WORKSHOP foreign key (WORKSHOPID)
      references WORKSHOP (WORKSHOPID)
go

alter table EMPLOYEE
   add constraint FK_EMPLOYEE_RT_EMPLOY_WORKSHOP foreign key (WORKSHOPID)
      references WORKSHOP (WORKSHOPID)
go

alter table INVOICE
   add constraint FK_INVOICE_RT_INVOIC_USER foreign key (USERID)
      references "USER" (USERID)
go

alter table ORDEREDPARTS
   add constraint FK_ORDEREDP_RT_SUPPLI_SUPPLIER foreign key (SUPPLIERID)
      references SUPPLIER (SUPPLIERID)
go

alter table ORDEREDPARTS
   add constraint FK_RT_SUPPL_RT_SUPPLI_SUPPLIER2 foreign key (SUPPLIERORDERID)
      references SUPPLIERORDER (SUPPLIERORDERID)
go

alter table PARTS_IN_WORKSHOP
   add constraint FK_PARTS_IN_RT_PART_P_PART foreign key (PARTID)
      references PART (PARTID)
go

alter table PARTS_IN_WORKSHOP
   add constraint FK_PARTS_IN_WORKSHOP_WORKSHOP foreign key (WORKSHOPID)
      references WORKSHOP (WORKSHOPID)
go

alter table PARTS_IN_WORKSHOPORDER
   add constraint FK_PARTS_IN_RT_WORKSH_PART foreign key (PARTID)
      references PART (PARTID)
go

alter table PARTS_IN_WORKSHOPORDER
   add constraint FK_PARTS_IN_WORKSHOP_WORKSHOPORDER foreign key (ORDERID)
      references WORKSHOPORDER (ORDERID)
go

alter table POST
   add constraint FK_POST_RT_POST_B_BIKE foreign key (BIKEID)
      references BIKE (BIKEID)
go

alter table POST
   add constraint FK_POST_RT_POST_S_STATION foreign key (STATIONID)
      references STATION (STATIONID)
go

alter table RENTAL
   add constraint FK_RENTAL_RT_RENTAL_BEGINSTATION foreign key (STATIONID)
      references STATION (STATIONID)
go

alter table RENTAL
   add constraint FK_RENTAL_RT_RENTAL_BIKE foreign key (BIKEID)
      references BIKE (BIKEID)
go

alter table RENTAL
   add constraint FK_RENTAL_RT_RENTAL_ENDSTATION foreign key (STA_STATIONID)
      references STATION (STATIONID)
go

alter table RENTAL
   add constraint FK_RENTAL_RT_RENTAL_INVOICE foreign key (INVOICEID)
      references INVOICE (INVOICEID)
go

alter table RENTAL
   add constraint FK_RENTAL_RT_RENTAL_USER foreign key (USERID)
      references "USER" (USERID)
go

alter table REPAIRLOG
   add constraint FK_REPAIRLO_RT_REPAIR_BIKE foreign key (BIKEID)
      references BIKE (BIKEID)
go

alter table REPAIRLOG
   add constraint FK_REPAIRLO_RT_REPAIR_EMPLOYEE foreign key (EMPLOYEEID)
      references EMPLOYEE (EMPLOYEEID)
go

alter table REPAIRLOG
   add constraint FK_REPAIRLO_RT_REPAIR_REPAIRLO foreign key (REP_REPAIRID)
      references REPAIRLOG (REPAIRID)
go

alter table RT_ORDEREDPARTS_PART
   add constraint FK_RT_ORDER_RT_ORDERE_PART foreign key (PARTID)
      references PART (PARTID)
go

alter table RT_ORDEREDPARTS_PART
   add constraint FK_RT_ORDER_RT_ORDERE_ORDEREDP foreign key (ORDEREDPARTSID)
      references ORDEREDPARTS (ORDEREDPARTSID)
go

alter table RT_PARTSINWORKSHOP_REPAIRLOG
   add constraint FK_RT_PARTS_RT_PARTSI_REPAIRLO foreign key (REPAIRID)
      references REPAIRLOG (REPAIRID)
go

alter table RT_PARTSINWORKSHOP_REPAIRLOG
   add constraint FK_RT_PARTS_RT_PARTSI_PARTS_IN foreign key (WORKSHOPID, PARTID)
      references PARTS_IN_WORKSHOP (WORKSHOPID, PARTID)
go

alter table SUPPLIERORDER
   add constraint FK_SUPPLIER_RT_SUPPLI_EMPLOYEE foreign key (EMPLOYEEID)
      references EMPLOYEE (EMPLOYEEID)
go

alter table "USER"
   add constraint FK_USER_RT_USER_S_SUBSCRIP foreign key (SUBSCRIPTIONID)
      references SUBSCRIPTION (SUBSCRIPTIONID)
go

alter table WORKSHOP
   add constraint FK_WORKSHOP_RT_MANAGE_EMPLOYEE foreign key (EMPLOYEEID)
      references EMPLOYEE (EMPLOYEEID)
go

alter table WORKSHOPORDER
   add constraint FK_WORKSHOP_RT_WORKSH_SUPPLIER foreign key (SUPPLIERORDERID)
      references SUPPLIERORDER (SUPPLIERORDERID)
go

alter table WORKSHOPORDER
   add constraint FK_WORKSHOP_RT_WORKSH_WORKSHOP foreign key (WORKSHOPID)
      references WORKSHOP (WORKSHOPID)
go

