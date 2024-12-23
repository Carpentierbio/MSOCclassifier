#' Gene expression profile of TCGA-OV.
#'
#' A dataset containing the pre-processed mRNA exoression profile of 226 TCGA high-grade serous ovarian cancer samples.
#'
#' @format A microRNA exoression profile with 5000 mRNAs and 226 samples.
"TCGAmRNAscaled"


#' microRNA exoression profile of TCGA-OV.
#'
#' A dataset containing the pre-processed microRNA exoression profile of 226 TCGA high-grade serous ovarian cancer samples.
#'
#' @format A microRNA exoression profile with 100 microRNAs and 226 samples.
"TCGAmiRNAscaled"


#' DNA methylation profile of TCGA-OV.
#'
#' A dataset containing the pre-processed DNA methylation profile of 226 TCGA high-grade serous ovarian cancer samples.
#'
#' @format A DNA methylation profile with 2000 gene symbols and 226 samples.
"TCGAmetscaled"


#' Copy number variation profile of TCGA-OV.
#'
#' A dataset containing the pre-processed gene-level copy number variation profile of 226 TCGA high-grade serous ovarian cancer samples.
#'
#' @format A DNA methylation profile with 5000 gene symbols and 226 samples.
"TCGAcnvscaled"


#' Mutation profile of TCGA-OV.
#'
#' A dataset containing the pre-processed gene mutation profile of 226 TCGA high-grade serous ovarian cancer samples.
#'
#' @format A DNA methylation profile with 200 gene symbols and 226 samples.
"TCGAmutscaled"


#' Projection matrixs derived from 226 paired mRNA expression, microRNA expression, DNA methylation, copy number variation, and mutation data from TCGA-OV samples.
#'
#' A list containing projection matrixs of each omics. In the list, under ws, the five elements correspond to the projection matrices for mRNA, microRNA, methylation, copy number variation, and mutation.
#'
#' @format A list derived from sparse mCCA using PMA::MultiCCA()
"TCGA_projection_mx"


#' Gene expression profile of ICGC-OV.
#'
#' A dataset containing example validation gene expression data for testing.
#'
#' @format A data frame with z-score scaled values, samples in columns, genes in rows, rownames corresponding to gene ensembl IDs.
#' @source \url{https://dcc.icgc.org/projects/OV-AU}
"rna_log_tpm_ICGC"


#' microRNA expression profile of ICGC-OV.
#'
#' A dataset containing example validation microRNA expression data for testing.
#'
#' @format A data frame with z-score scaled values, samples in columns, genes in rows, rownames corresponding to mature microRNA IDs.
#' @source \url{https://dcc.icgc.org/projects/OV-AU}
"mir_ICGC"


#' DNA methylation profile of ICGC-OV.
#'
#' A dataset containing example validation DNA methylation data for testing.
#'
#' @format A data frame with z-score scaled M values, samples in columns, genes in rows, rownames corresponding to gene symbols.
#' @source \url{https://dcc.icgc.org/projects/OV-AU}
"methy_M_ICGC"


#' Copy number variation profile of ICGC-OV.
#'
#' A dataset containing example validation copy number variation data for testing.
#'
#' @format A data frame with copy number variation values, samples in columns, genes in rows, rownames corresponding to gene symbols.
#' @source \url{https://dcc.icgc.org/projects/OV-AU}
"cnv_ICGC"


#' Gene mutation profile of ICGC-OV.
#'
#' A dataset containing example validation gene muation data for testing.
#'
#' @format A data frame with mutation values, samples in columns, genes in rows, rownames corresponding to gene symbols.
#' @source \url{https://dcc.icgc.org/projects/OV-AU}
"mut_ICGC"

