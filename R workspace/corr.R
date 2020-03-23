corr <- function(directory, threshold = 0) {
    id = 1:332
    filename <- list.files(directory, full.names = TRUE)

    threshold_samples <- complete(directory)
    threshold_samples <- threshold_samples[threshold_samples$nobs>=threshold, ]
        
    result <- vector(mode="numeric", length=0)
    
    #for(i in seq(filename)) {
        #airquality <- read.csv(filename[i])
        #good <- complete.cases(airquality)
        #airquality <- airquality[good, ]
        #if (nrow(airquality) > threshold) {
            # We need [[]] around pollutant instead of [] since airquality["sulfate"]
            # is a data.frame but we need a vector here. Hence, [[]]. Please note thatusing either
            #[[]] or [] gives the same results as the test cases
            #correlation <- cor(airquality[["sulfate"]], airquality[["nitrate"]])
            #result <- append(result, correlation)
            #print(correlation)
        #}
    for(i in threshold_samples$id) {
        samples <- read.csv(filename[i])
        complete_samples <- samples[complete.cases(samples), ]
        correlation <- cor(complete_samples[["sulfate"]], complete_samples[["nitrate"]])
        result <- append(result, correlation)
    }
    result
}