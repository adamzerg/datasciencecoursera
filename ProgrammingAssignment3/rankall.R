rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    states = unique(data[, 7])
    switch(outcome, `heart attack` = {col = 11}
           , `heart failure` = {col = 17}
           , pneumonia = {col = 23}
           , stop("invalid outcome"))
    
    ## Leave only name, state, and death rate
    data[, col] = as.numeric(data[, col])
    data = na.omit(data[, c(2, 7, col)])
    
    ## For each state, find the hospital of the given rank
    rank_in_state <- function(state) {
        dataset = data[data[, 2] == state, ]
        nhospital = nrow(dataset)
        switch(num, best = {num = 1}, worst = {num = nhospital})
        if (num > nhospital) {result = NA}
        o = order(dataset[, 3], dataset[, 1])
        result = dataset[o, ][num, 1]
        c(result, state)
    }
    
    ## Return a data frame with the hospital names and the (abbreviated) state name
    output = do.call(rbind, lapply(states, rank_in_state))
    output = output[order(output[, 2]), ]
    rownames(output) = output[, 2]
    colnames(output) = c("hospital", "state")
    data.frame(output)
}