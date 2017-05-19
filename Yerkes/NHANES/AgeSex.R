### Associations with age and sex

library(psych)
library(car)
library(lsr)
library(xtable)



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
with(all.bm[all.bm$species=='chimp',],plot(cholesterol~sex))
with(all.bm[all.bm$species=='chimp',],t.test(phosphate~sex))

with(all.bm[all.bm$species=='chimp',],cohensD(BMI~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(BPs~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(BPd~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(triglycerides~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(cholesterol~sex))
with(all.bm[all.bm$species=='chimp',],cohensD(phosphate~sex))



# table(all.bm$species)
# table(all.bm$species=='human')
# corr.test(
#   cbind(all.bm$BMI[all.bm$species=='human']),
#   all.bm$age[all.bm$species=='human'])
# )


sex.aov <- manova(cbind(BPs,BPd,BMI,triglycerides,cholesterol,phosphate) ~ sex * species, data=all.bm)
summary(sex.aov, test='Wilks')
summary.aov(sex.aov)


age.aov <- manova(cbind(BPs,BPd,BMI,triglycerides,cholesterol,phosphate) ~ age * species, data=all.bm)
summary(age.aov, test= 'Wilks')
summary.aov(age.aov)


mancova <- manova(cbind(BPs,BPd,BMI,triglycerides,cholesterol,phosphate) ~ age * species * sex, data=all.bm)
summary(mancova)
summary.aov(mancova)

xmancova <- xtable(mancova)
print.xtable(xmancova, type="html", file="mancova.html")

xmancova <- xtable(summary.aov(mancova)[3])
print.xtable(xmancova, type="html", file="mancova.html")


library(heplots)
library(candisc)


etasq(mancova)
coef(mancova)

print.xtable(xtable(coef(mancova)),type='html',file='mancova.html')


coefplot(mancova, variables=3:4, Scheffe=T)
heplot(mancova, variables=1:6)
heplot(mancova)
biplot(mancova)

pairs(mancova)







lda(cbind(BPs,BPd,BMI,triglycerides,cholesterol,phosphate) ~ age * species * sex, data=all.bm)



temp = aov(BPs ~ age * species * sex, data=all.bm)
TukeyHSD(temp)



# hist(all.bm$age[all.bm$species=='human'])
# hist(all.bm$age[all.bm$species=='chimp'])


