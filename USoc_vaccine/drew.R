library(tidyverse)
library(palmerpenguins)
library(broom)
library(glue)
library(patchwork)
library(ggplot2)


#rm(list = ls())

mod <- glm(sex ~ ., family = binomial, data = penguins)


events <- model.frame(mod) %>%
  select(where(is.factor)) %>%
  pivot_longer(-sex) %>%
  count(sex, name, value, name = "events") %>%
  add_count(name, value, name = "at_risk", wt = events) %>%
  filter(sex == levels(penguins$sex)[2]) %>%
  select(-sex) %>%
  mutate(term = glue("{name}{value}"))

events <- model.frame(mod) %>%
  select(where(is.numeric)) %>%
  names() %>%
  tibble(term = ., name = ., value = .,
         at_risk = nrow(model.frame(mod)), events = NA) %>%
  bind_rows(events) %>%
  arrange(term)




tidy_mod <- tidy(mod, conf.int = TRUE) %>%
  filter(term != "(Intercept)") %>%
  mutate(across(c(estimate, conf.low, conf.high), exp))

df_coef <- events %>%
  full_join(tidy_mod, by = "term") %>%
  mutate(estimate = ifelse(is.na(estimate), 1, estimate),
         string = glue("{round(estimate, 2)} ({round(conf.low, 2)}, {round(conf.high, 2)})"),
         string = ifelse(is.na(conf.low), "1 (Reference)", string)) %>%
  arrange(term)

df_tbl <- df_coef %>%
  select(term, name, value, at_risk, events, string) %>%
  mutate(value = ifelse(name == value, "", value))


p1 <- df_tbl %>%
  mutate(across(everything(), as.character)) %>%
  pivot_longer(-term) %>%
  drop_na() %>%
  mutate(name = factor(name, c("name", "value", "at_risk", "events", "string"))) %>%
  ggplot() +
  aes(y = fct_rev(term), x = name, label = value) +
  geom_text() +
  scale_x_discrete(position = "top") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) +
  labs(x = NULL, y = NULL)

p2 <- ggplot(df_coef) +
  aes(x = estimate, xmin = conf.low, xmax = conf.high, y = fct_rev(term)) +
  geom_vline(xintercept = 1) +
  geom_pointrange() +
  scale_x_log10() +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) +
  labs(x = "Odds Ratio", y = NULL)

p1 + p2



### DMA additions

p3 = tableGrob(events)
grid.arrange(p3,p1,p2)

