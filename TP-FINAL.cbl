       IDENTIFICATION DIVISION.
       PROGRAM-ID. TPFINAL.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT NOVEDADES ASSIGN TO 'NOVEDADES.TXT'
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-FS-NOVED.

       SELECT CLIENTES ASSIGN TO 'CLIENTES.TXT'
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-FS-CLIENT.

       SELECT SALIDA ASSIGN TO "SALIDA.TXT"
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS WS-FS-SAL.
       DATA DIVISION.
       FILE SECTION.

       FD  NOVEDADES
           BLOCK CONTAINS 0 RECORDS
           RECORDING MODE IS F.
       01  REG-NOVEDADES     PIC X(44).

       FD  CLIENTES
           BLOCK CONTAINS 0 RECORDS
           RECORDING MODE IS F.
       01  REG-CLIENTES      PIC X(43).

       FD  SALIDA
           BLOCK CONTAINS 0 RECORDS
           RECORDING MODE IS F.
       01  REG-SALIDA          PIC X(43).

       WORKING-STORAGE SECTION.
            77 FILLER                     PIC X(20) VALUE
                                               "WORKING-STORAGE".
            77  WS-FS-NOVED               PIC XX    VALUE SPACES.
            77  WS-FS-CLIENT              PIC XX    VALUE SPACES.
            77  WS-FS-SAL                 PIC XX    VALUE SPACES.

           01  WS-REG-NOVEDADES.
               03 WS-NOV-TIPO-DOC         PIC X(02) VALUE SPACES.
               03 WS-NOV-DOC              PIC X(11) VALUE SPACES.
               03 WS-NOV-NOMBRE           PIC X(30) VALUE SPACE.
               03 WS-NOV-TIPO             PIC X     VALUE SPACE.

           01  WS-REG-CLIENTES.
               03 WS-CLI-TIPO-DOC         PIC X(02) VALUE SPACES.
               03 WS-CLI-DOC              PIC X(11) VALUE SPACES.
               03 WS-CLI-NOMBRE           PIC X(30) VALUE SPACE.

           01 WS-CLIENT-EXIST             PIC X     VALUE 'N'.
           01 WS-CANT-CLIENT              PIC 9(5)  VALUE ZERO.
           01 WS-CANT-NOVED               PIC 9(5)  VALUE ZERO.
           01 WS-CANT-ALTA                PIC 9(5)  VALUE ZERO.
           01 WS-CANT-BAJA                PIC 9(5)  VALUE ZERO.
           01 WS-CANT-MODIF               PIC 9(5)  VALUE ZERO.
           01 WS-CANT-ERROR               PIC 9(5)  VALUE ZERO.
           01 WS-CANT-REG-SAL             PIC 9(5)  VALUE ZERO.
      *************************************************************************
      *                        PROCEDURE DIVISION                             *
      *************************************************************************

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
             PERFORM 100000-I-INICIO   THRU 100000-F-INICIO.
             PERFORM 200000-I-PROCESO  THRU 200000-F-PROCESO
                 UNTIL WS-FS-NOVED = '10' OR WS-FS-CLIENT = '10'
             PERFORM 999999-I-FIN      THRU 999999-F-FIN.
       END-MAIN-PROGRAM.
            GOBACK.

       100000-I-INICIO.
           OPEN INPUT NOVEDADES.
           IF WS-FS-NOVED IS NOT EQUAL '00'
              DISPLAY '* ERROR EN OPEN ENTRADA = ' WS-FS-NOVED
              GOBACK.

           OPEN INPUT CLIENTES.
           IF WS-FS-CLIENT IS NOT EQUAL '00'
              DISPLAY '* ERROR EN OPEN ENTRADA = ' WS-FS-CLIENT
              GOBACK.

           OPEN OUTPUT SALIDA.
           IF WS-FS-SAL IS NOT EQUAL '00'
              DISPLAY '* ERROR EN OPEN SALIDA = ' WS-FS-SAL
              GOBACK.
.
       100000-F-INICIO. EXIT.

       200000-I-PROCESO.
                EVALUATE WS-NOV-TIPO
                    WHEN 'A'
                        PERFORM 200002-I-PROCESAR-ALTA THRU
                           200002-F-PROCESAR-ALTA
                    WHEN 'B'
                        PERFORM 200003-I-PROCESAR-BAJA THRU
                           200003-F-PROCESAR-BAJA
                    WHEN 'M'
                        PERFORM 200004-I-PROCESAR-MODIFICACION THRU
                         200004-F-PROCESAR-MODIFICACION
                    WHEN OTHER
                        ADD 1 TO WS-CANT-ERROR
                        DISPLAY "ERROR: TIIPO DE NOVEDAD NO VALIDO"
                 END-EVALUATE.
       200000-F-PROCESO.EXIT.

       200002-I-PROCESAR-ALTA.

           IF WS-CLIENT-EXIST = 'N'
               WRITE REG-SALIDA
               ADD 1 TO WS-CANT-ALTA
               ADD 1 TO WS-CANT-REG-SAL
           ELSE
               DISPLAY "ERROR CLIENTE EXISTENTE"
           END-IF.
       200002-F-PROCESAR-ALTA.EXIT.

       200003-I-PROCESAR-BAJA.

           IF WS-CLIENT-EXIST = 'Y'
             ADD 1 TO WS-CANT-BAJA
           ELSE
             DISPLAY "ERROR:CLIENTE NO ENCONTRADO"
           END-IF.
       200003-F-PROCESAR-BAJA.EXIT.

       200004-I-PROCESAR-MODIFICACION.

       200004-F-PROCESAR-MODIFICACION.EXIT.

       999999-I-FIN.
           DISPLAY "CANTIDAD REGISTROS DE CLIENTES: " WS-CANT-CLIENT
           DISPLAY "CANTIDAD NOVEDADES: " WS-CANT-NOVED
           DISPLAY "CANTIDAD ALTAS: " WS-CANT-ALTA
           DISPLAY "CANTIDAD BAJAS: " WS-CANT-BAJA
           DISPLAY "CANTIDAD MODIFICACIONES: " WS-CANT-MODIF
           DISPLAY "CANTIDAD DE ERRORES: " WS-CANT-ERROR
           DISPLAY "CANTIDAD REGISTROS DE SALIDA: " WS-CANT-REG-SAL

           CLOSE NOVEDADES
              IF WS-FS-NOVED IS NOT EQUAL '00'
                DISPLAY '* ERROR EN CLOSE NOVEDADES = '
                                            WS-FS-NOVED
             END-IF.

           CLOSE  CLIENTES
              IF WS-FS-CLIENT IS NOT EQUAL '00'
                DISPLAY '* ERROR EN CLOSE CLIENTES   ='
                                            WS-FS-CLIENT
           END-IF.

           CLOSE  SALIDA
              IF WS-FS-SAL IS NOT EQUAL '00'
                DISPLAY '* ERROR EN CLOSE PRECIO   ='
                                            WS-FS-SAL
           END-IF.

       999999-F-FIN.
           EXIT.
       END PROGRAM TPFINAL.
