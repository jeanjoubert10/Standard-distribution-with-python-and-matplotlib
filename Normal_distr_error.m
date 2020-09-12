
clear;clc;clf; format compact;

Data = [53,54,55,56,57,58,59,60,61,62];
%freq = [1,1,2,3,3,4,3,2,1,1];
freq = [1,2,13,1115,1112228,11119,117,2,1,1];

s1=size(Data);
size(freq);
xmax = max(Data);
xmin = min(Data);
n = sum(freq);

total = 0;

for i = 1:s1(2)
    total = total + Data(i)*freq(i);
end
mean = total/n   % Best estimate of true value of x

delta = zeros([1,s1(2)]);
delta2 = zeros([1,s1(2)]);
d2f = zeros([1,s1(2)]);
tot_d2f = 0;
relative_f = zeros([1,s1(2)]);
k2 = 0;

for i = 1:s1(2)
    delta(i) = Data(i)-mean;
    delta2(i) = delta(i)^2;
    d2f(i) = delta2(i)*freq(i);
    tot_d2f = tot_d2f + d2f(i);
    relative_f(i) = freq(i)/n;
    ki = (Data(i)-mean).^4;      % For the kurtosis
    k2 = k2+ki;
end

S = sqrt(tot_d2f/n);   % Variance = tot_d2f/n or S^2

a = 1/(S*sqrt(2*pi));
c = -1/(2*S^2);

x = linspace(xmin,xmax);
y = a*exp(c*(x-mean).^2);% r = 1/(2*sqrtpi)*e^(1(x-mean)^2/(2sigma^2))

hold on;

bar(Data,relative_f)
plot(x,y,'r','linew',2)


% Adjusted standard deviation (Bessel's correction)

S_adj = sqrt(tot_d2f/(n-1)); % Best estimate of precision of measurement

s_e_mean = S/sqrt(n);  % Std error in mean (increased confidence with 
                        % increased measurements

adj_s_m = sqrt(tot_d2f/(n*(n-1))); % Adj std error in mean (best overall
                                %accuracy of experiment)
                                
% Kurtosis
k1 = n*(n+1)/((n-1)*(n-2)*(n-3));
k3 = 3*(n-1)^2/((n-2)*(n-3));

Kurt = k1*(k2/S^4) - k3;

if (Kurt > 0)
    message = "Leptokurtic >0";
elseif (Kurt == 0)
    message = "Mesokurtic = 0";
else
    message = "Platykurtic < 0";
end

sprintf("Mean value: %.3f +- %0.2f units",mean,adj_s_m)
sprintf("Max : %.3f    Min: %.3f",xmax,xmin)
sprintf("Total measurements: %d",n)
sprintf("Standard deviation: %.3f",S)
sprintf("Adj std deviation: %.3f",S_adj)
sprintf("Std error in mean: %.3f",s_e_mean)
sprintf("Adj std error in mean: %.3f:",adj_s_m)
sprintf("Kurtosis (%s): %.2f",message,Kurt)



