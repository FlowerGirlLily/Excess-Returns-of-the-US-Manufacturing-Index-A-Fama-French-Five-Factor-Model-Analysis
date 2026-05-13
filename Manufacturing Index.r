# =========================================================
# FAMA-FRENCH FIVE-FACTOR MODEL ANALYSIS
# US Manufacturing Index Excess Returns
# =========================================================

# ---------------------------------------------------------
# 1. Clear environment
# ---------------------------------------------------------
# Removes all existing variables from workspace
# to ensure a clean session.

rm(list = ls())

# ---------------------------------------------------------
# 2. Install and load required packages
# ---------------------------------------------------------
# Packages used for:
# - regression analysis
# - diagnostic testing
# - residual analysis
# - heteroscedasticity/autocorrelation testing
# - visualisation

if(!require(readxl)){install.packages('readxl')}
if(!require(tseries)){install.packages('tseries')}
if(!require(e1071)){install.packages('e1071')}
if(!require(lmtest)){install.packages('lmtest')}
if(!require(car)){install.packages('car')}
if(!require(orcutt)){install.packages('orcutt')}
if(!require(strucchange)){install.packages('strucchange')}

install.packages("viridis")

# Load libraries
library(readxl)
library(viridis)
library(lmtest)

# ---------------------------------------------------------
# 3. Read dataset
# ---------------------------------------------------------
# Different datasets can be tested by changing
# the selected Excel file.

# file_name <- "Yearly File.xlsx"
# file_name <- "Months.xlsx"
file_name <- "No outliers.xlsx"
# file_name <- "No outliers - Copy (2).xlsx"

dataset <- read_excel(file_name)

# ---------------------------------------------------------
# 4. Define regression equations
# ---------------------------------------------------------
# Main multivariate Fama-French five-factor model:
#
# Manuf = dependent variable
# MktRF = market risk premium
# SMB = size factor
# HML = value factor
# RMW = profitability factor
# CMA = investment factor
# RF = risk-free rate

regression_equation <- 
  "Manuf ~ MktRF + SMB + HML + RMW + CMA + RF"

# Separate univariate regressions
# used for diagnostic comparison.

regression_equationMktRF <- "Manuf ~ MktRF"
regression_equationSMB   <- "Manuf ~ SMB"
regression_equationHML   <- "Manuf ~ HML"
regression_equationRMW   <- "Manuf ~ RMW"
regression_equationCMA   <- "Manuf ~ CMA"
regression_equationRF    <- "Manuf ~ RF"

# ---------------------------------------------------------
# 5. Estimate regression models using OLS
# ---------------------------------------------------------
# lm() estimates linear regression models.

model <- lm(regression_equation, data = dataset)

modelMktRF <- lm(regression_equationMktRF, data = dataset)
modelSMB   <- lm(regression_equationSMB, data = dataset)
modelHML   <- lm(regression_equationHML, data = dataset)
modelRMW   <- lm(regression_equationRMW, data = dataset)
modelCMA   <- lm(regression_equationCMA, data = dataset)
modelRF    <- lm(regression_equationRF, data = dataset)

# ---------------------------------------------------------
# 6. Regression summaries
# ---------------------------------------------------------
# Evaluate:
# - coefficient significance
# - R-squared
# - adjusted R-squared
# - F-statistic
# - overall explanatory power

summary(model)

summary(modelMktRF)
summary(modelSMB)
summary(modelHML)
summary(modelRMW)
summary(modelCMA)
summary(modelRF)

# ---------------------------------------------------------
# 7. Residual analysis and normality testing
# ---------------------------------------------------------
# Residuals should ideally:
# - be approximately normally distributed
# - have mean close to zero
# - display no systematic patterns

Residuals <- residuals(model)

# Histogram of residuals
hist(
  Residuals,
  col = viridis(17),
  xlab = "Residuals",
  main = "Distribution of residuals",
  probability = TRUE
)

# Density curve
lines(density(Residuals), lty = 1)

# ---------------------------------------------------------
# 8. Residual histograms for individual models
# ---------------------------------------------------------

ResidualsMktRF <- residuals(modelMktRF)

hist(
  ResidualsMktRF,
  col = viridis(17),
  xlab = "Residuals Mkt-RF",
  main = "Distribution of Mkt-RF residuals",
  probability = TRUE
)

lines(density(ResidualsMktRF), lty = 1)

# SMB residuals
ResidualsSMB <- residuals(modelSMB)

