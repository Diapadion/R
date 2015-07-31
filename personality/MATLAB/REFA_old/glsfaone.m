function [Del2,BB,f1,th]=glsfaone(A,thi,DD,n,m)
%GLS factor analysis
    [u1 d1 v1]=svd(A);
    Ai=u1*inv(d1)*v1';
        m1=m+1;
        maxi=1;
        thl=log(thi);
        for ls=1:maxi
            if ls>1
                thi=thi-.05*rand(1,1);
            end
            thl=log(thi);
                        
            options=optimset('LargeScale','on','Display','off','GradObj','on','Hessian','on','TolFun',1e-10);
            [th,f1,exitflag,output]=fmincon(@glsonefgh,thl,[],[],[],[],-10,0,[],options,Ai,n,m1,DD);
            th=exp(th);
            Deln=sqrt(th*DD);
            diagD=diag(Deln);
            [u11 d11 v11]=svd(diagD*Ai*diagD);
            for i=1:n
                d10(i,i)=d11(n+1-i,n+1-i);
                u10(:,i)=u11(:,n+1-i);
            end
            if 1/d10(m,m)<1
                fprintf('The mth eigenvalue is smaller than 1\n')
            else
                BB=diagD*u10(:,1:m)*sqrt((inv(d10(1:m,1:m))-eye(m)));
            end
            Del2=th*DD;
        end
