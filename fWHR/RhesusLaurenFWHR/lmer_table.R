
## some of these are probably not needed
library(lme4)
library(car)
library(sjPlot)
library(effects)
library(pbkrtest)
library(xtable)
library(fifer)
library(piecewiseSEM)



#m <- lmer(....) #model
m = m4.LF.o
range = c(1:2) 
#range = c(1:3)

coefs <- data.frame(coef(summary(m)))
df.KR <- get_ddf_Lb(m, fixef(m))
conf_int <- confint(m, method='profile')
conf_int <- conf_int[-range, ]
coefs$ci <- paste0("[", round(conf_int[ , 1], 2), ", ",
                   round(conf_int[ , 2], 2), "]") 
coefs$p.KR <- 2 * (1 - pt(abs(coefs$t.value), df.KR))
#coefs$par <- c("...", "...", ...) # specify the "Paramater" column of the table
coefs$par = rownames(coefs)
#coefs$par <- c("(Intercept)", "Age", "Age^2", "Age^3")

m_tab <- cbind(coefs$par, round(coefs$Estimate, 2), coefs$ci,
               round(coefs$t.value, 2), round(coefs$p.KR, 3))
m_tab[ , 5] <- gsub("^0$", "", m_tab[ , 5])
m_tab <- as.data.frame(m_tab) 
m_tab[[1]] <- gsub("^2", "$^{2}$", m_tab[[1]], fixed = T)
m_tab[[1]] <- gsub("X", "$\\times$", m_tab[[1]], fixed = T)
#for (i in 2:4) m_tab[[i]] <- gsub("-", "$-$", m_tab[[i]], fixed = T)
m_tab[[5]] <- gsub("0.", ".", m_tab[[5]], fixed = T)
m_tab

cat("% TODO IMPORTANT!!! replace alignment with lr@{ }lrc\r\r")
print(xtable(m_tab, caption = "Overview of the linear mixed-effects model ...",
             label = "results_tab"
      , align = "llrlrc"),
      sanitize.text.function = identity,
      caption.placement = "top",
      include.colnames = FALSE,
      include.rownames = FALSE,
      hline.after = NULL,
      add.to.row = list(
        pos = as.list(c(-1, nrow(m_tab))),
        command=c("\\toprule \n Parameter & \\multicolumn{2}{c}{Beta [95\\% CI]} & $t$-value & $p$-value$^{\\dagger}$ \\\\ \n \\midrule\n", "\\bottomrule \\multicolumn{5}{l}{\\footnotesize $Note$. Unless stated otherwise, all $p$-values < .001.} \n \\\\  \\multicolumn{5}{l}{\\footnotesize $^{\\dagger} p$-values based on  Kenward-Roger approximate degrees of freedom.}\n")
                  ), type = "html", file = "outputTrans2excel.html")



#print(xtable(m1),type = "html", file = "outputTrans2excel.html")

#print.xtable(xmancova, type="html", file="mancova.html")