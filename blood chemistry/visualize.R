
library(texreg)

tbl1 = htmlreg(m_1)
texregTable(tbl1)


tbl2c = htmlreg(c(m_2c,m2c0,m2c1,m2c2,m2c3))
print.texregTable(tbl2c)
