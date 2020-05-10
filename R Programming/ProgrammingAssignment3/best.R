best <- function(state, outcome) {
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
    
    ## Return hospital name in that state with lowest 30-day death rate
    dataset = data[data$State == state, c(2, col)]
    dataset[which.min(dataset[, 2]), 1]
}