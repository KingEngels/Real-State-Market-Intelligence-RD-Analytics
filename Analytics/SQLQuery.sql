


USE RealEstateRD;

SELECT * FROM fact_licencias_construccion

--Pregunta 1
SELECT COUNT(*) AS registro_licencias FROM fact_licencias_construccion

--Pregunta 2
SELECT COUNT(DISTINCT PROVINCIA) AS Cantidad_provincia FROM fact_licencias_construccion

--Pregunta 3
SELECT DISTINCT PROVINCIA FROM fact_licencias_construccion 

--Pregunta 4
SELECT COUNT(DISTINCT TIPOLOGIA) AS Cantidad_tipologias 
FROM fact_licencias_construccion

--Pregunta 5
SELECT DISTINCT TIPOLOGIA FROM fact_licencias_construccion 

--Pregunta 6
SELECT DISTINCT TIPO_SISTEMA_ESTRUCTURAL FROM fact_licencias_construccion 

--Pregunta 7
SELECT DISTINCT CLASIFICACION_SUELO FROM fact_licencias_construccion 

--Pregunta 8 
SELECT PROVINCIA, COUNT(*) AS Cantidad_licencias
FROM fact_licencias_construccion 
GROUP BY PROVINCIA

--Pregunta 9
SELECT TOP 5 PROVINCIA, COUNT(*) AS Cantidad_licencias
FROM fact_licencias_construccion 
GROUP BY PROVINCIA
ORDER BY Cantidad_licencias DESC

--Pregunta 10 
SELECT PROVINCIA, SUM(CANTIDAD_EDIFICACIONES) AS Cantidad_Edfi 
FROM fact_licencias_construccion
GROUP BY PROVINCIA


--Pregunta 11
SELECT TOP 5 PROVINCIA, SUM(UNIDADES_HABITACIONALES) AS Unidades_habitacional 
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Unidades_habitacional DESC

--Pregunta 12
SELECT TOP 5 PROVINCIA, SUM(LOCALES_COMERCIALES_OFICINAS) AS Comerciales_Oficina 
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Comerciales_Oficina DESC

--Pregunta 13
SELECT TOP 1 TIPOLOGIA, COUNT(TIPOLOGIA) AS Cantidad_tipologias 
FROM fact_licencias_construccion
GROUP BY TIPOLOGIA
ORDER BY Cantidad_tipologias DESC


--Pregunta 14
WITH conteo AS (
    SELECT 
        PROVINCIA,
        CODIGO_TIPOLOGIA,
        MAX(TIPOLOGIA) AS TIPOLOGIA,
        COUNT(*) AS TOTAL,
        ROW_NUMBER() OVER (PARTITION BY PROVINCIA ORDER BY COUNT(*) DESC) AS POSICION
    FROM fact_licencias_construccion
    GROUP BY PROVINCIA, CODIGO_TIPOLOGIA
)
SELECT 
    PROVINCIA,
    TIPOLOGIA AS TIPOLOGIA_PREDOMINANTE
FROM conteo
WHERE POSICION = 1;

--Pregunta 15
SELECT PROVINCIA, SUM(VALOR_TASADO) AS total_tasado 
FROM fact_licencias_construccion
GROUP BY PROVINCIA

--Pregunta 16
SELECT PROVINCIA, AVG(VALOR_TASADO) AS Promedio_tasado 
FROM fact_licencias_construccion
WHERE VALOR_TASADO > 0
GROUP BY PROVINCIA

--Pregunta 17
SELECT PROVINCIA, AVG(VALOR_TASADO_M2) AS Promedio_M2
FROM fact_licencias_construccion
WHERE VALOR_TASADO_M2 > 0
GROUP BY PROVINCIA

--Pregunta 18
SELECT TOP 5 PROVINCIA, AVG(VALOR_TASADO_M2) AS Total_tasado_m2
FROM fact_licencias_construccion 
WHERE VALOR_TASADO_M2 > 0
GROUP BY PROVINCIA 
ORDER BY Total_tasado_m2 DESC

--Pregunta 19
SELECT TOP 5 PROVINCIA, SUM(MTS2_TASACION) AS Superficie_total_tasada 
FROM fact_licencias_construccion
WHERE MTS2_TASACION > 1
GROUP BY PROVINCIA
ORDER BY Superficie_total_tasada DESC

