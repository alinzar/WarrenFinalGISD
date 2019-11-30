#Title: Descriptives Stats on the Relationship Between Colorism and Health
#Author: Evangeline Warren
#Created: 11.13.2019
#Last Updated: 11.30.2019

#Setup
library (readstata13)
library (haven)
library (lattice)
library (stargazer)
library (xtable)


#Data has been cleaned in stata and analytic sample has been restricted.
#Import cleaned data from .dta file

#Office
#Sample <- read_dta("C:/Users/warren.651/Box/Strat/ColorismCleaned.dta")

#Personal
Sample <-read_dta("~/Box/Strat/ColorismCleaned.dta")
View(Sample)

#Touch up the data to reflect qualitative Responses

Sample$region <- factor(Sample$region,
                        levels = c(1:9),
                        labels = c("New England"
                                   , "Mid Atlantic"
                                   , "E. Nor. Central"
                                   , "W. Nor. Central"
                                   , "South Atlantic"
                                   , "E. Sou. Central"
                                   , "W. Sou. Central"
                                   , "Mountain"
                                   , "Pacific"))


Sample$healthcl <- factor(Sample$healthcl,
                          levels = c(1:4),
                          labels = c("Excellent"
                                     , "Good"
                                     , "Fair"
                                     , "Poor"))

Sample$health1cl <- factor(Sample$health1cl,
                           levels = c(1:4),
                           labels = c("Excellent"
                                      , "Good"
                                      , "Fair"
                                      , "Poor"))

#Descriptive Plots
histogram(Sample$ratetonecl,
          xlab = "Assigned Skin Tone of R",
          main = "Distribution of Skin Tone in Sample",
          type = "count",
          breaks=c(1,2,3,4,5,6,7,8,9,10),
          col = c("purple"))

#Descriptive Table (Frequency of Skin Tone and Region)
crosstab<- xtabs(~Sample$region+Sample$ratetonecl)
ftable(crosstab)
as.matrix(crosstab)
ltable <-xtable(crosstab,caption="Skin Tone Frequency by Region",digits=1,label="tab:table1")
capture.output(ltable,file="skintoneregionfreq.txt")

#Analytic Plots
xyplot (Sample$mentalcl~Sample$ratetonecl,
        ylim=range(0:30),
        y.jitter=TRUE,
        x.jitter=TRUE,
        type = c("p", "r"),
        auto.key=TRUE,
        xlab = "Assigned Skin Tone of R",
        ylab = "Days of Poor Mental Health")

xyplot (Sample$healthdayscl~Sample$ratetonecl,
        ylim=range(0:30),
        y.jitter=TRUE,
        x.jitter=TRUE,
        type = c("p", "r"),
        auto.key=TRUE,
        xlab = "Assigned Skin Tone of R",
        ylab = "Days of Activity Limitation")

xyplot (Sample$mentalcl~Sample$ratetonecl,
        ylim=range(0:30),
        y.jitter=TRUE,
        x.jitter=TRUE,
        type = c("p", "r"),
        group = Sample$region, auto.key=TRUE,
        xlab = "Assigned Skin Tone of R",
        ylab = "Days of Poor Mental Health")

xyplot (Sample$healthdayscl~Sample$ratetonecl,
        ylim=range(0:30),
        y.jitter=TRUE,
        x.jitter=TRUE,
        type = c("p", "r"),
        group = Sample$region, auto.key=TRUE,
        xlab = "Assigned Skin Tone of R",
        ylab = "Days of Activity Limitation")

#make skin tone a categorical variable so that it can be used to label plots
Sample$ratetonecl<-as.factor(Sample$ratetonecl)

histogram(Sample$healthcl,
          xlab = "Self Rated Health",
          main = "Distribution of Self Rated Health, Overall",
          type = "percent",
          col = c("purple"))
histogram(~healthcl | ratetonecl,data=Sample,
          xlab = "Self Rated Health",
          main = "Distribution of Self Rated Health, by Skin Tone",
          type = "percent",
          col = c("purple"))