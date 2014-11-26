function basis = polybasis(k)
    if k <= 1
        % repmat used to enforce same dimensionality
        basis = {@(x) repmat(1, size(x,1), size(x,2))}; 
    else
        basis = [polybasis(k-1), {@(x) x.^(k-1)}];
    end
end
