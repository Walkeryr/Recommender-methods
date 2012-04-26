tic
fid = fopen('../../data/movielens/ml-100k/u.data');
ratings_cell = textscan(fid, '%f %f %f %f', 'delimiter', '::', ... 
                           'CollectOutput', 1, 'MultipleDelimsAsOne', 1);
fclose(fid);       
raw_mat = ratings_cell{1};
% matrix of ratings of users x items
ratings = sparse(raw_mat(:,1), raw_mat(:,2), raw_mat(:,3), ... 
                                   max(raw_mat(:,1)), max(raw_mat(:,2)));
ratings_backup = ratings;

n = length(ratings(:,1));    % number of users                               
allpairprefs = cell(1,n);    % cell array of matrices containing pairwise
                             % preferences of all users
max_rating = max(raw_mat(:,3));
min_rating = min(raw_mat(:,3));
curr_max = max_rating;

% computing pairwise preferences for each user                          
for i = 1:n
    prefs = []; % pairwise preferences for one user
    while (curr_max > min_rating)
        a = find(ratings(i,:) == curr_max);
        b = find(ratings(i,:) < curr_max & ratings(i,:) ~= 0);
        cartprod = allcomb(a,b); % cartesian product to build preferences
        if (~isempty(cartprod))
            prefs = [prefs; cartprod];
        end
        ratings(i,a) = 0;
        curr_max = max(ratings(i,:)); 
    end
    allpairprefs{i} = prefs;
    curr_max = max_rating;
end

save ../../data/movielens/ml-100k/allpairprefs.mat allpairprefs;

toc                               
                               
                               
                               
                               
                               
                               
%n = length(raw_mat(:,1));
%n_test = floor(0.2 * n);
%test_ratings = sparse(length(ratings(:,1)),length(ratings(1,:)));

%[nzr,nzc] = find(ratings); % nzr - nonzero row, nzc - nonzero column
%idx = sub2ind(size(ratings), nzr, nzc);
%n = numel(idx);
%p = randperm(n);
%test_ratings(idx(p(1:n_test))) = ratings(idx(p(1:n_test)));
%ratings(idx(p(1:n_test))) = 0;

%save ../../data/movielens/ml-1m/test_rat.mat test_ratings;
%save ../../data/movielens/ml-1m/ratings.mat ratings;
                       


