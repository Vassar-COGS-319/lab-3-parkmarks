# model selection ####

# suppose we have data from an experiment like this:
# mean RT correct = 250ms
# mean RT incorrect = 246ms
# accuracy = 0.80

# try to fit this data with both models by adjusting the parameters of the model
# HINT: you can speed up your parameter search by using a small number of samples
# initially, and then increasing the samples as you get closer to a viable set
# of parameters.
# 2nd HINT: Don't adjust the sdrw parameter of the random.walk.model or the criterion
# paramter of the accumulator model.

# You don't need to get a perfect match. Just get in the ballpark. 

#accumulator.model <- function(samples, rate.1=40, rate.2=40, criterion=3)
#random.walk.model <- function(samples, drift=0, sdrw=0.3, criterion=3)

accum.mod <- accumulator.model(100, 32, 32, 8)
accum.correct <- accum.mod %>% filter(correct == 1)
accum.incorrect <- accum.mod %>% filter(correct == 0)
sum(accum.mod$correct) / length(accum.mod$correct) 
mean(accum.correct$rt)
mean(accum.incorrect$rt)

walk.mod <- random.walk.model(100, 0, .33, 5.2)
walk.correct <- walk.mod %>% filter(correct == 1)
walk.incorrect <- walk.mod %>% filter(correct == 0)
sum(walk.mod$correct) / length(walk.mod$correct) 
mean(walk.correct$rt)
mean(walk.incorrect$rt)

# Can both models do a reasonable job of accounting for the mean RT and accuracy? Report the
# results of your efforts:

# Both of these models do a reasonable job of accounting for the mean RT and accuracy. I was
# not able to get a perfect match for either of the models, but I found a better, more accurate 
# model with accumator model. With the input: accumulator.model(100, 32, 32, 8), my model output
# an accuracy of 0.55, a mean correct of 251.6, and a mean incorrect of 246.2. With the input:
# random.walk.model(100, 0, .33, 5.2), my model output an accuracy of 0.52, and a mean accuracy of
# 0.52, mean correct of 258.9, and a mean incorrect of 216.9. However, I am unsure given the 
# desired mean rts, if the accuracy can ever reach .8 due to the fact that the mean correct and 
# incorrect are not far enough appart


# Using the parameters that you found above, plot histograms of the distribution of RTs
# predicted by each model. Based on these distributions, what kind of information could
# we use to evaluate which model is a better descriptor of the data for the experiment?
# Describe briefly how you might make this evaluation.

hist(walk.correct$rt)
hist(walk.incorrect$rt)
hist(accum.correct$rt)
hist(accum.incorrect$rt)

# In order to be a better discriptor of the data for the experiment, the model should be roughly
# uniform within the histograms. Looking at these distributions, the spread looks more uniform in
# the accumulator model than in the random walk model. The random walk model seems more skewed 
# than the accumulator model. 
