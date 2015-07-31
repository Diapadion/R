function [Del2 BB f1 th]=mlfaone(A,thi,DD,n,m)
%ML factor analysis
        [u1 d1 v1]=svd(A);
        sqrAi=u1*sqrt(inv(d1))*v1';
        m1=m+1;
        maxi=1;
        for ls=1:maxi
            if ls>1 
                thi=thi-.05*rand(1,1);
            end
            
            options=optimset('LargeScale','on','Display','off','GradObj','on','Hessian','on','TolFun',1e-10);
            [th,f1,exitflag,output]=fmincon(@mlonefgh,thi,[],[],[],[],0,1,[],options,sqrAi,n,m1,DD);
            Del2=th*DD;
            tilD=sqrAi*diag(Del2)*sqrAi;
            [u3 d3 v3]=svd(tilD);
            for i=1:m
                u2(:,i)=u3(:,n-i+1);
                d2(i,i)=d3(n-i+1,n-i+1);
            end
            D=diag(diag(d2(1:m,1:m)));
            DE=sqrt(eye(m)-D)*inv(D);
            if 1/D(m,m)<1
                fprintf('The mth eigenvalues is smaller than 1 \n')
            else
            BB=diag(Del2)*sqrAi*u2(:,1:m)*DE;
            end
        end
