function [soln, X, Y, Z] = graddesc(f, g, i,e, t)
    % gradient descent
    % f -- function
    % g -- gradient
    % i -- initial guess
    % e -- step size
    % t -- tolerance
    gi = feval(g,i) ;
    X = [];
    Y = [];
    Z = [];
    while(norm(gi)>t)  % crude termination condition
        i = i - e .* feval(g,i) ;
        gi = feval(g,i);
        X = [X i(1)];
        Y = [Y i(2)];
        Z = [Z fc(i)];
    end
    soln = i ;
end
