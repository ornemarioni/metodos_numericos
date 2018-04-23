import numpy as np
import aceleraciones as ac

def DKD(eps,dt,nit,m,pos,vel,acel):

    path = '/home/users/valeria/metodos_numericos/_data/DKD/'
    
    pos[:,0] = pos[:,0] + vel[:,0]*dt*0.5
    pos[:,1] = pos[:,1] + vel[:,1]*dt*0.5
    pos[:,2] = pos[:,2] + vel[:,2]*dt*0.5

    for i in np.arange(nit):
        
        vel += acel*dt
        pos += vel*dt*0.5
        acel = ac.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        
        if i in np.arange(0,nit,10):
            
            np.savetxt(path+'posiciones'+str('%s'%i)+'.dat',pos,fmt='%12.6f')
            np.savetxt(path+'velocidades'+str('%s'%i)+'.dat',vel,fmt='%12.6f')
            np.savetxt(path+'aceleraciones'+str('%s'%i)+'.dat',acel,fmt='%12.6f')
        
    return pos, vel, acel

#-------------------------------------------------------------------------------

def KDK(eps,dt,nit,m,pos,vel,acel):
    
    path = '/home/users/valeria/metodos_numericos/_data/KDK/'
    
    vel[:,0] = vel[:,0] + acel[:,0]*dt*0.5
    vel[:,1] = vel[:,1] + acel[:,1]*dt*0.5
    vel[:,2] = vel[:,2] + acel[:,2]*dt*0.5
        
    for i in np.arange(nit):
        
        pos += vel*dt*0.5
        acel = ac.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        vel += acel*dt
        
        
        
        if i in np.arange(0,nit,10):
            
            np.savetxt(path+'posiciones'+str('%s'%i)+'.dat',pos,fmt='%12.6f')
            np.savetxt(path+'velocidades'+str('%s'%i)+'.dat',vel,fmt='%12.6f')
            np.savetxt(path+'aceleraciones'+str('%s'%i)+'.dat',acel,fmt='%12.6f')
        
    return pos, vel, acel