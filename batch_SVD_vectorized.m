load ../data/movielens/ml-100k/u1_base.mat

f = 3; % number of factors
U = create_and_fill(ratings,f,length(ratings(:,1)));
M = create_and_fill(ratings,f,length(ratings(1,:)));
ku = 0.05;
km = 0.05;
mu = 0.01; % learning rate
a = min(nonzeros(ratings)); % min rating
b = max(nonzeros(ratings)); % max rating

gradUtic = tic;
gradU = gradient_U(ratings,U,M,ku);
toc(gradUtic)