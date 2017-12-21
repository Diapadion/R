### Associations with age and sex

library(psych)
library(car)
library(lsr)
library(xtable)
library(heplots)



with(all.bm[all.bm$species=='human',],cor.test(age,BMI))
with(all.bm[all.bm$species=='human',],cor.test(age,BPs))
with(all.bm[all.bm$species=='human',],cor.test(age,BPd))
with(all.bm[all.bm$species=='human',],cor.test(age,triglycerides))
with(all.bm[all.bm$species=='human',],cor.test(age,cholesterol))
with(all.bm[all.bm$species=='human',],cor.test(age,phosphate))

with(all.bm[all.bm$species=='chimp',],cor.test(age,BMI))
with(all.bm[all.bm$species=='chimp',],cor.test(age,BPs))
with(all.bm[all.bm$species=='chimp',],cor.test(age,BPd))
with(all.bm[all.bm$species=='chimp',],cor.test(age,triglycerides))
with(all.bm[all.bm$species=='chimp',],cor.test(age,cholesterol))
with(all.bm[all.bm$species=='chimp',],cor.test(age,phosphate))

with(all.bm[all.bm$species=='human',],t.test(BMI~sex))
with(all.bm[all.bm$species=='human',],cohensD(BPs~sex))
with(all.bm[all.bm$species=='human',],cohensD(BPd~sex))
with(all.bm[all.bm$species=='human',],cohensD(triglycerides~sex))
with(all.bm[all.bm$species=='human',],cohensD(cholesterol~sex))
with(all.bm[all.bm$species=='human',],cohensD(phosphate~sex))



#female = 2
# a positive d indicates mean in males (1) was higher
with(all.bm[all.bm$species=='chimp',],t.test(BMI~sex))
with(all.bm[all.bm$species=='chimp',],t.test(BPs~sex))
with(all.bm[all.bm$species=='chimp',],t.test(BPd~sex))
with(all.bm[all.bm$species=='chimp',],t.test(triglycerides~sex))
with(all.bm[all.bm$species=='chimp',],t.test(cholesterol~sex))
with(all.bm[all.bm$species=='chimp',],t.test(phosphate~sex))

with(all.bm[all.bm$species=='chimp',],cohensD(BMI~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(BPs~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(BPd~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(triglycerides~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(cholesterol~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(phosphate~sex))



mancova <- manova(cbind(BPs,BPd,BMI,triglycerides,cholesterol,phosphate) ~ age * species * sex, data=all.bm)
summary(mancova)
summary.aov(mancova)
etasq(mancova)
coef(mancova)

# xmancova <- xtable(mancova)
# print.xtable(xmancova, type="html", file="mancova.html")
# 
# xmancova <- xtable(summary.aov(mancova)[6])
# print.xtable(xmancova, type="html", file="mancova.html")
# 
# print.xtable(xtable(coef(mancova)),type='html',file='mancova.html')


