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
       y = "Cena (€)") +
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
