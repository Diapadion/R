# power analysis of MMs

library(longpower)

summary(m_1)

lmmpower(m_1, sig.level = 0.01, pct.change = -0.4067, n = 3)
