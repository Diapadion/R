function [f,g,H]=ulsonefgh(thi,A,n,m1,DD)
%The routine that calculates the function value, 
%gradients, and the hessian factor analysis by ULS
            Del2=thi*DD;
            tilD=A-diag(Del2);
            [u2 d2]=eigord(tilD,n);
%The LS minimization of function 
            f=0;
            for i=m1:n
            f=f+d2(i,i).*d2(i,i);
            end
%Gradient & Hessian
if nargout>1
            gg=zeros(n,1);
            Gt=zeros(n,n);
            for i=m1:n
                gg=gg-d2(i,i)*u2(:,i).*u2(:,i);
                Gt=Gt+u2(:,i)*u2(:,i)';
            end
            g=2*DD'*gg;
            H=2*DD'*(Gt.*Gt)*DD;
end 