/*
==========================================================
Fuel Price Monitoring Database
Schema Definition

Description:
Creates the relational database schema used to store
fuel price monitoring data.

Authors:
- Lucas Delgado
- Tafnes Lima
- Eduardo Mendes

Database: FuelPriceMonitoring
==========================================================
*/

IF DB_ID('FuelPriceMonitoring') IS NULL
BEGIN
    CREATE DATABASE FuelPriceMonitoring;
END
GO

USE FuelPriceMonitoring;
GO

-- ======================================================
-- Table: Posto
-- ======================================================

CREATE TABLE dbo.Posto
(
    IdPosto INT IDENTITY(1,1) PRIMARY KEY,

    NomePosto VARCHAR(50) NOT NULL,
    Cidade     VARCHAR(50) NOT NULL,
    Bairro     VARCHAR(50) NOT NULL,
    Rua        VARCHAR(50) NOT NULL,
    Numero     CHAR(10) NULL
);
GO

-- ======================================================
-- Table: Combustivel
-- ======================================================

CREATE TABLE dbo.Combustivel
(
    IdCombustivel INT IDENTITY(1,1) PRIMARY KEY,

    TipoCombustivel VARCHAR(25) NOT NULL
);
GO

-- ======================================================
-- Table: Coleta
-- ======================================================

CREATE TABLE dbo.Coleta
(
    IdColeta INT IDENTITY(1,1) PRIMARY KEY,

    Preco DECIMAL(10,2) NOT NULL,
    DataColeta DATE NOT NULL,

    FK_IdPosto INT NOT NULL,
    FK_IdCombustivel INT NOT NULL,

	CONSTRAINT UQ_Coleta
        UNIQUE
        (
            FK_IdPosto,
            FK_IdCombustivel,
            DataColeta
        ),

    CONSTRAINT FK_Coleta_Posto
        FOREIGN KEY (FK_IdPosto)
        REFERENCES dbo.Posto(IdPosto),

    CONSTRAINT FK_Coleta_Combustivel
        FOREIGN KEY (FK_IdCombustivel)
        REFERENCES dbo.Combustivel(IdCombustivel)
);
GO