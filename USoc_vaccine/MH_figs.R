### Mental health figures


library(readxl)
library(ggplot2)
library(gg.gap)
library(scales)
library(forestmodel)

library(gridExtra)
library(ggpubr)
library(gtable)
library(tibble)



### Fig 2 forest plots
tab.MH = read_xlsx("FigORsCIs.xlsx", sheet=6)

stripMH = tab.MH

#unlist(strsplit(stripMH$coefs[2], " "))[3]

m = 1
for (i in 1:dim(stripMH[1])){
  stripMH$OR[i] = unlist(strsplit(stripMH$coefs[i], " "))[1]
  stripMH$lower.CI[i] = unlist(strsplit(stripMH$coefs[i], " "))[2]
  stripMH$upper.CI[i] = unlist(strsplit(stripMH$coefs[i], " "))[3]
}

stripMH$lower.CI = substr(stripMH$lower.CI,2, 5)
stripMH$upper.CI = substr(stripMH$upper.CI,1, 4)

stripMH$OR = as.numeric(stripMH$OR)
stripMH$lower.CI = as.numeric(stripMH$lower.CI)
stripMH$upper.CI = as.numeric(stripMH$upper.CI)

levels(factor(stripMH$variable))
stripMH$variable = factor(stripMH$variable,
                          levels=c('Anxiety','Depression','Other mental health condition(s)',
                                   'Any mental health condition',
                                   'Psychological distress','[filler]',
                                   'Cardiometabolic disease','Respiratory disease',
                                   'Any cancer','Any physical health condition'
                                   ))

# levels=c('Anxiety','Depression','Psychosis or schizophrenia','Bipolar disorder or manic depression',
#          'An eating disorder','Post-traumatic stress disorder','Other','Any mental health diagnosis',
#          'Psychological distress',
#          'Cardiometabolic disease','Respiratory disease',
#          'Any cancer','Any physical comorbidity'
# )

stripMH$variable = fct_rev(stripMH$variable)

levels(stripMH$variable)


MH.ORs = ggplot(data = stripMH, aes(x=variable, 
                                  y=OR, ymin=lower.CI, ymax=upper.CI,
                                  color=model
))+
  geom_pointrange(lwd=0.9, position=position_dodge(width=-0.8)) +
  #geom_point(aes(y=min, color='blue'))+
  #geom_point(aes(y=max, color='red'))+
  geom_hline(yintercept = 1, lty=2)+
  #scale_y_continuous(breaks = c(60,70,80,90,100,110,120,130,140), limits=c(80,125))+
  coord_flip()+
  #scale_x_discrete(labels=c("A"=expression(bold(A)), "C"=expression(bold(C)),
  #                          "E"=expression(bold(E)), parse=TRUE)) +
  #facet_wrap(~outcome, ncol=1, scales='free') +
  xlab('Heath condition(s)') + ylab('Odds ratio (95% CI)')+
  theme_classic()+theme(#legend.position='none',
    legend.position = c(0.75,0.15),#c(0.85,0.15),
    legend.background = element_rect(size=0.5, linetype="solid",colour ="darkblue")
    , text = element_text(size=15))

MH.ORs
MH.ORs + scale_color_manual(values=(hue_pal()(7)[c(1,4)]))

# gg.gap(plot=MH.ORs,
#        segments=c(5,10),
#        ylim=c(0,15))







### Fig 2 (and possibly for 3)

