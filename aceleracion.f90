MODULE aceleracion
    IMPLICIT NONE
    CONTAINS
    !esta subrutina sirve para calcular la energia potencial de las estrellas entre ellas  
    SUBROUTINE a_str(m,x,y,z,n,ax,ay,az)
    INTEGER, INTENT (IN):: n
    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n)
    REAL, INTENT (OUT)  :: ax(n), ay(n), az(n)
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: acx, acy, acz, dx, dy, dz, eps ,dist
    INTEGER             :: i, j      
    
    eps = 0.5

    DO i = 1, n  
        ax(i) = 0.
        ay(i) = 0.
        az(i) = 0.
    END DO
    DO i = 1, n
        DO j = 1, n
            dx = (x(j)-x(i))
            dy = (y(j)-y(i))
            dz = (z(j)-z(i))

            dist = sqrt(dx**2+dy**2+dz**2)

            IF (i /= j) THEN     
                acx = G*m(j)*dx/(dist**2 + eps**2)**(3/2.)
                ax(i) = acx + ax(i)

                acy = G*m(j)*dy/(dist**2 + eps**2)**(3/2.)
                ay(i) = acy + ay(i)

                acz = G*m(j)*dz/(dist**2 + eps**2)**(3/2.)
                az(i) = acz + az(i)


            END IF
        END DO
    END DO
    END SUBROUTINE
END MODULE
