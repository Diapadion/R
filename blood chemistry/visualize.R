
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

#--- 24/03/2015

sys.tbl = htmlreg(list(m.sys,m_1))
write(sys.tbl,"sys.html")

chol.tbl = htmlreg(list(m.chol,m_2a))
write(chol.tbl,"chol.html")

trig.tbl = htmlreg(list(m.trig,m_2b))
write(trig.tbl,"trig.html")

gluco.tbl = htmlreg(list(m.gluc,m_2c))
write(gluco.tbl,"gluco.html")

creat.tbl = htmlreg(list(m.creat,m2u))
write(creat.tbl,"creat.html")

alkphos.tbl = htmlreg(list(m.alp,m2w))
write(alkphos.tbl,"alkphos.html")


print.texregTable(tbl2c3)


#--- for 27/03/2015

#sys.tbl

sys.tbl = htmlreg(list(m.sys,mj.sys,m1a), custom.model.names=c('Americans','Japanese','Chimpanzees'), ci.force=TRUE)
write(sys.tbl,"sys.html")

trig.tbl = htmlreg(list(m.trig,mj.trig,m2.trig), custom.model.names=c('Americans','Japanese','Chimpanzees'), ci.force=TRUE)
write(trig.tbl,"trig.html")

chol.tbl = htmlreg(list(m.chol,mj.chol,m2.chol), custom.model.names=c('Americans','Japanese','Chimpanzees'), ci.force=TRUE)
write(chol.tbl,"chol.html")

creat.tbl = htmlreg(list(m.creat,mj.creat,m2.creat), custom.model.names=c('Americans','Japanese','Chimpanzees'), ci.force=TRUE)
write(creat.tbl,"creat.html")
