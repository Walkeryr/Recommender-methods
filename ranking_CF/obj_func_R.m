function [R] = obj_func_R(U, I, mU, mI, allpairprefs)
    util_func = U * I;
    n = length(U(:,1)); % number of users

    R = 0;
    for i = 1:n
        R = R + sum(exp(util_func(i,allpairprefs{i}(:,2)) - ... 
                                        util_func(i,allpairprefs{i}(:,1)))); 
    end
    R = R + mU * norm(U,'fro') + mI * norm(I,'fro');
end

