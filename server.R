# ════════════════════════════════════════════════════════════════
# SERVER
# ════════════════════════════════════════════════════════════════

server <- function(input, output, session) {
  
  # ════════════════════════════════════════════════════════════════
  # Reactivo central (selección de provincias)
  # ════════════════════════════════════════════════════════════════
  municipios_filtrados <- reactive({
    if (input$provincia_sel == "Todas") return(municipios_raw)
    filter(municipios_raw, provincia == input$provincia_sel)})
  
  # ════════════════════════════════════════════════════════════════
  # Mapa
  # ════════════════════════════════════════════════════════════════
  output$mapa <- renderLeaflet({
    leaflet(mapa_base) |>
      addTiles(options = tileOptions(opacity = 0.4)) |>
      addPolygons(
        fillColor   = ~paleta_mapa(log1p(n_municipios)),
        fillOpacity = 0.85,
        color       = "white",
        weight      = 1.2,
        label = ~paste0(
          provincia, ": ",
          ifelse(is.na(n_municipios), "sin datos",
                 paste0(n_municipios, " municipios con PP"))),
        labelOptions = labelOptions(
          style = list(
            "font-family" = "Nunito Sans, sans-serif",
            "font-size"   = "13px")),
        layerId = ~provincia) |>
      addLegend(
        pal      = paleta_mapa,
        values   = ~log1p(n_municipios),
        title    = "Municipios<br>con PP",
        position = "bottomright",
        labFormat = labelFormat(
          transform = function(x) round(expm1(x), 0)))
  })
  
  # ════════════════════════════════════════════════════════════════
  # Click en mapa
  # ════════════════════════════════════════════════════════════════
  observeEvent(input$mapa_shape_click, {
    clicked <- input$mapa_shape_click$id
    if (!is.null(clicked)) {
      updateSelectInput(session, "provincia_sel", selected = clicked)}})
  
  # ════════════════════════════════════════════════════════════════
  # Provincia seleccionada (resaltado)
  # ════════════════════════════════════════════════════════════════
  observe({
    sel   <- input$provincia_sel
    proxy <- leafletProxy("mapa") |> clearGroup("highlight")
    
    if (sel != "Todas") {
      geom_sel <- filter(mapa_base, provincia == sel)
      proxy |>
        addPolygons(
          data   = geom_sel,
          fill   = FALSE,
          color  = "#4f1410",
          weight = 3,
          group  = "highlight")}})
  
  # ════════════════════════════════════════════════════════════════
  # Tabla
  # ════════════════════════════════════════════════════════════════
  output$tabla <- renderDT({
    
    df <- municipios_filtrados() |>
      mutate(
        Tipo = mapply(function(t) {
          bg  <- COLORES_TIPO[t]
          txt <- TEXTO_TIPO[t]
          sprintf(
            '<span style="background:%s; color:%s; padding:2px 10px;
             border-radius:4px; font-size:0.8rem; font-weight:500;">%s</span>', bg, txt, t)
        }, tipo)) |>
      select(Provincia = provincia, Municipio = municipio, Tipo)
    
    datatable(df,
      escape   = FALSE,
      rownames = FALSE,
      options  = list(
        scrollY        = "520px",
        scrollCollapse = TRUE,
        paging         = FALSE,
        scrollX        = TRUE,
        columnDefs     = list(
          list(className = "dt-left", targets = "_all"))))})}

shinyApp(ui, server)
