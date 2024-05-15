# Expression level

# Create Dataset

# D1 Environnement 
# Bin 5
# Refine the Count file and Annotation file

Bins_5_D1_count <- Bins_5_D1_count[-c(2470:2474), ]
Bins_5_D1 <- Bins_5[Bins_5$ftype== "CDS", ]
colnames(Bins_5_D1_count)<- c("Gene","Bin 5")

Bins_5_D1$Bin_5 <- c(Bins_5_D1_count$`Bin 5`)

# Remove Na in gene column
Bins_5_D1 <- Bins_5_D1[!is.na(Bins_5_D1$gene), ]

# Change value to log
Bins_5_D1$Bin_5[Bins_5_D1$Bin_5 == 0]<- NA
Bins_5_D1$Bin_5<- log(Bins_5_D1$Bin_5)
Bins_5_D1$Bin_5[is.na(Bins_5_D1$Bin_5)]<- 0

# Bin 12
# Refine the Count file and Annotation file

Bins_12_D1_count <- Bins_12_D1_count[-c(1581:1585), ]
Bins_12_D1 <- Bins_12[Bins_12$ftype== "CDS", ]
colnames(Bins_12_D1_count)<- c("Gene","Bin 12")

Bins_12_D1$Bin_12 <- c(Bins_12_D1_count$`Bin 12`)

# Remove Na in gene column
Bins_12_D1 <- Bins_12_D1[!is.na(Bins_12_D1$gene), ]

# Change value to log
Bins_12_D1$Bin_12[Bins_12_D1$Bin_12 == 0]<- NA
Bins_12_D1$Bin_12<- log(Bins_12_D1$Bin_12)
Bins_12_D1$Bin_12[is.na(Bins_12_D1$Bin_12)]<- 0

# Bin 16
# Refine the Count file and Annotation file

Bins_16_D1_count <- Bins_16_D1_count[-c(2872:2876), ]
Bins_16_D1 <- Bins_16[Bins_16$ftype== "CDS", ]
colnames(Bins_16_D1_count)<- c("Gene","Bin 16")

Bins_16_D1$Bin_16 <- c(Bins_16_D1_count$`Bin 16`)

# Remove Na in gene column
Bins_16_D1 <- Bins_16_D1[!is.na(Bins_16_D1$gene), ]

# Change value to log
Bins_16_D1$Bin_16[Bins_16_D1$Bin_16 == 0]<- NA
Bins_16_D1$Bin_16<- log(Bins_16_D1$Bin_16)
Bins_16_D1$Bin_16[is.na(Bins_16_D1$Bin_16)]<- 0

# Bin 29
# Refine the Count file and Annotation file

Bins_29_D1_count <- Bins_29_D1_count[-c(2505:2509), ]
Bins_29_D1 <- Bins_29[Bins_29$ftype== "CDS", ]
colnames(Bins_29_D1_count)<- c("Gene","Bin 29")

Bins_29_D1$Bin_29 <- c(Bins_29_D1_count$`Bin 29`)

# Remove Na in gene column
Bins_29_D1 <- Bins_29_D1[!is.na(Bins_29_D1$gene), ]

# Change value to log
Bins_29_D1$Bin_29[Bins_29_D1$Bin_29 == 0]<- NA
Bins_29_D1$Bin_29<- log(Bins_29_D1$Bin_29)
Bins_29_D1$Bin_29[is.na(Bins_29_D1$Bin_29)]<- 0

# Create the Dataframe
Dataframe_Bin5_D1 <- data.frame(Bins_5_D1$Bin_5, row.names = Bins_5_D1$gene)

Dataframe_Bin12_D1 <- data.frame(Bins_12_D1$Bin_12, row.names = Bins_12_D1$gene)

Dataframe_Bin16_D1 <- data.frame(Bins_16_D1$Bin_16, row.names = Bins_16_D1$gene)

Dataframe_Bin29_D1 <- data.frame(Bins_29_D1$Bin_29, row.names = Bins_29_D1$gene)

# Merge Data frames

