#' Numeric matrix of differences between baseline and one year for annotated proteins and metabolites
#'
#' Numeric matrix of differences between baseline and one year for proteins averaged by gene symbol and 
#' metabolites averaged by CheBI ID for samples that have both proteomics and metabolomics.

options(stringsAsFactors = FALSE)

##soma
soma.mat <- read.csv('soma_diff_mat.csv', row.names=1)
soma.annot <- read.csv('soma_annot.csv', row.names=1)
#avg over duplicated entrez IDs
soma.mat.entrez <- apply(soma.mat, 2, FUN=function(v){ 
  tapply(v, INDEX=gsub(';.+', '',  soma.annot$EntrezGeneSymbol), FUN=mean) 
})

##mets
met.mat <- read.csv('met_diff_mat.csv', row.names=1)
met.annot <- read.csv('met_annot_with_chebi.csv', row.names=1)

#ss to mets with chebi
met.mat.ss <- met.mat[intersect(rownames(met.annot)[met.annot$CHEBI!=''], rownames(met.mat)),]
met.annot.ss <- met.annot[rownames(met.mat.ss),]
#need to avg over 7 duplicated chebi IDs
met.mat.chebi <- apply(met.mat.ss, 2, FUN=function(v){ tapply(v, INDEX=met.annot.ss$CHEBI, mean, na.rm=TRUE)})

##rbind
#lose 2 people in overlap, who don't have metabolomics
ppl.overlap <- sort(intersect(colnames(soma.mat), colnames(met.mat)))
diff.mat <- rbind(soma.mat.entrez[,ppl.overlap], met.mat.chebi[,ppl.overlap])
write.csv(diff.mat, 'soma_and_met_diff_mat.csv')