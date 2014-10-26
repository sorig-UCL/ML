function [trainingmse,testmse] = LSR(trainingsize,testsize, dim )

seed = 1
s = RandStream('mt19937ar','Seed',seed);
RandStream.setGlobalStream(s);

%LSR 
%  i -- iterations
% dim -- dimensions of w

w = randn(dim,1);
n = randn(trainingsize + testsize, 1);
x = randn(trainingsize + testsize, dim);
y = (x*w + n);


trainingset = [x(1:trainingsize,:),y(1:trainingsize,:)] 
testset = [x(trainingsize+1:trainingsize + testsize, :), y(trainingsize + 1: trainingsize + testsize, :)];
trainx = trainingset(:,1:end-1);
trainy = trainingset(:,end);
testx = testset(:,1:end-1);
testy = testset(:,end);
 
%Question 2

% Estimating w based on training set
we = (1\(trainx.' * trainx)) * (trainx.' * trainy)
 
 figure
 hold on
 scatter(trainingset(:,1),trainingset(:,2), 50, 'r')
% plot(x,x*we')
 title('training set')
 hold off
 
  figure
  hold on
  scatter(testset(:,1), testset(:,2),30, 'b' )
 % plot(x,x*we')
  title('test set')
  hold off
  
  figure
  plot(x,x*we')
 
 

%compute mean squared error on training set and test set
trainingmse = (1/trainingsize) * (trainx*we - trainy).' * (trainx*we - trainy)
testmse = (1/testsize) * (testx*we - testy).' * (testx*we - testy)
end
