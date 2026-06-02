anual= read.csv("datos/anual.csv")
anual$Indicador= stringr::str_squish(anual$Indicador)#Elimina espacio y letras duplicadas

bianual=read.csv("datos/bianual.csv")
bianual$Indicador=stringr::str_squish(bianual$Indicador)

mensual=read.csv("datos/mensual.csv")
mensual$Indicador=stringr::str_squish(mensual$Indicador)

quinquenal=read.csv("datos/quinquenal.csv")
quinquenal$Indicador=stringr::str_squish(quinquenal$Indicador)

trianual=read.csv("datos/trianual.csv")
trianual$Indicador=stringr::str_squish(trianual$Indicador)

trimestral=read.csv("datos/trimestral.csv")
trimestral$Indicador=stringr::str_squish(trimestral$Indicador)

temporalidad= read.csv("datos/temporalidad.csv")

temp_anual = temporalidad|> dplyr::filter(Temporalidad=="Anual")
temp_anual$Indicador= stringr::str_squish(temp_anual$Indicador)

temp_bianual= temporalidad |> dplyr::filter(Temporalidad=="Bianual")
temp_bianual$Indicador= stringr::str_squish(temp_bianual$Indicador)

temp_mensual= temporalidad |> dplyr::filter(Temporalidad=="Mensual")
temp_mensual$Indicador= stringr::str_squish(temp_mensual$Indicador)


temp_quinquenal= temporalidad |> dplyr::filter(Temporalidad=="Quinquenal")
temp_quinquenal$Indicador= stringr::str_squish(temp_quinquenal$Indicador)

temp_trianual= temporalidad |> dplyr::filter(Temporalidad=="Trianual")
temp_trianual$Indicador=stringr::str_squish(temp_trianual$Indicador)

temp_trimestral= temporalidad |> dplyr::filter(Temporalidad=="Trimestral")
temp_trimestral$Indicador=stringr::str_squish(temp_trimestral$Indicador)

#Comparacion entre data frames
anual_unicos =anual$Indicador |> unique() 
temp_anual$Indicador %in% anual_unicos
anual_unicos %in% temp_anual$Indicador

bianual_unicos= bianual$Indicador |> unique()
bianual_unicos %in% temp_bianual$Indicador

mensual_unicos= mensual$Indicador |> unique()
mensual_unicos %in% temp_mensual$Indicador

quinquenal_unicos= quinquenal$Indicador |> unique()
quinquenal_unicos %in% temp_quinquenal$Indicador
temp_quinquenal$Indicador %in% quinquenal_unicos

trianual_unicos= trianual$Indicador |> unique()
trianual_unicos %in% temp_trianual$Indicador
temp_trianual$Indicador %in% trianual_unicos

trimestral_unicos= trimestral$Indicador |> unique()
trimestral_unicos %in% temp_trimestral$Indicador
temp_trimestral$Indicador %in% trimestral_unicos

