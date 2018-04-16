MODULE integradores
    IMPLICIT NONE
    CONTAINS
    
    !Integrador tipo EULER
    SUBROUTINE euler(W,R,dt)
    INTEGER, INTENT (IN):: n
    REAL, INTENT (INOUT):: x(n), y(n), z(n)
    REAL, INTENT (INOUT):: vx(n), vy(n), vz(n)
    REAL, INTENT (IN)   :: ax(n), ay(n), az(n)
    REAL, INTENT (IN)   :: dt
    INTEGER             :: i      
    

    DO i = 1, n
        
        vx(i) = vx(i) + ax(i)*dt
        vy(i) = vy(i) + ay(i)*dt
        vz(i) = vz(i) + az(i)*dt

        x(i) = x(i) + vx(i)*dt
        y(i) = y(i) + vy(i)*dt
        z(i) = z(i) + vz(i)*dt
    END DO
    END SUBROUTINE
    
    !integrador tipo RUNGE-KUTTA
    SUBROUTINE rk(m,x,y,z,n,ax,ay,az)
    INTEGER, INTENT (IN):: n
    REAL, INTENT (IN)   :: x(n), y(n), z(n), m(n)
    REAL, INTENT (OUT)  :: ax(n)
    REAL, INTENT (OUT)  :: ay(n) 
    REAL, INTENT (OUT)  :: az(n)
    REAL, PARAMETER     :: G = 4.299e-6
    REAL                :: acx, acy, acz, dx, dy, dz, eps !,dist
    INTEGER             :: i, j      
    
SUBROUTINE(w,k,m,r0,g, h)    
real(8), intent(inout), dimension (7) :: w
real(8), intent(in) :: k,m,r0,g,h
real(8), dimension (7) :: k1,k2,k3,k4    
    
k1=w
call funcion(k1,k,m,r0,g,h)
k2=w+0.5d0*h*k1
call funcion(k2,k,m,r0,g,h)
k3=w+0.5d0*h*k2
call funcion(k3,k,m,r0,g,h)
k4=w+h*k3
call funcion(k4,k,m,r0,g,h)
w=w+(h/6d0)*(k1+2d0*k2+2d0*k3+k4)

END SUBROUTINE

subroutine funcion (f,k,m,r0,g, h)
implicit none
real(8), intent(inout), dimension(7) :: f
real(8), intent (in) :: r0,g,h,k,m
real(8), dimension(7):: v
real(8):: r,p
r= dsqrt(f(1)**2+f(2)**2+f(3)**2)
p=k/m
v=f
v(1)=f(4)
v(2)=f(5)
v(3)=f(6)
v(4)=p*f(1)*(-1.d0+(r0/r))
v(5)=p*f(2)*(-1.d0+(r0/r))
v(6)=-g+p*f(3)*(-1.d0+(r0/r))
f=v
end subroutine

