import numpy as np

def W(r,h):
    #Spline kernel of Monaghan and Lattanzio (1985)
    
    n=len(r)
    
    x = r/h
    W = np.zeros(n)
    
    for i in range(n):
        
        if 0.<= x[i] and x[i] < 1. :
            W[i] = (1. - 1.5*(x[i]**2) + 0.75*(x[i]**3)) / (np.pi * h**3)
        
        elif 1.<= x[i] and x[i] < 2. :
            W[i] = (2. - x[i])**3 / (4 * np.pi * h**3)
        
        else:
            W[i] = 0.
    
    return W