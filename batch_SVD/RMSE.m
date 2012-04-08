function [result] = RMSE(P,A)
    [nzr,nzc] = find(A); % nzr - nonzero row, nzc - nonzero column
    idx = sub2ind(size(A), nzr, nzc);
    result = sqrt(sum((A(idx)-P(idx)).^2)/length(nzr));
end