import numpy as np
import distancias as d

def aceleraciones(eps,x,y,z,m):
    G = 4.299e-6
    n = len(m)
    
    dx,dy,dz,masas = d.distancias(x,y,z,m)
    dist = np.sqrt(dx**2 + dy**2 + dz**2 + eps**2)

    aux1 = dx / dist**3
    aux2 = dy / dist**3
    aux3 = dz / dist**3

    ax = np.zeros([n])
    ay = np.zeros([n])
    az = np.zeros([n])
    
    for i in np.arange(n):
        for j in np.arange(n):
            ax[i] = ax[i] - G*m[j]*aux1[i,j]
            ay[i] = ay[i] - G*m[j]*aux2[i,j]
            az[i] = az[i] - G*m[j]*aux3[i,j]
            
    a = np.ndarray([n,3])
    a[:,0] = ax
    a[:,1] = ay
    a[:,2] = az

    return a