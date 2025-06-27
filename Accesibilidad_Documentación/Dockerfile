#Usa una imagen base de R
#FROM r-base:latest 
FROM rocker/geospatial
#rocker/shiny
#FROM r-base:4.3.1

# Instala las dependencias del sistema necesarias para R y sus paquetes
RUN sudo apt -y update && apt install -y libudunits2-dev libgdal-dev libgeos-dev libproj-dev libsqlite3-dev


# Actualiza las librerías de R
RUN R -e "update.packages(ask = FALSE, repos = 'https://cran.rstudio.com/')"

# Make a directory in the container
RUN mkdir /home/r-environment


# Install R dependencies
RUN R -e "install.packages(c('sf', 'raster','gdistance'))"
RUN R -e "install.packages(c('sf', 'raster','gdistance'))"
RUN R -e "library(sf)"
RUN R -e "library(raster)"
RUN R -e "install.packages('gdistance')"
RUN R -e "install.packages('gdistance')"

# Copy our R script to the container
COPY /Inputs /home/rstudio/Inputs
COPY Packs.R /home/rstudio/Inputs/Packs.R
#COPY MapitaFinal.R /home/r-environment/Inputs/MapitaFinal.R

#RUN R -e "source('../r-environment/Inputs/Packs.R')"
RUN R -e "print(list.files('../r-environment/Inputs/',recursive=TRUE,pattern='.R$'))"
RUN R -e "print('--------------------------------')"




#Para extraer el ID de un contenedor de Docker
#Para obtener los IDs de los contenedores en ejecución: 
#RUN $docker ps -qf "name=IMAGE_NAME"

#Would run your_image and anything written to /data inside the container would actually 
#write to the host in the ./download directory.
#RUN docker run -v "$(pwd)/download:/data" your_image














#RUN R -e "setwd('../r-environment/Inputs/')"



###Probar
#COPY 

# Run the R script
#CMD R -e "source('/home/r-environment/Inputs/MapitaN.R')"




# Imagen base con R
#FROM r-base:4.3.1

# Crear un usuario no root
#RUN useradd -m ruser

# Crear directorio para el proyecto o para guardar archivos
#RUN mkdir -p /app/output

# Cambiar el propietario del directorio
#RUN chown -R ruser:ruser /app

# Cambiar al usuario no root
#USER ruser

# Establecer el directorio de trabajo
#WORKDIR /app

# Copiar el script R
#COPY script.R .

# Comando por defecto
#CMD ["Rscript", "script.R"]
#################################
#FROM rocker/geospatial
#RUN useradd -m ruser
#RUN mkdir -p /r-environment
#RUN chown -R ruser:ruser /r-environment
#USER ruser
#WORKDIR /r-environment
#RUN sudo apt -y update && apt install -y libudunits2-dev libgdal-dev libgeos-dev libproj-dev libsqlite3-dev
#RUN R -e "install.packages(c('sf', 'raster','gdistance'))"
#COPY /Inputs .
#/home/r-environment/Inputs