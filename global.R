# ═════════════════════════════════════════════════════════════════
# LIBRERIAS 
# ═════════════════════════════════════════════════════════════════

library(shiny)
library(bslib)
#install.packages("leaflet")
library(leaflet)
library(DT)
library(dplyr)
library(readxl)
library(sf)
#install.packages("geoAr")
library(geoAr)

# ═════════════════════════════════════════════════════════════════
# PALETA BURDEOS
# ═════════════════════════════════════════════════════════════════

BURDEOS <- c("#f5f0ee", "#e8d0cc", "#d4a9a4", "#b97b74",
             "#9c504a", "#7a2e29", "#4f1410")

COLORES_TIPO <- c(
  "PP"        = "#e8d0cc",
  "PPJ"       = "#dce6f0",
  "PP y PPJ"  = "#deeae0",
  "Sin datos" = "#f0f1f2"
)

TEXTO_TIPO <- c(
  "PP"        = "#7a2e29",
  "PPJ"       = "#1a4a6e",
  "PP y PPJ"  = "#2a5c34",
  "Sin datos" = "#55595c"
)

# ═════════════════════════════════════════════════════════════════
# CARGA Y LIMPIEZA DE DATOS
# ═════════════════════════════════════════════════════════════════

provincias_raw <- read_excel("BBDD_Provincias con PP.xlsx") |>
  rename(provincia = Provincia,
         n_municipios = `Cantidad de Municipios con Presupuesto Participativo`) |>
  mutate(codprov_censo = sprintf("%02d", as.integer(codprov_censo))) ##nota: usé el mutate porque en la base la variable que vinculaba a las provincias con el mapa    

municipios_raw <- read_excel("BBDD_Municipios con PP.xlsx") |>
  rename(provincia = PROVINCIA, municipio = NOMBRE) |>
  mutate(tipo = case_when(PP == "SI" & PPJ == "SI" ~ "PP y PPJ",
      PP == "SI" & PPJ == "NO" ~ "PP",
      PPJ == "SI" & PP == "NO" ~ "PPJ",
      TRUE ~ "Sin datos")) |>
  distinct(provincia, municipio, .keep_all = TRUE) |>
  select(provincia, municipio, tipo)

# ═════════════════════════════════════════════════════════════════
# SHAPEFILE + JOIN POR codprov_censo
# ═════════════════════════════════════════════════════════════════

mapa_base <- get_geo(geo = "ARGENTINA", level = "provincia") |>
  left_join(provincias_raw, by = "codprov_censo")

paleta_mapa <- colorNumeric(
  palette  = BURDEOS,
  domain   = log1p(mapa_base$n_municipios),
  na.color = "#d0d0d0")
#paleta_mapa se ajutó de esta menera para ajustar la escala de colores del mapa por la dispersión de los datos

# ═════════════════════════════════════════════════════════════════
# TEMA
# ═════════════════════════════════════════════════════════════════

tema <- bs_theme(bootswatch = "lux", primary = "#7a2e29")
#se eligió esta paleta porque es la que mejor se vincula con el theme lux