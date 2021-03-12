function P = periodogramme(S,N)
N = length(S);
Y = fft(S,N);
Y = abs(Y);
P = (Y.^2)/N; 