N  = 10;         % number of sequences
T  = 100;        % length of the sequence
pi = [0.4; 0.6]; % inital probability pi_1 = 0.5 and pi_2 =0.5

%%two states hence A is a 2X2 matrix 
A  = [0.4 0.6 ; 0.4 0.6 ];         %p(y_t|y_{t-1})

%%alphabet of 6 letters (e.g., a die with 6 sides) E(i,j) is the
E = [1/6 1/6 1/6 1/6 1/6 1/6;      %p(x_t|y_{t}) 
    1/10 1/10 1/10 1/10 1/10 1/2];

[ Y, S ] = HmmGenerateData(N, T, pi, A, E ); 

%%Y is the set of generated observations 
%%S is the set of ground truth sequence of latent vectors 
% 
%  new_A  = [0.2 0.8 ; 0.2 0.8 ]; 
%  new_E  = [1/6 1/6 1/6 1/6 1/6 1/6;      %p(x_t|y_{t}) 
%      1/12 1/12 1/3 1/6 1/6 1/6];

%[ Y, S ] = HmmGenerateData(N, T, pi, A, E ); 
%for i=1: size(Y,1)
%  P=Viterbi(Y(i,:),A,E,pi);
%  true(i)=sum((P-S(i,:))==0)/100;
% end;
% plot(true);

% test for 20 times doing EM
 for i=1:20
 models(i)=EM_HMM_Discrete(Y,pi,E,A,1000);
 loglikes(i)=models(i).loglike;
 end
 % find the best
 [m,I]=max(loglikes');
 
 % print

 models(I).pi

 models(I).A

 models(I).B
 
