#' Moran's Index in TNBC, based on Gabriel neighborhoods
#'
#' Computed from the Mibi-TOF image data in 
#' "A Structured Tumor-Immune Microenvironment in
#' Triple Negative Breast Cancer Revealed by 
#' Multiplexed Ion Beam Imaging" (Keren et al., Cell 2018)
#' 
#' Also includes the tumor classifications assigned
#' in the original paper.
#' 
#' 
#' Output of the compute_morans.Rmd script
#'
#' @format csv with 41 patients, 41 Moran's I scores
#' \describe{
#'   \item{p_id}{patient ID}
#'   \item{cellSize}{Moran's Index for cell size}
#'   \item{Vimentin}{Moran's Index for the Vimentin expression}
#' }
"moran"

