library(dplyr)
library(ggplot2)
library(stringr)
library(factoextra)
library(ggpubr)

#Data prep
data <- read.csv("C:/Users/Uporabnik/Desktop/APPR projekt 2020/Avtomobili/uvoz/avtomobili.csv", encoding = "UTF-8")

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



stevilo_vrstic <- nrow(data)
summary(data)

data <- data[data$Znamka != "",] #napacen zajem podatkov




#Pregled najbolj prodajanih modelov

stetje_modelov <-data %>% count(data$Celo_ime, sort = TRUE)

names(stetje_modelov) <- c("Celo_ime", "Stevilo")

top10_prodajanih <- stetje_modelov[c(1:10),]



graf1 <- ggplot(top10_prodajanih, aes(x = reorder(Celo_ime, Stevilo), y = Stevilo, fill = reorder(Celo_ime, Stevilo)))+
  geom_bar(stat = "identity")+
  geom_text(aes(label = Stevilo), vjust = -0.25)+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 1))+
  theme(axis.text.x = element_text(size = 7))+
  labs(title = "Najbolj prodajani",
       x = "Ime modela",
       y = "Število oglasov",
       fill = "Ime modela")


#Pregled glede na vrsto motorja

vrsta_motorjev <-data %>% count(Motor, sort = TRUE)

names(vrsta_motorjev) <- c("Motor", "Stevilo")

graf2 <- ggplot(vrsta_motorjev, aes(x = reorder(Motor, Stevilo), y = Stevilo, fill = reorder(Motor, Stevilo)))+
  geom_bar(stat = "identity")+
  geom_text(aes(label = Stevilo), vjust = -0.25)+
  labs(title = "Pregled glede na vrsto motorja avtomoobila",
       x = "Vrsta motorja",
       y = "Število oglasov",
       fill = "Vrsta motorja"
       )

#Pregled glede na letnik avtomobila

najstarejsi_letnik <- min(data$Letnik) # najstarejsi letnik 1968

stetje_starost <-data %>% count(data$Letnik, sort = TRUE)

names(stetje_starost) <- c("Letnik", "Stevilo")


graf3 <- ggplot(stetje_starost, aes(x = Letnik, y = Stevilo))+
  geom_line()+
  geom_point()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
  scale_x_continuous("Letnik prve registracije", labels = as.character(stetje_starost$Letnik), breaks = stetje_starost$Letnik)+
  geom_text(aes(label = Stevilo), vjust = -0.25)+
  labs(title = "Število oglasov glede na letnik prve registracije",
       x = "Letnik prve registracije",
       y = "Število oglasov")

#Za pregled trenda starosti vozil po znamkah, bo analiza le za znamke, za katere imamo vec kot 10 vnosov

data_relavantne_znamke <- data %>%
  group_by(Znamka) %>%
  filter(n() >= 10)

znamke <- data_relavantne_znamke %>% group_by(Znamka) %>% count(Znamka, sort = TRUE)
names(znamke) <- c("Znamke", "Število oglasov")


graf4 <- ggplot(filter(data_relavantne_znamke, (Letnik > 1990 & Cena < 50000)), aes(x=Letnik, y = Cena))+
  geom_point()+
  stat_smooth(method = "lm", formula = y ~ x, col = "red")+
  stat_regline_equation(label.y = 45000, aes(label = ..eq.label..), size = 3) +
  stat_regline_equation(label.y = 35000, aes(label = ..rr.label..), size = 3) +
  labs(title = "Linearna odvisnost cene vozila od leta prve registacije, razdeljeno na znamko vozila",
       x = "Letnik prve registracije",
       y = "Cena") +
  facet_wrap(~ Znamka, ncol = 3) 
 
  



##Dvodimenzionalni kmeans







#Pregled glede na prevoženo kilometrino avtomobila
ggplot(data, aes(x=Kilometrina, y = Cena))+
  geom_point()

kmeans_matrix_price_km <- data %>% select(Cena, Kilometrina) %>% 
  as.matrix() %>% 
  scale()

fviz_nbclust(kmeans_matrix_price_km, FUN = kmeans, method = "wss") # vzeli bi 2-3 po  pravilu komolca 
fviz_nbclust(kmeans_matrix_price_km, FUN = kmeans, method = "silhouette") # vzeli bi 3
#fviz_nbclust(kmeans_matrix_price_km, FUN = kmeans, method = "gap_stat", nstart = 25, nboot = 300) ni konvergence

model_kmeans_price_km_3 <- kmeans(kmeans_matrix_price_km, 3)
razvrstitev_price_km_3 <- model_kmeans_price_km_3$cluster

ggplot(data, aes(x = Kilometrina, y = Cena, col = razvrstitev_price_km_3))+
  geom_point()






