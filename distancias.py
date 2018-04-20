import numpy as np

def distancias(x,y,z,m):

    n = len(m)

    masas = np.ones((n,n))
    
    dx = np.zeros((n,n))
    dy = np.zeros((n,n))
    dz = np.zeros((n,n))
    
    for i in range(0,n-1):
        for j in range(i+1,n):
                dx[i,j] = x[i]-x[j]
                dy[i,j] = y[i]-y[j]
                dz[i,j] = z[i]-z[j]
                
                dx[j,i] = -dx[i,j]
                dy[j,i] = -dy[i,j]
                dz[j,i] = -dz[i,j]
                
                masas[i,j] = m[i]*m[j]
                masas[j,i] = masas[i,j]

    for i in range(0,n):
        masas[i,i] = m[i]**2
    
    return dx,dy,dz,masas