hist(
  ResidualsSMB,
  col = viridis(17),
  xlab = "Residuals SMB",
  main = "Distribution of SMB residuals",
  probability = TRUE
)

lines(density(ResidualsSMB), lty = 1)

# HML residuals
ResidualsHML <- residuals(modelHML)

hist(
  ResidualsHML,
  col = viridis(17),
  xlab = "Residuals HML",
  main = "Distribution of HML residuals",
  probability = TRUE
)

lines(density(ResidualsHML), lty = 1)

# RMW residuals
ResidualsRMW <- residuals(modelRMW)

hist(
  ResidualsRMW,
  col = viridis(17),
  xlab = "Residuals RMW",
  main = "Distribution of RMW residuals",
  probability = TRUE
)

lines(density(ResidualsRMW), lty = 1)

# CMA residuals
ResidualsCMA <- residuals(modelCMA)

hist(
  ResidualsCMA,
  col = viridis(17),
  xlab = "Residuals CMA",
  main = "Distribution of CMA residuals",
  probability = TRUE
)

lines(density(ResidualsCMA), lty = 1)

# RF residuals
ResidualsRF <- residuals(modelRF)

hist(
  ResidualsRF,
  col = viridis(17),
  xlab = "Residuals RF",
  main = "Distribution of RF residuals",
  probability = TRUE
)

lines(density(ResidualsRF), lty = 1)

# ---------------------------------------------------------
# 9. Jarque-Bera normality tests
# ---------------------------------------------------------
# Tests whether residuals follow
# a normal distribution.

jarque.bera.test(Residuals)

jarque.bera.test(ResidualsMktRF)
jarque.bera.test(ResidualsSMB)
jarque.bera.test(ResidualsHML)
jarque.bera.test(ResidualsRMW)
jarque.bera.test(ResidualsCMA)
jarque.bera.test(ResidualsRF)

# ---------------------------------------------------------
# 10. Scatterplots and OLS visualisation
# ---------------------------------------------------------
# Visual inspection of linear relationships
# between dependent and independent variables.

plot(dataset$Manuf ~ dataset$MktRF,
     xlab = "MktRF",
     ylab = "Manuf")

abline(lm(dataset$Manuf ~ dataset$MktRF), col = 1)

plot(dataset$Manuf ~ dataset$SMB,
     xlab = "SMB",
     ylab = "Manuf")

abline(lm(dataset$Manuf ~ dataset$SMB), col = 1)

plot(dataset$Manuf ~ dataset$HML,
     xlab = "HML",
     ylab = "Manuf")

abline(lm(dataset$Manuf ~ dataset$HML), col = 1)

plot(dataset$Manuf ~ dataset$RMW,
     xlab = "RMW",
     ylab = "Manuf")

abline(lm(dataset$Manuf ~ dataset$RMW), col = 1)

plot(dataset$Manuf ~ dataset$CMA,
     xlab = "CMA",
     ylab = "Manuf")

abline(lm(dataset$Manuf ~ dataset$CMA), col = 1)

plot(dataset$Manuf ~ dataset$RF,
     xlab = "RF",
     ylab = "Manuf")

abline(lm(dataset$Manuf ~ dataset$RF), col = 1)

# ---------------------------------------------------------
# 11. Residuals vs explanatory variables
# ---------------------------------------------------------
# Used to visually inspect:
# - heteroscedasticity
# - non-linearity
# - outliers

plot(dataset$MktRF, Residuals,
     xlab = "MktRF",
     ylab = "Residual")

plot(dataset$SMB, Residuals,
     xlab = "SMB",
     ylab = "Residual")

plot(dataset$HML, Residuals,
     xlab = "HML",
     ylab = "Residual")

plot(dataset$RMW, Residuals,
     xlab = "RMW",
     ylab = "Residual")

plot(dataset$CMA, Residuals,
     xlab = "CMA",
     ylab = "Residual")

plot(dataset$RF, Residuals,
     xlab = "RF",
     ylab = "Residual")

# ---------------------------------------------------------
# 12. Breusch-Pagan heteroscedasticity tests
# ---------------------------------------------------------
# Null hypothesis:
# constant variance (homoscedasticity)

bptest(model)

bptest(modelMktRF)
bptest(modelSMB)
bptest(modelHML)
bptest(modelRMW)
bptest(modelCMA)
bptest(modelRF)

# ---------------------------------------------------------
# 13. Modified White test
# ---------------------------------------------------------
# Additional heteroscedasticity testing.

