MODULE integradores2
    IMPLICIT NONE
    CONTAINS
    
    !esta subrutina sirve para calcular la energia potencial de las estrellas entre ellas  
    SUBROUTINE a_str(eps,m,x,y,z,n,ax,ay,az)
    INTEGER, INTENT (IN):: n
    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n), eps
    REAL, INTENT (OUT)  :: ax(n), ay(n), az(n)
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: acx, acy, acz, dx, dy, dz,dist
    INTEGER             :: i, j      
   

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

!----------------------------------------------------------------------

    !Integrador tipo EULER
    SUBROUTINE euler(n,h,x,y,z,vx,vy,vz,ax,ay,az)
    !euler(n,h,nit,m,eps,x,y,z,vx,vy,vz,ax,ay,az)
    INTEGER, INTENT (IN):: n,h
    REAL, INTENT (INOUT):: x(n), y(n), z(n)
    REAL, INTENT (INOUT):: vx(n), vy(n), vz(n)
    REAL, INTENT (INOUT):: ax(n), ay(n), az(n)
    REAL, DIMENSION (n) :: xx, yy, zz, vxx, vyy, vzz 
    INTEGER             :: i      
    
    !DO j = 1,nit
    DO i = 1,n
        xx(i) = 0.
        yy(i) = 0.
        zz(i) = 0.
        
        vxx(i) = 0.
        vyy(i) = 0.
        vzz(i) = 0.
     END DO

        DO i = 1,n
            
            xx(i) = x(i) + vx(i)*h
            yy(i) = y(i) + vy(i)*h
            zz(i) = z(i) + vz(i)*h
        
            vxx(i) = vx(i) + ax(i)*h
            vyy(i) = vy(i) + ay(i)*h
            vzz(i) = vz(i) + az(i)*h

            x(i) = xx(i)
            y(i) = yy(i)
            z(i) = zz(i)
            
            vx(i) = vxx(i)
            vy(i) = vyy(i)
            vz(i) = vzz(i)
        
        !CALL a_str(m,x,y,z,n,eps,ax,ay,az)
        
        END DO
    !END DO
    END SUBROUTINE
END MODULE    
    !integrador tipo RUNGE-KUTTA
!    SUBROUTINE rk(m,x,y,z,n,ax,ay,az)
!    INTEGER, INTENT (IN):: n
!    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n)
!    REAL, INTENT (OUT)  :: ax(n)
!    REAL, INTENT (OUT)  :: ay(n) 
!    REAL, INTENT (OUT)  :: az(n)
!    REAL, PARAMETER     :: G = 4.299e-6
!   REAL                :: acx, acy, acz, dx, dy, dz, eps !,dist
!    INTEGER             :: i, j      
    
