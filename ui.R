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
                                    p("lorem ipsum"),
                                    h5("Relevamiento"),
                                    p("lorem ipsum")))), 
  nav_panel("Información",
            p("lorem ipsum")))
