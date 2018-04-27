import numpy as np
import distancias as d

def aceleraciones(eps,x,y,z,m):
    G = 4.299e-6
    n = len(m)
    
    dx, dy, dz, mass2 = d.distancias(x,y,z,m)
    dist = np.sqrt(dx**2 + dy**2 + dz**2 + eps**2)
    
    aux1 = -G * mass2 * dx /dist**3
    aux2 = -G * mass2 * dy /dist**3
    aux3 = -G * mass2 * dz /dist**3
    
    ax = np.sum(aux1, axis=0)
    ay = np.sum(aux2, axis=0)
    az = np.sum(aux3, axis=0)
            
    a = np.ndarray([n,3])
    a[:,0] = ax/m
    a[:,1] = ay/m
    a[:,2] = az/m

    return a

#----------------------------------------------
def epot(eps,x,y,z,m):
    
    G = 4.299e-6
    n = len(m)
      
    dx,dy,dz,mass2 = d.distancias(x,y,z,m)
    
    dist = np.sqrt(dx**2 + dy**2 + dz**2 + eps**2)

    U = G * mass2 / dist
    
    Upot = np.sum(U,axis=0)
    
    return Upot