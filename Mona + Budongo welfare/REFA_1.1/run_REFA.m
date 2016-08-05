%REFA (Regularized Exploratory Factor Analysis)
% APRIL 27, 2011 --- Sunho Jung

%References:
%(1) Jung, S., & Lee, S. (2011). Exploratory Factor Analyss for Small Samples, Behavior Research Methods, 43, 701-709. 
%(2) Jung, S., & Takane, Y. (2008). Regularized exploratory factor analysis. In K.
%Shigemasu, A. Okada, T.Imaizumi, & T. Hoshino (Eds.), New trends in
%psychometrics (pp. 141?149). Tokyo: University Academic Press

%----------------------------------------------------------
%Load data (store your data file in the same folder as the MATLAB codes)
%----------------------------------------------------------
%[Example Data] Bergami, M., and Bagozzi, R.P. (2000). 
%Self-categorization, affective commitment and 
%group self-esteem as distinct aspects of 
%social identity in the organization. British 
%Journal of Social Psychology, 39, 555-577.

%load pcano.txt;
%dt=pcano(:,3:15);

load aggWelSWBall.txt;
dt = aggWelSWBall;

load aggWelall.txt;
dt = aggWelall;

dt = SWB;

%load aggregatedWel.txt;
%dt = aggregatedWel;

%load aggregatedSWB.txt;
%dt = aggregatedSWB;

%load flatmat.txt;
%dt = flatmat';

%-----------------------------------------------------------
%Extraction Method: ML (maximum likelihood estimation) (By default)
%-----------------------------------------------------------

%-----------------------------------------------------------
%Choose Regularization Scheme
%-----------------------------------------------------------
fprintf(' \n')
fprintf('Choose regularization scheme \n')
reg=input('Type 1 for Anti-image; Type 2 for Constant: ')
if isempty(reg) reg=1; end
%Anti-image (By default)

%----------------------------------------------------------
%Determine the number of factors
%----------------------------------------------------------
%Eigenvalues greater than 1
s=corr(dt); [u d v]=svd(s); [I]=find(diag(d)>1); num_fac=length(I); 
factors=num_fac;

disp('  ');
fprintf('By the Kaiser criterion the number of factors suggested are %.i\n', factors);
disp('  ');
ask = input('Do you need to work with this number of factors? (y/n): ','s');
if~strcmp(ask,'y'),
   factors = input('Type the number of factors to extract: ');
end

%----------------------------------------------------------
%Choose Rotation Method
%----------------------------------------------------------
fprintf(' \n')
fprintf('Choose rotation method \n')
rotation=input('Type 1 for Varimax; Type 2 for Quartimin; Type 3 for Geomin: ')
if isempty(rotation) rotation=1; end
%Orthogonal rotation: Varimax (By default)
%Oblique rotation: Quartimin & Geomin
%Reference for oblique rotation: 
%Jennrich, R.I. (2002). A simple general method for oblique rotation. 
%Psychometrika, 67, 7-19. 
%----------------------------------------------------------

%%% RUN REFA %%%
REFA_estimate(dt,reg,rotation,factors);


