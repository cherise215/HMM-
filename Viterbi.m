function [ Z ] = Viterbi(X,A,E,pi)
%Viterbi decode, given the parameters and an observation
% see reference: wiki
%input:
%   X: One observation (X = {x1,..xT}
%   A: Transition Probability Matrix
%   E: Emission  Matrix
%   pi: probability of choosing a die
%return :
%   most probable sequence Z
      
T = length(X);
K = length(pi);

%%construct the states id 1,2,...K
for temp=1:K
    states(temp)=temp;
end;

% Initialize the two tables 
% T1 stores the probability of the  most probable graph
T1 = zeros(K,T); 
% T2 stores the most probable states/path so far 
T2 = zeros(K,T);

Z=zeros(1,T);
% use log2 to optimise 
E=log2(E);
A=log2(A);
pi=log2(pi);

%t=1
for s=1:K
    T1(s,1) = pi(s)+E(s,X(s));%%log(p(z))+logp(x|z))
end

% Estimate the most probable path
for t = 2:T
    for s = states %% for all next probable states
        score= zeros(1,K);
        % estimate probabilities of all possible states
        for k = 1:K
            score(k) = T1(k,t-1) +A(k,s) + E(s,X(t));
        end        
        % most probable next state (along with the probability)
        [T1(s,t),T2(s,t)] = max(score); 
    end
end
% backtracking to find path (starting form t=T)
[~,Z(T)] = max(T1(:,T)); % find state with max prob
for t = T:-1:2       
    Z(t-1) = T2(Z(t),t);
end
end




