function [f,g,H]=glsfafgh(thl,Ai,n,m1,DD)
%The routine that calculates the function value, gradients, 
%and the hessian for factor analysis
            th=exp(thl);
            diagD=diag(sqrt(th*DD));
            tilD=diagD*Ai*diagD;
            [u4 d4 v4]=svd(tilD);
            for i=1:n
                d2(i,i)=d4(n+1-i,n+1-i);
                u2(:,i)=u4(:,n+1-i);
            end
%GLS function
            f=0;
            for i=m1:n
                f=f+(d2(i,i)-1)^2;
            end
            f=.5*f;
%Gradient & Hessian
if nargout>1
            gg=zeros(n,1);
            Gt=zeros(n,n);
            for i=m1:n
                alpha=d2(i,i)*(d2(i,i)-1);
                gg=gg+alpha*u2(:,i).*u2(:,i);
                beta=d2(i,i)*(2*d2(i,i)-1);
                Gt=Gt+d2(i,i)*u2(:,i)*u2(:,i)';
            end
            %g=sum(gg)/th;
            g=sum(gg);
            %H=sum(sum(Gt.*Gt)')/th^2;
            H=sum(sum(Gt.*Gt)');
end %nargout>1