% Load data from simulations
load data_Pharynx.mat

%%% Auxiliar funcitons
%  X=table2array(X);
%  X=logical(X);

% Dimension of input data (L: length, N: number of neurons)
[L,N] = size(X);

% To fit GLM models with different history orders
for neuron = 1:N                            % neuron
    for ht = 2:2:2                         % history, when W=2ms
        [bhat{ht,neuron}] = glmwin(X,neuron,ht,200,2);
        disp ('Calculating Models')
        disp ('Neuron: ')
        disp (neuron)
        disp ('ht: ')
        disp (ht)
    end
end

% To select a model order, calculate AIC
for neuron = 1:N
    for ht = 2:2:4
        LLK(ht,neuron) = log_likelihood_win(bhat{ht,neuron},X,ht,neuron,2); % Log-likelihood
        aic(ht,neuron) = -2*LLK(ht,neuron) + 2*(N*ht/2 + 1);                % AIC
        disp ('Calculating AIC')
        disp ('Neuron: ')
        disp (neuron)
        disp ('ht: ')
        disp (ht)
    end
end

%%% Plot AIC 
% a=round(sqrt(N)+0.5);
%  
% figure();
% for neuron = 1:N
%     subplot(a,a,neuron)
%     plot(aic(2:2:10,neuron));
% end


%%% Save results
save('PharynxModels','bhat','aic','LLK','X')

%%% Identify Granger causality
% CausalTest;