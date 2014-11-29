% function segments = segmentation(X, k)    
%     
%     cindeces = sort(randsample(size(X,1), k, false));
%     c = X(cindeces, :);
%     r = repmat(0, size(X, 1), k);
%     oldr = 1; % something that is not equal to r initially
%     
%     dist = @(x, y) norm(x-y);
%     
%     % Loop as long as the clustering is changing
%     while ~isequal(r, oldr)
%         oldr = r;
%         
%         % Assign points to clusters
%         cluster = 1;
%         r(1, :) = [repmat(0, 1, cluster-1) 1 repmat(0, 1, k-cluster)];
%         for i = 2:size(X,1)
%             % If X(i) is closer to c(cluster+1), increment cluster and
%             % assign X(i) to cluster
%             if cluster < size(c, 1) && dist(X(i,:), c(cluster+1)) < dist(X(i,:), c(cluster))
%                 cluster = cluster + 1;
%             end
%             r(i, :) = [repmat(0, 1, cluster-1) 1 repmat(0, 1, k-cluster)];
%         end
% 
%         % Update center positions
%         for i = 1:k
%             npoints = 0;
%             c(i, :) = 0;
%             for j = 1:size(r, 1)
%                 c(i, :) = c(i, :) + r(j, i)*X(j, :);
%                 npoints = npoints + r(j, i);
%             end
%             c(i, :) = c(i, :)/npoints;
%         end
%     end
%     
%     % Output formatting (vector with cluster index for each row in X)
%     clustering = repmat(0, size(X,1), 1);
%     for i = 1:size(X,1)
%        for j = 1:k
%            if r(i, j) == 1
%                 clustering(i) = j;
%                 break;
%            end
%        end
%     end
%    
%     segments = clustering;
% end

% function segments = segmentation(X, k)    
%     
%     delimiters = [1:k-1];
%     olddelimiters = [0];
%     while delimiters ~= olddelimiters
%         olddelimiters = delimiters;
%         for i = size(delimiters, 2):-1:1
%             for j = delimiters(i):size(X, 1)
%                 newdelimiters = delimiters;
%                 newdelimiters(i) = j;
%                 if error(newdelimiters, X) < error(delimiters, X)
%                     delimiters(i) = j;
%                 end
%             end
%         end
%     end
%     
%     segments = delimiters;
% end

function segments = segmentation(X, k)    
    
    delimiters = [];
    
    % For each delimiter to add
    for j = 1:(k - 1)
        % Find the position that minimizes the error
        mindelimiters = [];
        for i = 1:(size(X,1) - 1)
            newdelimiters = sort([delimiters i]);
            if error(newdelimiters, X) < error(mindelimiters, X)
                mindelimiters = newdelimiters;
            end
        end
        % Add this minimizer to the list of delimiters
        delimiters = mindelimiters;
    end
    
    segments = delimiters;
end


function e = error(delimiters, X)
    e = 0;
    delimitersbounded = [0 delimiters size(X, 1)];
    for j = 2:size(delimitersbounded, 2)
       segment = X((1+delimitersbounded(j-1)):delimitersbounded(j), :);
       centroid = sum(segment)/size(segment, 1);
       for k = 1:size(segment, 1)
           e = e + norm(segment(k, :)-centroid)^2;
       end
    end
end