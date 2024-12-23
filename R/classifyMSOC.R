#' classify multi-omics subtypes for high-grade serous ovarian cancer (MSOC).
#' This function classifies molecular subtypes for high-grade serous ovarian cancer, based on any combination of mRNA expression, microRNA expression, DNA methylation, copy number variation, and mutation data.
#'
#' @param exp expression matrix with samples in rows and multi-omics features in columns. The column names of exp should be X1, X2, ..., X100.
#' @return A list label: a vector indicating the predicted subtype for each sample. prob: A data frame where each row represents a sample and each column represents the predicted probability for each subtype.
#' @export
#' @import caret stats
#' @importFrom stats predict
#' @examples
#' data("rna_log_tpm_ICGC")
#' data("mir_ICGC")
#' data("methy_M_ICGC")
#' data("cnv_ICGC")
#' data("mut_ICGC")
#' data("TCGA_projection_mx")
#' data("TCGAmRNAscaled")
#' data("TCGAmiRNAscaled")
#' data("TCGAmetscaled")
#' data("TCGAcnvscaled")
#' data("TCGAmutscaled")
#' geneexp_bf_mapping = rna_log_tpm_ICGC[colnames(TCGAmRNAscaled), ]
#' geneexp_bf_mapping = t(scale(t(geneexp_bf_mapping)))
#' mirexp_bf_mapping = mir_ICGC[colnames(TCGAmiRNAscaled), ]
#' mirexp_bf_mapping = t(scale(t(mirexp_bf_mapping)))
#' methy_bf_mapping = methy_M_ICGC[colnames(TCGAmetscaled), ]
#' methy_bf_mapping = t(scale(t(methy_bf_mapping)))
#' cnv_bf_mapping = cnv_ICGC[colnames(TCGAcnvscaled), ]
#' cnv_bf_mapping = t(scale(t(cnv_bf_mapping)))
#' mut_bf_mapping = mut_ICGC[colnames(TCGAmutscaled), ]
#' mut_bf_mapping = t(scale(t(mut_bf_mapping)))
#' mut_bf_mapping[is.na(mut_bf_mapping)]=0
#' mRNAexprCCA = t(geneexp_bf_mapping) %*% TCGA_projection_mx$ws[[1]]
#' mRNAexprCCA_2 = scale(mRNAexprCCA)
#' miRNAexprCCA = t(mirexp_bf_mapping) %*% TCGA_projection_mx$ws[[2]]
#' miRNAexprCCA_2 = scale(miRNAexprCCA)
#' methyexprCCA = t(methy_bf_mapping) %*% TCGA_projection_mx$ws[[3]]
#' methyexprCCA_2 = scale(methyexprCCA)
#' cnvexprCCA = t(cnv_bf_mapping) %*% TCGA_projection_mx$ws[[4]]
#' cnvexprCCA_2 = scale(cnvexprCCA)
#' mutexprCCA = t(mut_bf_mapping) %*% TCGA_projection_mx$ws[[5]]
#' mutexprCCA_2 = scale(mutexprCCA)
#' a1 = a2 = a3 = a4 = a5 = 0.2
#' data_input = a1*mRNAexprCCA_2 + a2*miRNAexprCCA_2 + a3*methyexprCCA_2 + a4*cnvexprCCA_2 + a5*mutexprCCA_2
#' colnames(data_input) = paste("X",1:ncol(data_input),sep = "")
#' result <- classifyMSOC(data_input)
#' label <- result$label
#' prob <- result$prob



classifyMSOC <-function(data_input) {
  model <- load_model()
  probs <- predict(model, newdata = as.data.frame(data_input), type = "prob")
  label <- as.factor(apply(probs, 1, function(t) colnames(probs)[which.max(t)]) )
  names(label) <- rownames(data_input)
  result <- list(label=label, prob=probs)
  return(result)
}
