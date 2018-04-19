MODULE aceleracion
    IMPLICIT NONE
    CONTAINS

!aceleracion
    SUBROUTINE ac(eps,m,x,y,z,n,ax,ay,az)
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
    
    DO i = 1, n-1
        DO j = i+1, n
            dx = (x(j)-x(i))
            dy = (y(j)-y(i))
            dz = (z(j)-z(i))

            dist = sqrt(dx**2+dy**2+dz**2)
            
            acx = G * m(j) * dx / (dist**2 + eps**2)**(3/2.)
            ax(i) = acx + ax(i)
        
            acy = G * m(j) * dy / (dist**2 + eps**2)**(3/2.)
            ay(i) = acy + ay(i)

            acz = G * m(j) * dz / (dist**2 + eps**2)**(3/2.)
            az(i) = acz + az(i)

        END DO
    END DO
    END SUBROUTINE
    
!----------------------------------------------------------------------------------------
!calcula la energia potencial
    
    SUBROUTINE epot(eps,m,x,y,z,n,u)
    INTEGER, INTENT (IN):: n
    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n), eps
    REAL, INTENT (OUT)  :: u(n)
!f2py INTENT (HIDE)     :: n
!f2py INTENT (IN)       :: x, y, z , m, eps
!f2py INTENT (OUT)      :: u
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: dx, dy, dz, dist, aux
    INTEGER             :: i, j   
    
    DO i = 1, n
        u(i) = 0
    END DO
    
    DO i = 1, n-1
        DO j = i+1, n
        
            dx = (x(j)-x(i))
            dy = (y(j)-y(i))
            dz = (z(j)-z(i))

            dist = sqrt(dx**2 + dy**2 + dz**2 + eps**2)
                
            aux = G*m(j)*m(i) / dist**2
            u(i) = aux + u(i)

        END DO
    END DO
    END SUBROUTINE
    
END MODULE
