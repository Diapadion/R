function [BB idx]=unscl(A,n,m)
[uu dd]=eigord(A,n);
D=sqrt(dd(1:m,1:m));
BB=uu(:,1:m)*D;
idx=0;
if dd(m,m)<-dd(n,n)
    idx=1;
    fprintf('\n')
    fprintf('The m-th largest eigenvalue is smaller than the\n')
    fprintf('smallest eigenvalue in the absolute value\n')
    [dd(m,m),-dd(n,n)]
    diag(dd)'
end