--Pregunta 20
SELECT PROVINCIA, SUM(CANTIDAD_EDIFICACIONES) AS EDIFICACIONES, SUM(VALOR_TASADO) AS VALOR_TOTAL_TASADO
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY VALOR_TOTAL_TASADO DESC

--Pregunta 21
SELECT MES, COUNT(*) AS Cantidad_licencia 
FROM fact_licencias_construccion
GROUP BY MES;

--Pregunta 22 y Pregunta 23
WITH actividad AS (
    SELECT MES, SUM(CANTIDAD_EDIFICACIONES) AS Total_edificaciones, 
    SUM(UNIDADES_HABITACIONALES) AS Total_habitacionales,  COUNT(*) AS Cantidad_licencias
    FROM fact_licencias_construccion
    GROUP BY MES
    ORDER BY Total_edificaciones

    
)

SELECT * FROM actividad


--Pregunta 24
SELECT CODIGO_MES, MES, SUM(VALOR_TASADO) AS Valor_tasado
FROM fact_licencias_construccion
GROUP BY MES, CODIGO_MES
ORDER BY CODIGO_MES ASC

--Pregunta 25
SELECT CODIGO_MES, MES, SUM(UNIDADES_HABITACIONALES) AS Und_HAB
FROM fact_licencias_construccion
GROUP BY MES, CODIGO_MES
ORDER BY CODIGO_MES ASC

--Pregunta 26
SELECT TOP 3 PROVINCIA, AVG(VALOR_TASADO_M2) AS Promedio_M2 
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Promedio_M2 DESC

--Pregunta 27
WITH actividad AS (
    SELECT PROVINCIA, SUM(CANTIDAD_EDIFICACIONES) AS Total_edificaciones, 
    SUM(UNIDADES_HABITACIONALES) AS Total_habitacionales,  COUNT(*) AS Cantidad_licencias
    FROM fact_licencias_construccion
    GROUP BY PROVINCIA
), 
Percentiles AS (
SELECT DISTINCT 
PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY Total_edificaciones) OVER () AS P33,
PERCENTILE_CONT(0.66) WITHIN GROUP (ORDER BY Total_edificaciones) OVER () AS P66
FROM actividad
)

SELECT 
    a.PROVINCIA,
    a.Total_edificaciones,
    CASE
        WHEN a.Total_edificaciones > p.P66 THEN 'Alta'
        WHEN a.Total_edificaciones > p.P33 THEN 'Media'
        ELSE 'Baja'
    END AS Nivel_actividad
FROM actividad a
CROSS JOIN percentiles p
ORDER BY a.Total_edificaciones DESC;

--Pregunta 28
SELECT 
    PROVINCIA,
    SUM(CANTIDAD_EDIFICACIONES) AS Total_edificaciones,
    RANK() OVER (ORDER BY SUM(CANTIDAD_EDIFICACIONES) DESC) AS Ranking
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Ranking;
--Pregunta 29
SELECT 
    PROVINCIA,
    SUM(VALOR_TASADO) AS Valor_tasado,
    RANK() OVER (ORDER BY SUM(VALOR_TASADO) DESC) AS Ranking
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Ranking;

--Pregunta 30
WITH ranking_tipologias AS (
    SELECT 
        PROVINCIA,
        TIPOLOGIA,
        SUM(UNIDADES_HABITACIONALES) AS Total_habitacionales,
        RANK() OVER (
            PARTITION BY PROVINCIA
            ORDER BY SUM(UNIDADES_HABITACIONALES) DESC
        ) AS Ranking
    FROM fact_licencias_construccion
    GROUP BY PROVINCIA, TIPOLOGIA
)
SELECT 
    PROVINCIA,
    TIPOLOGIA,
    Total_habitacionales,
    Ranking
FROM ranking_tipologias
WHERE Ranking = 1
ORDER BY PROVINCIA;

-- Pregunta 31
WITH licencias_mes AS (
    SELECT
        CODIGO_MES,
        MES,
        COUNT(*) AS Cantidad_licencias
    FROM fact_licencias_construccion
    GROUP BY CODIGO_MES, MES
)
SELECT
    CODIGO_MES,
    MES,
    Cantidad_licencias,
    LAG(Cantidad_licencias) OVER (ORDER BY CODIGO_MES) AS Licencias_mes_anterior,
    Cantidad_licencias 
        - LAG(Cantidad_licencias) OVER (ORDER BY CODIGO_MES) AS Cambio_licencias
