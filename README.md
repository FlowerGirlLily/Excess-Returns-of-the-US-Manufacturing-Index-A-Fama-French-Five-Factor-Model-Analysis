# Excess-Returns-of-the-US-Manufacturing-Index-A-Fama-French-Five-Factor-Model-Analysis

## Overview

This repository contains the R code, econometric analysis, and supporting materials for a study examining the determinants of excess returns of the US Manufacturing Index using the Fama-French Five-Factor Model framework. The analysis covers monthly data from July 1964 to August 2022. 

The project applies Ordinary Least Squares (OLS) regression models and extensive diagnostic testing to evaluate the explanatory power of:

* Market excess return (Mkt-RF)
* Size factor (SMB)
* Value factor (HML)
* Profitability factor (RMW)
* Investment factor (CMA)
* Risk-free rate (RF)

Due to violations of classical econometric assumptions in the full multivariate specification, additional univariate regressions were estimated for each explanatory factor. 

---

# Research Objective

The aim of this project is to identify which Fama-French factors best explain excess returns of the US Manufacturing Index over the analysed period. 

---

# Key Findings

* Mkt-RF (market excess return) was the strongest explanatory variable.
* Approximately 79% of variation in manufacturing excess returns was explained by the market factor alone.
* SMB and RF showed relatively weak explanatory power.
* RF exhibited heteroscedasticity and was excluded from the final interpretation.
* Durbin-Watson statistics suggested no significant autocorrelation.
* Multicollinearity diagnostics showed no major issues. 

The results suggest that systematic market risk is the dominant driver of excess returns in the US manufacturing sector.

---

# Econometric Methods

The project uses:

* Ordinary Least Squares (OLS) regression
* Jarque-Bera normality tests
* Breusch-Pagan heteroscedasticity tests
* Durbin-Watson autocorrelation tests
* Cochrane-Orcutt correction procedure
* Variance Inflation Factor (VIF) diagnostics
* Residual analysis and visualisation

The analysis was conducted entirely in R. 

---

# Repository Structure

```text id="ojfj9a"
├── data/
├── scripts/
│   └── fama_french_analysis.R
├── figures/
├── report/
│   ├── project_report.pdf
│   └── technical_appendix.pdf
├── README.md
└── requirements.txt
```

---

# Dataset

Data sources include:

* Kenneth French Data Library
* Fama-French Five-Factor dataset
* US Manufacturing Index returns

Period covered:

* July 1964 – August 2022 

---

# Software and Packages

Main R packages used:

* readxl
* lmtest
* tseries
* car
* orcutt
* viridis

---

# Main Diagnostic Tests

| Test            | Purpose                    |
| --------------- | -------------------------- |
| Jarque-Bera     | Residual normality         |
| Breusch-Pagan   | Heteroscedasticity         |
| Durbin-Watson   | Autocorrelation            |
| VIF             | Multicollinearity          |
| Cochrane-Orcutt | Autocorrelation correction |

---

# Limitations

Several limitations should be acknowledged:

* use of separate univariate regressions instead of a fully corrected multivariate specification,
* potential omitted variable bias,
* sensitivity of normality tests in large datasets,
* structural breaks across economic periods between 1964 and 2022. 

---

# Author

Patrycja Oliwia Pyzikiewicz
De Montfort University
Academic Year: 2022/2023
