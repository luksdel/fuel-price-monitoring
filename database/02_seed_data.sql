/*
==========================================================
Fuel Price Monitoring Database
Seed Data Script

Description:
Populates the lookup tables required before importing
fuel price collection data.

Tables:
- Combustivel
- Posto

Authors:
- Lucas Delgado
- Tafnes Lima
- Eduardo Mendes

Database: FuelPriceMonitoring
==========================================================
*/

USE FuelPriceMonitoring;
GO

-- ======================================================
-- Seed data: Combustivel
-- ======================================================

SET IDENTITY_INSERT dbo.Combustivel ON;
GO

INSERT INTO dbo.Combustivel (IdCombustivel, TipoCombustivel)
VALUES
    (1, 'Gasolina'),
    (2, 'Gasolina Aditivada'),
    (3, 'Etanol'),
    (4, 'Diesel');
GO

SET IDENTITY_INSERT dbo.Combustivel OFF;
GO

-- ======================================================
-- Seed data: Posto
-- ======================================================

SET IDENTITY_INSERT dbo.Posto ON;
GO

INSERT INTO dbo.Posto
(
    IdPosto,
    NomePosto,
    Cidade,
    Bairro,
    Rua,
    Numero
)
VALUES
    (1, 'Yahoo Auto Posto', 'Serra', 'Manguinhos', 'ES-010, Km 6,5', 'S/N'),
    (2, 'Posto Pedra Branca', 'Serra', 'Morada de Laranjeiras', 'Avenida Paulo Pereira Gomes', 'S/N'),
    (3, 'Rede Serra Linda - Posto Morada', 'Serra', 'Morada de Laranjeiras', 'Avenida Paulo Pereira Gomes', '2272'),
    (4, 'Giro Auto Posto', 'Serra', 'Morada de Laranjeiras', 'Avenida Paulo Pereira Gomes', 'S/N'),
    (5, 'Posto Pão Com Linguiça', 'Serra', 'Civit II', 'Avenida Central B', '386'),
    (6, 'Posto Metropolitano - Shell Civit II', 'Serra', 'Civit II', 'Avenida Central B', 'S/N'),
    (7, 'BR Petrobrás - Posto Avenida', 'Serra', 'Civit II', 'Rodovia Norte Sul', '3888'),
    (8, 'Rede Marcela - Posto Central', 'Serra', 'Colina de Laranjeiras', 'Avenida Civit', '2100');
GO

SET IDENTITY_INSERT dbo.Posto OFF;
GO