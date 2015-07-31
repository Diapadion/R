
function [q,Gq]=vgQoblq(L)

L2=L.^2;
[p,k]=size(L);
N=ones(k,k)-eye(k);
X=L2*N;
q=sum(sum(L2.*X))/4;
Gq=L.*X;

