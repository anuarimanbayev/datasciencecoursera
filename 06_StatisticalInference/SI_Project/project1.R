## =========================================================================================================================================== ##
## In this project, we will investigate the exponential distribution in R and compare it with the Central Limit Theorem. 
## The exponential distribution can be simulated in R with rexp(n, lambda) where lambda is the rate parameter. 
## The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda. 
## Set lambda = 0.2 for all of the simulations. 
## We will investigate the distribution of averages of 40 exponentials. 
## Note that we will need to do a thousand simulations.

## Illustrate via simulation and associated explanatory text the properties of the distribution of the mean of 40 exponentials. 
## We should:
##      - Show the sample mean and compare it to the theoretical mean of the distribution.
##      - Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.
##      - Show that the distribution is approximately normal.
## =========================================================================================================================================== ##

library(knitr)
opts_chunk$set(fig.width=7, fig.height=4, warning=FALSE, message=FALSE)

## Load necessary libraries
library(ggplot2)

## Set constants
lambda <- 0.2
n <- 40 
nosim <- 1000

# Set the seed for reproducability
set.seed(756)

## Collect data

exp_sim <- function(n, lambda)
{
        mean(rexp(n,lambda))
}

## Simulate data

sim <- data.frame(ncol=2,nrow=1000)
names(sim) <- c("Index","Mean")

for (i in 1:nosim)
{
        sim[i,1] <- i
        sim[i,2] <- exp_sim(n,lambda)
}

## Find Mean of n = 1000

sample_mean <- mean(sim$Mean)
sample_mean

## Histogram of means

exp_dis <- matrix(data=rexp(n * nosim, lambda), nrow=nosim)
exp_dis_means <- data.frame(means=apply(exp_dis, 1, mean))

ggplot(data = exp_dis_means, aes(x = means)) + 
        geom_histogram(binwidth=0.1) +   
        ggtitle("Hiistogram of Sample Means") +
        scale_x_continuous(breaks=round(seq(min(exp_dis_means$means), max(exp_dis_means$means), by=1)))

## Theoretical exponential mean of exponential distribution

theor_mean <- 1/lambda
theor_mean

## Histogram plot of the exponential distribution n = 1000

hist(sim$Mean, 
     breaks=100, 
     prob=TRUE, 
     main="Exponential Distribution n = 1000", 
     xlab="Spread")
abline(v = theor_mean, 
       col= 4,
       lwd = 2)
abline(v = sample_mean, 
       col = 2,
       lwd = 2)

legend('topright', c("Sample Mean", "Theoretical Mean"), 
       lty=c(1,1), 
       bty = "n",
       col = c(col=2, col=4))

## Variance

sample_var <- var(sim$Mean)
theor_var <- ((1/lambda)^2)/40

## Histogram of Theoretical Curve

hist(sim$Mean, 
     breaks = 100, 
     prob = TRUE, 
     main ="Exponential Distribution n = 1000", 
     xlab ="Spread")
xfit <- seq(min(sim$Mean), max(sim$Mean), length = 100)
yfit <- dnorm(xfit, mean = 1/lambda, sd = (1/lambda/sqrt(40)))
lines(xfit, yfit, pch=22, col=4, lty=2, lwd=2)
legend('topright', c("Theoretical Curve"), bty="n", lty=2,lwd=2, col=4)

## Histogram of Simulated Exponential Distribution

hist(sim$Mean, 
     breaks = 100, 
     prob = TRUE, 
     main = "Distribution of Simulated Exponential Distribution", xlab="")
lines(density(sim$Mean), col=3, lwd=2)
abline(v = 1/lambda, col = 4, lwd=4)
xfit <- seq(min(sim$Mean), max(sim$Mean), length = 100)
yfit <- dnorm(xfit, mean = 1/lambda, sd = (1/lambda/sqrt(40)))
lines(xfit, yfit, pch=22, col=4, lty=2, lwd=2)
legend('topright', c("Simulated Values", "Theoretical Values"), bty="n", lty=c(1,2), col=c(3,4))

## Quantile of Normal Distribution

qqnorm(sim$Mean, 
       main="Normal Q-Q Plot")
qqline(sim$Mean, 
       col="4")