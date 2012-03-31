load ../data/movielens/ml-100k/u1_base.mat
load ../data/movielens/ml-100k/u1_test.mat
f = 20; % number of factors
U = create_and_fill(ratings,f,length(ratings(:,1)));
M = create_and_fill(ratings,f,length(ratings(1,:)));
ku = 0.05;
km = 0.05;
mu = 0.0005; % learning rate
a = min(nonzeros(ratings)); % min rating
b = max(nonzeros(ratings)); % max rating

for i = 1:100
    gradU = gradient_U_vect(ratings,U,M,ku);
    gradM = gradient_M_vect(ratings,U,M,km);
    U = U + mu * gradU;
    M = M + mu * gradM;
    V = U' * M;
    RMSE(V,test_ratings)
end

%plot(1:10, RMSE_arr)