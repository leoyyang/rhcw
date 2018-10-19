The R Package of Panel Data Approach for Program Evaluation
===========================
**Author:** Leo Y. Yang <pdshuimu@gmail.com>

This package is used to do the program evaluation using the Panel Data Approach raised by Cheng Hsiao, H. Steve Ching, and Shui Ki Wan (2012), "A panel data approach for program evaluation: measuring the benefits of political and economic integration of Hong kong with mainland China", Journal of Applied Econometrics.

## Installation

``` r
# The development version from GitHub:
# install.packages("devtools")
devtools::install_github("jpshuimu/rhcw")
```

## Data
This package includes the data from Hsiao et.al (2012).

```{r}
library(rhcw)
data <- hcw_data

head(data)
```
| date | Hong Kong | Australia  | Austria | Canada | Denmark |
| :----: |:-----:|:-----:|:-----:|:-----:|:-----:|
| 1993Q1 | 0.062 | 0.040 | -0.013 | 0.010 | -0.012 |
| 1993Q2 | 0.059 | 0.038 | -0.008 | 0.021 | -0.003 |
| 1993Q3 | 0.058 | 0.023 | 0.001 | 0.019 | -0.008 |
## Select Donor Pool
```r
result <- draw_donorpool(data = hcw_data,
 target_name = "Hong Kong",
 donorpool_name = NULL,
 time_name = "date",
 period = 20, 
 nvmax = 6)
```

## Draw the Results
```r
plot_sim_result(result)
```

![](https://github.com/jpshuimu/rhcw/blob/master/img/plot_sim_result.png)

```r
plot_delta(result)
```
![](https://github.com/jpshuimu/rhcw/blob/master/img/plot_delta.png)
# Do Placebo Test
```r
placebo_time(result, lead_period = 5)
```
![](https://github.com/jpshuimu/rhcw/blob/master/img/placebo_time.png)

```r
placebo_unit(result)
```
![](https://github.com/jpshuimu/rhcw/blob/master/img/placebo_unit.png)
