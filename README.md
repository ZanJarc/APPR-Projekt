# Trg rabljenih avtomobilov v Sloveniji

Avtor: Žan Jarc 


Repozitorij z gradivi pri predmetu APPR v študijskem letu 2020/21

## Tematika

V projektni nalogi bom analiziral trg rabljenih vozil v Sloveniji. Najprej bom primerjal kateri modeli in katere znamke avtomobilov so najpopularnejši. V nadaljevanju bom analiziral, kakšni avtomobili so se prodajali glede na tip motorja. Analiziral bom tudi kako se cena avtomobila spreminja s starostjo avtomobila, pogojno na znamko avtomobila. Avtomobile bom na podlagi njihove kilometrine, starosti in cene uvrstil v skupine in tako vsakemu avtombilu določil, ali gre za nov avto, rabljen avtomobil ali “kripo”.

*TABELA 1: PODATKI AVTOMOBILOV - Znamka, Model, Letnik, Kilometrina, Motor, Velikost motorja, Menjalnik, Cena, Cas pridobitve podatkov

Vir podatkov: https://www.avto.net/Ads/results_100.asp?oglasrubrika=1

## Program

Glavni program in poročilo se nahajata v datoteki `Analiza.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo, tretji in četrti fazi projekta:

* analiza in vizualizacija podatkov: `vizualizacijaNOVO.r`
* napredna analiza podatkov: `vizualizacijaNOVO.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.


## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `readr` - za branje podatkov
* `dplyr` - za delo s podatki
* `ggplot2` - za izrisovanje grafov
* `factoextra` - za razvrščanje podatkov s skupine
* `ggpubr` - za vizualizacijo podatkov
* `stringr` - delo z nizi
