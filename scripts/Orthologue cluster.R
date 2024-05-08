# Work with the EggNOG Data

# Trim the non data
Bins_5_emapper_annotations <- Bins_5_emapper_annotations[-c(2349:2351), ]

Bins_12_emapper_annotations <- Bins_12_emapper_annotations[-c(1417:1419), ]

Bins_16_emapper_annotations <- Bins_16_emapper_annotations[-c(2656:2658), ]

Bins_29_emapper_annotations <- Bins_29_emapper_annotations[-c(2306:2308), ]

# Remave Na values for the gene name
Bins_5_emapper_annotations_gene <- Bins_5_emapper_annotations[!is.na(Bins_5_emapper_annotations$Preferred_name), ]

Bins_12_emapper_annotations_gene <- Bins_12_emapper_annotations[!is.na(Bins_12_emapper_annotations$Preferred_name), ]

Bins_16_emapper_annotations_gene <- Bins_16_emapper_annotations[!is.na(Bins_16_emapper_annotations$Preferred_name), ]

Bins_29_emapper_annotations_gene <- Bins_29_emapper_annotations[!is.na(Bins_29_emapper_annotations$Preferred_name), ]

# Create histogram using the emapper COG group
library(stringr)


Bin_5_Category_COG_vector <- unlist(str_split(Bins_5_emapper_annotations_gene$COG_category, ""))

Bin_12_Category_COG_vector <- unlist(str_split(Bins_12_emapper_annotations_gene$COG_category, ""))

Bin_16_Category_COG_vector <- unlist(str_split(Bins_16_emapper_annotations_gene$COG_category, ""))

Bin_29_Category_COG_vector <- unlist(str_split(Bins_29_emapper_annotations_gene$COG_category, ""))

par(mfrow = c(1,1))

barplot(prop.table(table(str_sort(Bin_5_Category_COG_vector))), main = "Bin 5", xlab = "COG Category" )
barplot(prop.table(table(str_sort(Bin_12_Category_COG_vector))), main = "Bin 12", xlab = "COG Category" )
barplot(prop.table(table(str_sort(Bin_16_Category_COG_vector))), main = "Bin 16", xlab = "COG Category" )
barplot(prop.table(table(str_sort(Bin_29_Category_COG_vector))), main = "Bin 29", xlab = "COG Category" )

