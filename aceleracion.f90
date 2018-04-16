MODULE aceleracion
    IMPLICIT NONE
    CONTAINS
    !esta subrutina sirve para calcular la energia potencial de las estrellas entre ellas  
    SUBROUTINE a_str(m,x,y,z,n,ax,ay,az)
    INTEGER, INTENT (IN):: n
    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n)
    REAL, INTENT (OUT)  :: ax(n), ay(n), az(n)
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: acx, acy, acz, dx, dy, dz, eps !,dist
    INTEGER             :: i, j      
    
    eps = 0.5

    DO i = 1, n  
        ax(i) = 0.
        ay(i) = 0.
        az(i) = 0.
    END DO
    DO i = 1, n
        DO j = 1, n
            dx = (x(i)-x(j))**2
            dy = (y(i)-y(j))**2
            dz = (z(i)-z(j))**2

            !dist = sqrt(dx+dy+dz)

            IF (i /= j) THEN     
                acx = -G*m(i)*m(j)/(dx**2 + eps**2)
                ax(i) = acx + ax(i)

                acy = -G*m(i)*m(j)/(dy**2 + eps**2)
                ay(i) = acy + ay(i)

                acz = -G*m(i)*m(j)/(dz**2 + eps**2)
                az(i) = acz + az(i)


            END IF
        END DO
    END DO
    END SUBROUTINE
END MODULE
