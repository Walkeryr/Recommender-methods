function [grad] = gradient_U_vect(ratings,U,M,ku)
    n = length(U(1,:));
    f = length(M(:,1));
    grad = zeros(f,length(U(1,:)));
    fileID = fopen('gradient_U.log','w');
    
    for i = 1:n  
        tic
        grad(:,i) = M * ((ratings(i,:) - U(:,i)' * M) .* ... 
                              full(logical(ratings(i,:))))'- ku * U(:,i);
        fprintf(fileID,'%s %f - %f\n','Time took to compute user: ', ...
                                                                  i,toc);
    end
    fclose(fileID);
end

