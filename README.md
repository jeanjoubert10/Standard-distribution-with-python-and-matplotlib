# Standard-distribution-with-python-and-matplotlib
Simple program to get mean, standard deviation and plot histogram and normal distribution curve


I was doing a lot of physics data calculations from experimental data and decided to automate the process as much as possible.
Program (both the Maltab/Octae and Python) takes the data and frequencies:

Calculate:

  - delta
  - detla^2
  - freq * delta^2
  - sum of the above
  
      Calculate:
      - Sigma (std deviation)
      - Adjusted std deviation(s)
      - Standard error in mean (sigma_m)
      - Adj std error mean (s_m)
      - Compare relative frequencies with calculated relative frequencies from:
      
              Rcalc = 1/(sigma*sqrt(2pi)) * e^ (-(x-mean)^2/(2*sigma^2))
Plot:

  - Histogram
  - Normalized histogram
  - Normal distribution
