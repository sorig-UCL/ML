function [clusterings, centers] = mykmeans(X, k)
    % Randomly initialize centers of clusters
    c = datasample(X, k, 'Replace', false);
    r = repmat(0, size(X, 1), k);
    oldr = 1; % something that is not equal to r initially
    
    dist = @(x, y) norm(x-y);
    
    % Loop as long as the clustering is changing
    while ~isequal(r, oldr)
        oldr = r;
        
        % Assign points to clusters
        for i = 1:size(X,1)
            cluster = 1;
            for j = 1:k
                if dist(X(i, :), c(j, :)) <  dist(X(i, :), c(cluster, :))
                    cluster = j;
                end
            end

            r(i, :) = [repmat(0, 1, cluster-1) 1 repmat(0, 1, k-cluster)];
        end

        % Update center positions
        for i = 1:k
            npoints = 0;
            c(i, :) = 0;
            for j = 1:size(r, 1)
                c(i, :) = c(i, :) + r(j, i)*X(j, :);
                npoints = npoints + r(j, i);
            end
            c(i, :) = c(i, :)/npoints;
        end
    end
    
    centers = c;
    % Output formatting (vector with cluster index for each row in X)
    clustering = repmat(0, size(X,1), 1);
    for i = 1:size(X,1)
       for j = 1:k
           if r(i, j) == 1
                clustering(i) = j;
                break;
           end
       end
    end
   
    clusterings = clustering;
end