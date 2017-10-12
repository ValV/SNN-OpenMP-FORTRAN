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

            REAL, DIMENSION(3, 4) :: X ! Input matrix
            REAL, DIMENSION(1, 4) :: Y ! Output vector
            REAL, DIMENSION(1, 3) :: SYNAPSE_0
            REAL, DIMENSION(3, 4) :: LAYER_0
            REAL, DIMENSION(1, 4) :: LAYER_1
            REAL, DIMENSION(1, 4) :: LAYER_1_ERROR
            REAL, DIMENSION(1, 4) :: LAYER_1_DELTA

            X = RESHAPE((/0, 0, 1, 0,&
                          1, 1, 1, 0,&
                          1, 1, 1, 1/), SHAPE(X))
            Y = RESHAPE((/0, 0, 1, 1/), SHAPE(Y))

            CALL RANDOM_NUMBER(SYNAPSE_0) ! Initialize synapse

            WRITE (*, *) "Input data:"
            CALL SNN_PRINT(X)

            WRITE (*, *) "Output data:"
            CALL SNN_PRINT(Y)

            WRITE (*, *) "Synapse:"
            CALL SNN_PRINT(SYNAPSE_0)

      END PROGRAM SNN

! vim: set et ts=6 sw=6:
