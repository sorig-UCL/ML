%% Generating noisy random dataset
w = randn(1,1)
n = randn(600, 1);
x = randn(600, 1);
y = (x*w' + n);


trainingset = [x(1:100),y(1:100)] 
testset = [x(101:600), y(101:600)]

figure
hold on
scatter(trainingset(:,1),trainingset(:,2), 30, 'r')
scatter(testset(:,1), testset(:,2),30, 'b' )
title('noisy random dataset')

%Question 2

% Estimating w based on training set
we = (1\(trainingset(1).' * trainingset(1))) * (trainingset(1).' * trainingset(2))

plot(x,x*we')

%compute mean squared error on training set and test set

trainingmse = (1/size(trainingset, 1)) * (trainingset(:,1)*we - trainingset(:,2)).' * (trainingset(:,1)*we - trainingset(:,2))
testmse = (1/size(testset, 1)) * (testset(:,1)*we - testset(:,2)).' * (testset(:,1)*we - testset(:,2))

%Question 3