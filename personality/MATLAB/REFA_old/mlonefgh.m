function [f,g,H]=mlonefgh(thi,sqrAi,n,m1,DD)
%The routine that calculates the function value, gradients, 
%and the hessian for factor analysis
            d2=zeros(n,n);
            u2=zeros(n,n);
            Del2=thi*DD;
            tilD=sqrAi*diag(Del2)*sqrAi;
            [u3 d3 v3]=svd(tilD);
            for i=1:n
                u2(:,i)=u3(:,n-i+1);
                d2(i,i)=d3(n-i+1,n-i+1);
            end
%Minus the likelihood/N
            f=-n+m1-1;
            for i=m1:n
            f=f+log(d2(i,i))+1/(d2(i,i));
            end
%Gradient & Hessian
if nargout>1
            U=sqrAi*u2;
            gg=zeros(n,1);
            Gt=zeros(n,n);
            for i=m1:n
                d2i(i)=1/(d2(i,i)*d2(i,i));
                alpha=(1-d2(i,i))*d2i(i);
                gg=gg+alpha*U(:,i).*U(:,i);
                Gt=Gt+U(:,i)*U(:,i)'/d2(i,i);
            end
            g=-DD'*gg;
            H=trace(DD'*(Gt.*Gt)*DD);
end %nargout>1