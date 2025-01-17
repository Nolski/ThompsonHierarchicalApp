source("ReadDataApp.R")
source("MCMC_HierarchicalThompson.R")

RR=50000
alpha=0.2

datapath="priordata_test_missings.csv"
  
nx=16
key=tibble(Strata=factor(1:nx),
           strata=factor(1:nx))

priordata=ReadDataApp(datapath,key)

Pstar=DtchoiceMCMCProbabilities(priordata$Y,priordata$D,priordata$X, #outcomes, treatments, and covariates thus far
                                priordata$k,priordata$nx, #number of treatments and number of strata
                                RR)

Pactual=(1-alpha) * Pstar + alpha * (1/priordata$k)

filename = paste(Sys.Date(), "_treatmentprobabilities.csv", sep="")
write_csv(Pactual, path=filename)
