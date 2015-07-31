function [u2 d2]=eigord(tilD,n);
            u2=zeros(n,n);
            [u3 d3]=eig(tilD);
            [D2,ii]=sort(-diag(d3));
            d2=-diag(D2);
            for i=1:n
                u2(:,i)=u3(:,ii(i));
            end
