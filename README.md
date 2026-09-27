# Real Estate Market Intelligence — República Dominicana 🇩🇴

## 📌 Descripción

Proyecto de análisis de datos enfocado en el mercado inmobiliario y de construcción de la República Dominicana.

El objetivo es analizar la actividad de construcción, el valor de los proyectos, el valor por metro cuadrado y la cantidad de unidades habitacionales para identificar patrones, diferencias entre provincias y posibles oportunidades para compradores e inversionistas.

El proyecto integra procesos de extracción, transformación, análisis y visualización de datos utilizando Python, SQL Server y Power BI.

---

## 🎯 Objetivo del proyecto

Analizar información relacionada con el mercado inmobiliario y la actividad de construcción en República Dominicana para identificar:

- Diferencias entre provincias.
- Niveles de actividad de construcción.
- Valor tasado de los proyectos.
- Valor promedio por metro cuadrado.
- Cantidad de edificaciones y unidades habitacionales.
- Distribución de la actividad inmobiliaria.
- Características y tipologías de las construcciones.
- Posibles oportunidades de inversión según los indicadores analizados.

---

## ❓ Preguntas de negocio

El análisis busca responder preguntas como:

1. ¿Cuál es el valor promedio de las propiedades y proyectos?
2. ¿Qué provincias presentan los valores más altos?
3. ¿Qué provincias tienen el mayor valor por m²?
4. ¿Qué provincias concentran mayor actividad de construcción?
5. ¿Qué tipo de propiedad o tipología es más común?
6. ¿Cómo se distribuyen las unidades habitacionales entre provincias?
7. ¿Cómo evoluciona la actividad de construcción a través del tiempo?
8. ¿Qué diferencias existen entre las distintas provincias?
9. ¿Qué provincias presentan indicadores más favorables para inversión?
10. ¿Qué oportunidades pueden identificarse a partir de los datos analizados?

---

## 🛠️ Tecnologías utilizadas

| Tecnología | Uso |
|---|---|
| **Python** | Limpieza, transformación y preparación de datos |
| **Pandas** | Manipulación y análisis de datos |
| **SQL Server** | Almacenamiento, consultas y análisis de datos |
| **SQL** | Exploración y análisis de información |
| **Power BI** | Modelado, métricas, visualización y dashboards |
| **Git / GitHub** | Control de versiones y documentación del proyecto |

---

## 🔄 Flujo del proyecto

El proyecto fue desarrollado siguiendo un flujo de análisis de datos:

**Data Discovery → Data Understanding → Data Cleaning → Transformación → SQL → Análisis → Power BI → Business Insights**

### 1. Data Discovery

Se identificaron diferentes fuentes relacionadas con vivienda, construcción, actividad inmobiliaria y contexto habitacional de República Dominicana.

Se revisó la estructura de los archivos, variables disponibles y utilidad de cada fuente para los objetivos del proyecto.

### 2. Data Understanding

Se realizó una exploración inicial de las variables para comprender:

- Tipos de datos.
- Variables categóricas.
- Variables numéricas.
- Códigos utilizados.
- Información geográfica.
- Variables relacionadas con construcción.
- Variables relacionadas con valor y superficie.

### 3. Data Cleaning

Durante la exploración se identificaron diferentes situaciones de calidad de datos, incluyendo espacios y valores que inicialmente podían interpretarse como inconsistencias.

También se identificaron registros con valores numéricos en cero.

Estos registros fueron revisados utilizando el diccionario de datos proporcionado por la fuente.

La documentación de los datos aclara que:

> Las licencias que muestran ceros en todas las variables numéricas corresponden a casos en los que se ha otorgado una licencia para modificación que no implica la integración de cantidad de edificaciones, unidades habitacionales, metros cuadrados, valor tasado, entre otras variables, o bien son licencias para renovación o inicio de obra.

Por esta razón, estos valores no fueron tratados automáticamente como errores, sino interpretados de acuerdo con la documentación disponible.

### 4. Transformación

Los datos fueron transformados y preparados utilizando Python y Pandas.

Entre las tareas realizadas se incluyeron:

- Limpieza de nombres y valores.
- Tratamiento de espacios.
- Normalización de información.
- Conversión de tipos de datos.
- Revisión de valores numéricos.
- Preparación de los datos para su posterior análisis.

