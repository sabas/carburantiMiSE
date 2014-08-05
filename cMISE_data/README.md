Il package necessita il pacchetto "devtools" installato in R:

> install.packages("devtools")

quindi caricare il devtools tramite il comando:

> library(devtools)

in seguito è possibile caricare il data package da remoto tramite R

> devtools::install_github("sabas", "carburantiMiSE/cMISE_data")
