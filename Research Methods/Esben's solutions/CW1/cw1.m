% 1.
%% a)
% Plot
[X,Y] = meshgrid(linspace(0,5,15),linspace(0,5,15));
mesh(X,Y,fcarg(X,Y));

%% b) (i) 
% Gradient descent
[result, X, Y, Z] = graddesc('fc','dfc',[0,0],0.001,0.1);
display(result)

%% (ii) 
% Plot descent path
plot3(X, Y, Z)
hold on
grid on
hold off

%% (iii) 
% Plot projection to XY plane
plot(X, Y)

%% 2.
% b)
A = [1 -1; 1 1; 1 2]
b = [1; 1; 3];
guess = [0; 0];

mygraddesc(A, b, guess, 0.01, 0.0001)

%% c)
[~, guesses] = mygraddesc(A, b, guess, 0.01, 0.001);

plot3(guesses(1,:), guesses(2,:), guesses(3,:));
hold on
grid on
hold off

%% Advanced
domain = [-1:0.01:3];
range = arrayfun(@(x) abs(x-1)^3, domain);

plot(domain, range);

%%
domain = [-1:0.01:3];
range = arrayfun(@(x) sqrt(abs(x-1)), domain);

plot(domain, range);

%%
domain = [-1:0.01:1];
range = arrayfun(@(x) x^4 + 5*x^2, domain);
plot(domain, range);

