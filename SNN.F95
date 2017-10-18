! This is a simple neural network
!23456789

      MODULE SNN_ROUTINES

            IMPLICIT NONE

            CONTAINS

            ! Column-to-row-wise matrix display function
            SUBROUTINE SNN_PRINT(MATRIX)
                  ! MATRIX is an automatic array
                  REAL, INTENT(IN) :: MATRIX(:, :)
                  INTEGER :: ROW
                  DO ROW = 1, SIZE(MATRIX, 2)
                        WRITE (*, *) MATRIX(:, ROW)
                  END DO
            END SUBROUTINE SNN_PRINT

            ! Sigmoid function (also returns derivative)
            PURE FUNCTION SNN_SIGMA(X, DERIV) RESULT(Y)
                  REAL, INTENT(IN) :: X(:, :)
                  LOGICAL, OPTIONAL, INTENT(IN) :: DERIV
                  REAL,& ! Output array has the same dimension as X
                  DIMENSION(LBOUND(X, DIM = 1):UBOUND(X, DIM = 1),&
                            LBOUND(X, DIM = 2):UBOUND(X, DIM = 2)) :: Y
                  IF (.NOT. PRESENT(DERIV) .OR. .NOT. DERIV) THEN
                        ! Return sigmoid
                        Y = 1 / (1 + EXP(-1 * X))
                  ELSE
                        ! Return derivative
                        Y = X * (1 - X)
                  END IF
            END FUNCTION SNN_SIGMA

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
            INTEGER :: I

            X = RESHAPE((/0, 0, 1, 0,&
                          1, 1, 1, 0,&
                          1, 1, 1, 1/), SHAPE(X))
            Y = RESHAPE((/0, 0, 1, 1/), SHAPE(Y))

            CALL RANDOM_NUMBER(SYNAPSE_0) ! Initialize synapse
            SYNAPSE_0 = SYNAPSE_0 * 2 - 1 ! Normalize towards 0 

            WRITE (*, *) "Input data:"
            CALL SNN_PRINT(X)

            WRITE (*, *) "Output data:"
            CALL SNN_PRINT(Y)

            WRITE (*, *) "Synapse:"
            CALL SNN_PRINT(SYNAPSE_0)

            ! Use BLAS library to mutiply matrices (link with -lblas)
            ! trans A, trans B, rows A & C, cols B & C, cols A & rows B
            ! alpha (A x B), A, N: rows A | cols A, B, N: rows B | cols B
            ! beta (C), C, rows A & C
            !CALL SGEMM('T', 'T', 4, 1, 3,&
            !           1.0, X, 3, SYNAPSE_0, 1,&
            !           0.0, LAYER_1, 4)
            !WRITE (*, *) "Multiplication:"
            !CALL SNN_PRINT(LAYER_1)

            ! TODO: wrap routines below into a cycle (6-10K iterations)
            DO I = 1, 10000
                  ! Layer 0 -> layer 1
                  LAYER_1 = SNN_SIGMA(MATMUL(SYNAPSE_0, X)) ! X is layer 0
                  !WRITE (*, *) "Layer 1 (sigma (layer 0, synapse 0)):"
                  !CALL SNN_PRINT(LAYER_1)

                  ! Error rate
                  LAYER_1_ERROR = Y - LAYER_1
                  !WRITE (*, *) "Layer 1 Error rate:"
                  !CALL SNN_PRINT(LAYER_1_ERROR)

                  ! Difference
                  LAYER_1_DELTA = LAYER_1_ERROR * SNN_SIGMA(LAYER_1, .TRUE.)
                  !WRITE (*, *) "Layer 1 Delta difference:"
                  !CALL SNN_PRINT(LAYER_1_DELTA)

                  ! Update synapse 0
                  SYNAPSE_0 = SYNAPSE_0 + MATMUL(LAYER_1_DELTA, TRANSPOSE(X))
                  !WRITE (*, *) "Synapse 0 updated:"
                  !CALL SNN_PRINT(SYNAPSE_0)

            END DO

            ! Display results
            WRITE (*, *) "Layer 1 (sigma (layer 0, synapse 0)):"
            CALL SNN_PRINT(LAYER_1)

            !WRITE (*, *) "Layer 1 Error rate:"
            !CALL SNN_PRINT(LAYER_1_ERROR)

            !WRITE (*, *) "Layer 1 Delta difference:"
            !CALL SNN_PRINT(LAYER_1_DELTA)

            !WRITE (*, *) "Synapse 0 (updated):"
            !CALL SNN_PRINT(SYNAPSE_0)

      END PROGRAM SNN

! vim: set et ts=6 sw=6:
