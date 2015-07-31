%REFA (Regularized Exploratory Factor Analysis)
% APRIL 27, 2011 ----- Sunho Jung

function REFA_estimate(dt,ana,reg,rt,m)

%data manipulation
t=sum(dt);
[nr nc]=size(dt); %nr= sample size, n= # variables
fm=t/nr;
dt=dt-ones(nr,1)*fm;
samplecov=dt'*dt/nr; %sample covariance matrix
     %the condition number: whether sample covariance matrix is
     %well-conditioned
     test_singular_cov=cond(samplecov);
        if test_singular_cov > 200
          samplecov=samplecov+nc/nr*diag(ones(nc,1));
        end
sd=sqrt(diag(diag(samplecov)));
sdb=inv(sd);
dts=dt*sdb; %standard score
samplecorr=sdb*samplecov*sdb; %sample correlation matrix

%One parameter LS procedure with Anti-image assumption and Constant
   if ana==3 & reg==2
   %Assumption 1 (Constant)
        [Deln A f1 th]=lsfaone(samplecorr,.5,ones(nc,1),nc,m);
   end
   if ana==3 & reg==1
    %Assumption 2 (Anti-image)
        iU1=sqrt(diag(inv(diag(diag(inv(samplecorr))))));
        [Deln A f1 th]=lsfaone(samplecorr,1,iU1.*iU1,nc,m);
   end
   
%One parameter GLS procedure with Anti-image and Constant
  if ana==2 & reg==2
   %Assumption 1 (Constant)
        [Deln A f1 th]=glsfaone(samplecov,.5,ones(nc,1),nc,m);        
  end
  if ana==2 & reg==1
    %Assumption 2 (Anti-image)
        iU2=sqrt(diag(inv(diag(diag(inv(samplecov))))));
        [Deln A f1 th]=glsfaone(samplecov,1,iU2.*iU2,nc,m);       
  end
    
%One parameter ML procedure with Anti-image and Constant     
 if ana==1 & reg==2   
  %Assumption 1 (Constant)
        [Deln A f1 th]=mlfaone(samplecov,.5,ones(nc,1),nc,m);        
 end
 if ana==1 & reg==1
    %Assumption 2 (Anti-image)
        iU3=sqrt(diag(inv(diag(diag(inv(samplecov))))));
        [Deln A f1 th]=mlfaone(samplecov,1,iU3.*iU3,nc,m);
 end
  
%ROTATION
if rt==1
        T=randorth(m);
        [L,T,table]=GPForth(A,T);
else
        T=randorth(m);
        [L,phi,T,table]=GPFoblq(A,T,rt);
end
% ==================== REFA OUTPUT  =========================

%FACTOR LOADINGS 
Unrotated_Factor_Matrix=A
%ROTATED FACTOR LOADINGS
Rotated_Factor_Matrix=L
if rt>=2
%FACTOR CORRELATION MATRIX
Factor_Correlation_Matrix=phi
end







