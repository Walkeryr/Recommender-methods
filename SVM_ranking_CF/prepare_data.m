tic
DATA_DIR = '../../data/movielens/ml-100k/';
fid = fopen(strcat(DATA_DIR, 'u.data'));
ratings_cell = textscan(fid, '%f %f %f %f', 'delimiter', '::', ... 
                           'CollectOutput', 1, 'MultipleDelimsAsOne', 1);
fclose(fid);       
raw_mat = ratings_cell{1};
% matrix of ratings of users x items
ratings = sparse(raw_mat(:,1), raw_mat(:,2), raw_mat(:,3), ... 
                                   max(raw_mat(:,1)), max(raw_mat(:,2)));

nu = length(ratings(:,1)); % number of users
num_rank_errors = 0; % Total number of rank errors
for usr = 1:nu                           
    fid2 = fopen(strcat(DATA_DIR, 'converted.data'), 'w');
    [users,items,rating] = find(ratings(usr,:));
    usr
    length(items)
    for k = 1:length(items)
        [other_users,curr_item,other_rating] = find(ratings(:,items(k)));
        features = '';
        for z = 1:length(other_users)
            if z ~= usr
                features = [features, ' ', sprintf('%i:%i',other_users(z),other_rating(z))];
            end
        end
        fprintf(fid2, '%i qid:1 %s # item %i\n', rating(k), features, items(k));
    end
    fclose(fid2);
    s = evalc('system(''./train_test.sh'')');
    search_pattern = 'Total Num Swappedpairs  :      ';
    num_rank_errors = num_rank_errors + str2num(s(findstr(s, search_pattern) + length(search_pattern)));
end

'number of rank errors', num_rank_errors / nu
toc