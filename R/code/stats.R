#Calculate some sample statistics for the 2 datasets

#AVERAGE:
num_goals_mens_avg <- mean(filt_mens$num_goals)
  #~ 2.513
num_goals_womens_avg <- mean(filt_womens$num_goals)
  # 2.98

#STANDARD DEVIATION:
num_goals_mens_sd <- sd(filt_mens$num_goals)
  #~ 1.653
num_goals_womens_sd <- sd(filt_womens$num_goals)
  #~ 2.022

#NUMBER of OBSERVATIONS:
num_goals_mens_matches <- nrow(filt_mens)
  #384
num_goals_womens_matches <- nrow(filt_womens)
  #200

################################################################################################

#Create distributions of the test variable for the two datasets. Use histograms with binwidth=1.
  #using range(), the total # goals in the filtered data ranges between: 0-8 (men's), 0-13 (women's)
#MEN's
M_goals <- ggplot(filt_mens, aes(x=num_goals)) + 
  geom_histogram(binwidth=1) + scale_x_continuous(breaks = 0:8) +
  labs(title="Number of Goals with Total # Goals - Men's", 
       subtitle="Data from FIFA World Cup matches after Feb. 1, 2002. There are 384 such matches.", 
       x="# Goals in a Match", y="# Matches") +
  theme(plot.title=element_text(size=11), plot.subtitle=element_text(size=9),
        axis.title.x=element_text(size=10), axis.title.y=element_text(size=10))
M_goals

#WOMEN's
W_goals <- ggplot(filt_womens, aes(x=num_goals)) + 
  geom_histogram(binwidth=1) + scale_x_continuous(breaks = 0:13) +
  labs(title="Number of Goals with Total # Goals - Women's", 
       subtitle="Data from FIFA World Cup matches after Feb. 1, 2002. There are 200 such matches.", 
       x="# Goals in a Match", y="# Matches") +
  theme(plot.title=element_text(size=11), plot.subtitle=element_text(size=9),
        axis.title.x=element_text(size=10), axis.title.y=element_text(size=10))
W_goals

###############################################################################################

#Perform the WMW hypothesis test
WMW_test <- wilcox.test(x=filt_womens$num_goals, y=filt_mens$num_goals, alternative="greater", 
                        paired=FALSE)
print(WMW_test)
  #Wilcoxon rank sum test with continuity correction,
  #W = 43273, p-value = 0.005107,
  #alternative hypothesis: true location shift is greater than 0

#Compare the p-value of WMW_test to the significance level (alpha)
alpha <- 0.10
#print(WMW_test$p.value <= alpha)
print(ifelse(WMW_test$p.value <= alpha, "The result is significant. Can reject the null hypothesis.", 
             "The result is not significant. Fail to reject the null hypothesis."))
  #OUTPUT: "The result is significant. Can reject the null hypothesis."

###############################################################################################

#Assign the specified variables
result_df <- data.frame(tribble(~p_val, ~result, WMW_test$p.value, 
                            ifelse(WMW_test$p.value <= alpha, "reject", "fail to reject")))
print(result_df)