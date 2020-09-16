
format compact; clc; clear; clf;
format short;

xval = [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
freq = [1,4,6,10,20,33,55,100,150,400,300,150,100,70,40,19,14];


% Creat a single list with all the data in the right frequency
rfreq = [];
n = sum(freq);
data = [];
mean = 0;

for i = 1:length(xval)
    lx = freq(i);
    datalx = zeros([1,lx]);
    for j = 1:lx
        datalx(j) = xval(i);
    end
    data = [data datalx];
    rfreq = [rfreq freq(i)/sum(freq)];
    mean = mean + xval(i)*freq(i);
end
mean = mean/n;

% Std deviation:
delta = zeros([1,length(xval)]);
d2 = zeros([1,length(xval)]);
fd2 = zeros([1,length(xval)]);
sum_fd2 = 0;

for i = 1:length(xval)
    delta(i) = xval(i)-mean;
    d2(i) = delta(i).^2;
    fd2(i) = freq(i)*d2(i);
    sum_fd2 = sum_fd2 + fd2(i);
end

S = sqrt(sum_fd2/n);

a = 1/(S*sqrt(2*pi));
b = -1/(2*S^2);
x = linspace(min(xval),max(xval));
y = a*exp(b*(x-mean).^2);

bin_width = (max(xval)-min(xval))/(length(xval)-1);
y = y*bin_width;

% Errors:
adjS = sqrt(sum_fd2/(n-1));
std_e = S/sqrt(n);
adj_std_e = adjS/sqrt(n);

% Plots
subplot(2,1,1),histogram(data,length(xval))
title("Histogram")
grid on; hold on;
subplot(2,1,2),histogram(data,length(xval),'Normalization','probability')
title("Normalized histogram and normal distribution")
grid on; hold on;
subplot(2,1,2),plot(x,y,'r','linew',2)

% Output:
fprintf("Data\t\tFrequency\n")
for i = 1 : length(xval)
    fprintf("%.3f\t%i\n",xval(i),freq(i))
end
fprintf("Total measurements: %i\n",n)
fprintf("Mean value: %.3f - Best estimate of true value of x\n",mean)
fprintf("Std deviation: %.4f\n",S)
fprintf("Adj std deviation: %.4f - Best estimate of precision\n",adjS)
fprintf("Std error: %.3f\n",std_e)
fprintf("Adj std error in mean: %.4f - Best est of accuracy\n\n",adj_std_e)
fprintf("Measurement: %.4f +- %.2f\n\n",mean,adj_std_e)
fprintf("Rcalc = %.4f * e^%.4f(x-%.4f)\n\n",a,b,mean)

% Relative frequencies:
calcrf = zeros([1,length(rfreq)]);
fprintf("n\tx\t\tRel freq\tCalc Rel Freq\n")
for i = 1:length(rfreq)
    calcrf(i) = a*exp(b*(xval(i)-mean).^2)*bin_width;
    fprintf("%i\t%.3f\t%.4f\t\t%.4f\n",i,xval(i),rfreq(i),calcrf(i))
end







