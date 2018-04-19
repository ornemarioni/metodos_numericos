import numpy as np
import aceleraciones as ac

def euler(eps,dt,nit,m,pos,vel,acel):
    
    for i in range(0,nit):
        pos = pos + vel*dt
        vel = vel + acel*dt
        acel = ac.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        
    return pos, vel, acel