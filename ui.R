# ═════════════════════════════════════════════════════════════════
# UI Diseño de la APP
# ═════════════════════════════════════════════════════════════════

ui <- page_navbar(title = "Presupuesto Participativo en Argentina",
  theme = tema,
  nav_panel("Datos",
    layout_sidebar(sidebar = sidebar(title = "Filtros",
        selectInput(inputId  = "provincia_sel",
          label = "Provincia",
          choices = c("Todas", sort(unique(municipios_raw$provincia))),
          selected = "Todas"),
        hr(),
        p(style = "font-size: 0.8rem; color: #919aa1;",
          "También podés hacer clic en una provincia del mapa para filtrar.")),
        layout_columns(col_widths = c(7, 5),
          leafletOutput("mapa", height = "600px"),
          DTOutput("tabla")))),

    nav_panel("Metodología",
            layout_column_wrap(width = "700px",
                               card(card_header("¿Cómo construimos la información?"),
                                    h5("Construcción del universo"),
                                    p("El universo se construyó a partir de la revisión del documento de códigos de gobiernos locales que publica el ",a("INDEC", href = "https://www.indec.gob.ar/indec/web/Nivel4-Tema-1-17-179",target = "_blank"),". Este documento permitió listar por provincias todos los municipios de Argentina, distinguiéndolos de otras formas de gobierno, como comuna, comisión de fomento, junta de gobierno o junta vecinal, entre otras que puede asumir el régimen municipal de cada provincia."),
                                    p("Una vez identificado el total de municipios del país, se procedió a identificar sus páginas web oficiales y se diseñó una base de datos con las variables: código de provincia, provincia, municipio y página web. Con este documento se procedió a comenzar la fase de relevamiento."),
                                    hr(),
                                    h5("Relevamiento"),
                                    p("El relevamiento comenzó construyendo una ficha para indicar en cada municipio la existencia de algún tipo de presupuesto participativo y en particular de presupuesto participativo joven. Además, en esa ficha se indicaba si se habían consultado fuentes alternativas a las páginas webs oficiales de los municipios, como medios periodísticos locales o redes sociales del mismo gobierno local. Para cada fuente alternativa consultada, además del link, se justificó en la ficha los fundamentos de la decisión."),
                                    br(),
                                    p("Finalmente, con la ficha completa, se estructuró una base de datos que permitió identificar a los municipios con algún tipo de presupuesto participativo. Cabe destacar que este proceso se llevó a cabo durante el tercer trimestre del 2025.")))), 
  nav_panel("Información",
    p("Este informe fue producido por Emiliano Arena (",a("emilianoarena@gmail.com", href = "mailto:emilianoarena@gmail.com"),
      "), en el marco del curso Introducción a Shiny de ",
      a("Estación R", href = "https://www.estacion-r.com", target = "_blank"),".")))
