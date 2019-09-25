install.packages("GGally")
install.packages("fastDummies")
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%

library(readr)
library(ggplot2)
library(GGally)
library(fastDummies)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%

## Importo datos
df_alumnos <- read_delim("https://doc-0o-ac-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/i2027oqeur1hikspvce9vka503b7umge/1569369600000/12156006334743028626/*/12ts1iY-OBkXTnLFjAPLDVcDHQU8k0bA5?e=download", 
                         ";", escape_double = FALSE, trim_ws = TRUE)
View(df_alumnos)
 
## Verificamos la existencia de datos nulos.
valoresNa<-which(is.empty(df_alumnos))
df_alumnos.isnull().any()
View(valoresNa)
##Convertimos las variables categoricas a dummies 
colnames(df_alumnos)
dummyCols <- c("sex", "Pstatus", "address", 
               "famsize", "Mjob", "Fjob","reason",
               "guardian", "schoolsup","famsup", "paid", 
               "activities", "nursery", "higher",
               "internet", "romantic", "freetime")
df_alumnos <- dummy_cols(df_alumnos,  select_columns = dummyCols)
df_alumnos <- select(df_alumnos, -dummyCols)
##Elimino la variable escuela yaque es un dato irrelevante para el analisis
df_alumnos <- select(df_alumnos, -c("school"))
## Vericamos coolinealidad. Funciona? lo probe y no funco capaz hay que cambiar cosas o hacer otra cosa
ggpairs(df_alumnos, lower = list(continuous = "smooth"), 
        diag = list(continuous = "bar"),
        axisLabels = "none")