y_fitted = fitted(model)

aux_regression_equation <- 
  "Residuals^2 ~ y_fitted + I(y_fitted^2)"

aux_model <- lm(aux_regression_equation, data = dataset)

summary(aux_model)

# ---------------------------------------------------------
# 14. Multicollinearity diagnostics
# ---------------------------------------------------------
# Correlation matrix and VIF values.

cor(dataset[, c(
  "MktRF",
  "SMB",
  "HML",
  "RMW",
  "CMA",
  "RF"
)])

# Variance Inflation Factors
vif(model)

# ---------------------------------------------------------
# 15. Autocorrelation diagnostics
# ---------------------------------------------------------
# Residuals should not exhibit
# serial correlation over time.

plot(
  Residuals,
  type = 'l',
  xlab = "Observation number",
  ylab = "Residuals"
)

# Lagged residual plots
ResidualsLagged <- c(
  NA,
  Residuals[1:length(Residuals)-1]
)

plot(
  ResidualsLagged,
  Residuals,
  xlab = "Lagged Residuals",
  ylab = "Residuals"
)

# ---------------------------------------------------------
# 16. Durbin-Watson tests
# ---------------------------------------------------------
# Tests for autocorrelation.

durbinWatsonTest(model)

durbinWatsonTest(modelMktRF)
durbinWatsonTest(modelSMB)
durbinWatsonTest(modelHML)
durbinWatsonTest(modelRMW)
durbinWatsonTest(modelCMA)
durbinWatsonTest(modelRF)

# ---------------------------------------------------------
# 17. Cochrane-Orcutt correction
# ---------------------------------------------------------
# Adjusts regression models
# for autocorrelation issues.

corrected_modelMktRF <- cochrane.orcutt(modelMktRF)
corrected_modelSMB   <- cochrane.orcutt(modelSMB)
corrected_modelHML   <- cochrane.orcutt(modelHML)
corrected_modelRMW   <- cochrane.orcutt(modelRMW)
corrected_modelCMA   <- cochrane.orcutt(modelCMA)
corrected_modelRF    <- cochrane.orcutt(modelRF)

# Model summaries after correction
summary(corrected_modelMktRF)
summary(corrected_modelSMB)
summary(corrected_modelHML)
summary(corrected_modelRMW)
summary(corrected_modelCMA)
summary(corrected_modelRF)

# ---------------------------------------------------------
# 18. Fitted values after correction
# ---------------------------------------------------------

fittedMktRF <- fitted(corrected_modelMktRF)
fittedSMB   <- fitted(corrected_modelSMB)
fittedHML   <- fitted(corrected_modelHML)
fittedRMW   <- fitted(corrected_modelRMW)
fittedCMA   <- fitted(corrected_modelCMA)
fittedRF    <- fitted(corrected_modelRF)

# ---------------------------------------------------------
# 19. Residuals vs fitted values plots
# ---------------------------------------------------------
# Used to inspect:
# - remaining heteroscedasticity
# - model fit quality

plot(fittedMktRF, Residuals,
     xlab = "Fitted",
     ylab = "Residuals MktRF")

plot(fittedSMB, Residuals,
     xlab = "Fitted",
     ylab = "Residuals SMB")

plot(fittedHML, Residuals,
     xlab = "Fitted",
     ylab = "Residuals HML")

plot(fittedRMW, Residuals,
     xlab = "Fitted",
     ylab = "Residuals RMW")

plot(fittedCMA, Residuals,
     xlab = "Fitted",
     ylab = "Residuals CMA")

plot(fittedRF, Residuals,
     xlab = "Fitted",
     ylab = "Residuals RF")

# ---------------------------------------------------------
# 20. Plot fitted values over time
# ---------------------------------------------------------

plot(fittedMktRF,
     type = 'l',
     xlab = "Observation number",
     ylab = "Residuals MktRF")

plot(fittedSMB,
     type = 'l',
     xlab = "Observation number",
     ylab = "Residuals SMB")

plot(fittedHML,
     type = 'l',
     xlab = "Observation number",
     ylab = "Residuals HML")

plot(fittedRMW,
     type = 'l',
     xlab = "Observation number",
     ylab = "Residuals RMW")

plot(fittedCMA,
     type = 'l',
     xlab = "Observation number",
     ylab = "Residuals CMA")

plot(fittedRF,
     type = 'l',
     xlab = "Observation number",
     ylab = "Residuals RF")

# =========================================================
# END OF ANALYSIS
# =========================================================

