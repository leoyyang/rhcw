#' Draw Optimaized Counterparts from the Donor Pool.
#'
#' \code{draw_donorpool} returns the best couterparts that match the target unit in the pre-treatment period.
#'
#' @param target The unit we want to match in the pre-treatment and to predict in the after-treatment.
#' @param donorpool The candidates of donorpool we want to optimizaed.
#' @param criteria The information criteria we want to use.
#' @param nvmax The maxmum number we want to draw from the donor pool
#'
#' @return The list of selected optimale counterparts and the $R^2$ of the model
draw_donorpool <-  function(target, donorpool, criteria = "BIC", nvmax) {
  Xy <- cbind(target, donnorpool)

  out <- bestglm(Xy, IC = criteria, nvmax = nvmax)
  a <- out$BestModel
  rs <- summary(a)$r.squared

  # generate the name of counterparts
  donor_pool_choosed <- names(a$coefficients)[-1]
  donor_pool_choosed <- str_replace(donor_pool_choosed,"\\."," ")

  alpha <- a$coefficients[1]
  a_star <- matrix(a$coefficients[-1])

  y_sim <- foreach(i = 1:nrow(Xy)) %do% {
    alpha + t(a_star) %*% t(as.matrix(Xy[i,donor_pool_choosed]))
  } %>%
    unlist()

  if (length(donor_pool_choosed) == 1){
    donor_pool_choosed <- c(donor_pool_choosed,"NA")
  }
  if (length(donor_pool_choosed) == 0){
    donor_pool_choosed <- c("NA","NA")
    rs <- 0
  }

  return(donor_pool_choosed, y_sim)
}
