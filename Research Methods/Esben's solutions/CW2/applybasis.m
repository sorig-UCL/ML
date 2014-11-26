% Applies a basis to a matrix X
function sol = applybasis(X, basis)
    % X     - (m x n) - a matrix of row input vectors
    % basis - (k x 1) - an array of functions
    % sol   - (m x k) - X with the applied basis
    
    sol = [];
    for i = 1:size(basis, 2)
        sol = [sol arrayfun(basis{i}, X)];
    end
end