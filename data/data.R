#' Tumor classifications from Keren et al. 2018
#'
#' A table containing the tumor classifications by
#' tumor-immune mixing from 
#' "A Structured Tumor-Immune Microenvironment in
#' Triple Negative Breast Cancer Revealed by 
#' Multiplexed Ion Beam Imaging" (Keren et al., Cell 2018)
#' 
#'
#' @format A csv with the tumor classifications for 41 patients
#' \describe{
#'   \item{p_id}{patient ID}
#'   \item{tumor_class}{class of tumor; 0=mixed, 1=compartmentalized, 2=cold}
#' }
#' @source \url{https://www.angelolab.com/mibi-data}
"patient_class"


#' Moran's Index in TNBC, based on Gabriel neighborhoods
#'
#' Computed from the Mibi-TOF image data in 
#' "A Structured Tumor-Immune Microenvironment in
#' Triple Negative Breast Cancer Revealed by 
#' Multiplexed Ion Beam Imaging" (Keren et al., Cell 2018)
#' 
#' (Output of the compute_morans.Rmd script)
#'
#' @format csv with 41 patients, 41 Moran's I scores
#' \describe{
#'   \item{p_id}{patient ID}
#'   \item{cellSize}{Moran's Index for cell size}
#'   \item{Vimentin}{Moran's Index for the Vimentin expression}
#'   ...
#' }
#' @source \url{https://www.angelolab.com/mibi-data}
"resMoranTest"
