function [result] = prediction(U,M,a,b)
    dot_prod = dot(U,M); 
    if (dot_prod < 0)
        result = a;
    else if (dot_prod > (b - a))
        result = b;
        else
            result = a + dot_prod;
        end
    end
end

