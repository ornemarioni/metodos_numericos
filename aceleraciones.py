import numpy as np
import distancias as d

def aceleraciones(eps,x,y,z,m):
    G = 4.299e-6

    dx,dy,dz,masas = d.distancias(x,y,z,m)
    dist = np.sqrt(dx**2 + dy**2 + dz**2 + eps**2)

    aux1 = np.sum(dx / dist**3,axis=0)
    aux2 = np.sum(dy / dist**3,axis=0)
    aux3 = np.sum(dz / dist**3,axis=0)

    ax = G * m * aux1
    ay = G * m * aux2
    az = G * m * aux3
    
    a = np.ndarray([len(m),3])
    a[:,0] = ax
    a[:,1] = ay
    a[:,2] = az

    return a