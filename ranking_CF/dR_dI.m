function [dR_dI_res] = dR_dI(U,I,mI,allpairprefs)
    f = length(I(:,1)); % number of factors
    p = length(I(1,:)); % number of items
    n = length(U(:,1)); % number of users
    dR_dI_res = zeros(f,p);
    
    for j = 1:p
        djax = cell(1,n);
        dbjx = cell(1,n);
        for d = 1:f
            tic
            dR_dIjd = 0;
            for x = 1:n
                a = unique(allpairprefs{x}(:,1));
                b = unique(allpairprefs{x}(:,2));
                al = length(a);
                bl = length(b);
                ja = [(j * ones(1,al))'      a];
                bj = [b                      (j * ones(1,bl))'];
                if (d == 1)
                    djax{x} = ismember(ja,allpairprefs{x},'rows');
                    dbjx{x} = ismember(bj,allpairprefs{x},'rows'); 
                end
                ux = U(x,:);
                Itux = I'*ux';
        
                dR_dIjd = dR_dIjd + ...
                ...
                (sum((U(x,d)*ones(1,al))' .* exp((Itux(j)*ones(1,al))' - ...
                Itux(a)) .* ...
                djax{x}) - ...
                ...
                sum((U(x,d)*ones(1,bl))' .* exp(Itux(b) - ...
                (Itux(j)*ones(1,bl))') .* ...
                dbjx{x}) ...
                );
            end
            dR_dIjd = dR_dIjd + 2*mI*I(j,d);
            dR_dI_res(j,d) = dR_dIjd;
            d
            toc
        end 
        j
    end
    toc
end

