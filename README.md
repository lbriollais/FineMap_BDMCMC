# FineMap_BDMCMC
Application of BDMCMC algorithm to fine mapping problem

We simulated a genomic region with LD structure and MAF mimicking observed genetic variants in the Kallikrein (KLK) region.  
A general description of the simulation framework is given in "Simulation_Description.pdf".
The LD blocks were determined with the software Haploview with the method “Solid Spine of LD”. 
The SNP numbers, SNP names and LD blocks are given in the file  “block.info.long.csv”.
A total of 10 simulated files, each containing 2000 cases and 2000 controls, is included as example. 
The files for cases are “gent_caseX.dat” and for controls “gent_contX.dat” with X=1,..,10.
The BDMCMC method is our implementation of the Birth-Death MCMC algorithm to regression models. 
A technical report is provided in the document “Bayesian_regression_BDMCMC.pdf”.  
An R code running the BDMCMC algorithm is given in “BDmcmcbin.R”. 
An example on how to run the code on the 10 simulation datasets is given in “Run_BDMCMC_Github.R” and 
how to read the final results and compute the FDR and TDR statistics in “read_BDMCMC_Github.R”.
