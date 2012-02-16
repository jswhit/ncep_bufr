      FUNCTION IUPBS1(MBAY,NBYT)

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    IUPBS1
C   PRGMMR: ATOR             ORG: NP12       DATE: 2003-11-04
C
C ABSTRACT: THIS FUNCTION UNPACKS AND RETURNS THE BINARY INTEGER WORD
C   CONTAINED WITHIN BYTE NBYT OF SECTION 1 (OR BYTE 8 OF SECTION 0,
C   IF NBYT = 0) OF THE BUFR MESSAGE STORED IN ARRAY MBAY.  THE START
C   OF THE BUFR MESSAGE (I.E., THE STRING "BUFR") MUST BE ALIGNED ON
C   THE FIRST FOUR BYTES OF MBAY.  NOTE THAT THIS FUNCTION IS CONSIDERED
C   OBSOLETE AND MAY BE REMOVED FROM THE BUFR ARCHIVE LIBRARY IN A
C   FUTURE VERSION; USERS SHOULD INSTEAD MIGRATE TO THE USE OF BUFR
C   ARCHIVE LIBRARY FUNCTION IUPBS01.
C
C PROGRAM HISTORY LOG:
C 2003-11-04  J. ATOR    -- ORIGINAL AUTHOR (WAS IN DECODER VERSION)
C 2003-11-04  S. BENDER  -- ADDED REMARKS/BUFRLIB ROUTINE
C                           INTERDEPENDENCIES
C 2003-11-04  D. KEYSER  -- UNIFIED/PORTABLE FOR WRF
C 2004-08-18  J. ATOR    -- REMOVED IFIRST CHECK, SINCE WRDLEN NOW
C                           KEEPS TRACK OF WHETHER IT HAS BEEN CALLED
C 2005-11-29  J. ATOR    -- MARKED AS OBSOLETE
C
C USAGE:    IUPBS1 (MBAY, NBYT)
C   INPUT ARGUMENT LIST:
C     MBAY     - INTEGER: *-WORD PACKED BINARY ARRAY CONTAINING BUFR
C                MESSAGE
C     NBYT     - INTEGER: BYTE TO UNPACK WITHIN SECTION 1 OF BUFR MSG
C                       0 = UNPACK BYTE 8 OF SECTION 0
C
C   OUTPUT ARGUMENT LIST:
C     IUPBS1   - INTEGER: UNPACKED INTEGER WORD
C
C REMARKS:
C    THIS ROUTINE CALLS:        ERRWRT   IUPB     WRDLEN
C    THIS ROUTINE IS CALLED BY: IUPVS1
C                               Also called by application programs.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  PORTABLE TO ALL PLATFORMS
C
C$$$

      COMMON /QUIET / IPRT

      DIMENSION MBAY(*)

      CHARACTER*128 ERRSTR

      DATA IFIRST/0/

      SAVE IFIRST

C-----------------------------------------------------------------------
C-----------------------------------------------------------------------

      IF(IFIRST.EQ.0) THEN

         IFIRST = 1

         IF(IPRT.GE.0) THEN
      CALL ERRWRT('++++++++++++++BUFR ARCHIVE LIBRARY+++++++++++++++++')
      ERRSTR = 'BUFRLIB: IUPBS1 - THIS FUNCTION IS NOW OBSOLETE;'//
     . ' USE FUNCTION IUPBS01 INSTEAD'
      CALL ERRWRT(ERRSTR)
      CALL ERRWRT('++++++++++++++BUFR ARCHIVE LIBRARY+++++++++++++++++')
      CALL ERRWRT(' ')
         ENDIF

      ENDIF

C     CALL SUBROUTINE WRDLEN TO INITIALIZE SOME IMPORTANT INFORMATION
C     ABOUT THE LOCAL MACHINE, JUST IN CASE SUBROUTINE OPENBF HASN'T
C     BEEN CALLED YET.

      CALL WRDLEN

C     NOTE THAT THERE ARE 8 BYTES WITHIN SECTION 0 THAT MUST BE SKIPPED.

      IUPBS1 = IUPB(MBAY,NBYT+8,8)

      RETURN
      END
