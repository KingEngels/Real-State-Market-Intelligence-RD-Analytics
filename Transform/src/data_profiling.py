import pandas as pd
import numpy as np
import unicodedata


# BUSCAR DATA
df = pd.read_excel('data/raw/data.xlsx', sheet_name='Datos')

# PARA CONVERTIR LOS NOMBRES DE LAS COLUMNAS A MAYUSCULAS
df = df.rename(columns=str.upper) 

# PARA REEMPLAZAR ESPACIOS EN BLANCO POR GUIONES BAJOS EN LOS NOMBRES DE LAS COLUMNAS
df = df.rename(columns=lambda x: x.replace(' ', '_')) 

# PARA ELIMINAR ACENTOS EN LOS NOMBRES DE LAS COLUMNAS
df.columns = (
    df.columns.str.normalize('NFKD') 
    .str.encode('ascii', errors='ignore')
    .str.decode('utf-8')) 

df = df.rename(columns=lambda x: x.replace('%', 'PCT'))
df = df.rename(columns=lambda x: x.replace('²', '2'))
df = df.rename(columns=lambda x: x.replace('ANO', 'ANIO'))
df = df.rename(columns=lambda x: x.replace('CANTIDAD__USO_DORMITORIOS', 'CANTIDAD_USO_DORMITORIOS'))


# PARA ELIMINAR ESPACIOS EN BLANCO AL INICIO Y AL FINAL DE LOS NOMBRES DE LAS COLUMNAS
df.columns = df.columns.str.strip() 

# IDENTIFICAR COLUMNAS DE TEXTO
columnas_string = df.select_dtypes(include=['object', 'string']).columns

# ELIMINAR ACENTOS DEL CONTENIDO DE LAS COLUMNAS DE TEXTO
df[columnas_string] = df[columnas_string].map(
    lambda x: unicodedata.normalize('NFKD', x)
    .encode('ascii', 'ignore')
    .decode('ascii')
    if isinstance(x, str) else x
)

# ELIMINAR ESPACIOS AL INICIO Y FINAL DE LOS VALORES DE TEXTO
df[columnas_string] = df[columnas_string].apply(
    lambda x: x.str.strip()
)

# CREAR VARIABLE DERIVADA VALOR_TASADO_M2
df['VALOR_TASADO_M2'] = np.where((df['MTS2_TASACION'] > 0) & (df['VALOR_TASADO'] > 0), df['VALOR_TASADO'] / df['MTS2_TASACION'], 0)


# OUTPUT
df.to_csv('data/processed/data_clean.csv', index=False)

print(df.head())
