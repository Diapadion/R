rf2rt <- array(0, c(2,2))
rf3rt <- array(0, c(3,2))
rf4rt <- array(0, c(4,2))
rf5rt <- array(0, c(5,2))
rf6rt <- array(0, c(6,2))
rf2e <- array(0, c(2,2))
rf3e <- array(0, c(3,2))
rf4e <- array(0, c(4,2))
rf5e <- array(0, c(5,2))
rf6e <- array(0, c(6,2))
rf2m <- array(0, c(2,2))
rf3m <- array(0, c(3,2))
rf4m <- array(0, c(4,2))
rf5m <- array(0, c(5,2))
rf6m <- array(0, c(6,2))
rf2p <- array(0, c(2,2))
rf3p <- array(0, c(3,2))
rf4p <- array(0, c(4,2))
rf5p <- array(0, c(5,2))
rf6p <- array(0, c(6,2))


# use the SD of RT (and the mean of accuracy)


for (i in 1:2) {
  rf2rt[i,1]= cor.test(scsdrt,rf2scores[i,])$p.value
  rf2rt[i,2]= cor.test(scsdrt,rf2scores[i,])$estimate
  rf2p[i,1]= cor.test(scprog,rf2scores[i,])$p.value
  rf2p[i,2]= cor.test(scprog,rf2scores[i,])$estimate
  rf2e[i,1]= cor.test(scerr,rf2scores[i,])$p.value
  rf2e[i,2]= cor.test(scerr,rf2scores[i,])$estimate
  rf2m[i,1]= cor.test(scm,rf2scores[i,])$p.value
  rf2m[i,2]= cor.test(scm,rf2scores[i,])$estimate
}

for (i in 1:3) {
  rf3rt[i,1]= cor.test(scsdrt,rf3scores[i,])$p.value
  rf3rt[i,2]= cor.test(scsdrt,rf3scores[i,])$estimate
  rf3p[i,1]= cor.test(scprog,rf3scores[i,])$p.value
  rf3p[i,2]= cor.test(scprog,rf3scores[i,])$estimate
  rf3e[i,1]= cor.test(scerr,rf3scores[i,])$p.value
  rf3e[i,2]= cor.test(scerr,rf3scores[i,])$estimate
  rf3m[i,1]= cor.test(scm,rf3scores[i,])$p.value
  rf3m[i,2]= cor.test(scm,rf3scores[i,])$estimate
}

for (i in 1:4) {
  rf4rt[i,1]= cor.test(scsdrt,rf4scores[i,])$p.value
  rf4rt[i,2]= cor.test(scsdrt,rf4scores[i,])$estimate
  rf4p[i,1]= cor.test(scprog,rf4scores[i,])$p.value
  rf4p[i,2]= cor.test(scprog,rf4scores[i,])$estimate
  rf4e[i,1]= cor.test(scerr,rf4scores[i,])$p.value
  rf4e[i,2]= cor.test(scerr,rf4scores[i,])$estimate
  rf4m[i,1]= cor.test(scm,rf4scores[i,])$p.value
  rf4m[i,2]= cor.test(scm,rf4scores[i,])$estimate
}

for (i in 1:5) {
  rf5rt[i,1]= cor.test(scsdrt,rf5scores[i,])$p.value
  rf5rt[i,2]= cor.test(scsdrt,rf5scores[i,])$estimate
  rf5p[i,1]= cor.test(scprog,rf5scores[i,])$p.value
  rf5p[i,2]= cor.test(scprog,rf5scores[i,])$estimate
  rf5e[i,1]= cor.test(scerr,rf5scores[i,])$p.value
  rf5e[i,2]= cor.test(scerr,rf5scores[i,])$estimate
  rf5m[i,1]= cor.test(scm,rf5scores[i,])$p.value
  rf5m[i,2]= cor.test(scm,rf5scores[i,])$estimate
}

for (i in 1:6) {
  rf6rt[i,1]= cor.test(scsdrt,rf6scores[i,])$p.value
  rf6rt[i,2]= cor.test(scsdrt,rf6scores[i,])$estimate
  rf6p[i,1]= cor.test(scprog,rf6scores[i,])$p.value
  rf6p[i,2]= cor.test(scprog,rf6scores[i,])$estimate
  rf6e[i,1]= cor.test(scerr,rf6scores[i,])$p.value
  rf6e[i,2]= cor.test(scerr,rf6scores[i,])$estimate
  rf6m[i,1]= cor.test(scm,rf6scores[i,])$p.value
  rf6m[i,2]= cor.test(scm,rf6scores[i,])$estimate
}




# there are 20 individual tests for all models
# so Holm-Bonferroni must be applied for each stat, m = 20

# Error: rf6,6 pass; rf2,2 pass; rf5,1 FAIL (barely).
# Progress: rf6,6 pass; rf2,2 pass; rf4,4 FAIL.
# Mean: rf6,6 pass; rf2,2 pass, rf4,4 FAIL.
# RT: rf6,5 FAIL.

# warning - the adjs listed below may need correcting*
# Adjectives loaded on accuracy domain-
# 2: -47 (unemotional), 42 (stingy/greedy), 39 (sociable), -36, 33, 
#    32, 27, 26, 25, 24, 23, 22, 15, -11 (depressed), 8, 7, 
# 3: -45 (thoughtless), 44 (sympathetic), 39 (sociable), 38 (sensitive), -36 (quitting), 
#    27, 26, 24, 19 (helpful), 17 (friendly), 8 (decisive), 7 (curious), 2 (affectionate)
# 4: -42, -33, -27, -26, -25, -24, -23, -22, -14 (erratic), 10 (dependent), -7,
#    6 (cool), 5 (conventional)
# 5: 42, 33 (playful), 32, 27, 26, 24, 23 (individualistic), 22 (independent),
#    14 (erratic), -10 (dependent), -6 (cool), -5 (conventional)
# 6: -36 (quitting), 32 (persistent), 27 (inventive), 26 (intelligent), 24 (innovative),
#    8 (decisive), -5 (conventional)





# RT-
# 6: -12 (distractible), -25 (inquisitive),

