# simulation to illustrate ensemble learning
# refer to slides 14 and 15 in slide deck

simulate.ens <- function(n, p, K){
        
        # single classifier
        c.single <- rbinom(n = n, size = 1, prob = p)
        tab.single <- table(c.single)
        print(paste(
                "Accuracy of single classifier: ",
                acc.single <- tab.single[2] / sum(tab.single),
                sep = ""))
        
        
        # K *independent* classifiers
        c.df <- NULL
        for(i in seq(K)){
                ci <- rbinom(n = n, size = 1, prob = p)
                c.df <- cbind(c.df, ci)
        }
        
        c.ens <- apply(c.df, MARGIN = 1, FUN = function(one.row){
                if(sum(one.row) >= 0.5 * K) return(1)
                else return(0)
        })
        tab.ens <- table(c.ens)
        print(paste(
                "Accuracy of ensemble: ",
                acc.ens <- tab.ens[2] / sum(tab.ens),
                sep = ""))
}


# let's have a dataset with 10000 samples,
# each classifier having 60% accuracy
# and an ensemble size of 3
simulate.ens(n = 10000, p = 0.6, K = 3)

# go ahead and change the parameters of our simulation
simulate.ens(n = 10000, p = 0.51, K = 100)
