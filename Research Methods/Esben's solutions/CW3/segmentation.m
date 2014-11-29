function delimiters = segmentation(X, k)
    delimitercount = k-1;
    if delimitercount <= 0
        delimiters = [];
        return;
    end
    
    delimiters = segmentation(X, k-1);
    mindelimiters = [];
    for i = 1:(size(X,1) - 1)
        newdelimiters = sort([delimiters i]);
        if error(newdelimiters, X) < error(mindelimiters, X)
            mindelimiters = newdelimiters;
        end
    end
    delimiters = mindelimiters;
end

function e = error(delimiters, X)
    e = 0;
    bounddelimiters = [0 delimiters size(X, 1)];
    for j = 2:size(bounddelimiters, 2)
        indeces = (1+bounddelimiters(j-1)):bounddelimiters(j);
        segment = X(indeces, :);
        centroid = sum(segment)/size(segment, 1);
        for k = 1:size(segment, 1)
            e = e + norm(segment(k, :)-centroid)^2;
        end
    end
end