function [Lh,Phi,Th,table]=GPFoblq(A,T,rt)

al=1;
table=[];
Ti=inv(T);
L=A*Ti';
if rt==2
[f,Gq]=vgQquartimin(L);
else
[f,Gq]=vgQgeomin(L);
end
G=-(L'*Gq*Ti)';
for iter=0:500
    Gp=G-T*diag(sum(T.*G));
    s=norm(Gp,'fro');
    table=[table;iter f log10(s) al];
    if s<10^(-5),break,end

    al=2*al;
    for i=0:10
       X=T-al*Gp;
       v=1./sqrt(sum(X.^2));
       Tt=X*diag(v);
       Ti=inv(Tt);
       L=A*Ti';
       if rt==2
       [ft,Gq]=vgQquartimin(L);
       else
       [ft,Gq]=vgQgeomin(L);
       end
       if ft<f-.5*s^2*al,break,end
       al=al/2;
    end
    T=Tt;
    f=ft;
    G=-(L'*Gq*Ti)';
end
Th=T;
Lh=L;
  factor_contribute=diag(Lh'*Lh);
  [I,J]=sort(factor_contribute,'descend');
Lh=Lh(:,J);
Phi=T'*T;

