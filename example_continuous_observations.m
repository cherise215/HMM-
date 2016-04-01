clear;
N  = 100;         % number of sequences
T  = 100;        % length of the sequence
pi = [0.5; 0.5]; % inital probability pi_1 = 0.5 and pi_2 =0.5

%%two states hence A is a 2X2 matrix 
A  = [0.4 0.6 ; 0.4 0.6 ];         %p(y_t|y_{t-1})


%%one dimensional Gaussians 

E.mu    =[ .9 10]; %%the means of each of the Gaussians
E.sigma2=[ .4 .2]; %%the variances
   


[ Y, S ] = HmmGenerateData(N, T, pi, A, E, 'normal'); 

%%Y is the set of generated observations 
%%S is the set of ground truth sequence of latent vectors 


for i=1:5
[model]=EM_HMM_Continous(Y,pi,A,E,1000);
models(i)=model;
likelihood(i)=models.loglike;
end
 % find the best
 [m,I]=max(likelihood');
 
 % print

 models(I).pi

 models(I).A

 models(I).mu
  models(I).sigma2
 