/*
==========================================================
Fuel Price Monitoring Database
Stored Procedures

Description:
Creates the stored procedures used to retrieve fuel price
information, calculate average fuel prices, and summarize
fuel price collections by gas station.

Authors:
- Lucas Delgado
- Tafnes Lima
- Eduardo Mendes

Database: FuelPriceMonitoring
==========================================================
*/

USE FuelPriceMonitoring;
GO

/*
==========================================================
Procedure: sp_menorpreco

Description:
Returns the lowest recorded price for each fuel type.
Optional filters:
- Neighborhood
- Fuel type
==========================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_menorpreco
    @bairro VARCHAR(50) = NULL,
    @combustivel VARCHAR(25) = NULL
AS
BEGIN

    WITH MenorPreco AS
    (
        SELECT
            MIN(C.Preco) AS MenorPreco,
            CO.IdCombustivel
        FROM dbo.Coleta AS C
        INNER JOIN dbo.Combustivel AS CO
            ON CO.IdCombustivel = C.FK_IdCombustivel
        INNER JOIN dbo.Posto AS P
            ON P.IdPosto = C.FK_IdPosto
        WHERE (@bairro IS NULL OR P.Bairro LIKE '%' + @bairro + '%')
          AND (@combustivel IS NULL OR CO.TipoCombustivel LIKE '%' + @combustivel + '%')
        GROUP BY CO.IdCombustivel
    )

    SELECT
        P.NomePosto AS Posto,
        P.Rua,
        P.Bairro,
        C.Preco AS PreçoCombustivel,
        CO.TipoCombustivel,
        C.DataColeta
    FROM dbo.Coleta AS C
    INNER JOIN dbo.Posto AS P
        ON C.FK_IdPosto = P.IdPosto
    INNER JOIN dbo.Combustivel AS CO
        ON C.FK_IdCombustivel = CO.IdCombustivel
    INNER JOIN MenorPreco AS MP
        ON C.FK_IdCombustivel = MP.IdCombustivel
       AND C.Preco = MP.MenorPreco
    WHERE (@bairro IS NULL OR P.Bairro LIKE '%' + @bairro + '%')
      AND (@combustivel IS NULL OR CO.TipoCombustivel LIKE '%' + @combustivel + '%');

END
GO

/*
==========================================================
Procedure: sp_precomedio

Description:
Returns the average fuel price grouped by neighborhood.
Optionally filters results by collection period.
==========================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_precomedio
    @dataInicio DATE = NULL,
    @dataFim DATE = NULL
AS
BEGIN

    SELECT
        ISNULL(P.Bairro, 'Todos os Bairros') AS Bairro,
        CAST(AVG(C.Preco) AS NUMERIC(15,2)) AS PreçoMedio
    FROM dbo.Coleta AS C
    INNER JOIN dbo.Posto AS P
        ON C.FK_IdPosto = P.IdPosto
    INNER JOIN dbo.Combustivel AS CO
        ON C.FK_IdCombustivel = CO.IdCombustivel
    WHERE (@dataInicio IS NULL OR C.DataColeta >= @dataInicio)
      AND (@dataFim IS NULL OR C.DataColeta <= @dataFim)
    GROUP BY P.Bairro;

END
GO

/*
==========================================================
Procedure: sp_resumopostos

Description:
Returns a summary of each gas station, including the
number of collected samples and the average fuel price
for a specified collection period.
==========================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_resumopostos
    @dataInicio DATE,
    @dataFim DATE
AS
BEGIN

    IF @dataInicio IS NULL OR @dataFim IS NULL
    BEGIN
        RAISERROR('Parâmetros de data são obrigatórios.', 16, 1);
        RETURN;
    END;

    SELECT
        P.NomePosto AS NomePosto,
        P.Bairro,
        COUNT(C.IdColeta) AS QuantidadeAmostras,
        CO.TipoCombustivel,
        CAST(AVG(C.Preco) AS NUMERIC(15,2)) AS PreçoMedio
    FROM dbo.Coleta AS C
    INNER JOIN dbo.Posto AS P
        ON C.FK_IdPosto = P.IdPosto
    INNER JOIN dbo.Combustivel AS CO
        ON C.FK_IdCombustivel = CO.IdCombustivel
    WHERE C.DataColeta BETWEEN @dataInicio AND @dataFim
    GROUP BY
        P.NomePosto,
        P.Bairro,
        CO.TipoCombustivel
    ORDER BY
        P.NomePosto;

END
GO