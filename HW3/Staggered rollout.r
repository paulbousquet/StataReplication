#install.packages("devtools")
devtools::install_github("jonathandroth/staggered")
library(staggered) #load the staggered package
library(dplyr) #load dplyr for data manipulation
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(ggplot2) #load ggplot2 for plotting the results
library(purrr)

df <- staggered::pj_officer_level_balanced #load the officer data
staggered(df = df, 
          i = "uid",
          t = "period",
          g = "first_trained",
          y = "complaints", 
          estimand = "simple")
#Calculate efficient estimator for the calendar weighted average
staggered(df = df, 
          i = "uid",
          t = "period",
          g = "first_trained",
          y = "complaints", 
          estimand = "calendar")
#Calculate event-study coefficients for the first 24 months (month 0 is instantaneous effect)
eventPlotResults <- staggered(df = df,         
                              i = "uid",
                              t = "period",
                              g = "first_trained",
                              y = "complaints", 
                              estimand = "eventstudy", 
                              eventTime = 0:23)
#Create event-study plot from the results of the event-study
eventPlotResults %>% 
  mutate(ymin_ptwise = estimate + 1.96*se,
         ymax_ptwise = estimate - 1.96*se)%>%
  ggplot(aes(x=eventTime, y =estimate)) +
  geom_pointrange(aes(ymin = ymin_ptwise, ymax = ymax_ptwise))+ 
  geom_hline(yintercept =0) +
  xlab("Event Time") + ylab("Estimate") +
  ggtitle("Effect of Procedural Justice Training on Officer Complaints")
#Calculate efficient estimator for the simple weighted average
#Use Fisher permutation test with 500 permutation draws
staggered(df = df, 
          i = "uid",
          t = "period",
          g = "first_trained",
          y = "complaints", 
          estimand = "simple",
          compute_fisher = T, 
          num_fisher_permutations = 500)
#Calculate Callaway and Sant'Anna estimator for the simple weighted average
staggered_cs(df = df, 
             i = "uid",
             t = "period",
             g = "first_trained",
             y = "complaints", 
             estimand = "simple")
#Calculate Sun and Abraham estimator for the simple weighted average
staggered_sa(df = df, 
             i = "uid",
             t = "period",
             g = "first_trained",
             y = "complaints", 
             estimand = "simple")
