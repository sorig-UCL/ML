function delimiters = segmentation(X, k)
    % E(i, k) represents the minimum error of segmenting
    % X(1:i, :) into k segments.
    E = [];
    
    % D(i, j) stores the jth delimiter that segments X(1:i, :)  
    % into the optimal j+1 segments.
    D = [];
    
    % We initialise E's first column (error of a single 
    % segment over the points X(1:i, :))
    for i = 1:size(X, 1)
        E(i,1) = error([], X(1:i, :));
    end
    
    % We then proceed to filling out each entry in E until
    % we have reached our objective (the minimum k 
    % segmentation of all points in X).
    for i = 1:size(X, 1)
        for l = 2:min(i, k)
            % Find min error of segmenting x_1, ..., x_i 
            % into l segments
            minerror = Inf;
            for j = 1:(i-1)
                if j >= l
                    e = E(j, l-1) + error([], X((j+1):i, :));
                    if e < minerror
                        minerror = e;
                        D(i, l) = j; % Store delimiter
                    end
                end
            end
            E(i, l) = minerror;
        end
    end
    
    % We retrieve the optimal delimiters from D
    delimiters = [];
    delimiter = size(X, 1);
    for i = k:-1:2
       delimiter = D(delimiter, i);
       delimiters = [delimiters delimiter];
    end
    delimiters = sort(delimiters)
end

function e = error(delimiters, X)
    e = 0;
    bounddelimiters = [0 delimiters size(X, 1)];
    for j = 2:size(bounddelimiters, 2)
        indeces = (1+bounddelimiters(j-1)):bounddelimiters(j);
        segment = X(indeces, :);
        centroid = sum(segment, 1)/size(segment, 1);
        for k = 1:size(segment, 1)
            e = e + norm(segment(k, :)-centroid)^2;
        end
    end
end