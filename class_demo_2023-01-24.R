# Ian Jin
# 2023-01-24
# Ice mass loss over poles

# .table to read .txt files
ant_ice_loss = read.table(file="data/antarctica_mass_200204_202209.txt", skip=31, sep="", header=FALSE,col.names=c("decimal_date", "mass_Gt", "sigma_Gt")) #skip first 31 lines

typeof(ant_ice_loss)
class(ant_ice_loss)
dim(ant_ice_loss)

grn_ice_loss = read.table(file="data/greeland_mass_200204_202209.txt", skip=31, sep="", header=FALSE,col.names=c("decimal_date", "mass_Gt", "sigma_Gt")) #skip first 31 lines

head(grn_ice_loss)
tail(grn_ice_loss)
summary(grn_ice_loss)

# plot it

plot(x=ant_ice_loss$decimal_date, y=ant_ice_loss$mass_Gt, type="l", xlab="Year", ylab="Antarctica ice loss (Gt)", ylim=range(grn_ice_loss$mass_Gt))
lines(mass_Gt~decimal_date, data=grn_ice_loss, col="red")

data_break = data.frame(decimal_date=2018.0, mass_Gt=NA, sigma_Gt=NA)

ant_ice_loss_with_NA = rbind(ant_ice_loss, data_break)
grn_ice_loss_with_NA = rbind(grn_ice_loss, data_break)

order(ant_ice_loss_with_NA$decimal_date)
ant_ice_loss_with_NA = (ant_ice_loss_with_NA[order(ant_ice_loss_with_NA$decimal_date),])
grn_ice_loss_with_NA = (grn_ice_loss_with_NA[order(grn_ice_loss_with_NA$decimal_date),])

plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type="l", 
     xlab="Year", ylab="Antarctica ice loss (Gt)", ylim=range(grn_ice_loss$mass_Gt))
lines(mass_Gt~decimal_date, data=grn_ice_loss_with_NA, col="red")

# Error Bars!

head(ant_ice_loss_with_NA)
pdf("figures/ice_mass_trends.pdf", width=7, height=5)
plot(x=ant_ice_loss_with_NA$decimal_date, y=ant_ice_loss_with_NA$mass_Gt, type="l", xlab="Year", ylab="Antarctica ice loss (Gt)", ylim=range(grn_ice_loss$mass_Gt))
lines((mass_Gt + 2*sigma_Gt) ~ decimal_date, data=ant_ice_loss_with_NA, lty="dashed")
lines((mass_Gt - 2*sigma_Gt) ~ decimal_date, data=ant_ice_loss_with_NA, lty="dashed")
dev.off()

# Bar Plot of total ice loss
min(ant_ice_loss_with_NA$mass_Gt, na.rm=T) # remove NA before evaluating
max(ant_ice_loss_with_NA$mass_Gt, na.rm=T)

tot_ice_loss_ant = min(ant_ice_loss_with_NA$mass_Gt, na.rm=T) - max(ant_ice_loss_with_NA$mass_Gt, na.rm=T)
tot_ice_loss_grn = min(grn_ice_loss_with_NA$mass_Gt, na.rm=T) - max(grn_ice_loss_with_NA$mass_Gt, na.rm=T)

barplot(height= -1*c(tot_ice_loss_ant, tot_ice_loss_grn), 
        names.arg=c("Antarctica", "Greenland"))
      
