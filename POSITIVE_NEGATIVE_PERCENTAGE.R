#positive_percentage
#renaming
posSc=table_final$positive
negSc=table_final$negative

#adding column
table_final$PosPercentage=posSc/(posSc+negSc)

#replacing NAN with 0

pp=table_final$PosPercentage
pp[is.nan(pp)]<-0
table_final$PosPercentage=pp

#negative percentage

#adding column
table_final$NegPercentage=negSc/(negSc+posSc)

#replacing nan with 0
nn=table_final$NegPercentage
nn[is.nan(nn)]<-0
table_final$NegPercentage=nn
table_final