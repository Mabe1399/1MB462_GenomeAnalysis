# Methabolic pathway reconstruction Bin 12 

Bin_12_Ko_identifiers <- data.frame(Bins_12_emapper_annotations_gene$query,Bins_12_emapper_annotations_gene$Preferred_name,Bins_12_emapper_annotations_gene$KEGG_ko)

Bin_12_Ko_identifiers[c("ko_1","ko_2","ko_3")]<- str_split_fixed(Bins_12_emapper_annotations_gene$KEGG_ko, ",",3)

Bin_12_Ko_identifiers <- Bin_12_Ko_identifiers[!is.na(Bin_12_Ko_identifiers$ko_1), ]

Bin_12_Ko_identifiers_first <- data.frame(Bin_12_Ko_identifiers$Bins_12_emapper_annotations_gene.Preferred_name,Bin_12_Ko_identifiers$ko_1)

# tranform to a matrix

Bin_12_Ko_identifiers_first_M<- data.matrix(Bin_12_Ko_identifiers_first)

# Create a text file 

write.table(Bin_12_Ko_identifiers_first,"Ko_identifiers_Bin_12.txt", append = FALSE,quote = FALSE, sep = " ", dec = ".",
            row.names = FALSE, col.names = FALSE)