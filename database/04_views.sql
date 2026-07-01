/*
==========================================================
Fuel Price Monitoring Database
View Script

View:
vw_MonitoramentoCombustiveis

Description:
Creates a consolidated view by joining gas stations,
fuel types, and fuel price collections into a single
dataset for querying, reporting, and Power BI analysis.

Authors:
- Lucas Delgado
- Tafnes Lima
- Eduardo Mendes

Database: FuelPriceMonitoring
==========================================================
*/

USE FuelPriceMonitoring;
GO

CREATE OR ALTER VIEW dbo.vw_MonitoramentoCombustiveis
AS

SELECT
    c.IdColeta,
    c.DataColeta,
    c.Preco,

    p.IdPosto,
    p.NomePosto,
    p.Cidade,
    p.Bairro,
    p.Rua,
    p.Numero,

    cb.IdCombustivel,
    cb.TipoCombustivel

FROM dbo.Coleta AS c
INNER JOIN dbo.Posto AS p
    ON c.FK_IdPosto = p.IdPosto
INNER JOIN dbo.Combustivel AS cb
    ON c.FK_IdCombustivel = cb.IdCombustivel;
GO