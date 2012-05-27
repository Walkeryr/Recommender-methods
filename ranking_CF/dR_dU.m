function [dR_dU_res] = dR_dU(U,I,mU,allpairprefs)
    n = length(U(:,1)); % number of users
    f = length(U(1,:)); % number of factors
    dR_dU_res = zeros(n,f); 
    
    for i = 1:n
        ux = U(i,:);
        Itux = I'*ux';
        dR_dUx = sum( ...
        (I(:,allpairprefs{i}(:,2)) - I(:,allpairprefs{i}(:,1))) .* ...
        (exp(Itux(allpairprefs{i}(:,2)) - Itux(allpairprefs{i}(:,1))) * ones(1,f))' ...
        ,2)' + 2*mU*ux;
        dR_dU_res(i,:) = dR_dUx;
    end
end

