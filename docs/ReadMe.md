# **MSOCclassifier**: an R package for multi-omics subtyping of high-grade serous ovarian cancer

The `MSOCclassifier` package provides multi-omics subtyping for high-grade serous ovarian cancer. It accepts any combination of mRNA expression, microRNA expression, DNA methylation, copy number variation, and mutation data as input. The training data of the classifier is integrated from the three omics data based on [sparse mCCA](https://www.degruyter.com/document/doi/10.2202/1544-6115.1470/html). See [accompagnying vignette](https://Carpentierbio.github.io/MSOCclassifier/MSOCclassifier.html) for further details.


## Set up

The `MSOCclassifier` package requires R (>= 2.10), and depends on the R packages "caret".
Use the following command in R to install the `MSOCclassifier` package:
```
library(devtools)
install_github("Carpentierbio/MSOCclassifier") # install the "MSOCclassifier" package
```

## Quick start
The detailed multi-omics integration and pre-processing steps can be referred to here: [https://github.com/Carpentierbio/MSOC](https://github.com/Carpentierbio/MSOC).
```
library(caret)
library(MSOCclassifier)

## MSOC prediction of primary high-grade serous ovarian cancer samples
# Take ICGC-OV as an example
data("rna_log_tpm_ICGC")
data("mir_ICGC")
data("methy_M_ICGC")
data("cnv_ICGC")
data("mut_ICGC")

# Load projection matrices derived from 226 TCGA-OV samples
data("TCGA_projection_mx")

# Load pre-processed TCGA-OV multi-omics data for feature selection in validation cohort
data("TCGAmRNAscaled")
data("TCGAmiRNAscaled")
data("TCGAmetscaled")
data("TCGAcnvscaled")
data("TCGAmutscaled")

# ensure that the number and order of features in the test data are identical to those in the training data (TCGA)
geneexp_bf_mapping = rna_log_tpm_ICGC[colnames(TCGAmRNAscaled), ]
geneexp_bf_mapping = t(scale(t(geneexp_bf_mapping)))
mirexp_bf_mapping = mir_ICGC[colnames(TCGAmiRNAscaled), ]
mirexp_bf_mapping = t(scale(t(mirexp_bf_mapping)))
methy_bf_mapping = methy_M_ICGC[colnames(TCGAmetscaled), ]
methy_bf_mapping = t(scale(t(methy_bf_mapping)))
cnv_bf_mapping = cnv_ICGC[colnames(TCGAcnvscaled), ]
cnv_bf_mapping = t(scale(t(cnv_bf_mapping)))
mut_bf_mapping = mut_ICGC[colnames(TCGAmutscaled), ]
mut_bf_mapping = t(scale(t(mut_bf_mapping)))
mut_bf_mapping[is.na(mut_bf_mapping)]=0

# Projecting each omics data into an unified space
mRNAexprCCA = t(geneexp_bf_mapping) %*% TCGA_projection_mx$ws[[1]]
mRNAexprCCA_2 = scale(mRNAexprCCA)
miRNAexprCCA = t(mirexp_bf_mapping) %*% TCGA_projection_mx$ws[[2]]
miRNAexprCCA_2 = scale(miRNAexprCCA)
methyexprCCA = t(methy_bf_mapping) %*% TCGA_projection_mx$ws[[3]]
methyexprCCA_2 = scale(methyexprCCA)
cnvexprCCA = t(cnv_bf_mapping) %*% TCGA_projection_mx$ws[[4]]
cnvexprCCA_2 = scale(cnvexprCCA)
mutexprCCA = t(mut_bf_mapping) %*% TCGA_projection_mx$ws[[5]]
mutexprCCA_2 = scale(mutexprCCA) # samples in rows and genes in columns 

# Multi-omics data fusion
a1 = a2 = a3 = a4 = a5 = 0.2
data_input = a1*mRNAexprCCA_2 + a2*miRNAexprCCA_2 + a3*methyexprCCA_2 + a4*cnvexprCCA_2 + a5*mutexprCCA_2
colnames(data_input) = paste("X",1:ncol(data_input),sep = "")

result <- classifyMSOC(data_input)
label <- result$label
prob <- result$prob %>%
  `colnames<-`(paste("MSOC", 1:5, "_prob", sep = ""))
res <- data.frame(prob, subtype = paste("MSOC", label, sep = "") ) %>%
  `rownames<-`(names(label))
head(res)

```

## Design

Package was developed in _[RStudio](https://www.rstudio.com/)_ following guidelines in [R packages](http://r-pkgs.had.co.nz/).
