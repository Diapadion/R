




panels3 <- list(
  list(width = 0.03),
  #list(width = 0.05, display = ~variable, heading = ""),  # swap this with the below one as needed
  list(width = 0.1, display = ~level),
  list(width = 0.05, display = ~n, hjust = 1, heading = "N"),
  #list(width = 0.05, display = ~n_events, width = 0.05, hjust = 1, heading = "Events"),
  # list(
  #   width = 0.05,
  #   display = ~ replace(sprintf("%0.1f", person_time / 365.25), is.na(person_time), ""),
  #   heading = "Person-\nYears", hjust = 1
  # ),
  list(width = 0.03, item = "vline", hjust = 0.5),
  list(
    width = 0.55, item = "forest", hjust = 0.5, heading = "Odds ratio", linetype = "dashed",
    line_x = 0
  ),
  list(width = 0.03, item = "vline", hjust = 0.5),
  list(width = 0.12, display = ~ ifelse(reference, "Reference", sprintf(
    "%0.2f (%0.2f, %0.2f)",
    trans(estimate), trans(conf.low), trans(conf.high)
  )), display_na = NA),
  # list(
  #   width = 0.05,
  #   display = ~ ifelse(reference, "", format.pval(p.value, digits = 1, eps = 0.001)),
  #   display_na = NA, hjust = 1, heading = "p"
  # ),
  list(width = 0.03)
)



ghq.lvls.6 = glm(vax.cat ~ ghq.fact + j_age_dv + female + non.white +
                   cmds + cancer + respir +
                   Edu + shield + g
                 , data = df.MH
                 , family=binomial())
# summary(ghq.lvls.6)


forest_model(model=ghq.lvls.6, covariates='ghq.fact',
             panels=panels3
             , format_options=forest_model_format_options(text_size=6)
)
