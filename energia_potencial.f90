MODULE energia_potencial
    IMPLICIT NONE
    CONTAINS
    !esta subrutina sirve para calcular la energia potencial de las estrellas entre ellas  
    SUBROUTINE ep_str(m,x,y,z,n,p)
    INTEGER, INTENT (IN):: n
    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n)
    REAL, INTENT (OUT)  :: p(n)
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: aux, dist, dx, dy, dz
    INTEGER             :: i, j      
    
    
    DO i = 1, n  
        p(i) = 0.
    END DO
    DO i = 1, n
        DO j = 1, n
            dx = (x(i)-x(j))**2
            dy = (y(i)-y(j))**2
            dz = (z(i)-z(j))**2
            dist = sqrt(dx+dy+dz)
            IF (i /= j .AND. dist /=0. ) THEN     
                   aux = G*m(i)*m(j)*1.e20/dist
                   p(i) = aux + p(i) 
            END IF
        END DO
    END DO
    END SUBROUTINE
!---------------------------------------------------------------------------------------------------------------------    
    !esta subrutina sirve para calcular la energia potencial de las estrellas con otras part, ya sea gas o drk
    SUBROUTINE ep_part(m_str, m_part ,x_str, y_str, z_str, x_part, y_part, z_part, n_str, n_part, p)
    INTEGER, INTENT (IN):: n_str, n_part
    REAL, INTENT (IN)   :: x_str(n_str), y_str(n_str), z_str(n_str), m_str(n_str)
    REAL, INTENT (IN)   :: x_part(n_part), y_part(n_part), z_part(n_part), m_part(n_part)
    REAL, INTENT (OUT)  :: p(n_str)
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: aux, dist, dx, dy, dz
    INTEGER             :: i, j      
    
    
    DO i = 1, n_str
        p(i) = 0.
    END DO
    DO i = 1, n_str
        DO j = 1, n_part
            dx = (x_str(i)-x_part(j))**2
            dy = (y_str(i)-y_part(j))**2
            dz = (z_str(i)-z_part(j))**2
            dist = sqrt(dx+dy+dz)
            IF ( dist /=0. ) THEN     
                   aux = G*m_str(i)*m_part(j)*1.e20/dist
                   p(i) = aux + p(i) 
            END IF
        END DO
    END DO
    END SUBROUTINE
END MODULE
    
            
            
