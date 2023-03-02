library(tidyverse)
library(glue)
library(patchwork)

#rm(list = ls())
setwd("C:/Users/liamj/Downloads")


# Data ----
# p-values 
p_val <- c(hosp = 0.021, dead = 0.004)

# At Risk ----
n <- list()
n$dead <- tribble(
  ~decile, ~events, ~at_risk,
  0, 10, 41331,
  1, 12, 40828,
  2, 24, 41190,
  3, 20, 40302,
  4, 21, 40954,
  5, 20, 39954,
  6, 25, 40039,
  7, 20, 39886,
  8, 27, 38602,
  9, 22, 37933,
)

n$hosp <- tribble(
  ~decile, ~events, ~at_risk,
  0, 21, 41331,
  1, 11, 40828,
  2, 25, 41190,
  3, 19, 40302,
  4, 25, 40954,
  5, 32, 39954,
  6, 23, 40039,
  7, 23, 39886,
  8, 34, 38602,
  9, 27, 37933,
)

# Hazard Ratios
format_hr <- function(df, outcome){
  df %>%
    add_row(decile = 0, hr = 1, .before = 1) %>%
    left_join(n[[outcome]], by = "decile") %>%
    mutate(p_trend = p_val[outcome],
           across(c(at_risk, events),
                  ~ format(.x, big.mark = ",") %>% trimws()))
}

hr_dead <- tribble(
  ~decile, ~hr, ~se, ~z, ~p, ~lci, ~uci,
  1, 1.149102, .4928528, 0.32, 0.746, .4957655, 2.663429, 
  2, 2.235081, .8458401, 2.13, 0.034, 1.06455, 4.692675, 
  3, 1.886236, .7366723, 1.62, 0.104, .8773201, 4.055403,
  4, 1.941926, .7553582, 1.71, 0.088, .9060198, 4.162246,
  5, 1.905815, .7504486, 1.64, 0.101, .8808562, 4.12341,
  6,  2.41273, .9232074, 2.30, 0.021, 1.139738, 5.10755,
  7, 1.999289, .7952247, 1.74, 0.082, .9168684, 4.359575,
  8, 2.913667, 1.119881, 2.78, 0.005, 1.371755, 6.188752,
  9,  2.57698, 1.029311, 2.37, 0.018, 1.177931, 5.637708,
) %>%
  format_hr("dead") 

hr_hosp <- tribble(
  ~decile, ~hr, ~se, ~z, ~p, ~lci, ~uci,
  1, .9201267, .3930063, -0.19, 0.845, .3983646, 2.125272,
  2, 1.735785, .6445722, 1.49, 0.138, .838316, 3.594049,
  3, 1.240893, .4899926, 0.55, 0.585, .5722941, 2.6906,
  4, 1.707748, .6345402, 1.44, 0.150, .8244161, 3.537536,
  5, 1.707389, .6375945, 1.43, 0.152, .8212325, 3.549758,
  6, 1.602602, .6055718, 1.25, 0.212, .7641592, 3.360991,
  7, 1.454569, .56201, 0.97, 0.332, .682104, 3.101829,
  8, 1.863312, .7022249, 1.65, 0.099, .8902133, 3.900113,
  9, 1.739218, .6726332, 1.43, 0.152, .8149977, 3.711518,
) %>%
  format_hr("hosp") 

# Combine
tbl <- bind_rows(hosp = hr_hosp, dead = hr_dead,
                 .id = "outcome") %>%
  mutate(row = row_number(),
         dep_clean = ifelse(outcome == "dead", "Death", "Hospitalisation") %>%
           paste0("\n(p value for trend = ", p_trend, ")") %>%
           fct_reorder(row),
         x_clean = ifelse(decile == 0, "Reference", as.character(decile)),
         x_clean = glue("{x_clean}({at_risk}, {events})") %>%
           fct_reorder(row) %>%
           fct_rev())

tbl

# Plots ----
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73",
                "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


ggplot(tbl) +
  aes(x = x_clean, y = hr, ymin = lci, ymax = uci) +
  facet_wrap(~ dep_clean, scales = "free") +
  geom_hline(yintercept = 1) +
  geom_pointrange(color = cbbPalette[7]) +
  scale_y_log10() +
  theme_minimal() +
  coord_flip() +
  theme(axis.title.y = element_text(angle = 0, vjust = 0.5),
        panel.spacing = unit(1, "lines")) +
  labs(y = "Hazard Ratio (95% Confidence Interval)", 
       x = "Decile\nof CRP\n(At Risk / Events)")

ggsave("both.png", units = "cm", 
       width  = 21, height = 9.9, dpi = 300)



p1 <- tbl %>%
  select(outcome, decile, at_risk, events) %>%
  pivot_wider(names_from = outcome, values_from = events) %>%
  mutate(x_clean = ifelse(decile == 0, "Reference", as.character(decile)), 
         .after = 1) %>%
  pivot_longer(-decile) %>%
  mutate(name = case_when(name == "x_clean" ~ "Decile\nof CRP",
                          name == "at_risk" ~ "At Risk",
                          name == "hosp" ~ "Hospitalised",
                          name == "dead" ~ "Dead") %>%
           fct_reorder(row_number())) %>%
  ggplot() +
  aes(x = decile, y = name, label = value) +
  geom_text(size = 3) +
  coord_flip() +
  scale_y_discrete(position = "right") +
  scale_x_reverse() + 
  labs(x = NULL, y = NULL) +
  theme_minimal() +
  theme(axis.text.y = element_blank(),
        axis.text.x = element_text(color = "black"),
        panel.grid = element_blank())
p1

p2 <- ggplot(tbl) +
  aes(x = decile, y = hr, ymin = lci, ymax = uci) +
  facet_wrap(~ dep_clean, scales = "free_x") +
  geom_hline(yintercept = 1) +
  geom_pointrange(color = cbbPalette[7]) +
  scale_x_reverse() +
  scale_y_log10() +
  theme_minimal() +
  coord_flip() +
  theme(axis.title.y = element_text(angle = 0, vjust = 0.5),
        panel.spacing = unit(1, "lines")) +
  labs(y = "Hazard Ratio (95% Confidence Interval)", 
       x = NULL) +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        strip.placement = "outside")


p1 + p2 + plot_layout(widths = c(1, 2))
ggsave("both_2.png", units = "cm", 
       width  = 21, height = 9.9, dpi = 300)
