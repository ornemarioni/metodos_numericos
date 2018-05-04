MODULE integradores
    IMPLICIT NONE
    CONTAINS
    
!aceleracion
    SUBROUTINE a_str(eps,m,x,y,z,n,ax,ay,az)
    
    USE OMP_LIB
    
    INTEGER, INTENT (IN):: n
    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n), eps
    REAL, INTENT (OUT)  :: ax(n), ay(n), az(n)
!f2py INTENT (HIDE)     :: n
!f2py INTENT (IN)       :: x, y, z , m, eps
!f2py INTENT (OUT)      :: ax, ay, az
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: acx, acy, acz, dx, dy, dz, dist
    INTEGER             :: i, j      
   

    DO i = 1, n  
        ax(i) = 0.
        ay(i) = 0.
        az(i) = 0.
    END DO
      
      

!$OMP PARALLEL DEFAULT(NONE) &
!$OMP SHARED (n,x,y,z,eps,m,ax,ay,az,j) &
!$OMP PRIVATE(i,dx,dy,dz,dist,acx,acy,acz)
!$OMP DO SCHEDULE(DYNAMIC)


    DO i = 1, n
        DO j = 1, n
            dx = (x(j)-x(i))
            dy = (y(j)-y(i))
            dz = (z(j)-z(i))

            dist = sqrt(dx**2+dy**2+dz**2)

            IF (i /= j) THEN     
                acx = G * m(j) * dx / (dist**2 + eps**2)**(3/2.)
                ax(i) = acx + ax(i)

                acy = G * m(j) * dy / (dist**2 + eps**2)**(3/2.)
                ay(i) = acy + ay(i)

                acz = G * m(j) * dz / (dist**2 + eps**2)**(3/2.)
                az(i) = acz + az(i)


            END IF
        END DO
    END DO
    
!$OMP END DO
!$OMP END PARALLEL

    END SUBROUTINE

!----------------------------------------------------------------------

!Integrador tipo EULER
    SUBROUTINE euler(eps,dt,nit,m,x,y,z,vx,vy,vz,ax,ay,az,n)
    !euler(n,h,nit,m,eps,x,y,z,vx,vy,vz,ax,ay,az)
    
    INTEGER             :: i, j 
    INTEGER, INTENT (IN):: n, nit
    REAL, INTENT (IN)   :: dt, eps, m(n)
    REAL, INTENT (INOUT):: x(n), y(n), z(n)
    REAL, INTENT (INOUT):: vx(n), vy(n), vz(n)
    REAL, INTENT (INOUT):: ax(n), ay(n), az(n)
!f2py INTENT (HIDE)  :: n
!f2py INTENT(IN,OUT) :: x(n), y(n), z(n)
!f2py INTENT(IN,OUT) :: vx(n), vy(n), vz(n)
!f2py INTENT(IN,OUT) :: ax(n), ay(n), az(n)


    DO j = 1,nit

        DO i = 1,n
            
            x(i) = x(i) + vx(i)*dt
            y(i) = y(i) + vy(i)*dt
            z(i) = z(i) + vz(i)*dt

        
            vx(i) = vx(i) + ax(i)*dt
            vy(i) = vy(i) + ay(i)*dt
            vz(i) = vz(i) + az(i)*dt
            
        END DO
        
        CALL a_str(eps,m,x,y,z,n,ax,ay,az)
        
    END DO
    END SUBROUTINE
    
!---------------------------------------------------------------
    
!Integrador tipo RUNGEKUTTA
    SUBROUTINE rungek(eps,dt,nit,m,x,y,z,vx,vy,vz,ax,ay,az,n)
    
    INTEGER             :: i, j
    REAL                :: k1, k2, k3, k4
    INTEGER, INTENT (IN):: n, nit
    REAL, INTENT (IN)   :: dt, eps, m(n)
    REAL, INTENT (INOUT):: x(n), y(n), z(n)
    REAL, INTENT (INOUT):: vx(n), vy(n), vz(n)
    REAL, INTENT (INOUT):: ax(n), ay(n), az(n)
!f2py INTENT (HIDE)  :: n
!f2py INTENT(IN,OUT) :: x(n), y(n), z(n)
!f2py INTENT(IN,OUT) :: vx(n), vy(n), vz(n)
!f2py INTENT(IN,OUT) :: ax(n), ay(n), az(n)
    
    DO j = 1,nit

        DO i = 1,n
            
            k1   = vx(i)
            k2   = vx(i) + k1 * dt/2.
            k3   = vx(i) + k2 * dt/2.
            k4   = vx(i) + k3 * dt
            x(i) = x(i)  + dt * (k1/6. + k2/3. + k3/3. + k4/6.)
            
            k1   = vy(i)
            k2   = vy(i) + k1 * dt/2.
            k3   = vy(i) + k2 * dt/2.
            k4   = vy(i) + k3 * dt
            y(i) = y(i)  + dt * (k1/6. + k2/3. + k3/3. + k4/6.)
    
            k1   = vz(i)
            k2   = vz(i) + k1 * dt/2.
            k3   = vz(i) + k2 * dt/2.
            k4   = vz(i) + k3 * dt
            z(i) = z(i)  + dt * (k1/6. + k2/3. + k3/3. + k4/6.)
    
    
            k1    = ax(i)
            k2    = ax(i) + k1 * dt/2.
            k3    = ax(i) + k2 * dt/2.
            k4    = ax(i) + k3 * dt
            vx(i) = vx(i) + dt * (k1/6. + k2/3. + k3/3. + k4/6.)
    
            k1    = ay(i)
            k2    = ay(i) + k1 * dt/2.
            k3    = ay(i) + k2 * dt/2.
            k4    = ay(i) + k3 * dt
            vy(i) = vy(i) + dt * (k1/6. + k2/3. + k3/3. + k4/6.)
    
            k1    = az(i)
            k2    = az(i) + k1 * dt/2.
            k3    = az(i) + k2 * dt/2.
            k4    = az(i) + k3 * dt
            vz(i) = vz(i) + dt * (k1/6. + k2/3. + k3/3. + k4/6.)
            
        END DO
        
        CALL a_str(eps,m,x,y,z,n,ax,ay,az)
        
    END DO
    END SUBROUTINE
    
END MODULE


