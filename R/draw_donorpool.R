#' Draw Optimaized Counterparts from the Donor Pool.
#'
#' \code{draw_donorpool} returns the best couterparts that match the target unit in the pre-treatment period.
#'
#' @param data The imput data, which contains the outcome Y for both the target and donor pool units,
#'  and also a time variable
#' @param target_name The unit name we want to match in the pre-treatment and to predict in the after-treatment.
#' @param donorpool_name The unit name of candidates in donorpool we want to optimizaed.
#' @param time_name The name of time variable.
#' @param period The number of observations in pre-treatment period, start from the first period.
#' @param criteria The information criteria we want to use.
#' @param nvmax The maxmum number we want to draw from the donor pool
#'
#' @return The list of selected optimale counterparts and the $R^2$ of the model
#' @export
draw_donorpool <-  function(data, target_name, donorpool_name = NULL,
                            time_name, period, criteria = "BIC", nvmax) {
  y = data %>%
    dplyr::select(target_name)

  if (is.null(donorpool_name)) {
    X = data %>%
      dplyr::select(-matches(target_name), -matches(time_name))
  } else {
    X = data %>%
      dplyr::select(donorpool_name)
  }

  Xy <- cbind(X,y) %>%
    as.data.frame()

  out <- bestglm::bestglm(Xy[1:period,], IC = criteria, nvmax = nvmax)
  a <- out$BestModel
  rs <- summary(a)$r.squared

  # generate the name of counterparts
  donor_pool_choosed <- names(a$coefficients)[-1] %>%
    stringr::str_replace("\\."," ")

  alpha <- a$coefficients[1]
  coefficient <- a$coefficients
  a_star <- matrix(a$coefficients[-1])

  y_sim <- foreach::foreach(i = 1:nrow(Xy)) %do% {
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

  donor_pool_result <- data.frame(coefficient)

  sim_result <- data.frame(time = data[,time_name], y_actural = data[, target_name], y_sim) %>%
    dplyr::mutate(treatment_dummy = ifelse(time %in% data[1:period,time_name], 0, 1))

  # we also want to return all the parameters, so that we could run the placebo test with same setting.
  return(list(Simulation_Result = sim_result, Donor_Pool_Result = donor_pool_result, R_Square = rs,
              data = data, target_name = target_name, donorpool_name = donorpool_name,
              time_name = time_name, period = period, criteria = criteria, nvmax = nvmax))
}
