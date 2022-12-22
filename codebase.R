library(tidyverse)
library(readxl)
library(here)
library(flextable)
library(webshot2)


#init_flextable_defaults()
set_flextable_defaults(
  post_process_html = autofit,
  post_process_pdf = autofit,
  post_process_docx = autofit
)

style_fnc <- function(ft){
  # format table
  big_border = fp_border_default(color="black", width = 2)
  small_border = fp_border_default(color="gray", width = 1)
  # border_remove()
  
  theme_zebra(ft) |>
    border_inner_h( part="all", border = small_border ) |>  border_inner_v(part="all", border = big_border ) |>  border_outer(part="all", border = big_border )  |>
    align( part = "all", align = "center") |>
    autofit()
}


#import data and add header row
datos_iniciales <-
  read_excel(here::here('data', "sintesis.xlsx"),
             sheet = 1,
             col_types = c("numeric", "text", "text","text","text", "text", 'text')) |>
  flextable() |>
  add_header_row(values = c("DATOS INICIALES"),
                 colwidths = c(7))

informe_snc <- 
  read_excel(here::here('data', "sintesis.xlsx"),
             sheet = 2,
             col_types = c("text", "text", "text","text","text")) |>
  flextable() |>
  add_header_row(values = c("INFORME SNC"),
                 colwidths = c(5))

datos_registros_publicos <- 
  read_excel(here::here('data', "sintesis.xlsx"),
             sheet = 3,
             col_types = c("numeric", "text", "text","text","text", "text", 'text', 'text', 'text', 'text')) |>
  flextable() |>
  add_header_row(values = c("Datos Registros Publicos"),
                 colwidths = c(10))

actividades_realizadas <- 
  read_excel(here::here('data', "sintesis.xlsx"), sheet = 4) |>
  flextable() |>
  add_header_row(values = c("Actividades Realizades"),
                 colwidths = c(5))

#apply style and save as png
datos_iniciales |> style_fnc() |> save_as_image(path = 'datos_iniciales.png' )

informe_snc |> style_fnc() |> save_as_image(path = 'informe_snc.png' )

datos_registros_publicos |> style_fnc() |> save_as_image(path = 'datos_registros_publicos.png' )

actividades_realizadas |> style_fnc() |> save_as_image(path = 'actividades_realizadas.png' )
