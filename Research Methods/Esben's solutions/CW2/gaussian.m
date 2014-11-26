% The function produces a sample from a gaussian distribution with a given
% mean and standard deviation. The dim argument can be used to create a
% matrix of arbitrary dimensions with each element being a sample from the 
% distribution.
function sol = guassian(mean, stddeviation, dim)
    % Default output matrix is 1x1
    if nargin < 3
        dim = 1;
    end
    
    sol = randn(dim)*stddeviation + mean;
end