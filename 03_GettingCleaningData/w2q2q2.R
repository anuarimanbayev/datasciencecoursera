w2q2q2 <- function(){
        # Loading Data
        library(data.table)
        library(sqldf)
        
        acs = fread("getdata-data-ss06pid.csv", header=TRUE, na.strings="")
        #head(acs)
        #works yay!
        
        # Option 1 is correct since it sources from just pwgtp1
        #sqldf("select pwgtp1 from acs where AGEP < 50")
        # Option 2 is incorrect since it sources from ALL dataset
        #sqldf("select * from acs where AGEP < 50")
        
        #unique(acs$AGEP)
        # Option 1 threw an error
        #sqldf("select unique AGEP from acs")
        # Option 3 is correct
        # It appears that "distinct" is the command for unique instead of"unique"
        sqldf("select distinct AGEP from acs")
}