panels2 <- list(
  # list(width = 0.001),
  #list(width = 0.05, display = ~variable, heading = ""),  # swap this with the below one as needed
  #list(width = 0.1, display = ~level),
  # list(width = 0.05, display = ~n, hjust = 1, heading = "N"),
  # list(width = 0.05, display = ~n_events, width = 0.05, hjust = 1, heading = "Events"),
  # list(
  #   width = 0.05,
  #   display = ~ replace(sprintf("%0.1f", person_time / 365.25), is.na(person_time), ""),
  #   heading = "Person-\nYears", hjust = 1
  # ),
  list(width = 0.001, item = "vline", hjust = 0.5),
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


df.MH$Anxiety = as.integer(df.MH$anxiety)-1
df.MH$Depression = as.integer(df.MH$depress)-1
df.MH$`Other mental health condition` = as.integer(df.MH$otherMH)-1
df.MH$`Any mental health condition` = as.integer(df.MH$anyMH)-1
df.MH$`Psychological distress` = df.MH$ghq.bin


anx.6for = glm(vax.cat ~ Anxiety + j_age_dv + female + non.white
            + cmds + cancer + respir 
            + shield + Edu + g
            , data = df.MH
            , family=binomial())

dep.6for = glm(vax.cat ~ Depression + j_age_dv + female + non.white
               + cmds + cancer + respir 
               + shield + Edu + g
               , data = df.MH
               , family=binomial())

oth.6for = glm(vax.cat ~ `Other mental health condition` + j_age_dv + female + non.white
               + cmds + cancer + respir 
               + shield + Edu + g
               , data = df.MH
               , family=binomial())

any.6for = glm(vax.cat ~ `Any mental health condition` + j_age_dv + female + non.white
               + cmds + cancer + respir 
               + shield + Edu + g
               , data = df.MH
               , family=binomial())

ghq.6bin = glm(vax.cat ~ `Psychological distress` + j_age_dv + female + non.white
               + cmds + cancer + respir 
               + shield + Edu + g
               , data = df.MH
               , family=binomial())


summary(any.6for)


fp.ment = forest_model(model_list=list(anx.6for, dep.6for, oth.6for, any.6for, ghq.6bin),# cmds.6, respir.6, cancer.6, anyMorb.6),
                             covariates=c('Anxiety','Depression',
                                          '`Other mental health condition`',
                                          '`Any mental health condition`',
                                          '`Psychological distress`')#,'cmds','respir','cancer','anyMorb'
             , merge_models=TRUE
             , exponentiate = TRUE
             , limits=c(-0.55,0.7)
             , format_options=forest_model_format_options(text_size=5, banded=FALSE)
             , panels=panels2
                             ) + theme(axis.text.x=element_text(size=15))
fp.ment



df.MH$`Cardiometabolic disease` = as.integer(df.MH$cmds)-1
df.MH$`Respiratory disease` = as.integer(df.MH$respir)-1
df.MH$`Any cancer` = as.integer(df.MH$cancer)-1
df.MH$`Any physical health condition` = as.integer(df.MH$anyMorb)-1
df.MH$Shielding = as.integer(df.MH$shield)

cmds.6for = glm(vax.cat ~ `Cardiometabolic disease` + j_age_dv + female + non.white
               + anyMH
               + shield + Edu + g
               , data = df.MH
               , family=binomial())

respir.6for = glm(vax.cat ~ `Respiratory disease` + j_age_dv + female + non.white
                + anyMH
                + shield + Edu + g
                , data = df.MH
                , family=binomial())

cancer.6for = glm(vax.cat ~ `Any cancer` + j_age_dv + female + non.white
                + anyMH
                + shield + Edu + g
                , data = df.MH
                , family=binomial())

anyMorb.6for = glm(vax.cat ~ `Any physical health condition` + j_age_dv + female + non.white
                + anyMH
                + shield + Edu + g
                , data = df.MH
                , family=binomial())

shield.6for = glm(vax.cat ~ Shielding + j_age_dv + female + non.white
                + anyMH
                + Edu + g
                , data = df.MH
                , family=binomial())

summary(shield.6for)


fp.phys = forest_model(model_list=list(cmds.6for, respir.6for, cancer.6for, anyMorb.6for, shield.6for),
             covariates=c('`Cardiometabolic disease`',
                          '`Respiratory disease`',
                          '`Any cancer`',
                          '`Any physical health condition`',
                          'Shielding')
             , merge_models=TRUE
             , exponentiate = TRUE
             , limits=c(-0.55,0.7)
             , format_options=forest_model_format_options(text_size=5, banded=FALSE)
             , panels=panels2
) + theme(axis.text.x=element_text(size=15))
fp.phys 



# ggarrange(fp.ment, fp.phys, labels=c('A','B'), ncol=1)

table(df.MH$vax.cat, df.MH$Shielding)

ment.cols = tribble(
  ~`Mental health`, ~N, ~Hesitant,
  'Anxiety', 324, 50,
  'Depression', 368, 54,
  'Other mental health condition', 111, 20,
  'Any mental health condition', 491, 71,
  'Psychological distress', 4022, 510
)


phys.cols = tribble(
  ~`Physical health`, ~N, ~Hesitant,
  'Cardiometabolic disease', 1905, 147,
  'Respiratory disease', 1034, 107,
  'Any cancer', 389, 29,
  'Any physical health condition', 2614, 225,
  'Shielding', 889, 88
)


## Make the gg objects


hj <- matrix(c(0, 0.5, 1), ncol=3, nrow=nrow(df), byrow=TRUE)
x <- matrix(c(0, 0.5, 1), ncol=3, nrow=nrow(df), byrow=TRUE)
tt1 <- ttheme_minimal(core=list(fg_params=list(hjust = as.vector(hj)
                                               , x = as.vector(x)
                                               )),
                      colhead=list(fg_params=list(hjust=1, x=0.95)))

p.phys = tableGrob(phys.cols, rows=NULL, theme=tt1)
p.phys$heights = unit(rep(1/nrow(p.phys), nrow(p.phys))-0.02, "npc")

p.ment = tableGrob(ment.cols, rows=NULL, theme=tt1)
p.ment$heights = unit(rep(1/nrow(p.ment), nrow(p.ment))-0.02, "npc")


g.up = arrangeGrob(grobs=list(p.ment,fp.ment), ncol=2, widths=c(0.3,0.7)
)
                   
# g.down = p.phys+fp.phys
g.down = arrangeGrob(grobs=list(p.phys,fp.phys), ncol=2, widths=c(0.3,0.7)
)

grid.arrange(g.up, g.down
  # p.ment, fp.ment, p.phys, fp.phys
             #, nrow=2#, ncol=2
             # , layout_matrix=lay
             #, widths=c(0.3,0.7,0.3,0.7)
  )
# 1111 x 611
          

### Fig 3 - GHQ forest plots


panels3 <- list(
  list(width = 0.001),
  #list(width = 0.05, display = ~variable, heading = ""),  # swap this with the below one as needed
  #list(width = 0.1, display = ~level),
  #list(width = 0.05, display = ~n, hjust = 1, heading = "N"),
#  list(width = 0.05, display = ~n_events, width = 0.05, hjust = 1, heading = "Events"),
  # list(
  #   width = 0.05,
  #   display = ~ replace(sprintf("%0.1f", person_time / 365.25), is.na(person_time), ""),
  #   heading = "Person-\nYears", hjust = 1
  # ),
  #list(width = 0.03, item = "vline", hjust = 0.5),
  list(
    width = 0.55, item = "forest", hjust = 0.5, heading = "Odds ratio", linetype = "dashed",
    line_x = 0
  ),
  list(width = 0.03, item = "vline", hjust = 0.5),
  list(width = 0.20, display = ~ ifelse(reference, "Reference", sprintf(
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

# ghq.lvls.1 = glm(vax.cat ~ ghq.fact + j_age_dv + female + non.white
#                  , data = df.MH
#                  , family=binomial())
# summary(ghq.lvls.1)
# 
# forest_model(model=ghq.lvls.1, covariates='ghq.fact')



ghq.lvls.6 = glm(vax.cat ~ ghq.fact + j_age_dv + female + non.white +
                   cmds + as.factor(cancer) + respir +
                   Edu + shield + g
                 , data = df.MH
                 , family=binomial())
#summary(ghq.lvls.6)

## Need to extract a df of Levels, Ns, hesitants
# table(df.MH$vax.cat, df.MH$ghq.fact)

ghq.cols = tribble(
  ~Level, ~N, ~Hesitant,
  0, 3339, 443,
  1, 1262, 120,
  2, 604, 72,
  3, 390, 55,
  4, 281, 31,
  5, 256, 28,
  6, 213, 31,
  7, 173, 26,
  8, 161, 20,
  9, 163, 22,
  10, 132, 24,
  11, 150, 25,
  12, 237, 56
)


## Make the gg objects
fp.ghq = forest_model(model=ghq.lvls.6, covariates='ghq.fact',
             panels=panels3
             ,limits=c(-0.8,0.8)
             , format_options=forest_model_format_options(text_size=5, banded=FALSE)
             ) + theme(axis.text.x=element_text(size=15))


p3 = tableGrob(ghq.cols, rows=NULL, theme=ttheme_minimal())
# p4 = ggplot() +
#   annotation_custom(p3)

p3$heights = unit(rep(1/nrow(p3), nrow(p3))-0.005, "npc")


grid.arrange(p3, fp.ghq, ncol=2, nrow=1, widths=c(0.3,0.7))



# p4 + fp.ghq + plot_layout(ncol=2, widths=c(0.3, 0.7))
# 
# fp.ghq + gridExtra::tableGrob(ghq.cols)
