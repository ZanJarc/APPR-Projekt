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






