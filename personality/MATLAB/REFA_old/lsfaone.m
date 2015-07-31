function [Deln BB f1 th]=lsfaone(A,thi,DD,n,m)
%LS factor analysis
        m1=m+1;
        ls=0;
        maxi=1;
        for ls=1:maxi
        if ls>1
            thi=thi-.05*rand(1,1);
        end

            options=optimset('LargeScale','on','Display','off','GradObj','on','Hessian','on','TolFun',1e-8);
            [th,f1,exitflag,output]=fmincon(@ulsonefgh,thi,[],[],[],[],0,1,[],options,A,n,m1,DD);
            Deln=th*DD;
            [BB idx]=unscl(A-diag(Deln),n,m);
        end
