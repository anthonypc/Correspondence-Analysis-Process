## Analysis and display
library(ggplot2)
library(data.table)
library(MASS)
library(ca)
library(FactoMineR)

## Load the data.
wip = as.data.frame(HairEyeColor)
wip.dt <- data.table::dcast(wip, Hair ~ Eye, fun.aggregate = sum, value.var = "Freq")
rownames(wip.dt) <- wip.dt$Hair

## setting values for fit
chisq <- chisq.test(wip.dt[,c(2:3)])
n <- sum(wip$Freq)

# Printing the chi square statistic.
# Testing the significance of the relationship.
# Not always reliable.
chisq

## Table of frequencies.
wip.dt[,c(2:3)]

## Table of residuals.
chisq$residuals

## Table of adjusted residuals.
chisq$stdres

## Total inertia value
chisq$statistic/n

## Principal intertias table/contingency table
test.ca <- ca(wip.dt[,c(2:5)], nd=2)
test.cac <- CA(wip.dt[,c(2:5)], ncp = 2, graph = FALSE)

## Summary statistics. Dimension contribution figures are not actual percent. Use figures produced later.
summary(test.ca)
summary(test.cac)

rows <- data.frame(as.vector(test.ca$rownames),as.vector(test.ca$rowinertia), as.vector(test.ca$rowmass))
colnames(rows) <- c("Row Group", "Inertia", "Mass")
cols <- data.frame(as.vector(test.ca$colnames), as.vector(test.ca$colinertia), as.vector(test.ca$colmass))
colnames(cols) <- c("Col Group", "Inertia", "Mass")

## Row and COlumn Summaries
rowTable.df <- cbind(rows, test.cac$row$contrib)
colTable.df <- cbind(cols, test.cac$col$contrib)
# Display output.
rowTable.df
colTable.df

## Display the biplot.
plot.CA(test.cac)
