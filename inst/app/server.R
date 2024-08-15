shinyServer(function(input, output, session) {
  logistic_model <- function(time, y, parms) {
    with(as.list(c(y, parms)), {
      dN <- r * N * (1 - N / K)
      list(dN)
    })
  }

  # load example data
  data(logistic)
  # user defined data likelihood
  logistic_obs_model <- function(data, sim.data,
                                 samp) {
    epsilon <- 1e-6
    llik <- sum(dlnorm(data$ N_noisy,
      meanlog = log
      (sim.data[, "N"] + epsilon),
      sdlog = samp[["sdlog.N"]], log = TRUE
    ))
    return(llik)
  }

  r <- debinfer_par(
    name = "r", var.type = "de", fixed =
      FALSE, value = 0.5, prior = "norm", hypers = list(
      mean = 0, sd = 1
    ), prop.var = 0.005, samp.type = "rw"
  )
  K <- debinfer_par(
    name = "K", var.type = "de", fixed =
      FALSE, value = 5, prior = "lnorm", hypers = list
    (meanlog = 1, sdlog = 1), prop.var = 0.1, samp.type =
      "rw"
  )
  sdlog.N <- debinfer_par(
    name = "sdlog.N", var.type =
      "obs", fixed = FALSE, value = 0.1, prior = "lnorm",
    hypers = list(meanlog = 0, sdlog = 1), prop.var = c
    (3, 4), samp.type = "rw-unif"
  )

  N <- debinfer_par(
    name = "N", var.type = "init", fixed =
      TRUE, value = 0.1
  )

  mcmc.pars <- setup_debinfer(r, K, sdlog.N, N)

  # do inference with deBInfer
  # MCMC iterations
  iter <- 1000
  # inference call
  mcmc_samples <- de_mcmc(
    N = iter, data = logistic,
    de.model = logistic_model,
    obs.model = logistic_obs_model, all.params =
      mcmc.pars,
    Tmax = max(logistic$time), data.times = logistic
    $time,
    cnt = 500, plot = FALSE, solver = "ode"
  )

  observe({
    output$example_plot_1 <- renderPlot({
      plot(mcmc_samples)
    })
    output$example_plot_2 <- renderPlot({
      pairs(mcmc_samples)
    })
    output$example_plot_3 <- renderPlot({
      post_prior_densplot(mcmc_samples)
    })
  }) %>% bindEvent(input$example)
})
