readhousingidaho <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## WOrking directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Download the CSV data from the internet
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
        filePath <- file.path(getwd(), "/data/housing_idaho.csv")
        download.file(fileUrl, filePath)
        #list.files("./data")
        
        # Be sure to include the data.table library that contains the fread function. Great googally moogally!
        library(data.table)
        DT <- fread(filePath)
        #DT
        
        check <- function(y, t) {
                message(sprintf("Elapsed time: %.100f", t[3]))
                print(y)
        }
        # TEST 1: DT[,mean(pwgtp15),by=SEX]
        t <- system.time(y <- DT[,mean(pwgtp15),by=SEX])
        
        # TEST 2: mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
        #t <- system.time(y <- mean(DT[DT$SEX == 1, ]$pwgtp15)) + system.time(mean(DT[DT$SEX == 2, ]$pwgtp15))
        
        # TEST 3: mean(DT$pwgtp15,by=DT$SEX)
        #t <- system.time(y <- mean(DT$pwgtp15, by = DT$SEX))
        #y <- mean(DT$pwgtp15, by = DT$SEX)
        #y
        
        # TEST 4: sapply(split(DT$pwgtp15,DT$SEX),mean)
        #t <- system.time(y <- sapply(split(DT$pwgtp15, DT$SEX), mean))
        #y <- sapply(split(DT$pwgtp15, DT$SEX), mean)
        #y
        #for(i in 1:1000) 
        #{
        #        t <- system.time(y <- sapply(split(DT$pwgtp15, DT$SEX), mean))
        #}
        
        # TEST 5: tapply(DT$pwgtp15,DT$SEX,mean)
        #t <- system.time(y <- tapply(DT$pwgtp15, DT$SEX, mean))
        #for(i in 1:1000) 
        #{
        #        t <- system.time(y <- tapply(DT$pwgtp15, DT$SEX, mean))
        #}
        
        # TEST 6: rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
        #t <- system.time(y <- rowMeans(DT)[DT$SEX == 1]) + system.time(rowMeans(DT)[DT$SEX == 2])
        
        check(y, t)
}