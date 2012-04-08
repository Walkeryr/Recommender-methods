function [grad] = gradient_M_vect(ratings,U,M,km)
    m = length(M(1,:));
    f = length(M(:,1));
    grad = zeros(f,length(M(1,:)));
    fileID = fopen('gradient_M.log','w');
    
    for j = 1:m  
        tic
        grad(:,j) = U * ((ratings(:,j)' - M(:,j)' * U)' .* ... 
                              full(logical(ratings(:,j)))) - km * M(:,j);
        fprintf(fileID,'%s %f - %f\n','Time took to compute item: ', ...
                                                                  j,toc);
    end
    fclose(fileID);
end