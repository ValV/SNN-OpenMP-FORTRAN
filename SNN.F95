! This is a simple neural network example
!23456789

      MODULE SNN_ROUTINES

            IMPLICIT NONE

            CONTAINS

            SUBROUTINE SNN_PRINT(MATRIX)
                  ! MATRIX is an automatic array
                  REAL, INTENT(IN) :: MATRIX(:, :)
                  INTEGER :: IDX
                  DO IDX = 1, SIZE(MATRIX, 2)
                        WRITE (*, *) MATRIX(:, IDX)
                  END DO
            END SUBROUTINE SNN_PRINT

      END MODULE SNN_ROUTINES

      PROGRAM SNN

            USE SNN_ROUTINES ! Creates interfaces

            IMPLICIT NONE

            REAL, DIMENSION(3, 4) :: X
            X = RESHAPE((/ 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1 /), SHAPE(X))

            WRITE (*, *) "Initial matrix:"
            CALL SNN_PRINT(X)
      END PROGRAM SNN

! vim: set et ts=6 sw=6:
