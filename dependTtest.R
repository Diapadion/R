# related (dependant) samples t-test of the medium choices to the overall average


ovrall <- hightrials
append(ovrall,medtrials)
append(ovrall,lowtrials)

t.test(medtrials,ovrall,paired=T, alternative="greater")
