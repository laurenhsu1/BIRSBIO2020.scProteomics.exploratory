library(sf)
library(stars)
library(raster)
library(adespatial)
library(maptools)
library(spdep)
library(stringr)
library(readr)
library(dplyr)

# Some parts of this image processing steps of this script 
# are adapted from code by Pratheepa Jeganathan and Kris Sankaran
# Github: @PratheepaJ @krisrs1128

# download the mibiTOF data from the Angelo Lab
# https://www.angelolab.com/mibi-data
# move the datasets into the DATAPATH directory

###########################################################
# Image loading & spatial processing
###########################################################

DATAPATH <- "../data"
SAVEPATH <- "../data/spatial_proc"

data_dir <- file.path(DATAPATH, "TNBC_shareCellData")

fns <- list.files(data_dir, str_interp(".tiff"))
moran_list <- list()

for(fn in fns){
  samp_list <- list()
  
  f <- paste(data_dir, fn, sep = '/')
  
  samp_id <- str_split_fixed(fn,'_',2)[1] # with p
  sample_id <- as.numeric(str_split_fixed(str_split_fixed(fn,'_',2)[1],'p',2)[2]) # without p as numeric
  samp_list[['samp']] <- samp_id
  
  polys <- read_stars(f) %>%
    st_as_sf(merge = TRUE) %>%
    st_cast("POLYGON")
  colnames(polys)[1] <- colnames(cell_data)[2]
  
  cell_data <- read_csv(file.path(data_dir, "cellData.csv")) %>%
    filter(SampleID == sample_id)
  
  polys <- polys %>%
    inner_join(cell_data) %>%
    group_by(cellLabelInImage) %>% # some regions get split into two adjacent polys --> merge
    summarise_all(first)
  
  samp_list[['polys']] <- polys
  
  nb.maf <- poly2nb(polys)
  xy <- polys %>% st_cast("POINT") %>% st_coordinates()
  nbgab <- graph2nb(gabrielneigh(xy), sym = TRUE)
  
  samp_list[['nb.maf']] <- nb.maf
  samp_list[['xy']] <- xy
  samp_list[['nbgab']] <- nbgab
  
  nblgab <- nb2listw(nbgab)
  distgab <- nbdists(nbgab, xy)
  
  samp_list[['nblgab']] <- nblgab
  samp_list[['distgab']] <- distgab
  
  saveRDS(samp_list, file = paste0(SAVEPATH, samp_id,'.rds'))
}


###########################################################
# Computing Moran's I after processing image files
###########################################################

rdsfolder <- SAVEPATH
pFiles <- file.path(rdsfolder, dir(rdsfolder))

runMoranScript <- function(pFiles){
  pFilesNames <-  reshape2::colsplit(reshape2::colsplit(pFiles,"/",1:4)[,4],"\\.",1:2)[,1]
  
  res<-lapply(pFiles,sc)
  cols <- unique(unlist(sapply(res, names)))
  
  resM <- matrix(NA, ncol=length(cols), nrow=length(pFilesNames), dimnames = list(pFilesNames,cols))
  for (i in seq_along(res)) resM[i,names(res[[i]])]<-res[[i]]
  return(resM)
}

sc<-function(pFile) {
  print(pFile)
  p<-readRDS(pFile)
  if (!exists("p")) Sys.sleep(5)
  print(ls())
  mp<- moranS(sf=p)
  rm(p)
  return(mp)
}

moranS<-function(sf){
  # Exclude non number cols or where max-min =0
  to_drop <- c("cellLabelInImage" ,"SampleID" , "geometry", # non numeric
               'Na','Si','P','Ca','Fe','Background', 'dsDNA','Ta','Au',  # elemental / irrelevant
               'tumorCluster', 'immuneCluster','immuneGroup','Group') # factors
  p <- sf$polys
  nbl <- sf$nblgab
  n <- colnames(p) [! colnames(p) %in% to_drop]
  n <- n[!apply(p[, n,drop=TRUE],2, function(x)max(x)-min(x))==0]
  tt <- lapply(n, function(x) (moran.test(p[,x, drop=TRUE],nbl)))
  ms <- sapply(tt, function(x) x$estimate[1])
  names(ms) <- n
  return(ms)
}

resMoranTest <- runMoranScript(pFiles)
write.csv(resMoranTest, file=paste0(SAVEPATH,"resMoranTest.csv"))