Dataframe_D1<- merge(Dataframe_Bin5_D1,Dataframe_Bin12_D1, by = 'row.names', all = TRUE)
row.names(Dataframe_D1)<- c(Dataframe_D1$Row.names)
Dataframe_D1<- Dataframe_D1[ ,2:3]

Dataframe_D1<- merge(Dataframe_D1,Dataframe_Bin16_D1, by = 'row.names', all = TRUE)
row.names(Dataframe_D1)<- c(Dataframe_D1$Row.names)
Dataframe_D1<- Dataframe_D1[ ,2:4]

Dataframe_D1<- merge(Dataframe_D1,Dataframe_Bin29_D1, by = 'row.names', all = TRUE)
row.names(Dataframe_D1)<- c(Dataframe_D1$Row.names)
Dataframe_D1<- Dataframe_D1[ ,2:5]

Dataframe_D1 <- Dataframe_D1[order(rowSums(is.na(Dataframe_D1))), ]
#Dataframe_D1<- log(Dataframe_D1)
#Dataframe_D1[is.na(Dataframe_D1)]<-0
# Convert to Matrix
Matrix_D1<- data.matrix(Dataframe_D1)

# Create Heatmap
ht1<-Heatmap(Matrix_D1, name = "D1" , show_row_names = FALSE, top_annotation = HeatmapAnnotation(foo = anno_block(gp = gpar(fill = "blue"), labels = "D1 (Oxic)")), cluster_rows = FALSE, cluster_columns = FALSE, na_col = "black", col = Colors, column_labels = column_labels, row_split = row_split , row_title_rot = 0, border = TRUE)
draw(ht1)


# Create Dataset

# D3 Environnement 
# Bin 5
# Refine the Count file and Annotation file

Bins_5_D3_count <- Bins_5_D3_count[-c(2470:2474), ]
Bins_5_D3 <- Bins_5[Bins_5$ftype== "CDS", ]
colnames(Bins_5_D3_count)<- c("Gene","Bin 5")

Bins_5_D3$Bin_5 <- c(Bins_5_D3_count$`Bin 5`)

# Remove Na in gene column
Bins_5_D3 <- Bins_5_D3[!is.na(Bins_5_D3$gene), ]

# Change value to log
Bins_5_D3$Bin_5[Bins_5_D3$Bin_5 == 0]<- NA
Bins_5_D3$Bin_5<- log(Bins_5_D3$Bin_5)
Bins_5_D3$Bin_5[is.na(Bins_5_D3$Bin_5)]<- 0

# Bin 12
# Refine the Count file and Annotation file

Bins_12_D3_count <- Bins_12_D3_count[-c(1581:1585), ]
Bins_12_D3 <- Bins_12[Bins_12$ftype== "CDS", ]
colnames(Bins_12_D3_count)<- c("Gene","Bin 12")

Bins_12_D3$Bin_12 <- c(Bins_12_D3_count$`Bin 12`)

# Remove Na in gene column
Bins_12_D3 <- Bins_12_D3[!is.na(Bins_12_D3$gene), ]

# Change value to log
Bins_12_D3$Bin_12[Bins_12_D3$Bin_12 == 0]<- NA
Bins_12_D3$Bin_12<- log(Bins_12_D3$Bin_12)
Bins_12_D3$Bin_12[is.na(Bins_12_D3$Bin_12)]<- 0

# Bin 16
# Refine the Count file and Annotation file

Bins_16_D3_count <- Bins_16_D3_count[-c(2872:2876), ]
Bins_16_D3 <- Bins_16[Bins_16$ftype== "CDS", ]
colnames(Bins_16_D3_count)<- c("Gene","Bin 16")

Bins_16_D3$Bin_16 <- c(Bins_16_D3_count$`Bin 16`)

# Remove Na in gene column
Bins_16_D3 <- Bins_16_D3[!is.na(Bins_16_D3$gene), ]

