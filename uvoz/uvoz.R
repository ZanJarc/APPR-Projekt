
#Data prep
data <- read.csv("podatki/avtomobili.csv", encoding = "UTF-8")

data <- data[,c(1:9)]
names(data) <- c("Znamka", "Model", "Letnik", "Kilometrina", "Motor", "Velikost_motorja","Menjalnik", "Cena", "Cas_pridobitve_podatkov")

summary(data)

data$Celo_ime <- paste(data$Znamka, data$Model, sep=" ")

#Urejanje datuma pridobitve podatkov

data$Mesec_pridobitve_podatkov = str_split_fixed(str_sub(data$Cas_pridobitve_podatkov, 2, -2), ", ", 2)[,2]
data$Dan_pridobitve_podatkov = str_split_fixed(str_sub(data$Cas_pridobitve_podatkov, 2, -2), ", ", 2)[,1]

data <- data %>% mutate(Cas_pridobitve_podatkov = ifelse(Mesec_pridobitve_podatkov > 1,
                                                         paste(2018, Mesec_pridobitve_podatkov, Dan_pridobitve_podatkov, sep = "-"),
                                                         paste(2019, Mesec_pridobitve_podatkov, Dan_pridobitve_podatkov, sep = "-")
)
)


data <- data %>% subset(select = -c(Mesec_pridobitve_podatkov, Dan_pridobitve_podatkov))

data <- data[data$Znamka != "",] #napacen zajem podatkov

#Data prep for shiy
data_shiny <- data

names(data_shiny) <- c("Znamka", "Model", "Letnik", "Kilometrina (km)", "Motor", "Velikost_motorja (ccm)", "Menjalnik", "Cena (€)","Cas_pridobitve_podatkov", "Celo_ime")




