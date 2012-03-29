fid = fopen('../data/movielens/ratings.dat');
ratings_cell = textscan(fid, '%f %f %f %f', 'delimiter', ':', ... 
                           'CollectOutput', 1, 'MultipleDelimsAsOne', 1);
ratings_raw = ratings_cell{1};
ratings = sparse(max(ratings_raw(:,1)), max(ratings_raw(:,2)));
fclose(fid);                                 