# Change value to log
Bins_16_D3$Bin_16[Bins_16_D3$Bin_16 == 0]<- NA
Bins_16_D3$Bin_16<- log(Bins_16_D3$Bin_16)
Bins_16_D3$Bin_16[is.na(Bins_16_D3$Bin_16)]<- 0

# Bin 29
# Refine the Count file and Annotation file

Bins_29_D3_count <- Bins_29_D3_count[-c(2505:2509), ]
Bins_29_D3 <- Bins_29[Bins_29$ftype== "CDS", ]
colnames(Bins_29_D3_count)<- c("Gene","Bin 29")

Bins_29_D3$Bin_29 <- c(Bins_29_D3_count$`Bin 29`)

# Remove Na in gene column
Bins_29_D3 <- Bins_29_D3[!is.na(Bins_29_D3$gene), ]

# Change value to log
Bins_29_D3$Bin_29[Bins_29_D3$Bin_29 == 0]<- NA
Bins_29_D3$Bin_29<- log(Bins_29_D3$Bin_29)
Bins_29_D3$Bin_29[is.na(Bins_29_D3$Bin_29)]<- 0

# Create the Dataframe
Dataframe_Bin5_D3 <- data.frame(Bins_5_D3$Bin_5, row.names = Bins_5_D3$gene)

Dataframe_Bin12_D3 <- data.frame(Bins_12_D3$Bin_12, row.names = Bins_12_D3$gene)

Dataframe_Bin16_D3 <- data.frame(Bins_16_D3$Bin_16, row.names = Bins_16_D3$gene)

Dataframe_Bin29_D3 <- data.frame(Bins_29_D3$Bin_29, row.names = Bins_29_D3$gene)

# Merge Data frames

Dataframe_D3<- merge(Dataframe_Bin5_D3,Dataframe_Bin12_D3, by = 'row.names', all = TRUE)
row.names(Dataframe_D3)<- c(Dataframe_D3$Row.names)
Dataframe_D3<- Dataframe_D3[ ,2:3]

Dataframe_D3<- merge(Dataframe_D3,Dataframe_Bin16_D3, by = 'row.names', all = TRUE)
row.names(Dataframe_D3)<- c(Dataframe_D3$Row.names)
Dataframe_D3<- Dataframe_D3[ ,2:4]

Dataframe_D3<- merge(Dataframe_D3,Dataframe_Bin29_D3, by = 'row.names', all = TRUE)
row.names(Dataframe_D3)<- c(Dataframe_D3$Row.names)
Dataframe_D3<- Dataframe_D3[ ,2:5]

Dataframe_D3 <- Dataframe_D3[order(rowSums(is.na(Dataframe_D3))), ]

# Convert to Matrix
Matrix_D3<- data.matrix(Dataframe_D3)

# Create Heatmap
row_split = rep("4 Bins",3002)
row_split[149:422]= "3 Bins"
row_split[423:952]= "2 Bins"
row_split[953:3002]= "1 Bin"
column_labels = structure(paste0(c("Bin 5", "Bin 12", "Bin 16", "Bin 29")), names = paste0("column", 1:4))
offset = 1e-10
Colors = colorRamp2(c(0,0+offset,3),c("white","blue","red"))

ht2<-Heatmap(Matrix_D3, name = "D3", show_row_names = FALSE, top_annotation = HeatmapAnnotation(foo = anno_block(gp = gpar(fill = "red"), labels = "D3 (Hypoxic)")), cluster_rows = FALSE, cluster_columns = FALSE, na_col = "black", col = Colors , column_labels = column_labels, row_split = row_split, row_title_rot = 0, border = TRUE)
draw(ht2)

# Create the complexHeatmap

ht_list = ht1+ht2
htShiny(ht_list)
draw(ht_list)

# Barplot gene expression
# Bin 5
Bins_5_D1_count$Env <- "D1"
Bins_5_D3_count$Env <- "D3"
Bins_5_Bar_count <- rbind.data.frame(Bins_5_D1_count,Bins_5_D3_count)

ggplot(Bins_5_Bar_count, aes(x= Gene, y= `Bin 5`, fill= Env)) + geom_col()
