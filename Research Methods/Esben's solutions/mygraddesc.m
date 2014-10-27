function [sol, guesses] = mygraddesc(A, b, guess, step, tol)

    mse = @(w) (A*w - b).' * (A*w - b);
    dmsedw = @(w) (-2*A.' * b) + (2*A.' * A * w);
    guesses = [guess; mse(guess)];
    
    while norm(dmsedw(guess)) > tol
        guess = guess - dmsedw(guess)*step;
        guesses = [guesses [guess; mse(guess)]];
    end
    
    sol = guess;
    
end