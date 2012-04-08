load ../data/movielens/ml-1m/ratings.mat
load ../data/movielens/ml-1m/test_rat.mat
f = 60; % number of factors
U = create_and_fill(ratings,f,length(ratings(:,1)));
M = create_and_fill(ratings,f,length(ratings(1,:)));
ku = 0.05;
km = 0.05;
mu = 0.0001; % learning rate
a = min(nonzeros(ratings)); % min rating
b = max(nonzeros(ratings)); % max rating
RMSE_vals = [];
iter_times = [];
iters = 0;
prev_RMSE = 100;
curr_RMSE = 50;

while ((prev_RMSE - curr_RMSE) > 0)
    iters = iters + 1;
    tstart = tic;
    gradU = gradient_U_vect(ratings,U,M,ku);
    gradM = gradient_M_vect(ratings,U,M,km);
    U = U + mu * gradU;
    M = M + mu * gradM;
    V = U' * M;    
    prev_RMSE = curr_RMSE;
    curr_RMSE = RMSE(V,test_ratings); 
    RMSE_vals = [RMSE_vals curr_RMSE];    
    iter_times = [iter_times toc(tstart)];
end

plot(1:length(RMSE_vals),RMSE_vals)
xlabel('iteration');
ylabel('RMSE');
