function [q,Gq]=vgQgeomin(L)

ep=.01;

L2=L.^2;
[p,k]=size(L);
u=ones(k,1);
e=exp(log(L2+ep)*u/k);
q=sum(e);
Gq=(2/k)*L.*(e*u')./(L2+ep);
