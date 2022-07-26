#NDVI

#Carregando os pacotes
install.packages("raster")
require(raster)
install.packages("rgdal")
require(rgdal)
install.packages("terra")
library("terra")

#alterando pasta padr�o
getwd()
setwd("C:/Users/roger/Documents/NDVI - Santana Do Araguaia/")


#carregando uma banda como exemplo
banda_exemplo = raster("CBERS_4A_WPM_20220703_211_126_L4_BAND3.TIF")
plot(banda_exemplo, col = gray(0:100/100))

#Reflect�ncia de superficie variando de 0 at� 8000


#criar um stack, que � basicamente a composi��o (composite bands no arcGIS)

bands_Santana_araguaia = stack("CBERS_4A_WPM_20220703_211_126_L4_BAND1.TIF",
                                 "CBERS_4A_WPM_20220703_211_126_L4_BAND2.TIF",
                                 "CBERS_4A_WPM_20220703_211_126_L4_BAND3.TIF",
                                 "CBERS_4A_WPM_20220703_211_126_L4_BAND4.TIF")

bands_Santana_araguaia

#verificar a ordem
names(bands_Santana_araguaia)


#criando o plot da composi��o (cor verdadeira)
plotRGB(bands_Santana_araguaia, r=3, g=2, b=1, axes=T, stretch='lin', main="Cor verdadeira - Santana do Araguaia")


#recortando a imagem
recorte = crop(bands_Santana_araguaia, extent(525900,568416,8849802,8893278))


#recriando o plot de composi��o verdadeira
plotRGB(recorte, r=3, g=2, b=1, axes=T, stretch='lin', main="Cor verdadeira - Santana do Araguaia")

#NDVI
NDVI = (recorte$CBERS_4A_WPM_20220703_211_126_L4_BAND4-recorte$CBERS_4A_WPM_20220703_211_126_L4_BAND3)/
  (recorte$CBERS_4A_WPM_20220703_211_126_L4_BAND4+recorte$CBERS_4A_WPM_20220703_211_126_L4_BAND3)

plot(NDVI)
