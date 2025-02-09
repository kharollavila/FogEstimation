# Códigos estimación de niebla

Hola, en el presente repositorio se presenta un código en Matlab que permite la estimación de la niebla (Fog) mediante dos modelos propuestos en la literatura. A continuación se señalan los artículos en donde se describen cada uno de ellos: 

- Hildebrandt y Eltahir, 2008: Using a horizontal precipitation model to investigate the role of turbulent cloud deposition in survival of a seasonal cloud forest in Dhofar.
- Unsworth y Wilshaw, 1989: Wet, occult and dry deposition of pollutant on forest.

Código elaborado por Kharoll Ávila


## Requisitos

Para ejecutar los códigos, necesitas tener instalado:

- Matlab R2022B

## Archivos adicionales

### Input
Se definen algunas variables de interés tales como: la velocidad del viento, altura de la vegetación, A, a,  FIC_FOC, FIV, Rc y altura del viento.

Las demás variables son definidas en el código.

### Output
En un archivo excel se presenta: 
- PHyr_HE: Niebla anual mediante Hildebrandt y Eltahir
- Fic_Foc: Promedio entre el factor de incidencia y el factor de compresión por la columna atmosférica
- PH_Ef_HE: Niebla anual efectiva mediante Hildebrandt y Eltahir
- PHyr_B: Niebla anual mediante Hildebrandt y Eltahir
- Fvi: Factor conjugado de intersección
- PH_Ef_B: Niebla anual efectiva mediante Unsworth y Wilshaw
