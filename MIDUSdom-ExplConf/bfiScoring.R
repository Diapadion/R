library(lavaan)





ipip.bfi.Ast.mt <- '
Ast =~ I12 + # Take charge. (BFI)
I162 + # Wait for others to lead the way. (BFI)
I72 + # Can talk others into doing things. (BFI)
I282 #+ # Hold back my opinions. (BFI)
#I42 + # Try to lead others.
#I132 + # Take control of things.
#I102 # + # Seek to influence others.
#I192 + # Keep in the background.
#I222 + # Have little to say.
#I252 # Dont like to draw attention to myself.
'
## Missing BFI items:
# Have a strong personality.
# Know how to captivate people.
# See myself as a good leader.
# Am the first to act. 
# Do not have an assertive personality.
# Lack the talent for influencing people.





ipip.bfi.Ent.mt <- '
Ent =~ I2 + I57 + I92 + I32 + I272 + I152 #+
#I117
'




ipip.bfi.Ast.ft = cfa(ipip.bfi.Ast.mt, data=df)
ipip.bfi.Ent.ft = cfa(ipip.bfi.Ent.mt, data=df)

fitMeasures(ipip.bfi.Ast.ft, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))
fitMeasures(ipip.bfi.Ent.ft, c("chisq", "df", "pvalue", "cfi", "rmsea","srmr"))

summary(ipip.bfi.Ast.ft)
summary(ipip.bfi.Ent.ft)
