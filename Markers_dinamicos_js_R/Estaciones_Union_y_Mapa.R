library(sf)
library(openxlsx)
library(openxlsx)
library(stringr)
library(purrr)

lugares=read_sf("../estaciones.shp")
lugares$Dscrpcn=str_to_title(str_squish(lugares$Dscrpcn))
Base1=readxl::read_excel("../Transporte_TUZO_Mensual.xlsx")
DATA1=as.data.frame(Base1[-c(1,2,6,7,21,22),])
DATA1$Estaciones=stringr::str_to_title(DATA1$Estaciones)
DATA1$Estaciones=chartr("ÁÉÍÓÚ", "AEIOU", DATA1$Estaciones)
DATA1$Estaciones=chartr("áéíóú", "aeiou", DATA1$Estaciones)
DATA1$Estaciones=gsub("\\.", "", DATA1$Estaciones)
X=as.data.frame(cbind(lugares$Dscrpcn,lugares$geometry))
colnames(X)[1]="Estaciones"



####
lugares=lugares |> dplyr::select(Dscrpcn,geometry)
lugares$Dscrpcn=chartr("ÁÉÍÓÚ", "AEIOU", lugares$Dscrpcn)
lugares$Dscrpcn=chartr("áéíóú", "aeiou", lugares$Dscrpcn)
lugares$Dscrpcn=gsub("\\.", "", lugares$Dscrpcn)
lugares$Dscrpcn[22]="Cuna Del Futbol"
union=merge(DATA1,lugares |> dplyr::mutate(Dscrpcn=stringr::str_to_title(Dscrpcn)),by.x='Estaciones',by.y='Dscrpcn',all=TRUE)
colnames(union)[1]="ESTACIONES"
#colnames(union)[13]="GEOMETRY"
colnames(union)[4]="DICIEMBRE 2024"
union=st_as_sf(union)
sf::write_sf(union,"../Estaciones_g.gpkg")

union=read_sf("../Estaciones_g.gpkg")

sf::write_sf(union, "Estaciones_TUZO_2025.shp",,names,)
###
library(leaflet)
library(leaflet.extras)
library(sf)
library(htmltools)
library(htmlwidgets)
library(leaflegend)


circle_marker <- makeIcon(
  iconUrl = "../CirculoA.png",
  iconWidth = 25, iconHeight = 25,
  iconAnchorX = 10, iconAnchorY = 10,
)

mapa_web=leaflet() |> addTiles()
p=c(2:12)
for(i in p){
  mapa_web=mapa_web |> addHeatmap(data=union |> as("Spatial"),radius = 20,intensity = as.numeric(unlist(as.vector(unname(st_drop_geometry(union[,i]))))),max=1500,minOpacity=0.5,group = colnames(union)[i]) |> 
    addMarkers(data=union |> as("Spatial"),label = paste0(unlist(as.vector(unname(st_drop_geometry(union[,1]))))," : ",as.numeric(unlist(as.vector(unname(st_drop_geometry(union[,i])))))," usuarios"),icon=circle_marker,labelOptions = (cex= 100),group = colnames(union)[i])
  
}
mapa_web=mapa_web |> addLayersControl(baseGroups = colnames(union)[-c(1,13)],options = layersControlOptions(collapsed = F))
mapa_web <- htmlwidgets::onRender(mapa_web, "
  function(el, x) {
    var map = this;
    
    // Función para ajustar el tamaño del ícono según el nivel de zoom
    function resizeMarkers() {
      var zoom = map.getZoom();
      
      // Cambiar el tamaño de cada marcador
      map.eachLayer(function(layer) {
        if (layer.options && layer.options.icon && layer.options.icon.options) {
          var newSize;
          if (zoom<=14) {
            newSize = 0.005
          } else {
            newSize = (zoom+20)/2
          }

          // Ajustar el tamaño del icono
          var iconSize = [newSize, newSize];
          layer.setIcon(
            L.icon({
              iconUrl: layer.options.icon.options.iconUrl,
              iconSize: iconSize,
              iconAnchor: [iconSize[0] / 2, iconSize[1] / 2]
            })
          );
        }
      });
    }

    // Llamar a resizeMarkers en eventos de zoom y al cargar el mapa
    map.on('zoomend', resizeMarkers);
    map.whenReady(resizeMarkers);
    map.on('baselayerchange',resizeMarkers);
  }
")

mapa_web
###############