### 5. SQL Server

Los datos preparados fueron llevados a SQL Server para estructurar la información y realizar consultas analíticas.

Se trabajó con variables relacionadas con:

- Provincias.
- Meses y años.
- Tipologías.
- Clasificación de suelo.
- Sistemas estructurales.
- Edificaciones.
- Unidades habitacionales.
- Superficie.
- Valor tasado.
- Valor por metro cuadrado.

### 6. Análisis

Se utilizaron consultas y métricas para analizar diferentes indicadores del mercado.

Entre ellos:

- Actividad de construcción.
- Valor tasado.
- Valor por m².
- Cantidad de viviendas.
- Participación del mercado.
- Distribución por provincia.
- Evolución temporal.
- Indicadores de oportunidad.

### 7. Power BI

Finalmente, los datos fueron utilizados para construir dashboards interactivos en Power BI.

Los dashboards permiten explorar la información desde diferentes perspectivas y comparar las provincias mediante indicadores de mercado y construcción.

---

## 📊 Dashboards

### Dashboard 1 — Market Overview

Este dashboard presenta una visión general del mercado inmobiliario y de construcción.

Incluye indicadores y visualizaciones relacionadas con:

- Licencias de construcción.
- Edificaciones registradas.
- Viviendas registradas.
- Valor total de las propiedades.
- Valor promedio por m².
- Evolución de licencias.
- Distribución geográfica.
- Tipos de edificaciones.

![Market Overview](Dashboard/Media/Primer%20dashboard.png)

---

### Dashboard 2 — Investment Insights

Este dashboard se enfoca en la comparación entre provincias y la identificación de posibles oportunidades.

Incluye:

- Índice de oportunidad por provincia.
- Relación entre oportunidad y valor por m².
- Total de viviendas.
- Participación del mercado.
- Ranking de provincias.
- Indicadores de oportunidad.
- Tabla comparativa por provincia.

![Investment Insights](Dashboard/Media/Segundo%20dashboard.png)

---

## 📈 Principales indicadores

Entre los indicadores utilizados en el análisis se encuentran:

- **Valor tasado**
- **Valor tasado por m²**
- **M² de tasación**
- **Cantidad de edificaciones**
- **Unidades habitacionales**
- **Locales comerciales y oficinas**
- **Cantidad de dormitorios**
- **Participación del mercado**
- **Índice de oportunidad**

---

## 🗄️ Estructura de datos

Entre las principales variables utilizadas se encuentran:

### Variables enteras

- `ID`
- `CODIGO_MES`
- `ANO`
- `CODIGO_CLASIFICACION_SUELO`
- `CODIGO_TIPO_SISTEMA_ESTRUCTURAL`
- `CODIGO_PROVINCIA`
- `CODIGO_TIPOLOGIA`
- `CANTIDAD_EDIFICACIONES`
- `UNIDADES_HABITACIONALES`
- `LOCALES_COMERCIALES_OFICINAS`
- `CANTIDAD_USO_DORMITORIOS`

### Variables de texto

- `MES`
- `CLASIFICACION_SUELO`
- `TIPO_SISTEMA_ESTRUCTURAL`
- `PROVINCIA`
- `TIPOLOGIA`

### Variables decimales

- `MTS2_TASACION`
- `VALOR_TASADO`
- `PERIMETRO_CONSTRUCCION`
- `EXTENSION_SOLAR_MTS2`
- `INDICE_CONSTRUCCION_PCT`
- `VALOR_TASADO_M2`

---

## 💡 Business Insights

A partir del análisis se construyó un índice de oportunidad para comparar las provincias bajo los indicadores utilizados en el proyecto.

Entre las provincias que destacan en el ranking presentado en el dashboard se encuentran:

1. **La Altagracia**
2. **Distrito Nacional**
3. **San Pedro de Macorís**

Estos resultados representan el comportamiento de los indicadores definidos para este proyecto y no constituyen por sí mismos una recomendación financiera o de inversión.

---

## 📁 Estructura del repositorio

```text
Real-State-Market-Intelligence-RD-Analytics/
│
├── README.md
│
├── Analytics/
│
├── Dashboard/
│
├── Documentation/
│
├── Extract/
│
├── Load/
│
└── Transform/