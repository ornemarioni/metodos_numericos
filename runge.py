import numpy as np
import aceleraciones as ac

def rungek(eps,dt,nit,m,pos,vel,acel):
    #path = '/home/users/valeria/metodos_numericos/_data/runge/'
    path = '/home/omarioni/metodos_numericos/_data/P2C/runge/'
    
    k1 = np.zeros(np.shape(vel))
    k2 = np.zeros(np.shape(vel))
    k3 = np.zeros(np.shape(vel))
    k4 = np.zeros(np.shape(vel))
       
    for i in np.arange(nit):

        k1 = acel
        k2 = acel + k1*dt/2.
        k3 = acel + k2*dt/2.
        k4 = acel + k3*dt
    
        vel = vel + dt*(k1/6. + k2/3. + k3/3. + k4/6.)
        
        k1 = vel
        k2 = vel + k1*dt/2.
        k3 = vel + k2*dt/2.
        k4 = vel + k3*dt
    
        pos = pos + dt*(k1/6. + k2/3. + k3/3. + k4/6.)
    
        acel = ac.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        
        if i in np.arange(0,nit,10):
            
            np.savetxt(path + 'posiciones'+str('%s'%i)+'.dat',pos,fmt='%12.6f')
            np.savetxt(path +'velocidades'+str('%s'%i)+'.dat',vel,fmt='%12.6f')
            #np.savetxt(path +'aceleraciones'+str('%s'%i)+'.dat',acel,fmt='%12.6f')    
    
    return pos, vel, acel