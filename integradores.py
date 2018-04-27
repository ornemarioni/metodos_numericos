import numpy as np
import fuerza as fz

def euler(eps,dt,nit,m,pos,vel,acel):
    
    path = '/home/omarioni/metodos_numericos/_data/P2C/euler/'
    
    for i in np.arange(nit):
        
        vel = vel + acel*dt
        pos = pos + vel*dt
        acel = fz.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        
        if i in np.arange(0,nit,10):
            
            np.savetxt(path+'posiciones'+str('%s'%i)+'.dat',pos,fmt='%12.6f')
            np.savetxt(path+'velocidades'+str('%s'%i)+'.dat',vel,fmt='%12.6f')
            np.savetxt(path+'aceleraciones'+str('%s'%i)+'.dat',acel,fmt='%12.6f')
        
    return pos, vel, acel

#--------------------------------------------------------------------------------

def rungek(eps,dt,nit,m,pos,vel,acel):
    #path = '/home/users/valeria/metodos_numericos/_data/runge/'
    path = '/home/omarioni/metodos_numericos/_data/P2C/runge/'
       
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
    
        acel = fz.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        
        if i in np.arange(0,nit,10):
            
            np.savetxt(path + 'posiciones'+str('%s'%i)+'.dat',pos,fmt='%12.6f')
            np.savetxt(path +'velocidades'+str('%s'%i)+'.dat',vel,fmt='%12.6f')
            #np.savetxt(path +'aceleraciones'+str('%s'%i)+'.dat',acel,fmt='%12.6f')    
    
    return pos, vel, acel

#---------------------------------------------------------------------------------------

def DKD(eps,dt,nit,m,pos,vel,acel):

    #path = '/home/users/valeria/metodos_numericos/_data/DKD/'
    #path = '/home/ornela/metodos_numericos/_data/DKD/'
    path = '/home/omarioni/metodos_numericos/_data/P2C/DKD/'
    
    for i in np.arange(nit):
        pos  = pos + vel*dt*0.5
        acel = fz.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        vel  = vel + acel*dt
        pos  = pos + vel*dt*0.5
        
        
        if i in np.arange(0,nit,10):
            
            np.savetxt(path+'posiciones'+str('%s'%i)+'.dat',pos,fmt='%12.6f')
            np.savetxt(path+'velocidades'+str('%s'%i)+'.dat',vel,fmt='%12.6f')
            #np.savetxt(path+'aceleraciones'+str('%s'%i)+'.dat',acel,fmt='%12.6f')
        
    return pos, vel, acel

#-------------------------------------------------------------------------------

def KDK(eps,dt,nit,m,pos,vel,acel):
    
    #path = '/home/users/valeria/metodos_numericos/_data/KDK/'
    #path = '/home/ornela/metodos_numericos/_data/KDK/'
    path = '/home/omarioni/metodos_numericos/_data/P2C/KDK/'
        
    for i in np.arange(nit):
        vel  = vel + acel*dt*0.5
        pos  = pos + vel*dt
        acel = fz.aceleraciones(eps,pos[:,0],pos[:,1],pos[:,2],m)
        vel  = vel + acel*dt*0.5
        
        
        
        if i in np.arange(0,nit,10):
            
            np.savetxt(path+'posiciones'+str('%s'%i)+'.dat',pos,fmt='%12.6f')
            np.savetxt(path+'velocidades'+str('%s'%i)+'.dat',vel,fmt='%12.6f')
            #np.savetxt(path+'aceleraciones'+str('%s'%i)+'.dat',acel,fmt='%12.6f')
        
    return pos, vel, acel