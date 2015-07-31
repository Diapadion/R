
%clear; 
tic;
nvars     = 9    ;    % number of variables
ncases    = 500  ;    % number of cases
ndatsets  = 100   ;    % number of ndatsets
percent   = 95   ;    % desired percentile

% Specify the desired kind of parellel analysis, where:
% 1 = principal components analysis
% 2 = principal axis / common factor analysis
kind = 2 ;


%the next command can be used to set the state of the random # generator
randn('state',1953125)

%%%%%%%%%%%%%%% End of user specifications %%%%%%%%%%%%%%%


% principal components analysis
if kind == 1;
for nds = 1:ndatsets; evals(:,nds) = eig(corrcoef(randn(ncases,nvars)));end
end

% principal axis/common factor analysis with SMCs on the diagonal
if kind == 2;
for nds = 1:ndatsets; 
r = corrcoef(randn(ncases,nvars));
smc = 1 - (1 ./ diag(inv(r)));
for ii=1:size(r,1);r(ii,ii) = smc(ii,1);end;
evals(:,nds) = eig(r);
end;end

evals = flipud(sort(evals,1));
means = (mean(evals,2));   % mean eigenvalues for each position.
evals = sort(evals,2);     % sorting the eigenvalues for each position.
percentiles = (evals(:,round((percent*ndatsets)/100)));  % percentiles.

format short
disp([' ']);disp(['PARALLEL ANALYSIS ']); disp([' '])
if kind == 1;disp(['Principal Components' ]);disp([' ']);end
if kind == 2;disp(['Principal Axis / Common Factor Analysis' ]);disp([' ']);end
disp(['Variables  = ' num2str(nvars) ]);
disp(['Cases      = ' num2str(ncases) ]);
disp(['Datsets    = ' num2str(ndatsets) ]);
disp(['Percentile = ' num2str(percent) ]); disp([' '])
disp(['     Root     Means   Percentiles' ])
disp([(1:nvars).' , means , percentiles]); disp([' '])

if kind == 2;
disp(['Compare the random data eigenvalues to the real-data' ]);
disp(['eigenvalues that are obtained from a Common Factor Analysis ' ]);
disp(['in which the # of factors extracted equals the # of variables/items,' ]);
disp(['and the number of iterations is fixed at zero; MATLAB commands for' ]);
disp(['obtaining these real-data values for a correl matrix "r":' ]);
disp(['smc = 1 - (1 ./ diag(inv(r)));' ]);
disp(['for ii=1:size(r,1);r(ii,ii) = smc(ii,1);end;eig(r)' ]);disp([' ' ]);

disp(['Warning: Parallel analyses of adjusted correlation matrices' ]);
disp(['e.g., with SMCs on the diagonal, tend to indicate more factors' ]);
disp(['than warranted (Buja, A., & Eyuboglu, N., 1992, Remarks on parallel' ]);
disp(['analysis. Multivariate Behavioral Research, 27, 509-540).' ]);
disp(['The eigenvalues for trivial, negligible factors in the real' ]);
disp(['data commonly surpass corresponding random data eigenvalues' ]);
disp(['for the same roots. The eigenvalues from parallel analyses' ]);
disp(['can be used to determine the real data eigenvalues that are' ]);
disp(['beyond chance, but additional procedures should then be used' ]);
disp(['to trim trivial factors.' ]);disp([' ' ]);

disp(['Principal components eigenvalues are often used to determine' ]);
disp(['the number of common factors. This is the default in most' ]);
disp(['statistical software packages, and it is the primary practice' ]);
disp(['in the literature. It is also the method used by many factor' ]);
disp(['analysis experts, including Cattell, who often examined' ]);
disp(['principal components eigenvalues in his scree plots to determine' ]);
disp(['the number of common factors. But others believe this common' ]);
disp(['practice is wrong. Principal components eigenvalues are based' ]);
disp(['on all of the variance in correlation matrices, including both' ]);
disp(['the variance that is shared among variables and the variances' ]);
disp(['that are unique to the variables. In contrast, principal' ]);
disp(['axis eigenvalues are based solely on the shared variance' ]);
disp(['among the variables. The two procedures are qualitatively' ]);
disp(['different. Some therefore claim that the eigenvalues from one' ]);
disp(['extraction method should not be used to determine' ]);
disp(['the number of factors for the other extraction method.' ]);
disp(['The issue remains neglected and unsettled.' ]);disp([' ']);disp([' ']);end

disp(['time for this problem = ', num2str(toc) ]); disp([' '])




