%REFA (Regularized Exploratory Factor Analysis)
% APRIL 27, 2011 --- Sunho Jung

% The correct reference for this MATLAB codes is: 
%Jung, S., & Lee, S. (in press). Exploratory Factor Analyss for Small Samples, Behavior Research Methods. 

%Rotation method: orthogonal and oblique algorithms
%(reference) Coen A. Bernaards and Robert I. Jennrich (2005). Gradient Projection Algorithms and Software for Arbitrary
%Rotation Criteria in Factor Analysis, Educational and Psychological
%Measurement, 65, 676-696. 

%Parallel analysis (permutation tests) is used for determining the number of significant components 
%(reference) Cota, A. A., Longman, R. S., Holden, R. R., & Fekken, G. C. (1993).
%Comparing different methods for implementing parallel analysis: A
%practical index of accuracy. Educational & Psychological Measurement,
%53, 865-875.


%Load data
load creative_employee.txt;
dt=creative_employee;
%load pcano.txt;
%dt=pcano(:,3:15);

%Alternatively, designate a directory of data file as below
%z0=load('C:\Research\RICK\rick.dat'); 
%dt=z0(:,3:15);

%load monkeyPersAvg.txt;
%dt = monkeyPersAvg;

%[Example Data] Bergami, M., and Bagozzi, R.P. (2000). 
%Self-categorization, affective commitment and 
%group self-esteem as distinct aspects of 
%social identity in the organization. British 
%Journal of Social Psychology, 39, 555-577.

%choose Extraction Method
fprintf(' \n')
fprintf('Choose extraction method \n')
ana=input('Type 1 for ML; Type 2 for GLS; Type 3 for ULS: ')
if isempty(ana) ana=1; end
%ana=1;
%By default, REFA employes ML estimation method

%choose Regularization Scheme
fprintf(' \n')
fprintf('Choose regularization scheme \n')
reg=input('Type 1 for Anti-image; Type 2 for Constant: ')
if isempty(reg) reg=1; end
%reg = 1;
%By default, REFA uses anti-image procedure as a regulariation scheme

%choose Rotation Method
fprintf(' \n')
fprintf('Choose rotation method \n')
rotation=input('Type 1 for Quartimax; Type 2 for Quartimin; Type 3 for Geomin: ')
if isempty(rotation) rotation=3; end
%rotation=3;
%Orthogonal rotation: Quartimax
%Oblique rotation: Quartimin & Geomin
%By default, REFA provides a geomin rotated solution

%Parallel analysis for determining the number of factors or components
fprintf('Determine the number of significant factors or components using parallel analysis \n')
[number_factors]=permudim(dt)

%%% RUN REFA %%%
REFA_estimate(dt,ana,reg,rotation,number_factors);


