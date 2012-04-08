function [fact_mat] = create_and_fill(V,f,n)
    avgrat = mean(nonzeros(V));
    minrat = min(nonzeros(V));
    fact_mat = zeros(f,n);
    for i = 1:f
        for j = 1:n
            fact_mat(i,j) = sqrt((avgrat - minrat)/f) + ...
                                             (- 0.1 + (0.1+0.1).*rand()); 
        end
    end
end

