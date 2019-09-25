library(readr)

## Importo datos
df_alumnos <- read_delim("https://doc-0o-ac-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/i2027oqeur1hikspvce9vka503b7umge/1569369600000/12156006334743028626/*/12ts1iY-OBkXTnLFjAPLDVcDHQU8k0bA5?e=download", 
                         ";", escape_double = FALSE, trim_ws = TRUE)
View(df_alumnos)
