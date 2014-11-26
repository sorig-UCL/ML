%% 1. a)
% Data to fit
X = [1; 2; 3; 4];
y = [3; 2; 0; 5];

% Bases are applied and the best fit is found
fit1 = applybasis(X, polybasis(1))\y;
fit2 = applybasis(X, polybasis(2))\y;
fit3 = applybasis(X, polybasis(3))\y;
fit4 = applybasis(X, polybasis(4))\y;

figure 
hold on
grid on

axis([0 5 -4 8])
scatter(X,y)

domain = [-4:0.1:8];

% The bases with their coefficients (the fit) are plotted
plot(domain, applyfit(domain, polybasis(1), fit1));
plot(domain, applyfit(domain, polybasis(2), fit2));
plot(domain, applyfit(domain, polybasis(3), fit3));
plot(domain, applyfit(domain, polybasis(4), fit4));

hold off

%% 1. b)
display(fit1) % 2.5
display(fit2) % 0.4 + 1.5x
display(fit3) % 9 + -7.1x + 1.5x^2
display(fit4) % -5 + 15.17x - 8.5x^2 + 1.33x^3

%% 1. c)
mymse = @(X, w, y) (X*w - y).' * (X*w - y) / size(X, 1);
mse1 = mymse(applybasis(X, polybasis(1)), fit1, y)
mse2 = mymse(applybasis(X, polybasis(2)), fit2, y)
mse3 = mymse(applybasis(X, polybasis(3)), fit3, y)
mse4 = mymse(applybasis(X, polybasis(4)), fit4, y)

%% 2. a)
% normaldist enables us to sample from any normal distribution
normaldist = @(mean, stddeviation) randn(1)*stddeviation + mean;

%% b)
% The underlying function is sin^2(2*pi*x)
func = @(x) (sin(2*pi*x))^2;

% g lets us add 0-mean normal noise to the function
g = @(x, sigma) func(x) + normaldist(0, sigma);

% g07 adds normal noise with standard deviation 0.07
g07 = @(x) g(x, 0.07);

% Random samples are generated
SX = rand([30 1]);
SY = arrayfun(g07, SX);

%i) plot the underlying function and the random noisy samples
figure
hold on
axis([0 1 -0.5 1.5])

domain = [0:0.01:1];
range = arrayfun(func, domain);
plot(domain, range, '--r');
scatter(SX, SY);

%% ii)
fit2 = applybasis(SX, polybasis(2))\SY;
fit5 = applybasis(SX, polybasis(5))\SY;
fit10 = applybasis(SX, polybasis(10))\SY;
fit14 = applybasis(SX, polybasis(14))\SY;
fit18 = applybasis(SX, polybasis(18))\SY;

plot(domain, applyfit(domain, polybasis(2), fit2));
plot(domain, applyfit(domain, polybasis(5), fit5));
plot(domain, applyfit(domain, polybasis(10), fit10));
plot(domain, applyfit(domain, polybasis(14), fit14));
plot(domain, applyfit(domain, polybasis(18), fit18));
hold off

%% c)
ks = [];
errors = [];
for i = 1:18
    ks = [ks i];
    featurespacedX = applybasis(SX, polybasis(i));
    fit = featurespacedX\SY;
	errors = [errors mymse(featurespacedX, fit, SY)];
end

figure 
hold on
plot(ks, log(errors));

%% d)
TX = rand([1000 1]);
TY = arrayfun(g07, TX);

% Maps input X to k-degree polynomial basis space
mappolyspace = @(X, k) applybasis(X, polybasis(k));

% Fits a k-degree polynomial to X, Y
fitpoly = @(X, Y, k) mappolyspace(X, k)\Y;

% Fits a k-degree polynomial to training set and gives test set error.
tsek = @(trainX, trainY, testX, testY, k) ...
            mymse(mappolyspace(testX, k), fitpoly(trainX, trainY, k), testY);

ks = [1:18];
errors = arrayfun(@(k) tsek(SX, SY, TX, TY, k), ks);

plot(ks, log(errors));
hold off

%% e)
iterations = 100;
totaltrainerrors = 0;
totaltesterrors = 0;
ks = [1:18];

for i = 1:iterations
    SX = rand([30 1]);
    SY = arrayfun(g07, SX);
    TX = rand([1000 1]);
    TY = arrayfun(g07, TX);
    
    trainerrors = arrayfun(@(k) tsek(SX, SY, SX, SY, k), ks);
    testerrors = arrayfun(@(k) tsek(SX, SY, TX, TY, k), ks);
    
    totaltrainerrors = totaltrainerrors + trainerrors;
    totaltesterrors = totaltesterrors + testerrors;
end

avgtrainerror = totaltrainerrors/iterations;
avgtesterror = totaltesterrors/iterations;

figure
hold on
plot(ks, log(avgtrainerror));
plot(ks, log(avgtesterror));
hold off

%% 3.
%c & d)
% Maps input X to the {sin(1*pi*x), ..., sin(k*pi*x)} basis space
mapsinspace = @(X, k) applybasis(X, sinbasis(k));

% Fits a the the data in the sinus space
fitsin = @(X, Y, k) mapsinspace(X, k)\Y;

% Fits the training set in the sin space and gives test set error.
tsek = @(trainX, trainY, testX, testY, k) ...
            mymse(mapsinspace(testX, k), fitsin(trainX, trainY, k), testY);

SX = rand([30 1]);
SY = arrayfun(g07, SX);
TX = rand([1000 1]);
TY = arrayfun(g07, TX);

ks = [1:18];
trainerrors = arrayfun(@(k) tsek(SX, SY, SX, SY, k), ks);
testerrors = arrayfun(@(k) tsek(SX, SY, TX, TY, k), ks)

figure
hold on
plot(ks, log(trainerrors));
plot(ks, log(testerrors));
hold off

%% e)
iterations = 100;
totaltrainerrors = 0;
totaltesterrors = 0;
ks = [1:18];

for i = 1:iterations
    SX = rand([30 1]);
    SY = arrayfun(g07, SX);
    TX = rand([1000 1]);
    TY = arrayfun(g07, TX);
    
    trainerrors = arrayfun(@(k) tsek(SX, SY, SX, SY, k), ks);
    testerrors = arrayfun(@(k) tsek(SX, SY, TX, TY, k), ks);
    
    totaltrainerrors = totaltrainerrors + trainerrors;
    totaltesterrors = totaltesterrors + testerrors;
end

avgtrainerror = totaltrainerrors/iterations;
avgtesterror = totaltesterrors/iterations;

figure
hold on
plot(ks, log(avgtrainerror));
plot(ks, log(avgtesterror));
hold off