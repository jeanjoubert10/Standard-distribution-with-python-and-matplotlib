
format compact; clc; clear; clf;
format short;

xval = [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
freq = [1,2,1,4,6,7,13,18,20,14,10,11,8,2,2,1]
rfreq = [];
mean = 0;

% Creat a single list with all the data in the right frequency
n = sum(freq)
data = [];

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

mean = mean/n

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

S = sqrt(sum_fd2/n)

a = 1/(S*sqrt(2*pi))
b = -1/(2*S^2)
x = linspace(min(xval),max(xval));
y = a*exp(b*(x-mean).^2);

bin_width = (max(xval)-min(xval))/(length(xval)-1)
y = y*bin_width;

disp(rfreq)

% Plots
subplot(2,1,1),histogram(data,length(xval))
grid on;
subplot(2,1,2),histogram(data,length(xval),'Normalization','probability')
grid on; hold on;
subplot(2,1,2),plot(x,y,'r','linew',2)



