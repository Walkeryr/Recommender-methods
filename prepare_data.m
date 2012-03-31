fid = fopen('../data/movielens/ml-100k/u1.base');
ratings_cell = textscan(fid, '%f %f %f %f', 'delimiter', ' ', ... 
                           'CollectOutput', 1, 'MultipleDelimsAsOne', 1);
fclose(fid);       
raw_mat = ratings_cell{1};
ratings = sparse(raw_mat(:,1), raw_mat(:,2), raw_mat(:,3), ... 
                                   max(raw_mat(:,1)), max(raw_mat(:,2)));
                               
save ../data/movielens/ml-100k/u1_base.mat ratings;
                       


