import numpy as np
import aceleraciones as ac

def euler(eps,dt,nit,m,pos,vel,acel):
    
    for i in np.arange(nit):
        
        vel += acel*dt
        pos += vel*dt
        acel = ac.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        
        if i in np.arange(0,nit,10):
            
            np.savetxt('posiciones'+str('%s'%i)+'.dat',pos,fmt='%12.6f')
            np.savetxt('velocidades'+str('%s'%i)+'.dat',vel,fmt='%12.6f')
            np.savetxt('aceleraciones'+str('%s'%i)+'.dat',acel,fmt='%12.6f')
        
    return pos, vel, acel