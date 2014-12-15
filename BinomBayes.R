# calculate probabilities

# 3 vars (ideal) model

nHi <- length(hightrials)
nMed <- length(medtrials)
nLo <- length(lowtrials)
nAll = nHi+nMed+nLo

totHi <- sum(hightrials)
totMed <- sum(medtrials)
totLo <- sum(lowtrials)


succH <- NULL
succM <- NULL
succL <- NULL
### test to produce confidence interval about probs

hConf = binom.confint(totHi,nHi)
mConf = binom.confint(totMed,nMed)
lConf = binom.confint(totLo,nLo)


pHi = totHi/nHi
pMed = totMed/nMed
pLo = totLo/nLo

#ll = log likelihood

llh3 = dbinom(x=totHi, size=nHi, prob=pHi, log=TRUE)
llm3 = dbinom(x=totMed, size=nMed, prob=pMed, log=TRUE)
lll3 = dbinom(x=totLo, size=nLo, prob=pLo, log=TRUE)

comboll3=lll3+llm3+llh3

bic3 <- -2*(comboll3) + 3*log(nAll)
aic3 <- -2*(comboll3) + 2*3


# 1 var model

alltrials <- c(hightrials,medtrials,lowtrials)
totAll <- sum(alltrials)
pAll <- totAll/nAll

llh1 = dbinom(x=totHi, size=nHi, prob=pAll, log=TRUE)
llm1 = dbinom(x=totMed, size=nMed, prob=pAll, log=TRUE)
lll1 = dbinom(x=totLo, size=nLo, prob=pAll, log=TRUE)

comboll1=lll1+llm1+llh1

bic1 <- -2*(comboll1) + 1*log(nAll)


# 2 var models

# a) HM vs L

pHM = (sum(c(hightrials, medtrials)))/(nHi+nMed)

llh2a = dbinom(x=totHi, size=nHi, prob=pHM, log=TRUE)
llm2a = dbinom(x=totMed, size=nMed, prob=pHM, log=TRUE)
lll2a = dbinom(x=totLo, size=nLo, prob=pLo, log=TRUE)

comboll2a=lll2a+llm2a+llh2a

bic2a <- -2*(comboll2a) + 2*log(nAll)
aic2a <- -2*(comboll2a) + 2*2



# b) H vs ML

pML = (sum(c(medtrials, lowtrials)))/(nLo+nMed)

llh2b = dbinom(x=totHi, size=nHi, prob=pHi, log=TRUE)
llm2b = dbinom(x=totMed, size=nMed, prob=pML, log=TRUE)
lll2b = dbinom(x=totLo, size=nLo, prob=pML, log=TRUE)

comboll2b=lll2b+llm2b+llh2b

bic2b <- -2*(comboll2b) + 2*log(nAll)
aic2b <- -2*(comboll2b) + 2*2


# c) HL vs M

pHL = (sum(c(hightrials, lowtrials)))/(nHi+nLo)

llh2c = dbinom(x=totHi, size=nHi, prob=pHL, log=TRUE)
llm2c = dbinom(x=totMed, size=nMed, prob=pMed, log=TRUE)
lll2c = dbinom(x=totLo, size=nLo, prob=pHL, log=TRUE)

comboll2c=lll2c+llm2c+llh2c

bic2c <- -2*(comboll2c) + 2*log(nAll)
aic2c <- -2*(comboll2c) + 2*2


# chi-sq tests

# 3 vs. 1

D1 = -2*(comboll1)+2*(comboll3)
df = 3-1
chi1_3 <- pchisq(D1, df, ncp=0, lower.tail=FALSE, log.p=FALSE)




# 3 vs. 2b

D2 = -2*(comboll2b)+2*(comboll3)
df = 2-1
chi2b3 <- pchisq(D2, df, ncp=0, lower.tail=FALSE, log.p=FALSE)


# 3 vs. 2a

D3 = -2*(comboll2a)+2*(comboll3)
df = 2-1
chi2a3 <- pchisq(D3, df, ncp=0, lower.tail=FALSE, log.p=FALSE)


# Gin's test of medium vs overall average
# medium selections with medium average vs overall average

comboMvAll = dbinom(x=totMed, size=nMed, prob=pAll, log=TRUE)

Dmed <- -2*(comboMvAll)+2*(llm3)
df <- 2-1
chimt <- pchisq(Dmed, df, ncp=0, lower.tail=FALSE, log.p=FALSE)


out <-as.matrix(cbind(c("chi1_3","chi2a3","chi2b3","chimt","bic1","bic2a","bic2c","bic2b","bic3","aic2a","aic2b","aic3"),c(chi1_3,chi2a3,chi2b3,chimt,bic1,bic2a,bic2c,bic2b,bic3,aic2a,aic2b,aic3)))


