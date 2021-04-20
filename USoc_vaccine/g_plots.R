### Forest plots for cognitive function


library(readxl)
library(ggplot2)
library(forestmodel)



## 1. The basics

tab3 = read_xlsx("FigORsCIs.xlsx", sheet=4)

strip3 = tab3


unlist(strsplit(strip3$coefs[2], " "))[3]


m = 1
for (i in 1:dim(strip3[1])){
  strip3$OR[i] = unlist(strsplit(strip3$coefs[i], " "))[1]
  strip3$lower.CI[i] = unlist(strsplit(strip3$coefs[i], " "))[2]
  strip3$upper.CI[i] = unlist(strsplit(strip3$coefs[i], " "))[3]
}



strip3$lower.CI = substr(strip3$lower.CI,2, 5)
strip3$upper.CI = substr(strip3$upper.CI,1, 4)

strip3$OR = as.numeric(strip3$OR)
strip3$lower.CI = as.numeric(strip3$lower.CI)
strip3$upper.CI = as.numeric(strip3$upper.CI)

strip3$level = factor(strip3$level, levels=c('low','middle','high'))


g.ORs = ggplot(data = strip3, aes(x=level, 
                                  y=OR, ymin=lower.CI, ymax=upper.CI,
                                  color=Model
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
  xlab('Cognitive function (g) tertile') + ylab('Odds ratio (95% CI)')+
  theme_classic()+theme(#legend.position='none',
    legend.position = c(0.85,0.85),#c(0.85,0.15),
    legend.background = element_rect(size=0.5, linetype="solid",colour ="darkblue")
    , text = element_text(size=17))

g.ORs
#g.ORs + scale_color_manual(values=(hue_pal()(7)[c(1:3,5: 7)]))




### at the moment, see bottom



## 2. Models 1 & 6 broken down by g deciles

m2g10cat = glm(vax.cat ~ as.integer(g.dec) + j_age_dv + female + non.white
            , data = df.sub
            , family=binomial())
summary(m2g10cat)

forest_model(model=m2g10cat, covariates='g.dec')


m7g10cat = glm(vax.cat ~ as.integer(g.dec) + j_age_dv + female + non.white +
              cmds + as.factor(cancer) + respir +
              Edu + shield + 
              cf_scghq2_dv
            , data = df.sub
            , family=binomial())
summary(m7g10cat)

forest_model(m7g10cat, covariates='g.dec')






## Gussied version

tab5 = read_xlsx("FigORsCIs.xlsx", sheet=5)

strip5 = tab5

unlist(strsplit(strip5$coefs[2], " "))[3]

m = 1
for (i in 1:dim(strip5[1])){
  strip5$OR[i] = unlist(strsplit(strip5$coefs[i], " "))[1]
  strip5$lower.CI[i] = unlist(strsplit(strip5$coefs[i], " "))[2]
  strip5$upper.CI[i] = unlist(strsplit(strip5$coefs[i], " "))[3]
}

strip5$lower.CI = substr(strip5$lower.CI,2, 5)
strip5$upper.CI = substr(strip5$upper.CI,1, 4)

strip5$OR = as.numeric(strip5$OR)
strip5$lower.CI = as.numeric(strip5$lower.CI)
strip5$upper.CI = as.numeric(strip5$upper.CI)

strip5$level = factor(strip5$level, levels=c('1','2','3','4','5','6','7','8','9','Highest (10)'))


g.dec.ORs = ggplot(data = strip5, aes(x=level, 
                                  y=OR, ymin=lower.CI, ymax=upper.CI,
                                  color=Model
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
  xlab('Cognitive function (g) decile') + ylab('Odds ratio (95% CI)')+
  theme_classic()+theme(#legend.position='none',
    legend.position = c(0.85,0.85),#c(0.85,0.15),
    legend.background = element_rect(size=0.5, linetype="solid",colour ="darkblue")
    , text = element_text(size=17))

g.dec.ORs
#g.ORs + scale_color_manual(values=(hue_pal()(7)[c(1:3,5: 7)]))



### FIG 2 - CONFIDENCE INTERVALS ###



#######


















### FUNCTIONS ###

## Allows control over facet dimensions

UniquePanelCoords <- ggplot2::ggproto(
  "UniquePanelCoords", ggplot2::CoordCartesian,
  
  num_of_panels = 1,
  panel_counter = 1,
  panel_ranges = NULL,
  
  setup_layout = function(self, layout, params) {
    self$num_of_panels <- length(unique(layout$PANEL))
    self$panel_counter <- 1
    layout
  },
  
  setup_panel_params =  function(self, scale_x, scale_y, params = list()) {
    if (!is.null(self$panel_ranges) & length(self$panel_ranges) != self$num_of_panels)
      stop("Number of panel ranges does not equal the number supplied")
    
    train_cartesian <- function(scale, limits, name, given_range = NULL) {
      if (is.null(given_range))
        range <- scale_range(scale, limits, self$expand)
      else
        range <- given_range
      
      out <- scale$break_info(range)
      out$arrange <- scale$axis_order()
      names(out) <- paste(name, names(out), sep = ".")
      out
    }
    
    cur_panel_ranges <- self$panel_ranges[[self$panel_counter]]
    if (self$panel_counter < self$num_of_panels)
      self$panel_counter <- self$panel_counter + 1
    else
      self$panel_counter <- 1
    
    c(train_cartesian(scale_x, self$limits$x, "x", cur_panel_ranges$x),
      train_cartesian(scale_y, self$limits$y, "y", cur_panel_ranges$y))
  }
)

coord_panel_ranges <- function(panel_ranges, expand = TRUE, default = FALSE, clip = "on") 
{
  ggplot2::ggproto(NULL, UniquePanelCoords, panel_ranges = panel_ranges, 
                   expand = expand, default = default, clip = clip)
}

scale_range <- function(scale, limits = NULL, expand = TRUE) {
  expansion <- if (expand) expand_default(scale) else c(0, 0)
  
  if (is.null(limits)) {
    scale$dimension(expansion)
  } else {
    range <- range(scale$transform(limits))
    expand_range(range, expansion[1], expansion[2])
  }
}


expand_default <- function(scale, discrete = c(0, 0.6, 0, 0.6), continuous = c(0.05, 0, 0.05, 0)) {
  scale$expand %|W|% if (scale$is_discrete()) discrete else continuous
}
