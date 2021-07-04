#' Scaled GTEx muscle covariance matrix for 500 genes
#'
#' GTEx v8 skeletal muscle data objects of the same name as the files used below were downloaded from the GTEx portal 
#' and processed.
#' There was a total of 803 samples that had both RNA-seq data and metadata. These were used to estimate dependence 
#' structure for omics simulations. We prepare metadata for sex, age, RIN Number, and total ischemic time, as 
#' these are the variables suggested by the GTEx Portal analysis pipeline. 
#' Missing values in RIN Number and total ischemic time are imputed as the median. 
#' Age is 10-year ranges (20-29, 30-39...) and we use the mean age in each range (25, 35...).
#' We processed the counts using limma-voom, and estimated sources of unwanted variation using 
#' surrogate variable analysis (SVA). We removed the unwanted variation and the effects of the exposures (e.g. sex & age)
#' because we added our own exposure effects in the simulations. We scaled the covariance matrix so that the median
#' variance per gene was one.
#'
#' @source \url{https://gtexportal.org/home/datasets}

options(stringsAsFactors=FALSE)

library(AnnotationDbi)
library(org.Hs.eg.db)
library(readr)

# counts
counts <- readr::read_tsv("GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_reads.gct", skip = 2)
counts <- data.frame(counts, row.names = 1, check.names = FALSE)
# rm 44 genes like ENSG00000228572.7_PAR_Y
counts <- counts[-grep("_", rownames(counts)), ]
rownames(counts) <- gsub("\\..*", "", rownames(counts))

# pheno
pheno <- readr::read_tsv("GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt")
pheno <- data.frame(pheno[pheno$SMTSD == "Muscle - Skeletal", c("SAMPID", "SMRIN","SMTSISCH")], row.names = 1)
com.nms <- intersect(rownames(pheno), colnames(counts)) 
pheno <- pheno[com.nms,]
counts <- counts[, com.nms]

pheno1 <- readr::read_tsv("GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt")
pheno1 <- data.frame(pheno1[, 1:3], row.names = 1)
ids <- colsplit(rownames(pheno), pattern = "-", names = 1:4)[, 1:2]
ids <- apply(ids, MARGIN = 1, FUN = paste, collapse = "-")
pheno <- cbind(pheno, pheno1[ids, ])
pheno$SMTSISCH[is.na(pheno$SMTSISCH)] <- median(pheno$SMTSISCH, na.rm = TRUE)
pheno$SMRIN[is.na(pheno$SMRIN)] <- median(pheno$SMRIN, na.rm = TRUE)
pheno$SEX <- ifelse(pheno$SEX == 1, "Male", "Female")
pheno$SEX <- factor(pheno$SEX, levels = c("Male", "Female"))
pheno$AGE <- as.numeric(gsub("-.*", "", pheno$AGE)) + 5

# annot
annot <- counts[, 1, drop = FALSE]
counts[,1] <- NULL
colnames(annot) <- "symbol"
annot1 <- AnnotationDbi::select(org.Hs.eg.db, keys = annot$symbol, columns = c("ENTREZID", "GENENAME"), keytype = "SYMBOL")
colnames(annot1) <- tolower(colnames(annot1))
annot1 <- stats::aggregate(.~symbol, data= annot1, FUN = paste, collapse = " /// ")
rownames(annot1) <- annot1$symbol
annot <- cbind(annot, annot1[annot$symbol, -1]); rm(annot1)
annot[is.na(annot)] <- ""

# save(annot, counts, pheno, file = "data/gtex_v8_muscle_data.rda")
# load("data/gtex_v8_muscle_data.rda")

x <- edgeR::DGEList(counts = counts)

# remove duplicated genes
expr_gene <- cbind(counts, annot[rownames(counts), "symbol", drop = FALSE])
keep <- !duplicated(expr_gene)
sum(!keep)
x <- x[keep, ]
rm(expr_gene)

# barplot(colSums(counts))
cpm_cutoff <- 0.2
grp_num <- round(min(table(pheno$SEX))/2)
x <- x[rowSums(edgeR::cpm(x) > cpm_cutoff) >= grp_num, ]

x <- edgeR::calcNormFactors(x)
# range(x$samples$norm.factors)

des <- model.matrix(~SEX+SMTSISCH+SMRIN+AGE, pheno)
colnames(des) <- gsub("SEX|\\(|\\)", "", colnames(des))
y <- limma::voom(x, design = des, plot = TRUE, span = 0.8)

# sva
# n.sv <- sva::num.sv(y$E, mod=des, method="be", seed=0) # 59
sv <- limma::wsva(y = y, n.sv = 59, design=des)

des <- cbind(des, sv)
y <- limma::voom(x, design = des, plot = TRUE, span = 0.8)
mat2p <- limma::removeBatchEffect(y$E, covariates = des[, -1])

# write
set.seed(1)
gene.ind <- sample(x=1:nrow(mat2p), size = 500)
cov.mat <- cov(t(mat2p[gene.ind,]))
cov.mat.sc <- cov.mat/median(diag(cov.mat))
write.csv(cov.mat.sc, "data/gtex_muscle_cov_subset_scaled.csv")