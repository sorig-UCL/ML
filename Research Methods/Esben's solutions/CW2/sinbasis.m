function basis = sinbasis(k)
    if k <= 1
        basis = {@(x) sin(k*pi*x)}; 
    else
        basis = [sinbasis(k-1), {@(x) sin(k*pi*x)}];
    end
end
