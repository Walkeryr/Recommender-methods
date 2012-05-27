load ../../data/movielens/ml-100k/allpairprefs.mat  
load ../../data/movielens/ml-100k/ratings.mat  

f = 10; % number of factors
n = length(ratings(:,1)); % number of users
p = length(ratings(1,:)); % number of items
mU = 100;
mI = 100;
alpha = 0.001; % learning rate

U = create_and_fill(ratings, f, n)';
I = create_and_fill(ratings, f, p);

R = realmax('double');
i = 0;
while (true)
    U = U - alpha * dR_dU(U,I,mU,allpairprefs);
    I = I - alpha * dR_dI(U,I,mI,allpairprefs);
    R_new = obj_func_R(U, I, mU, mI, allpairprefs);
    if (R_new > R)
        break;
    end
    i = i + 1;
    R = R_new;
end