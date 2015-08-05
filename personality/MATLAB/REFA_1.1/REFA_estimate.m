%REFA (Regularized Exploratory Factor Analysis)
% APRIL 27, 2011 ----- Sunho Jung

function REFA_estimate(dt,reg,rotate,nlv)

%data
[nr nc]=size(dt); %nr= sample size, nc= # variables

samplecorr=corr(dt); %sample correlation matrix
     %the condition number: assess whether sample covariance matrix is
     %well-conditioned
     test_singular_corr=cond(samplecorr);
        if test_singular_corr > 100
          samplecorr=samplecorr+.2*diag(ones(nc,1));
        end

%[REFA] One parameter ML procedure with Anti-image and Constant     
  if reg==1
    %Assumption 1 (Anti-image)
        iU=sqrt(diag(inv(diag(diag(inv(samplecorr))))));
        [psi LAMBDA f1 th]=mlfaone(samplecorr,1,iU.*iU,nc,nlv);
 end
 if reg==2   
  %Assumption 2 (Constant)
        [psi LAMBDA f1 th]=mlfaone(samplecorr,.5,ones(nc,1),nc,nlv);        
 end 
 
%ROTATION
if rotate==1
        R_LAMBDA=rotatefactors(LAMBDA);
else
        T=randorth(nlv);
        [R_LAMBDA,phi,T,table]=GPFoblq(LAMBDA,T,rotate);
end


disp(' =========================== OUTPUTS ========================== ')

[U L U] = svd(samplecorr,0);
E = diag(L);  %eigenvalues vector

    disp(' ')
    disp('Eigenvalues of Sample Correlation Matrix')
    fprintf('--------------------------------------------------------------\n');
    E
    fprintf('--------------------------------------------------------------\n');

%%%----------------

C=diag(LAMBDA*LAMBDA');
Factor=LAMBDA;

    disp(' ')
    disp('Table of Unrotated Factor Matrix')
    fprintf('--------------------------------------------------------------\n');
    Factor
    fprintf('--------------------------------------------------------------\n');

    disp(' ')
    disp('Communalities')
    fprintf('--------------------------------------------------------------\n');
    C
    fprintf('--------------------------------------------------------------\n');

%------------------

if rotate == 1
    
    Rotated_Factors=R_LAMBDA;
    F = Rotated_Factors;
    vef=sum(F.^2);
    pt = vef/nc;
    pp = pt*100;
    cp = sum(pt)*100;
   
    disp(' ')
    disp('Table of Varimax Rotated Factor Matrix')
    fprintf('--------------------------------------------------------------\n');
    Rotated_Factors
    fprintf('--------------------------------------------------------------\n');
    
    disp(' ')
    disp('Rotation Sums of Squared Loadings');
    fprintf('--------------------------------------------------------------\n');
    disp('Variance');
    vef
    disp('Percentage of Variance');
    pp
    disp('Cumulative Percentage');
    cp
    fprintf('--------------------------------------------------------------\n');

else
    
    Rotated_Factors=R_LAMBDA;
    F = Rotated_Factors;
    F=F*phi;
    vef = sum(F.^2);
    
    disp(' ')
    disp('Table of Oblique Rotated Factor Matrix')
    fprintf('--------------------------------------------------------------\n');
    Rotated_Factors
    fprintf('--------------------------------------------------------------\n');
    
    disp(' ')
    disp('Rotation Sums of Squared Loadings');
    fprintf('--------------------------------------------------------------\n');
    disp('Variance');
    vef
    fprintf('--------------------------------------------------------------\n');

    disp(' ')
    disp('Table of Factor Correlation');
    fprintf('--------------------------------------------------------------\n');
    phi
    fprintf('--------------------------------------------------------------\n');
end

%%%----------------







