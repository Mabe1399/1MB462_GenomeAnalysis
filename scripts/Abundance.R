# Abundance Analysis 

# Create a dataframe with the data 

Bin_5_D1_Abundance<- data.frame(Bins_5_D1_stats$numreads, Bins_5_D1_stats$endpos)
Bin_5_D1_Abundance<- colSums(Bin_5_D1_Abundance)

Bin_12_D1_Abundance<- data.frame(Bins_12_D1_stats$numreads, Bins_12_D1_stats$endpos)
Bin_12_D1_Abundance<- colSums(Bin_12_D1_Abundance)

Bin_16_D1_Abundance<- data.frame(Bins_16_D1_stats$numreads, Bins_16_D1_stats$endpos)
Bin_16_D1_Abundance<- colSums(Bin_16_D1_Abundance)

Bin_29_D1_Abundance<- data.frame(Bins_29_D1_stats$numreads, Bins_29_D1_stats$endpos)
Bin_29_D1_Abundance<- colSums(Bin_29_D1_Abundance)

Bin_5_D3_Abundance<- data.frame(Bins_5_D3_stats$numreads, Bins_5_D3_stats$endpos)
Bin_5_D3_Abundance<- colSums(Bin_5_D3_Abundance)

Bin_12_D3_Abundance<- data.frame(Bins_12_D3_stats$numreads, Bins_12_D3_stats$endpos)
Bin_12_D3_Abundance<- colSums(Bin_12_D3_Abundance)

Bin_16_D3_Abundance<- data.frame(Bins_16_D3_stats$numreads, Bins_16_D3_stats$endpos)
Bin_16_D3_Abundance<- colSums(Bin_16_D3_Abundance)

Bin_29_D3_Abundance<- data.frame(Bins_29_D3_stats$numreads, Bins_29_D3_stats$endpos)
Bin_29_D3_Abundance<- colSums(Bin_29_D3_Abundance)

Abundance<- c(Bin_5_D1_Abundance[1]/Bin_5_D1_Abundance[2],Bin_5_D3_Abundance[1]/Bin_5_D3_Abundance[2],Bin_12_D1_Abundance[1]/Bin_12_D1_Abundance[2],Bin_12_D3_Abundance[1]/Bin_12_D3_Abundance[2],Bin_16_D1_Abundance[1]/Bin_16_D1_Abundance[2],Bin_16_D3_Abundance[1]/Bin_16_D3_Abundance[2],Bin_29_D1_Abundance[1]/Bin_29_D1_Abundance[2],Bin_29_D3_Abundance[1]/Bin_29_D3_Abundance[2])

par(mfrow =c(2,2))

Abundance_DF<- data.frame(Bin = c("5","5","12","12","16","16","29","29"), Env = c("D1","D3","D1","D3","D1","D3","D1","D3"), Abundance = Abundance)

# Plot a barplot using ggplot 

ggplot(Abundance_DF, aes(fill=Env, y=Abundance, x=Bin)) + 
  geom_bar(position="dodge", stat="identity")

