
library(texreg)

tbl1 = htmlreg(m_1)
print.texregTable(tbl1)

tbl2a = htmlreg(m_2a)
print.texregTable(tbl2a)

tbl2b = htmlreg(m_2b)
print.texregTable(tbl2b)

#---

tbl2c1 = htmlreg(m_2c)
print.texregTable(tbl2c1)

tbl2c2 = htmlreg(c(m_2c,m2c1,m2c2))
print.texregTable(tbl2c2)

tbl2c3 = htmlreg(c(m_2c,m2c1,m2c2,m2c0))
print.texregTable(tbl2c3)

tbl2c4 = htmlreg(c(m_2c,m2c1,m2c2,m2c0,m2c3))
print.texregTable(tbl2c4)
