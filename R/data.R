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
#' Output of the compute_morans.Rmd script
#' 
#' The proteins included in this dataset are:
#' Vimentin, SMA, Lag3, CD4, CD16, CD56, PD1, CD31, Ki67, CD209, CD11c, CD138, CD68, CSF.1R, CD8, CD3, IDO, Keratin17, CD63, CD45RO, CD20, p53, Beta.catenin, HLA.DR, CD11b, CD45, H3K9ac, Pan.Keratin, H3K27me3, phospho.S6, MPO, Keratin6, HLA_Class_1, B7H3, FoxP3, OX40, PD.L1, EGFR, CD163
#' 
#' Each column provides the Moran's I's on that variable for each sample. See Vimentin below as example.
#'
#' @format data.frame with 35 patients, 42 Moran's I scores
#' \describe{
#'   \item{p_id}{patient ID}
#'   \item{cellSize}{Moran's Index for cell size}
#'   \item{Vimentin}{Moran's Index for the Vimentin expression. This is computed the same way as each other protein, and the column name indicates which protein.}
#'   \item{tumorYN}{Moran's Index for dummy variable of whether cell is tumor or not (computed on 0,1)}
#'   \item{class}{class of tumor: mixed, compartmentalized, cold}
#' }
"moran"

