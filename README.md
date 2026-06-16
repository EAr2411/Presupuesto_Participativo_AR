# Presupuesto_Participativo_AR
Este proyecto releva, sistematiza, analiza y publica información sobre la implementación del presupuesto participativo en Argentina.


## Metodología del proyecto
### Construcción del universo
El universo se construyó a partir de la revisión del documento de códigos de gobiernos locales que publica el INDEC. Este documento permitió listar por provincias todos los municipios de Argentina, distinguiéndolos de otras formas de gobierno, como comuna, comisión de fomento, junta de gobierno o junta vecinal, entre otras que puede asumir el régimen municipal de cada provincia.
Una vez identificado el total de municipios del país, se procedió a identificar sus páginas web oficiales y se diseñó una base de datos con las variables: código de provincia, provincia, municipio y página web. Con este documento se procedió a comenzar la fase de relevamiento. 

### Relevamiento
El relevamiento comenzó construyendo una ficha para indicar en cada municipio la existencia de algún tipo de presupuesto participativo y en particular de presupuesto participativo joven. Además, en esa ficha se indicaba si se habían consultado fuentes alternativas a las páginas webs oficiales de los municipios, como medios periodísticos locales o redes sociales del mismo gobierno local. Para cada fuente alternativa consultada, además del link, se justificó en la ficha los fundamentos de la decisión. Finalmente, con la ficha completa, se estructuró una base de datos que permitió identificar a los municipios con algún tipo de presupuesto participativo. 

### Temporalidad
El relevamiento se realizó durante el tercer trimestre de 2025.


## Estructura del proyecto
### Archivos
La estructura de los archivos se estructura de la siguiente manera: i) tres script (global, ui y server) que contienen toda la lógica, objetos y procesos para la visualización; ii) dos archvios .xlsx que contienen los datos para visualizar.
```text
📂 pp_argentina
├── 📜 global.R
├── 📜 ui.R
├── 📜 server.R
├── 📊 BBDD_Provincias_con_PP.xlsx
└── 📊 BBDD_Municipios_con_PP.xlsx
