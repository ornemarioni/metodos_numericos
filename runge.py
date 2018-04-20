import numpy as np
import aceleraciones as ac

def rungek(eps,h,nit,m,pos,vel,acel):
    
    k2 = np.ndarray([len(m),len(m)])
    k3 = np.ndarray([len(m),len(m)])
    k4 = np.ndarray([len(m),len(m)])
    
    for i in range(0,nit):

    k2 = vel + vel*h/2.
    k3 = vel + k2*h/2.
    k4 = vel + k3*h
    
    pos = pos + h*(vel/6. + k2/3. + k3/3. + k4/6.)
    
    k2 = acel + acel*h/2.
    k3 = acel + k2*h/2.
    k4 = acel + k3*h
    
    vel = vel + h*(acel/6. + k2/3. + k3/3. + k4/6.)

    acel = ac.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
    
    return pos, vel, acel