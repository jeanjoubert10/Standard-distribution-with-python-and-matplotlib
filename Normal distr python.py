
# Jean Joubert
# Example 4 p 99 PHY1503
# STURGE's rule: m = ceil(1 + 3.3log(n))
# mean = mu value (arrithmetic mean)
# sigman = std deviation
# Z = (x-mu)/sigma  (x is largest and smalles values)

from math import *
import matplotlib.pyplot as plt
import scipy.stats
import numpy as np


# All that needs to change
Dataset = [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
Freqset = [1,2,1,4,6,7,13,18,20,14,10,11,8,2,2,1]
Relativef = []
bin_width = (max(Dataset)-min(Dataset))/(len(Dataset)-1) #? Comp for non cont data

mean = 0
n = sum(Freqset)
length = len(Dataset)
xmax = max(Dataset)
xmin = min(Dataset)
xrange = xmax-xmin


print("Dataset:   ",Dataset)
print("Frequency: ",Freqset)
print("Length of dataset: ",length)
print(f"Max value: {xmax}\tMin value: {xmin}\tRange: {xrange:.3f}")


# Work out mean value and total measurements:

for i in range(length):
    mean = mean + Freqset[i]*Dataset[i]
    
mean = mean/n

print("Number of measurements: ",n)
print()
print(f"Mean: {mean:.3f}")
print()


# work out delta/deltasq/fdeltasq
delta = [0]*length
deltasq = [0]*length
fdeltasq = [0]*length
Sumfdsq = 0*length
k2 = 0 # Use for kurtosis

for k in range(length):
    delta[k] = Dataset[k]-mean           # delta (xi - mean)
    deltasq[k] = delta[k]*delta[k]  
    fdeltasq[k] = deltasq[k]*Freqset[k]  # delta squared * freq
    Sumfdsq = Sumfdsq+fdeltasq[k]        # sum of d^2*f
    Relativef.append(Freqset[k]/n)       # Work out relative freq for normalized histogram
    ki = pow((Dataset[k]-mean),4)
    k2 = k2 + ki

# Make table:
print("i\tx\tf\tdelta\tdelta^2\tf*delta^2\tRel f")
print("----------------------------------------------------------------")
for i in range(len(Dataset)):  
    print(f'{i} \t{Dataset[i]} \t{Freqset[i]} \t{delta[i]:.2f} \t{deltasq[i]:.2f}\t{fdeltasq[i]:.2f}\t\t{Freqset[i]/n:.4f}')
print(f"\t\t{n}\t\t\t{Sumfdsq:.4f}")


print("Data: ")
print(f"Range from {xmin} to {xmax} = {xrange:.2f}")

# Standard deviation:
Sigma = sqrt(Sumfdsq/n)

adj_sigma = sqrt(Sumfdsq/(n-1))  # Bessel's correction
Std_e_m = Sigma/(sqrt(n))
Adj_e_m = adj_sigma/sqrt(n)

#Kurtosis
k1 = n*(n+1)/ ((n-1)*(n-2)*(n-3))
k3 = 3*pow((n-1),2) / ((n-2)*(n-3))
kurtosis = k1*(k2/pow(Sigma,4)) - k3
if kurtosis == 0:
    message = "mesokurtic = 0"
elif kurtosis < 0:
    message = "platykurtic < 0"
else:
    message = "leptokurtic > 0"


print(f"Standard deviation: {Sigma:.4f}\nMean(mu): {mean:.3f} - best estimate of true value of x")
print()
print(f"Adjusted Std dev: {adj_sigma:.4f} - best estimate of precision")
print(f"Std error in mean: {Std_e_m:.4f}")
print(f"Adj Std error in mean: {Adj_e_m:.4f}")
print(f"Kurtosis: {kurtosis:.2f}, {message}")

# Calculated relative frequency based in mean,sigma:
rcalc = []
a = 1/(Sigma*sqrt(2*pi))
c = -(1/(2*Sigma**2))

print()
print(f"Rcalc = {a:.4f}*e^{c:.4f}(xi-{mean:.4f})^2")
print()

for i in range(length):
    rcalc.append(bin_width*(a*exp(c*(Dataset[i]-mean)**2)))#?????

print("x\tRel f(exp)\tRel f(calc)")
print("------------------------------")
for i in range(length):
    print(f"{Dataset[i]}\t{Freqset[i]/n:.4f}\t\t{rcalc[i]:.4f}")
    

# Print graphs
data =[]


print(f"Bin width: {bin_width:.3f}")


for i in range(length):
    for j in range(Freqset[i]):
        data.append(Dataset[i])
        
#####################################


# Normalized Histogram

bins = len(Dataset)
plt.hist(Dataset,bins,weights=Relativef,rwidth=0.8)


# Normal curve
x = np.linspace(xmin,xmax,100)
y = scipy.stats.norm.pdf(x,mean,Sigma)*bin_width   # Compensate non cont data

plt.plot(x,y,color='coral')


plt.xlabel('Value')
plt.ylabel('Relative Frequency')
plt.title(f'Normalized Histogram u={mean:.2f}, s={Sigma:.3f}, n={n}')



# plot histogram
figure, axes2 = plt.subplots(nrows = 1,ncols=1)
plt.hist(Dataset,bins,weights = Freqset,rwidth=0.8)
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.title(f'Histogram u={mean:.2f}, s={Sigma:.3f}, n={n}')

plt.show()


    
