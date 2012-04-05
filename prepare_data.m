fid = fopen('../data/movielens/ml-100k/u1_base.dat');
ratings_cell = textscan(fid, '%f %f %f %f', 'delimiter', '::', ... 
                           'CollectOutput', 1, 'MultipleDelimsAsOne', 1);
fclose(fid);       
raw_mat = ratings_cell{1};
ratings = sparse(raw_mat(:,1), raw_mat(:,2), raw_mat(:,3), ... 
                                   max(raw_mat(:,1)), max(raw_mat(:,2)));

n = length(raw_mat(:,1));
n_test = floor(0.2 * n);
test_ratings = sparse(length(ratings(:,1)),length(ratings(1,:)));

[nzr,nzc] = find(ratings); % nzr - nonzero row, nzc - nonzero column
idx = sub2ind(size(ratings), nzr, nzc);
n = numel(idx);
p = randperm(n);
test_ratings(idx(p(1:n_test))) = ratings(idx(p(1:n_test)));
ratings(idx(p(1:n_test))) = 0;

save ../data/movielens/ml-1m/test_rat.mat test_ratings;
save ../data/movielens/ml-1m/ratings.mat ratings;
                       


