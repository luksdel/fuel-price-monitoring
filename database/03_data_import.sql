/*
==========================================================
Fuel Price Monitoring Database
Data Import Script

Description:
Imports fuel price collection data from a CSV file into
the Coleta table using OPENROWSET and an XML format file.

Requirements:
- SQL Server
- Ad Hoc Distributed Queries enabled
- fuel_price_collection.csv
- fuel_price_format.xml

Update the file paths before executing.
==========================================================
*/

USE FuelPriceMonitoring;
GO

/*
Note:
OPENROWSET requires the "Ad Hoc Distributed Queries"
option to be enabled on SQL Server.
*/

INSERT INTO dbo.Coleta
(
    Preco,
    DataColeta,
    FK_IdPosto,
    FK_IdCombustivel
)
SELECT
    ColetaCSV.Preco,
    ColetaCSV.DataColeta,
    ColetaCSV.FK_IdPosto,
    ColetaCSV.FK_IdCombustivel
FROM OPENROWSET
(
    BULK 'C:\Path\To\data\fuel_price_collection.csv',
    FORMATFILE = 'C:\Path\To\data\fuel_price_format.xml',
    CODEPAGE = '65001',
    FIRSTROW = 2
) AS ColetaCSV;
GO