FROM licencias_mes
ORDER BY CODIGO_MES;

-- Pregunta 32
WITH valor_mes AS (
    SELECT
        CODIGO_MES,
        MES,
        SUM(VALOR_TASADO) AS Valor_tasado
    FROM fact_licencias_construccion
    GROUP BY CODIGO_MES, MES
)
SELECT
    CODIGO_MES,
    MES,
    Valor_tasado,
    LAG(Valor_tasado) OVER (ORDER BY CODIGO_MES) AS Valor_mes_anterior,
    Valor_tasado 
        - LAG(Valor_tasado) OVER (ORDER BY CODIGO_MES) AS Cambio_valor
FROM valor_mes
ORDER BY CODIGO_MES;

-- Pregunta 33
WITH licencias_mes AS (
    SELECT
        CODIGO_MES,
        MES,
        COUNT(*) AS Cantidad_licencias
    FROM fact_licencias_construccion
    GROUP BY CODIGO_MES, MES
),
cambios AS (
    SELECT
        CODIGO_MES,
        MES,
        Cantidad_licencias,
        LAG(Cantidad_licencias) OVER (ORDER BY CODIGO_MES) AS Licencias_mes_anterior
    FROM licencias_mes
)
SELECT
    CODIGO_MES,
    MES,
    Cantidad_licencias,
    Licencias_mes_anterior,
    ((Cantidad_licencias - Licencias_mes_anterior) * 100.0 
        / NULLIF(Licencias_mes_anterior, 0)) AS Crecimiento_porcentual
FROM cambios
ORDER BY CODIGO_MES;

-- Pregunta 34
WITH licencias_mes AS (
    SELECT
        CODIGO_MES,
        MES,
        COUNT(*) AS Cantidad_licencias
    FROM fact_licencias_construccion
    GROUP BY CODIGO_MES, MES
),
crecimiento AS (
    SELECT
        CODIGO_MES,
        MES,
        Cantidad_licencias,
        LAG(Cantidad_licencias) OVER (ORDER BY CODIGO_MES) AS Licencias_mes_anterior
    FROM licencias_mes
)
SELECT TOP 1
    CODIGO_MES,
    MES,
    Cantidad_licencias,
    Licencias_mes_anterior,
    ((Cantidad_licencias - Licencias_mes_anterior) * 100.0 
        / NULLIF(Licencias_mes_anterior, 0)) AS Crecimiento_porcentual
FROM crecimiento
WHERE Licencias_mes_anterior IS NOT NULL
ORDER BY Crecimiento_porcentual DESC;

--Pregunta 35
SELECT TOP 5 PROVINCIA, SUM(CANTIDAD_EDIFICACIONES) AS Actividad_constructiva 
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Actividad_constructiva DESC

--Pregunta 36
SELECT TOP 5 PROVINCIA, SUM(UNIDADES_HABITACIONALES) AS Habitacional 
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Habitacional DESC

--Pregunta 37
SELECT TOP 5 PROVINCIA, SUM(VALOR_TASADO) AS Valor_tasado
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Valor_tasado DESC

--Pregunta 38
SELECT TOP 5 PROVINCIA, SUM(VALOR_TASADO_M2) AS Valor_tasado_M2
FROM fact_licencias_construccion
GROUP BY PROVINCIA
ORDER BY Valor_tasado_M2 DESC

--Pregunta 39
WITH indicadores AS (
    SELECT
        PROVINCIA,
        SUM(CANTIDAD_EDIFICACIONES) AS Actividad_constructiva,
        SUM(VALOR_TASADO) AS Valor_tasado
    FROM fact_licencias_construccion
    GROUP BY PROVINCIA
),
limites AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.66) 
            WITHIN GROUP (ORDER BY Actividad_constructiva) OVER () AS P66_actividad,
        PERCENTILE_CONT(0.66) 
            WITHIN GROUP (ORDER BY Valor_tasado) OVER () AS P66_valor
    FROM indicadores
)
SELECT
    i.PROVINCIA,
    i.Actividad_constructiva,
    i.Valor_tasado
FROM indicadores i
CROSS JOIN limites l
WHERE i.Actividad_constructiva >= l.P66_actividad
  AND i.Valor_tasado >= l.P66_valor
ORDER BY i.Actividad_constructiva DESC,
         i.Valor_tasado DESC;
