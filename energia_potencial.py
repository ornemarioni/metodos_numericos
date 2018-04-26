import numpy as np
import distancias as d

def epot(eps,x,y,z,m):
    
    G = 4.299e-6
    n = len(m)
    
    U = np.zeros((n,n))
    
    dx,dy,dz,masas = d.distancias(x,y,z,m)
    
    dist = np.sqrt(dx**2 + dy**2 + dz**2 + eps**2)

    for i in np.arange(n-1):
        for j in np.arange(i+1,n):
            U[i,j] = G*m[j]*m[i]/dist[i,j]
            U[j,i] = U[i,j]
    
    Upot = np.sum(U,axis=0)
    return Upot