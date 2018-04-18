MODULE test
    IMPLICIT NONE
    CONTAINS
    
    SUBROUTINE algo(n,x)
    INTEGER, INTENT (IN) :: n
    INTEGER, INTENT (OUT) :: x
!f2py INTENT (IN) :: n
!f2py INTENT (OUT) :: x
    INTEGER :: i
    x = 0
        
    DO i = 1, n
        x  = x + 5
    END DO
    
    END SUBROUTINE
END MODULE
    