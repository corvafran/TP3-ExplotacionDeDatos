install.packages("GGally")
install.packages("fastDummies")
install.packages("funModeling")
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%

library(readr)
library(ggplot2)
library(funModeling)
library(GGally)
library(fastDummies)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%
##Seteo mi working directory
setwd("~/Documents/UNO Facultad/Explotacion de datos/TP3-ExplotacionDeDatos")

## Importo datos
df_alumnos <- read_delim("student-mat.csv", 
                         ";", escape_double = FALSE, trim_ws = TRUE)
View(df_alumnos)
## Filtrar casos no deseados
# Analizar los datos ingresados
my_data_status=df_status(df_alumnos, print_results = F)
##Elimino filas G1, G2 y G3 que contengan 0
df_alumnos <- df_alumnos[!(df_alumnos$G2==0) &!(df_alumnos$G1==0) & !(df_alumnos$G3==0) , ] 
## Ordenar datos según el porcentaje de ceros
arrange(my_data_status, -p_zeros) %>% select(variable, q_zeros, p_zeros)
# Quitar las variables que tienen un 60% de valores cero
vars_to_remove=filter(my_data_status, p_zeros > 60)  %>% .$variable
vars_to_remove
##Las eliminamos, en este caso no se elimina nada
##porque no tenemos ninguna que cumpla esta condicion
df_alumnos = select(df_alumnos, -one_of(vars_to_remove))
## Verificamos la existencia de datos nulos.
valoresNa<-which(is.empty(df_alumnos))
df_alumnos.isnull().any()
View(valoresNa)

##Elimino la variable escuela yaque es un 
##dato irrelevante para el analisis 
##como la escuela, el sexo y la edad
##yaque por este analisis no van a ser patrones que nos interese ver
## df_alumnos <- select(df_alumnos, -c("school"))
##Fuciono el promedio de los tres trimestres
df_alumnos$promedioTrimestres<- ((df_alumnos$G1 
                                + df_alumnos$G2 
                                + df_alumnos$G3) /3)
##Elimino los trimestres de la tabla
df_alumnos <- select(df_alumnos, -c("G1", "G2", "G3"))
df_alumnos$promedioTrimestres
View(df_alumnos)
##describe nos permite analizar rápidamente un conjunto
##de datos completo para variables númericas y categóricas
##y vemos que no tenemos mas valores missing(cantidad de valores faltantes)
describe(df_alumnos)

## Vericamos coolinealidad. 
ggpairs(df_alumnos, lower = list(continuous = "smooth"), 
        diag = list(continuous = "bar"),
        axisLabels = "none")

glimpse(df_alumnos)
##Funcion summary
summary(df_alumnos) 
##Test de correlación
ggpairs(df_alumnos, lower = list(continuous = "smooth"),
        diag = list(continuous = "bar"), axisLabels = "none")
colnames(df_alumnos)
modelo <- lm(promedioTrimestres ~ absences + sex + age + asesinatos +
               universitarios + heladas + area + densidad_pobl, data = datos )

##Coorelacion entre var

##Convertimos las variables categoricas a dummies 
colnames(df_alumnos)
dummyCols <- c("school","sex", "Pstatus", "address", 
               "famsize", "Mjob", "Fjob","reason",
               "guardian", "schoolsup","famsup", "paid", 
               "activities", "nursery", "higher",
               "internet", "romantic", "freetime")
df_alumnos <- dummy_cols(df_alumnos,  select_columns = dummyCols)
df_alumnos <- select(df_alumnos, -dummyCols)

boxplot(df_alumnos)
##Una vez que tenemos las dummies hay que generar el modelo
##De esta forma vamos el impacto que tienen las dummies y 
##el incremento provocado de la variable independiente sobre la dependiente
## modelo <- lm(esp_vida ~ habitantes + ingresos + analfabetismo + asesinatos +
##           universitarios + heladas + area + densidad_pobl, data = datos )
summary(modelo)

round(cor(x = df_alumnos, method = "pearson"), 3)
summary(modelo)