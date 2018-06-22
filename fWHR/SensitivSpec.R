### Mixed Model Sensitvity Analyses

library(lme4)



### Iterate over sample specification
## - all adults

## - just Verus (of the adults)
jV = adults&(chFP$Subspecies=='verus')

## - Verus & Schweinfurthii (of the adults)
VS = adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii')

## - Verus & Schweinfurthii & Unknowns (of the adults)
VSU = adults&(chFP$Subspecies=='verus'|chFP$Subspecies=='schweinfurthii'|chFP$Subspecies=='unknown')

## - just Troglodytes (of the adults)
jT = adults&(chFP$Subspecies=='troglodytes')



### Iterate over model specifications

## - all vars

## Sex * Dom * Neu



m.all = lmer(fWHR ~ Age + I(Age^2) + I(Age^3) + Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                 (1 | location) + (1 | ID),
               data = chFP[adults,]
)

jV.all = lmer(fWHR ~ Age + I(Age^2) + I(Age^3) + Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
               (1 | location) + (1 | ID),
             data = chFP[jV,]
)

VS.all = lmer(fWHR ~ Age + I(Age^2) + I(Age^3) + Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | ID),
              data = chFP[VS,]
)

VSU.all = lmer(fWHR ~ Age + I(Age^2) + I(Age^3) + Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | ID),
              data = chFP[VSU,]
)

jT.all = lmer(fWHR ~ Age + I(Age^2) + #I(Age^3) + 
                Sex + Dom_CZ + Ext_CZ + Con_CZ + Agr_CZ + Neu_CZ + Opn_CZ +
                (1 | location) + (1 | ID),
              data = chFP[jT,]
)


options("scipen"=5, "digits"=4)
set.seed(12334567)

ci.m.all = confint(m.all, method='boot')
ci.jV.all = confint(jV.all, method='boot')
ci.VS.all = confint(VS.all, method='boot')
ci.VSU.all = confint(VSU.all, method='boot')
ci.jT.all = confint(jT.all, method='boot')

fixef(m.all)
ci.m.all

fixef(jV.all)
ci.jV.all

fixef(VS.all)
ci.VS.all

fixef(VSU.all)
ci.VSU.all

fixef(jT.all)
ci.jT.all








m.3way = lmer(fWHR ~ Sex * Dom_CZ * Neu_CZ +
                 (1 | location) + (1 | ID),
               data = chFP[adults,]
)

# mp3.tree = "jV.3way"
jV.3way = lmer(fWHR ~ Sex * Dom_CZ * Neu_CZ +
               (1 | location) + (1 | ID),
             data = chFP[jV,]
)

VS.3way = lmer(fWHR ~ Sex * Dom_CZ * Neu_CZ +
                (1 | location) + (1 | ID),
              data = chFP[VS,]
)

VSU.3way = lmer(fWHR ~ Sex * Dom_CZ * Neu_CZ +
                 (1 | location) + (1 | ID),
               data = chFP[VSU,]
)

jT.3way = lmer(fWHR ~ Sex * Dom_CZ * Neu_CZ +
                (1 | location) + (1 | ID),
              data = chFP[jT,]
)


set.seed(1234567)

ci.m.3way = confint(m.3way, method='boot')
ci.jV.3way = confint(jV.3way, method='boot')
ci.VS.3way = confint(VS.3way, method='boot')
ci.VSU.3way = confint(VSU.3way, method='boot')
ci.jT.3way = confint(jT.3way, method='boot')

fixef(m.3way)
ci.m.3way

fixef(jV.3way)
ci.jV.3way

fixef(VS.3way)
ci.VS.3way

fixef(VSU.3way)
ci.VSU.3way

fixef(jT.3way)
ci.jT.3way

