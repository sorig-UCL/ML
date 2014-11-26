% Applies a basis and a matching set of coefficients (the fit) to input X
% e.g. X = [1,2,3], basis = {@(x) x^2}, coefficients = [1] gives
% sol = [1, 4, 9] 
function sol = applyfit(X, basis, coefficients)
    sol = 0;
    for i = 1:size(basis, 2)
        sol = sol + coefficients(i) * basis{i}(X);
    end
end