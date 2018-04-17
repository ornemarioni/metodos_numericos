PROGRAM test

    USE integradores
    
    IMPLICIT NONE
    
    
    
    REAL :: x, y, z, h
    h = 1.
    
    x = 2.
    y = 3.
    z = 4.
    
    CALL euler(h,x,y,z)
    
    WRITE(*,*) x, y, z
END PROGRAM
    