import pandas as pd
import sqlite3
import os

# CONFIGURACION INICIAL
EXCEL_FILE = '04_Ventas_Datos_Limpios_S03.xlsx'
DATABASE_FILE = 'Novamarket_S07.db'

def cargar_y_modelar():
    print(f"Iniciando carga desde: {EXCEL_FILE}...")
    
    try:
        # 1. LEER LOS DATOS (Limpios de Sesión 3)
        df = pd.read_excel(EXCEL_FILE, sheet_name='Tabla1')
        df['Fecha'] = pd.to_datetime(df['Fecha'])
        
        # 2. CONSTRUIR DIMENSIONES (NORMALIZACIÓN)
        
        # --- DimProducto ---
        print("Creando Diccionario de Productos...")
        dim_producto = df[['Producto', 'Categoria', 'Precio_Unitario', 'Costo_Unitario']].drop_duplicates().sort_values('Categoria').groupby('Producto').first().reset_index()
        dim_producto.insert(0, 'ProductoID', range(1, len(dim_producto) + 1))
        dim_producto = dim_producto.rename(columns={'Producto': 'Nombre'})
        
        # --- DimCiudad ---
        print("Creando Diccionario de Ciudades...")
        dim_ciudad = df[['Ciudad']].drop_duplicates().reset_index(drop=True)
        dim_ciudad.insert(0, 'CiudadID', range(1, len(dim_ciudad) + 1))
        
        mapeo_ciudades = {
            'Bogota':      {'Region': 'Centro',   'Factor_Envio': 1.0, 'Costo_Envio_Base': 100},
            'Medellin':    {'Region': 'Andina',   'Factor_Envio': 1.2, 'Costo_Envio_Base': 150},
            'Cali':        {'Region': 'Pacifico', 'Factor_Envio': 1.3, 'Costo_Envio_Base': 180},
            'Barranquilla':{'Region': 'Caribe',   'Factor_Envio': 1.5, 'Costo_Envio_Base': 200},
            'Cartagena':   {'Region': 'Caribe',   'Factor_Envio': 1.6, 'Costo_Envio_Base': 250},
            'Leticia':     {'Region': 'Amazonia', 'Factor_Envio': 8.0, 'Costo_Envio_Base': 500},
            'Bogotá':      {'Region': 'Centro',   'Factor_Envio': 1.0, 'Costo_Envio_Base': 100},
            'Medellín':    {'Region': 'Andina',   'Factor_Envio': 1.2, 'Costo_Envio_Base': 150}
        }
        
        dim_ciudad['Region'] = dim_ciudad['Ciudad'].map(lambda x: mapeo_ciudades.get(x, {}).get('Region', 'Otro'))
        dim_ciudad['Factor_Envio'] = dim_ciudad['Ciudad'].map(lambda x: mapeo_ciudades.get(x, {}).get('Factor_Envio', 1.0))
        dim_ciudad['Costo_Envio_Base'] = dim_ciudad['Ciudad'].map(lambda x: mapeo_ciudades.get(x, {}).get('Costo_Envio_Base', 0))
        dim_ciudad = dim_ciudad.rename(columns={'Ciudad': 'Nombre'})
        
        # --- DimFecha ---
        print("Creando Dimensión de Tiempo...")
        fechas_unicas = pd.Series(df['Fecha'].unique()).sort_values()
        # Generamos un rango completo para el año 2023 si hay datos de 2023
        rango_fechas = pd.date_range(start='2023-01-01', end='2023-12-31')
        dim_fecha = pd.DataFrame({'Fecha': rango_fechas})
        dim_fecha['FechaID'] = dim_fecha['Fecha'].dt.strftime('%Y%m%d').astype(int)
        dim_fecha['Dia'] = dim_fecha['Fecha'].dt.day
        dim_fecha['Mes'] = dim_fecha['Fecha'].dt.month
        dim_fecha['Anio'] = dim_fecha['Fecha'].dt.year
        dim_fecha['NombreMes'] = dim_fecha['Fecha'].dt.month_name(locale='es_ES')
        
        # Mapeo de meses en español (porque localedepende del sistema)
        meses_es = {
            1: 'Enero', 2: 'Febrero', 3: 'Marzo', 4: 'Abril', 5: 'Mayo', 6: 'Junio',
            7: 'Julio', 8: 'Agosto', 9: 'Septiembre', 10: 'Octubre', 11: 'Noviembre', 12: 'Diciembre'
        }
        dim_fecha['NombreMes'] = dim_fecha['Mes'].map(meses_es)
        
        # Eventos Especiales
        eventos = {
            '20231124': 'Black Friday',
            '20231127': 'Cyber Monday',
            '20231225': 'Navidad',
            '20230101': 'Año Nuevo'
        }
        dim_fecha['Evento_Especial'] = dim_fecha['FechaID'].astype(str).map(eventos)
        # Convertimos la columna Fecha a string para SQLite
        dim_fecha['Fecha'] = dim_fecha['Fecha'].dt.strftime('%Y-%m-%d')

        # 3. CREAR TABLA DE HECHOS (FACTVENTAS)
        print("Realizando el modelado final...")
        fact_ventas = df.copy()
        
        prod_map = dim_producto.set_index('Nombre')['ProductoID'].to_dict()
        fact_ventas['ProductoID'] = fact_ventas['Producto'].map(prod_map)
        
        city_map = dim_ciudad.set_index('Nombre')['CiudadID'].to_dict()
        fact_ventas['CiudadID'] = fact_ventas['Ciudad'].map(city_map)
        
        fact_ventas['FechaID'] = fact_ventas['Fecha'].dt.strftime('%Y%m%d').astype(int)
        
        fact_ventas = fact_ventas[[
            'ID_Transaccion', 'FechaID', 'ProductoID', 'CiudadID', 
            'Cantidad', 'Precio_Unitario', 'Descuento_pct', 'Costo_Envio'
        ]].rename(columns={
            'ID_Transaccion': 'TransaccionID', 
            'Precio_Unitario': 'Precio_Venta', 
            'Descuento_pct': 'Descuento_Pct'
        })

        # 4. GUARDAR EN LA BASE DE DATOS SQLITE
        conn = sqlite3.connect(DATABASE_FILE)
        dim_producto.to_sql('DimProducto', conn, if_exists='replace', index=False)
        dim_ciudad.to_sql('DimCiudad',     conn, if_exists='replace', index=False)
        dim_fecha.to_sql('DimFecha',       conn, if_exists='replace', index=False)
        fact_ventas.to_sql('FactVentas',   conn, if_exists='replace', index=False)
        
        print(f"Exito! Base de Datos '{DATABASE_FILE}' completa (incluye DimFecha).")
        print(f"Resumen: Ventas: {len(fact_ventas)} | Ciudades: {len(dim_ciudad)} | Productos: {len(dim_producto)} | Fechas: {len(dim_fecha)}")
        conn.close()
        
    except Exception as e:
        print(f"Error durante la carga: {e}")

if __name__ == "__main__":
    if os.path.exists(EXCEL_FILE):
        cargar_y_modelar()
    else:
        print(f"No se encontro el archivo: {EXCEL_FILE}")
