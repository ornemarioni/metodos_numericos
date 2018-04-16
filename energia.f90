MODULE aceleracion
    IMPLICIT NONE
    CONTAINS
    !esta subrutina sirve para calcular la energia potencial de las estrellas entre ellas  
    SUBROUTINE a_str(m,x,y,z,n,a)
    INTEGER, INTENT (IN):: n
    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n)
    REAL, INTENT (OUT)  :: a(n)
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: aux, dist, dx, dy, dz, eps
    INTEGER             :: i, j      
    
    ep = 0.5

    DO i = 1, n  
        a(i) = 0.
    END DO
    DO i = 1, n
        DO j = 1, n
            dx = (x(i)-x(j))**2
            dy = (y(i)-y(j))**2
            dz = (z(i)-z(j))**2
            dist = sqrt(dx+dy+dz)

            IF (i /= j) THEN     
                   aux = G*m(i)*m(j)/(dist**2 + eps**2)
                   a(i) = aux + a(i) 
            END IF
        END DO
    END DO
    END SUBROUTINE
END MODULE
