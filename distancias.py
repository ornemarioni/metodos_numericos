import numpy as np

def distancias(x,y,z,m):

    n = len(m)

    mass2 = np.zeros((n,n))
    
    dx = np.zeros((n,n))
    dy = np.zeros((n,n))
    dz = np.zeros((n,n))
    
    for i in range(0,n-1):
        for j in range(i+1,n):
                dx[i,j] = x[j]-x[i]
                dy[i,j] = y[j]-y[i]
                dz[i,j] = z[j]-z[i]
                
                dx[j,i] = -dx[i,j]
                dy[j,i] = -dy[i,j]
                dz[j,i] = -dz[i,j]
                
                mass2[i,j] = m[i]*m[j]
                mass2[j,i] = mass2[i,j]
    
    return dx,dy,dz,mass2