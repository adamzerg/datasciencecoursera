rankhospital <- function(state, outcome, num = "best") {
    ## Read the outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    if (!state %in% unique(data[, 7])) {
        stop("invalid state")
    }
    switch(outcome, `heart attack` = {col = 11}
           , `heart failure` = {col = 17}
           , pneumonia = {col = 23}
           , stop("invalid outcome"))
    
    ## Return hospital name in that state with the given rank 30-day death rate
    data[, col] = as.numeric(data[, col])
    dataset = na.omit(data[data[, 7] == state, c(2, col)])
    nhospital = nrow(dataset)
    
    switch(num, best = {num = 1}, worst = {num = nhospital})
    if (num > nhospital) {
        result = NA
    }
    o = order(dataset[, 2], dataset[, 1])
    dataset[o, ][num, 1]
}