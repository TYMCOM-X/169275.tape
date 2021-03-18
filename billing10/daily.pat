PROCEDURE DAILY.SESS.UPD.X             % DAISUX.PR2    GD05W0.ME2  08.0

Version 8.0 - July 21, 1981 - L. E. Rickan
   Added code to handle negative TRU data on Paris machines.

Version 7.0 - 16 March 1981 - Patricia Enos Brown
   Data fields pertaining to TRU components eliminated from output
   session records.

Version 6.0     15 October 1979     Natalie Rudnick
AT LABELS DUPCHK, DUPCHK1 AND DUPCHK2 ADDED If tstart = tstop then add .0001
to start, tstop else add .0001 to tstart, TO CORRECT DUPLICATE TSTARTS,
TSTOPS THAT ARE EQUAL.

  Version 5.0 - November 30, 1978 - Jackie Peregoy
    The message to move SR and PS files now includes the running of 
    Royalty first.

  VERSION 4.0 - APRIL 13TH 1978 - BRUCE SHEPHERD
   ADDED NEW CHECKS FOR SESSION PRICING ($1.00 - PER SESSION)
   ADDED FIELDS SESS.CHG, SESS.CHG.CNT, NON.SESS.CHG.CNT
   ADDED NUMBER OF SESSIONS CHARGED AND NUMBER OF SESSIONS NOT CHARGED
     TO SESSION.SUMMARY THAT PRINTS OUT TO TERMINAL
   PROCEDURE WILL NOT CHARGE FOR MULTIPLE PC CHANGES
     BUT WILL CHARGE LAST PC AT LOG-OFF ('Y' IN SESS.CHG INDICATES
     SESSION TO BE CHARGED - 'N' INDICATES PC CHANGE/NO CHARGE FOR SESSION)

  VERSION 3.1 - JULY 15TH 1977 - LEONARD RICKAN
   FIXED DATE BUG IN CKSUM RECORD.

  VERSION 3.0 - JULY 8TH 1977 - LEONARD RICKAN
   CHANGED PROCEDURE TO USE ACCOUNTING DATE FOR DATE IN THE
   CHECKSUM RECORD.

  VERSION 2.1 - FEBRUARY 28TH 1977 - ANVER MEGHJI

  REMOVES BUG THAT WAS CAUSING DUPLICATE SESSIONS ON CAIS

  VERSION 2.0 - JANUARY 17TH, 1977 - ANVER MEGHJI

  MODIFIED TO PROCESS INPUT RECORDS BY UP-TIME GROUPS -
  ON ENCOUNTERING AN UP-TIME REC.TYPE 5, ALL PENDING RECORDS
  IN SUSPENSE ARE CLEARED PRIOR TO FURTHER PROCESSING OF RAW.DATA
  RECORDS

  VERSION 1.0 - DECEMBER 17, 1976 - ANVER MEGHJI
*

  A. CONVERTS STREAM ACCOUNTING DATA INTO SESSION RECORDS
     FOR LOADING TO BILLING HOST - INCLUDES PROJ.CODE CHANGE LOGIC

  B. TRACKS HOST/SESSIONS VIA EXTERNAL FILE SESION.CTL,
     UPDATED AT EVERY RUN. EACH DATA FILE OF THE FORM SRMMDD.HHH CARRIES
     A CHECKSUM RECORD AT THE END, WHICH ALSO CARRIES THE HOST/SESSION
     NUMBERS ASSOCIATED WITH THAT FILE.

  C. THE FIRST RECORD ON EACH FILE IS A RECORD-TYPE 2, WHICH COMPRISES
     DATE OF FILE AND HOST.

  D. B & C ABOVE ARE USED TO CHECK DATA INTEGRITY ON THE BILLING HOST
     PRIOR TO LOADING VIA PROCEDURE SESS.CK.X


%


BEGIN  % 1 - %
   FIELDS
        DUP.FLAG          AS 'C',
        TRAN.TYP          AS 'N',
        HOST.L            SAME AS HOST,
        BILLING.HOST.L    SAME AS HOST,
        BILLING.HOST      SAME AS HOST,
        IN.FIL            SAME AS IN.FNAM,
        OUT.FIL           SAME AS OUT.FNAM,
        STG.FIL           SAME AS IN.FNAM,
        MCS.HIGH          AS '11Z',
        MCS.LOW           SAME AS MCS.HIGH,
        MC.HIGH           SAME AS MCS.HIGH,
        MC.LOW            SAME AS MCS.HIGH,
        TRUS.HIGH         SAME AS MCS.HIGH,
        TRUS.LOW          SAME AS MCS.HIGH,
        PC.SESS           AS 'C',
        DELSUS            AS 'C',
        PCUUN             AS 'C',
        UUNTST            AS '2C',
        FINSEL            AS 'C',
        SESS.ERR          AS 'C',
        ERR.CMNT          AS '13C',
        ERR.CT            AS '10Z',
        UUN.SUM           AS '10Z',
        DP.WORD           AS '11Z',
        TMP.WORD          AS '9Z',
        SESS.CT           AS '5Z',
        FIRST.SESS        AS '7Z',
        LAST.SESS         AS '7Z',
        FIL.DATE          AS DATE'MMDD',
        FIL.DATE.L        SAME AS FIL.DATE,
        DAILY.DATE        AS DATE 'YYMMDD',
        STG.FNAM          SAME AS IN.FNAM,
        SESS.CHG          AS 'C',
        SESS.CHG.CNT      AS '10Z',
        NON.SESS.CHG.CNT  AS '10Z'

SOURCE FILE.CTL FROM 'DAILY.CTL'
  FIXED FORM
  INPUT REC.TYPE,
 CONDITIONAL ON REC.TYPE
  BEGIN  % 2 - %
    1: @TAB TO 3, HOST, @TAB TO 7, BILLING.HOST
    2: @TAB TO 14,STG.FIL,@CR
    3: @TAB TO 3, IN.FIL, @TAB TO 14, OUT.FIL, @TAB TO 16, FIL.DATE,@CR
    4: @TAB TO 3, DAILY.DATE,@CR
  END  % 2 - %

RELATION DUP.CHECK IS

  KEY
      DSTART, TSTART, UUN
  DATA
      JOB

SOURCE CNTRL.FIL FROM 'SESION.CTL'
  FREE FORM
  INPUT FIRST.SESS,LAST.SESS

REPORT FILE.CTL1 TO 'DAILY.CTL-ANY'
  PAGE.SIZE 0
REPORT FILE.CTL2 TO 'DAILY.RUN-ANY'
  PAGE.SIZE 0
REPORT SESS.CNTRL TO 'SESION.CTL-ANY'
  PAGE.SIZE 0

REPORT SESS.FIL TO OUT.FNAM
  PAGE.SIZE 0
  LINE.LENGTH 318
REPORT ERR.FIL TO 'DAILYX.ERR-ANY'
  PAGE.SIZE 0
  LINE.LENGTH 350

  FORMAT RUN.DATE.TIME
    @TAB 3,
    TODAY AS DATE 'MM/DD/YY',
    @TAB 2,
    (TIME/3600) AS '2Z', ":",
    ((TIME-TIME/3600*3600)/60) AS '2N', @CR

SOURCE DAILYX.DATA FROM IN.FNAM
  FIXED FORM
  LINE.LENGTH 290
  INPUT REC.TYPE,JOB,TID,GAN,UUN,
 CONDITIONAL ON REC.TYPE
  BEGIN  % 2 - %

    1: DSTART.X,     % Log-on record - equates type 21 %
       TSTART.X,     % of the binary file YYMMDD.SAT   %
       PROJ.CODE,
       NODE,
       PORT,
       HOST,GROUP.NUM,@CR

    2 OR 3: DSTOP.X, % 2 - Chkpnt record - equates type 22 %
            TSTOP.X, % 3 - Log-off record - equates type 23 %
            LOOKUPS,
            LOOKUPS.SIZE,
            ENTERS.RENAMES.SIZE,
            DISC.BLKS.IN.SIZE,
            DISC.BLKS.OUT.SIZE,
            CIN,
            COUT,
            CNC.SEC.SIZE,
            CNC.SEC,
            BREAK.CHARS.SIZE,
            MCS.HIGH,
            MCS.LOW,
            DISC.BLKS.IN,
            DISC.BLKS.OUT,
            NODE,PORT,HOST,
            ENTERS.RENAMES,
            CNC.SEC.DISPATCH,
            CIO.REMOTE,
            XCHARG,
            CNC.SEC.BLOCK.IO,CIO.BLOCK.IO,
            TRUS.HIGH,TRUS.LOW,
            MC.HIGH,MC.LOW,GROUP.NUM,@CR

    4: DSTOP.X,      % Change PROJ.CODE record - equates type 7 %
       TSTOP.X, 
       PROJ.CODE,
       TRUS.HIGH, TRUS.LOW,
       CNC.SEC,GROUP.NUM,@CR

    5: DSTART.X, TSTART.X, GROUP.NUM, @CR

  END  % 2 - %

TYPE @CR, "Beginning DAILY SESSION UPDATE.....Version 8.0", RUN.DATE.TIME

% SET UP START HOST/SESSION # FOR THIS RUN %

MOVE DEFAULT TO YEAR.MONTH, DAILY.DATE

FOR EACH FILE.CTL

   BEGIN  % 2 - %

   CONDITIONAL ON REC.TYPE

      BEGIN % 3 - %

      1: BEGIN % 4 - %
         IF HOST = 0 AND BILLING.HOST = 0 THEN

             BEGIN  % 5 - %
             TYPE @CR,'PRIMARY ACTG HAS NOT BEEN RUN',@CR
             ABORT
             END  % 5 - %

         MOVE HOST TO HOST.L
         MOVE BILLING.HOST TO BILLING.HOST.L
         END % 4 - %

      2: MOVE STG.FIL TO STG.FNAM

      3: BEGIN % 4 - %
         MOVE IN.FIL TO IN.FNAM
         MOVE OUT.FIL TO OUT.FNAM
         MOVE FIL.DATE TO FIL.DATE.L
         END % 4 - %

      4: BEGIN
         MOVE DAILY.DATE TO DAILY.DATE OF DAILY.SESS.UPD.X
         MOVE ((DAILY.DATE AS DATE 'YYMM')AS '4C') AS DATE 'YYMM'
         TO YEAR.MONTH OF DAILY.SESS.UPD.X
         END

      END % 3 - %

   END % 2 - %

TYPE @CR, "Processing DAILY ACCOUNTING file ", IN.FNAM, @CR

SELECT SRC.FNAMS VIA KEY THEN
   BEGIN % 2 - %
   TYPE @CR,'FILE:  ',IN.FNAM,'  ALREADY PROCESSED',@CR
   ABORT
   END % 2 - %


MOVE DEFAULT TO FIRST.SESS,LAST.SESS,SESS.CT, UUN.SUM, ERR.CT,
          BAD.CNC.REC, CHKPNT.ONLY, CHKPNT.CHKPNT, CHKPNT.LOGOUT,
          CHKPNT.PC.CHANGE, LOGIN.CHKPNT, LOGIN.LOGOUT,
          LOGIN.ONLY, LOGIN.PC.CHANGE, LOGOUT.ONLY, PC.CHANGE,
          PC.CHANGE.CHKPNT, PC.CHANGE.LOGOUT, PC.CHANGE.ONLY, 
          PC.CHANGE.PC.CHANGE, DUPL.SES.REC, ILGL.INP.REC, PC.SESS,
          DUP.FLAG

FOR EACH CNTRL.FIL
    MOVE LAST.SESS TO LAST.SESS OF DAILY.SESS.UPD.X

MOVE (LAST.SESS + 1) TO FIRST.SESS

   DELETE FROM RAW.DATA ALL

MOVE 34359738368 TO DP.WORD     % 2**35 %

FOR EACH DAILYX.DATA     % READ INPUT FILE INTO RELATION RAW.DATA %

LOADIN:
   BEGIN % 2 - %

   CONDITIONAL ON REC.TYPE

      BEGIN % 3 - %

      1: BEGIN % 4 - %
         LET DSTART = DSTART.X + '640101' AS DATE 'YYMMDD'
         LET TSTART = TSTART.X / 3600.00000
         MOVE 0 AS DATE TO DSTOP
         MOVE 0 TO TSTOP, LOOKUPS, LOOKUPS.SIZE,
                   ENTERS.RENAMES.SIZE, DISC.BLKS.IN.SIZE, DISC.BLKS.OUT.SIZE,
                   CIN, COUT, CNC.SEC.SIZE, CNC.HRS.X, BREAK.CHARS.SIZE,
                   MICRO.CYCLES.SIZE, DISC.BLKS.IN, DISC.BLKS.OUT,
                   ENTERS.RENAMES, CNC.SEC.DISPATCH, CIO.REMOTE,
                   XCHARG, CNC.SEC.BLOCK.IO,CIO.BLOCK.IO,
                   TRUS, MICRO.CYCLES
         END % 4 - %
  
 2 OR 3: BEGIN % 4 - %
         MOVE ' ' TO PROJ.CODE
         LET DSTART = DSTOP.X + '640101' AS DATE 'YYMMDD'
         LET TSTART = TSTOP.X / 3600.00000
         LET CNC.HRS.X = CNC.SEC / 3600.00000
         MOVE DSTART TO DSTOP
         MOVE TSTART TO TSTOP
         MOVE (MCS.HIGH AS '9Z') TO TMP.WORD
         MOVE (TMP.WORD * DP.WORD) TO MICRO.CYCLES.SIZE
         MOVE (MICRO.CYCLES.SIZE + MCS.LOW) TO MICRO.CYCLES.SIZE
         MOVE (TRUS.HIGH AS '9Z') TO TMP.WORD
         MOVE (TMP.WORD * DP.WORD) TO TRUS
         MOVE (TRUS + TRUS.LOW) TO TRUS
         MOVE (MC.HIGH AS '9Z') TO TMP.WORD
         MOVE (TMP.WORD * DP.WORD) TO MICRO.CYCLES
         MOVE (MICRO.CYCLES + MC.LOW) TO MICRO.CYCLES
         END % 4 - %
  
      4: BEGIN % 4 - %
         LET DSTART = DSTOP.X + '640101' AS DATE'YYMMDD'
         LET TSTART = TSTOP.X / 3600.00000
         LET CNC.HRS.X = CNC.SEC / 3600.00000
         MOVE DSTART TO DSTOP
         MOVE TSTART TO TSTOP
         MOVE (TRUS.HIGH AS '9Z') TO TMP.WORD
         MOVE ((TMP.WORD * DP.WORD) + TRUS.LOW) TO TRUS
         MOVE 0 TO BREAK.CHARS.SIZE, CIN, COUT, CIO.BLOCK.IO,
                   CIO.REMOTE, CNC.SEC.BLOCK.IO,CNC.SEC.DISPATCH,
                   CNC.SEC.SIZE, DISC.BLKS.IN.SIZE, DISC.BLKS.OUT.SIZE,
                   LOOKUPS, LOOKUPS.SIZE, MICRO.CYCLES,
                   MICRO.CYCLES.SIZE, ENTERS.RENAMES, ENTERS.RENAMES.SIZE,
                   XCHARG, DISC.BLKS.IN, DISC.BLKS.OUT
         END % 4 - %

      5: BEGIN
         LET DSTART = DSTART.X + '640101' AS DATE 'YYMMDD'
         LET TSTART = TSTART.X / 3600.00000

         END

      END % 3 - %

    ELSE

      BEGIN % 3 - %
      ADD 1 TO ILGL.INP.REC
      TYPE @CR,"ILLEGAL INPUT REC.TYPE OF ",REC.TYPE,@CR
      FINISH LOADIN
      END % 3 - %

   INSERT INTO RAW.DATA
   END % 2 -         END OF INPUT FILE %

TYPE @CR, COUNT(RAW.DATA), " Valid Records Input", @CR

WRITE REPORTS SESS.FIL, ERR.FIL

   BEGIN % 2 - %

   MOVE 2 TO TRAN.TYP       % PRINT HEADER RECORD %
   PRINT TO SESS.FIL
        TRAN.TYP, FIL.DATE.L, HOST.L,@CR
   MOVE 1 TO TRAN.TYP


      BEGIN % 3 - %

      FOR EACH RAW.DATA     % READ RAW.DATA AND MATCH RECORDS %
      IF REC.TYPE # 5 THEN

RPTSEL:  BEGIN % 4 - %

         MOVE DEFAULT TO  DELSUS, PCUUN, UUNTST, FINSEL, SESS.ERR, ERR.CMNT
         SELECT X.SUSPENSE VIA KEY THEN % DO WE HAVE A PREVIOUS RECORD IN SUS %

            BEGIN % 5 - %

            IF UUN OF X.SUSPENSE = UUN OF RAW.DATA THEN % IF SO ARE UUNS SAME %

               BEGIN % 6 - %
               LET UUNTST = 'EQ'
               IF REC.TYPE # 1 THEN % IGNORE LOGIN - MISSED LOGOUT FOR SESSION
                                      IN SUSPENSE  %
                  BEGIN % 7 - % % IS RAW.DATA TIME GE TO SUSPENSE TIME %

                  IF CNC.HRS.X LE CNC.HRS.X OF RAW.DATA THEN

                     BEGIN % 8 - % % YES - UPDATE SUSPENSE %


                     IF (REC.TYPE = 4) AND (PROJ.CODE OF X.SUSPENSE =
                                            PROJ.CODE OF RAW.DATA) THEN
                       FINISH RPTSEL
                   ELSE
                       NOTHING

                     MOVE REC.TYPE TO REC.STOP
                     MOVE DSTOP OF RAW.DATA TO DSTOP
                     MOVE TSTOP OF RAW.DATA TO TSTOP
                     MOVE CNC.HRS.X OF RAW.DATA TO CNC.HRS.X
                     MOVE TRUS OF RAW.DATA TO TRUS
                     IF REC.START = 4 AND PC.SESS # 'Y' THEN %PC.CHANGE RECORD%

                        BEGIN % 9 - %

                        LET CNC.HRS.X = CNC.HRS.X - CNC.HRS.PC
                        LET TRUS = TRUS - TRUS.PC

                        END % 9 - %

                     IF REC.TYPE # 4 THEN % SET NODE, PORT IF 0 IN SUS %

                        BEGIN % 9 - %

                        IF NODE OF X.SUSPENSE # 0 THEN
                          NOTHING

                      ELSE

                          BEGIN % 10 - %
                          MOVE NODE OF RAW.DATA TO NODE
                          MOVE PORT OF RAW.DATA TO PORT
                          END % 10 - %

                        END % 9 - %

                     MOVE LOOKUPS OF RAW.DATA TO LOOKUPS
                     MOVE LOOKUPS.SIZE OF RAW.DATA TO LOOKUPS.SIZE
                     MOVE ENTERS.RENAMES.SIZE OF RAW.DATA TO ENTERS.RENAMES.SIZE
                     MOVE DISC.BLKS.IN.SIZE OF RAW.DATA TO DISC.BLKS.IN.SIZE
                     MOVE DISC.BLKS.OUT.SIZE OF RAW.DATA TO DISC.BLKS.OUT.SIZE
                     MOVE CIN OF RAW.DATA TO CIN
                     MOVE COUT OF RAW.DATA TO COUT
                     MOVE CNC.SEC.SIZE OF RAW.DATA TO CNC.SEC.SIZE
                     MOVE BREAK.CHARS.SIZE OF RAW.DATA TO BREAK.CHARS.SIZE
                     MOVE MICRO.CYCLES.SIZE OF RAW.DATA TO MICRO.CYCLES.SIZE
                     MOVE DISC.BLKS.IN OF RAW.DATA TO DISC.BLKS.IN
                     MOVE DISC.BLKS.OUT OF RAW.DATA TO DISC.BLKS.OUT
                     MOVE ENTERS.RENAMES OF RAW.DATA TO ENTERS.RENAMES
                     MOVE CNC.SEC.DISPATCH OF RAW.DATA TO CNC.SEC.DISPATCH
                     MOVE CIO.REMOTE OF RAW.DATA TO CIO.REMOTE
                     MOVE XCHARG OF RAW.DATA TO XCHARG
                     MOVE CNC.SEC.BLOCK.IO OF RAW.DATA TO CNC.SEC.BLOCK.IO
                     MOVE CIO.BLOCK.IO OF RAW.DATA TO CIO.BLOCK.IO
                     MOVE MICRO.CYCLES OF RAW.DATA TO MICRO.CYCLES

                     ALTER X.SUSPENSE

                     CONDITIONAL ON REC.TYPE

                        BEGIN % 9 -  % % SET FLAGS ON TERMINATING RECORD -
                                         ELSE GET NEXT RAW.DATA REC %

                        2: FINISH RPTSEL
                        3: MOVE 'Y' TO  DELSUS, FINSEL
                        4: BEGIN % 10 - %

                           MOVE 'Y' TO  PCUUN, FINSEL
                           MOVE 'N' TO DELSUS

                           END % 10 - %

                        END % 9 - %

                     END % 8 - %

                ELSE
   
                     BEGIN % 8 - % % BAD CONNECT TIME ON RECORD %

                     TYPE @CR,"DEFICIENT TIME ON INPUT RECORD",@CR
                     ADD 1 TO BAD.CNC.REC
                     PRINT TO ERR.FIL
                         JOB OF RAW.DATA,
                          REC.TYPE,
                          TID OF RAW.DATA,
                          GAN OF RAW.DATA,
                          UUN OF RAW.DATA,
                          DSTART OF RAW.DATA,
                          TSTART OF RAW.DATA,
                          PROJ.CODE OF RAW.DATA,
                          NODE OF RAW.DATA,
                          PORT OF RAW.DATA,
                          HOST OF RAW.DATA,
                          DSTOP OF RAW.DATA,
                          TSTOP OF RAW.DATA,
                          LOOKUPS OF RAW.DATA,
                          LOOKUPS.SIZE OF RAW.DATA,
                          ENTERS.RENAMES.SIZE OF RAW.DATA,
                          DISC.BLKS.IN.SIZE OF RAW.DATA,
                          DISC.BLKS.OUT.SIZE OF RAW.DATA,
                          CIN OF RAW.DATA,
                          COUT OF RAW.DATA,
                          CNC.SEC.SIZE OF RAW.DATA,
                          CNC.HRS.X OF RAW.DATA,
                          BREAK.CHARS.SIZE OF RAW.DATA,
                          MICRO.CYCLES.SIZE OF RAW.DATA,
                          DISC.BLKS.IN OF RAW.DATA,
                          DISC.BLKS.OUT OF RAW.DATA,
                          ENTERS.RENAMES OF RAW.DATA,
                          CNC.SEC.DISPATCH OF RAW.DATA,
                          CIO.REMOTE OF RAW.DATA,
                          XCHARG OF RAW.DATA,
                          CNC.SEC.BLOCK.IO OF RAW.DATA,
                          CIO.BLOCK.IO OF RAW.DATA,
                          TRUS OF RAW.DATA,
                          MICRO.CYCLES OF RAW.DATA,
                          ' BAD.CNC.REC',@CR
   
                     CONDITIONAL ON REC.TYPE
   
                        BEGIN % 9 - % % SET FLAGS IF BAD REC IS LOGOUT -
                                        ELSE GET NEXT RAW.DATA RECORD %
                        3: MOVE 'Y' TO  DELSUS, FINSEL
                   2 OR 4: FINISH RPTSEL
   
                        END % 9 - %
   
                     END % 8 - % % CONNECT TIME TEST %

                  END % 7 - %

             ELSE

                  BEGIN % 7 - % % LOGIN RECORD - MISSED LOGOUT RECORD FOR
                                  PREVIOUS SESSION - SET FLAGS TO DUMP %
                  MOVE 'Y' TO  DELSUS % SUS AND PROCESS CURRENT R.DATA REC %
                  MOVE 'N' TO FINSEL

                  END % 7 - % % REC.TYPE TEST %

               END % 6 - %

          ELSE

               BEGIN % 6 - % % UUNS # - CLOSE X.SUSPENSE - PROCESS R.DATA REC %

               LET UUNTST = 'NE'
               MOVE 'Y' TO  DELSUS
               MOVE 'N' TO FINSEL

               END % 6 - % % UUN TEST %


%  IS THE RECORD IN X.SUSPENSE  COMPLETE  %

            IF ((REC.START = 1 OR 2 OR 3 OR 4) AND (REC.STOP = 2 OR 3 OR 4))
                   OR ((REC.START = 2) AND (REC.STOP = 0)) THEN
   
   DUPCHK:     BEGIN % 6 - % % YES - IS IT UNIQUE %

               SELECT DUP.CHECK VIA KEY THEN
   
                  BEGIN % 7 - % % IF JOBS = THEN TRUE  DUPLICATE %

                  IF JOB OF DUP.CHECK # JOB OF X.SUSPENSE THEN
   
                     BEGIN % 8 - % % ELSE INCREMENT TIME TILL IUNIQUE %

                     IF TSTART OF X.SUSPENSE = TSTOP OF X.SUSPENSE THEN
                       ADD .0001 TO TSTART OF X.SUSPENSE, TSTOP OF X.SUSPENSE
                     ELSE
                       ADD .0001 TO TSTART OF X.SUSPENSE

                     REPEAT DUPCHK

                     END % 8 - %
   
                ELSE
   
                     BEGIN % 8 - % % GAD - IT IS A TRUE DUPLICATE - ERROR %

                     MOVE 'Y' TO SESS.ERR
                     MOVE 'Y' TO DELSUS
                     MOVE ' DUPL.SES.REC' TO ERR.CMNT
                     ADD 1 TO DUPL.SES.REC
   

                     END % 8 - %
   
                  END % 7 - %
   
             ELSE
   
                  BEGIN % 7 - % % WE HAVE VALID AND UNIQUE SESSION RECORD %

                  INSERT INTO DUP.CHECK

%  COMPUTE DETACHED TIME  %

                  LET CNC.ELAPSED = ((DSTOP - DSTART) * 24) + (TSTOP - TSTART)
                  LET CNC.DETACHED = (CNC.ELAPSED - CNC.HRS.X)
                  IF CNC.DETACHED LT .0083 THEN
   
                     BEGIN % 8 - %

                     MOVE 0 TO CNC.DETACHED
                     MOVE CNC.ELAPSED TO CNC.HRS.X

                     END % 8 - %
   
                  ADD 1 TO SESS.CT % INCREMENT SESSION COUNTER %
   
                  IF REC.START = 1 THEN % INCREMENT CATEGORY COUNTER %
   
                     BEGIN % 8 - %

                     CONDITIONAL ON REC.STOP
   
                        BEGIN % 9 - %
   
                        2: ADD 1 TO LOGIN.CHKPNT
                        3: ADD 1 TO LOGIN.LOGOUT
                        4: ADD 1 TO LOGIN.PC.CHANGE

                        END % 9 - %
   
                     END % 8 - %
   
                  IF REC.START = 2 THEN
   
                     BEGIN % 8 - %

                     CONDITIONAL ON REC.STOP
   
                        BEGIN % 9 - %
   
                        0: ADD 1 TO CHKPNT.ONLY
                        2: ADD 1 TO CHKPNT.CHKPNT
                        3: ADD 1 TO CHKPNT.LOGOUT
                        4: ADD 1 TO CHKPNT.PC.CHANGE
   
                        END % 9 - %
   
                     END % 8 - %
   
                  IF REC.START = 4 THEN
   
                     BEGIN % 8 - %

                     IF PC.SESS = 'Y' THEN

                        BEGIN % 9 - %
                        ADD 1 TO PC.CHANGE
                        MOVE 'N' TO PC.SESS
                        END % 9 - %

                   ELSE

                     CONDITIONAL ON REC.STOP
   
                        BEGIN % 9 - %
   
                        2: ADD 1 TO PC.CHANGE.CHKPNT
                        3: ADD 1 TO PC.CHANGE.LOGOUT
                        4: ADD 1 TO PC.CHANGE.PC.CHANGE
   
                        END % 9 - %
   
                     END % 8 - %
   
                  IF REC.START = 3 THEN
                        ADD 1 TO LOGOUT.ONLY
   
                  IF REC.STOP = 4 THEN

                    BEGIN % 9 - % % PC change - do not charge for SESS %

                    MOVE 'N' TO SESS.CHG
                    ADD 1 TO NON.SESS.CHG.CNT

                    END  % 9 - %

                  ELSE     % REC.STOP # 4 %

                    BEGIN % 9 - % % Complete SESS - charge for SESS %

                    MOVE 'Y' TO SESS.CHG
                    ADD 1 TO SESS.CHG.CNT

                    END  % 9 - %
                  IF TRUS < 0 THEN
                    MOVE 0 TO TRUS
                  ELSE
                    NOTHING
                  PRINT TO SESS.FIL
                       TRAN.TYP, JOB, TID, GAN, UUN, DSTART, TSTART,
                       CIN, COUT, CNC.HRS.X, NODE, PORT, HOST,
                       CNC.SEC.DISPATCH, CIO.REMOTE, XCHARG, CNC.SEC.BLOCK.IO,
                       CIO.BLOCK.IO, TRUS, DSTOP, TSTOP, REC.START, REC.STOP,
                       PROJ.CODE, CNC.DETACHED, SESS.CHG, @CR
                  ADD UUN TO UUN.SUM
   
                  END % 7 - % % DUP.CHECK TEST %

               END % 6 - %

          ELSE

               BEGIN % 6 - % % INCOMPLETE RECORD IN SUSPENSE - ERROR %

               MOVE 'Y' TO SESS.ERR
               MOVE ' INCM.SES.REC' TO ERR.CMNT
               IF REC.START = 1 THEN 
                 ADD 1 TO LOGIN.ONLY
             ELSE
                 ADD 1 TO PC.CHANGE.ONLY

   

               END % 6 - % % REC.TYPE TEST %


            IF SESS.ERR = 'Y' THEN
              PRINT TO ERR.FIL
                   JOB, REC.START, TID, GAN, UUN, DSTART, TSTART,
                   PROJ.CODE, NODE, PORT, HOST, REC.STOP, DSTOP,
                   TSTOP, LOOKUPS, LOOKUPS.SIZE,
                   ENTERS.RENAMES.SIZE, DISC.BLKS.IN.SIZE,
                   DISC.BLKS.OUT.SIZE, CIN, COUT,
                   CNC.SEC.SIZE, CNC.HRS.X, CNC.HRS.PC,  BREAK.CHARS.SIZE,
                   MICRO.CYCLES.SIZE, DISC.BLKS.IN, DISC.BLKS.OUT,
                   ENTERS.RENAMES, CNC.SEC.DISPATCH, CIO.REMOTE,
                   XCHARG, CNC.SEC.BLOCK.IO, CIO.BLOCK.IO, TRUS,
                   TRUS.PC, MICRO.CYCLES, ERR.CMNT,@CR

            IF PCUUN = 'Y' THEN  % WAS LAST REC.TYPE 4 - IF SO SET UP DUMMY
                                   LOGIN IN SUSPENSE - SAVE CONNECT TIME, TRUS %

               BEGIN % 6 - %

               MOVE REC.TYPE TO REC.START
               MOVE PROJ.CODE OF RAW.DATA TO PROJ.CODE
               MOVE CNC.HRS.X OF RAW.DATA TO CNC.HRS.PC
               MOVE TRUS OF RAW.DATA TO TRUS.PC
               MOVE DSTOP OF RAW.DATA TO DSTART
               MOVE TSTOP OF RAW.DATA TO TSTART
               MOVE 0 TO CNC.HRS.X, TRUS, TSTOP, REC.STOP
               MOVE 0 AS DATE TO DSTOP

               ALTER X.SUSPENSE

               END % 6 - %

            IF DELSUS = 'Y' THEN
              DELETE FROM X.SUSPENSE VIA KEY

            IF UUNTST = 'EQ' THEN  % IF UUNS = THEN DONE WITH CURRENT R.DATA %
              MOVE 'Y' TO FINSEL   % RECORD ELSE WE STILL HAVE TO PROCESS IT %
          ELSE
              MOVE 'N' TO FINSEL

            IF FINSEL = 'Y' THEN
              FINISH RPTSEL
          ELSE
              REPEAT RPTSEL

            END % 5 - % % SCOPE OF SELECT ON X.SUSPENSE %

       ELSE

            BEGIN % 5 - % % NO PREVIOUS RECORD IN X.SUSPENSE FOR THIS SESSION %

            MOVE REC.TYPE TO REC.START
            MOVE 0 TO REC.STOP, CNC.HRS.PC, TRUS.PC
            MOVE DEFAULT TO PC.SESS

            CONDITIONAL ON REC.TYPE

               BEGIN % 6 - %

               1: BEGIN % 7 - %
                  INSERT INTO X.SUSPENSE
                  FINISH RPTSEL  % GET NEXT R.DATA RECORD %
                  END % 7 - %

               2: BEGIN % 7 - %
                  MOVE (TSTART - CNC.HRS.X) TO TSTART

                     WHILE TSTART LT 0 DO BEGIN % 8 - % % COMPUTE LOGON %
                     MOVE (DSTART - 1) TO DSTART
                     MOVE (TSTART + 24.0000) TO TSTART
                     END % 8 - %

                  INSERT INTO X.SUSPENSE
                  FINISH RPTSEL  % GET NEXT R.DATA RECORD %
                  END % 7 - %

               3: BEGIN % 7 - %
                  MOVE (TSTART - CNC.HRS.X) TO TSTART

                     WHILE TSTART LT 0 DO BEGIN % 8 - % % COMPUTE LOGON %
                     MOVE (DSTART - 1) TO DSTART
                     MOVE (TSTART + 24.0000) TO TSTART
                     END % 8 - %

                  INSERT INTO X.SUSPENSE
                  REPEAT RPTSEL  % LET'S PROCESS THIS ONE %
                  END % 7 - %

               4: BEGIN % 7 - %
                  MOVE 'Y' TO PC.SESS
                  MOVE CNC.HRS.X TO CNC.HRS.PC
                  MOVE TRUS TO TRUS.PC
                  MOVE (TSTART - CNC.HRS.X) TO TSTART

                     WHILE TSTART LT 0 DO BEGIN % 8 - % % COMPUTE LOGON %
                     MOVE (DSTART - 1) TO DSTART
                     MOVE (TSTART + 24.0000) TO TSTART
                     END % 8 - %

                  INSERT INTO X.SUSPENSE
                  REPEAT RPTSEL  % LET'S PROCESS THIS ONE %
                  END % 7 - %

               END % 6 - %

            END % 5 - % % PROCESSING OF FIRST RECORD FOR A SESSION %

         END % 4 - % % REPEAT SELECT %

       ELSE          % FORCE TERMINATION ON X.SUSPENSE RECORDS %
                     % WE HAVE A NEW UPTIME RECORD                 %
         BEGIN % 4 - %

         TYPE @CR,'Encountered UP-TIME RECORD dated  ',DSTART AS DATE
                  'ZM/ZD/YY',@TAB 2,TSTART,@CR,
         @CR, COUNT(X.SUSPENSE), " RECORD(S) being CLEARED from SUSPENSE", @CR

         FOR EACH X.SUSPENSE

            BEGIN % 5 - %

            MOVE DEFAULT TO SESS.ERR
            IF ((REC.START = 1 OR 2 OR 3 OR 4) AND (REC.STOP = 2 OR 3 OR 4))
                   OR ((REC.START = 2) AND (REC.STOP = 0)) THEN
   
   DUPCHK1:    BEGIN % 6 - % % YES - IS IT UNIQUE %

               SELECT DUP.CHECK VIA KEY THEN
   
                  BEGIN % 7 - % % IF JOBS = THEN TRUE  DUPLICATE %

                  IF JOB OF DUP.CHECK # JOB OF X.SUSPENSE THEN
   
                     BEGIN % 8 - % % ELSE INCREMENT TIME TILL IT IS UNIQUE %

                     IF TSTART OF X.SUSPENSE = TSTOP OF X.SUSPENSE THEN
                       ADD .0001 TO TSTART OF X.SUSPENSE, TSTOP OF X.SUSPENSE
                     ELSE
                       ADD .0001 TO TSTART OF X.SUSPENSE

                     REPEAT DUPCHK1

                     END % 8 - %
   
                ELSE
   
                     BEGIN % 8 - % % GAD - IT IS A TRUE DUPLICATE - ERROR %

                     MOVE 'Y' TO SESS.ERR
                     MOVE ' DUPL.SES.REC' TO ERR.CMNT
                     ADD 1 TO DUPL.SES.REC
   

                     END % 8 - %
   
                  END % 7 - %
   
             ELSE
   
                  BEGIN % 7 - % % WE HAVE VALID AND UNIQUE SESSION RECORD %

                  INSERT INTO DUP.CHECK

%  COMPUTE DETACHED TIME  %

                  LET CNC.ELAPSED = ((DSTOP - DSTART) * 24) + (TSTOP - TSTART)
                  LET CNC.DETACHED = (CNC.ELAPSED - CNC.HRS.X)
                  IF CNC.DETACHED LT .0083 THEN
   
                     BEGIN % 8 - %

                     MOVE 0 TO CNC.DETACHED
                     MOVE CNC.ELAPSED TO CNC.HRS.X

                     END % 8 - %
   
                  ADD 1 TO SESS.CT % INCREMENT SESSION COUNTER %
   
                  IF REC.START = 1 THEN % INCREMENT CATEGORY COUNTER %
   
                     BEGIN % 8 - %

                     CONDITIONAL ON REC.STOP
   
                        BEGIN % 9 - %
   
                        2: ADD 1 TO LOGIN.CHKPNT
                        3: ADD 1 TO LOGIN.LOGOUT
                        4: ADD 1 TO LOGIN.PC.CHANGE

                        END % 9 - %
   
                     END % 8 - %
   
                  IF REC.START = 2 THEN
   
                     BEGIN % 8 - %

                     CONDITIONAL ON REC.STOP
   
                        BEGIN % 9 - %
   
                        0: ADD 1 TO CHKPNT.ONLY
                        2: ADD 1 TO CHKPNT.CHKPNT
                        3: ADD 1 TO CHKPNT.LOGOUT
                        4: ADD 1 TO CHKPNT.PC.CHANGE
   
                        END % 9 - %
   
                     END % 8 - %
   
                  IF REC.START = 4 THEN
   
                     BEGIN % 8 - %

                     CONDITIONAL ON REC.STOP
   
                        BEGIN % 9 - %
   
                        2: ADD 1 TO PC.CHANGE.CHKPNT
                        3: ADD 1 TO PC.CHANGE.LOGOUT
                        4: ADD 1 TO PC.CHANGE.PC.CHANGE
   
                        END % 9 - %
   
                     END % 8 - %
   
                  IF REC.START = 3 THEN
                        ADD 1 TO LOGOUT.ONLY
   
                  IF REC.STOP = 4 THEN

                    BEGIN % 8 - % % PC change - do not charge for SESS %

                    MOVE 'N' TO SESS.CHG
                    ADD 1 TO NON.SESS.CHG.CNT

                    END  % 8 - %

                  ELSE   % REC.STOP # 4 %

                    BEGIN % 8 - % % Complete SESS - charge for SESS %

                    MOVE 'Y' TO SESS.CHG
                    ADD 1 TO SESS.CHG.CNT

                    END  % 8 - %

                  IF TRUS < 0 THEN
                    MOVE 0 TO TRUS
                  ELSE
                    NOTHING
                  PRINT TO SESS.FIL
                       TRAN.TYP, JOB, TID, GAN, UUN, DSTART, TSTART,
                       CIN, COUT, CNC.HRS.X, NODE, PORT, HOST,
                       CNC.SEC.DISPATCH, CIO.REMOTE, XCHARG, CNC.SEC.BLOCK.IO,
                       CIO.BLOCK.IO, TRUS, DSTOP, TSTOP, REC.START, REC.STOP,
                       PROJ.CODE, CNC.DETACHED, SESS.CHG, @CR
                  ADD UUN TO UUN.SUM
   
                  END % 7 - % % DUP.CHECK TEST %

               END % 6 - %

          ELSE

               BEGIN % 6 - % % INCOMPLETE RECORD IN SUSPENSE - ERROR %

               MOVE 'Y' TO SESS.ERR
               MOVE ' INCM.SES.REC' TO ERR.CMNT
               IF REC.START = 1 THEN 
                 ADD 1 TO LOGIN.ONLY
             ELSE
                 ADD 1 TO PC.CHANGE.ONLY

   

               END % 6 - % % REC.TYPE TEST %


            IF SESS.ERR = 'Y' THEN
              PRINT TO ERR.FIL
                   JOB, REC.START, TID, GAN, UUN, DSTART, TSTART,
                   PROJ.CODE, NODE, PORT, HOST, REC.STOP, DSTOP,
                   TSTOP, LOOKUPS, LOOKUPS.SIZE,
                   ENTERS.RENAMES.SIZE, DISC.BLKS.IN.SIZE,
                   DISC.BLKS.OUT.SIZE, CIN, COUT,
                   CNC.SEC.SIZE, CNC.HRS.X, CNC.HRS.PC,  BREAK.CHARS.SIZE,
                   MICRO.CYCLES.SIZE, DISC.BLKS.IN, DISC.BLKS.OUT,
                   ENTERS.RENAMES, CNC.SEC.DISPATCH, CIO.REMOTE,
                   XCHARG, CNC.SEC.BLOCK.IO, CIO.BLOCK.IO, TRUS,
                   TRUS.PC, MICRO.CYCLES, ERR.CMNT,@CR

            DELETE FROM X.SUSPENSE VIA KEY

            END % 5 - %


         END % 4 - %

      END % 3 - % % FOR EACH RAW.DATA %

% APPEND CHECKSUM RECORD %

   MOVE 9 TO TRAN.TYP
   LET LAST.SESS = FIRST.SESS + (SESS.CT - 1)
   PRINT TO SESS.FIL
        TRAN.TYP, UUN.SUM, FIRST.SESS, LAST.SESS, DAILY.DATE,@CR
   
   END % 2 - % % WRITE REPORTS SESS.FIL, ERR.FIL %

SELECT MONTHLY.STATS VIA KEY THEN % UPDATE STATISTICS RELATION %

   BEGIN % 2 - %

   LET BAD.CNC.REC OF MONTHLY.STATS = BAD.CNC.REC OF MONTHLY.STATS +
                                      BAD.CNC.REC OF DAILY.SESS.UPD.X
   LET DUPL.SES.REC OF MONTHLY.STATS = DUPL.SES.REC OF MONTHLY.STATS +
                                       DUPL.SES.REC OF DAILY.SESS.UPD.X
   LET CHKPNT.CHKPNT OF MONTHLY.STATS = CHKPNT.CHKPNT OF MONTHLY.STATS +
                                        CHKPNT.CHKPNT OF DAILY.SESS.UPD.X
   LET CHKPNT.LOGOUT OF MONTHLY.STATS = CHKPNT.LOGOUT OF MONTHLY.STATS +
                                        CHKPNT.LOGOUT OF DAILY.SESS.UPD.X
   LET CHKPNT.ONLY OF MONTHLY.STATS = CHKPNT.ONLY OF MONTHLY.STATS +
                                      CHKPNT.ONLY OF DAILY.SESS.UPD.X
   LET CHKPNT.PC.CHANGE OF MONTHLY.STATS = CHKPNT.PC.CHANGE OF MONTHLY.STATS +
                                       CHKPNT.PC.CHANGE OF DAILY.SESS.UPD.X
   LET LOGIN.ONLY OF MONTHLY.STATS = LOGIN.ONLY OF MONTHLY.STATS +
                                     LOGIN.ONLY OF DAILY.SESS.UPD.X
   LET LOGIN.CHKPNT OF MONTHLY.STATS = LOGIN.CHKPNT OF MONTHLY.STATS +
                                       LOGIN.CHKPNT OF DAILY.SESS.UPD.X
   LET LOGIN.LOGOUT OF MONTHLY.STATS = LOGIN.LOGOUT OF MONTHLY.STATS +
                                       LOGIN.LOGOUT OF DAILY.SESS.UPD.X
   LET LOGIN.PC.CHANGE OF MONTHLY.STATS = LOGIN.PC.CHANGE OF MONTHLY.STATS +
                                       LOGIN.PC.CHANGE OF DAILY.SESS.UPD.X
   LET LOGOUT.ONLY OF MONTHLY.STATS = LOGOUT.ONLY OF MONTHLY.STATS +
                                       LOGOUT.ONLY OF DAILY.SESS.UPD.X
   LET PC.CHANGE OF MONTHLY.STATS = PC.CHANGE OF MONTHLY.STATS +
                                    PC.CHANGE OF DAILY.SESS.UPD.X
   LET PC.CHANGE.CHKPNT OF MONTHLY.STATS = PC.CHANGE.CHKPNT OF MONTHLY.STATS +
                                        PC.CHANGE.CHKPNT OF DAILY.SESS.UPD.X
   LET PC.CHANGE.LOGOUT OF MONTHLY.STATS = PC.CHANGE.LOGOUT OF MONTHLY.STATS +
                                        PC.CHANGE.LOGOUT OF DAILY.SESS.UPD.X
   LET PC.CHANGE.ONLY OF MONTHLY.STATS = PC.CHANGE.ONLY OF MONTHLY.STATS +
                                         PC.CHANGE.ONLY OF DAILY.SESS.UPD.X
   LET PC.CHANGE.PC.CHANGE OF MONTHLY.STATS = PC.CHANGE.PC.CHANGE OF
                    MONTHLY.STATS + PC.CHANGE.PC.CHANGE OF DAILY.SESS.UPD.X
   
   ALTER MONTHLY.STATS
   
   END % 2 - %
   
 ELSE
   
   INSERT INTO MONTHLY.STATS

FOR EACH X.SUSPENSE

DUPCHK2:

  BEGIN % 2 - %
  SELECT DUP.CHECK VIA KEY THEN

     BEGIN % 3 - %
     MOVE 'Y' TO DUP.FLAG

     IF TSTART OF X.SUSPENSE = TSTOP OF X.SUSPENSE THEN
       ADD .0001 TO TSTART OF X.SUSPENSE, TSTOP OF X.SUSPENSE
     ELSE
       ADD .0001 TO TSTART OF X.SUSPENSE

     REPEAT DUPCHK2
     END % 3 - %

ELSE

     BEGIN % 3 - %
     IF DUP.FLAG = 'Y' THEN
   
       BEGIN % 4 - %
       ALTER X.SUSPENSE
       MOVE ' ' TO DUP.FLAG
       END % 4 - %
   
     INSERT INTO DUP.CHECK
     END % 3 - %

  END % 2 - %

WRITE REPORTS FILE.CTL1, FILE.CTL2, SESS.CNTRL

   BEGIN % 2 - %
   PRINT TO FILE.CTL1 "1 000 000"
   PRINT TO FILE.CTL2 "0"
   PRINT TO SESS.CNTRL FIRST.SESS,",",LAST.SESS,@CR
   END % 2 - %

INSERT INTO SRC.FNAMS

LET ERR.CT = BAD.CNC.REC + DUPL.SES.REC + LOGIN.ONLY + PC.CHANGE.ONLY

TYPE @CR, "SESSION SUMMARY FOLLOWS:", @CR, @CR,

                 'CHKPNT-CHKPNT       =====> ',CHKPNT.CHKPNT,@CR,
                 'CHKPNT-LOGOUT       =====> ',CHKPNT.LOGOUT,@CR,
                 'CHKPNT-ONLY         =====> ',CHKPNT.ONLY,@CR,
                 'CHKPNT-PC.CHANGE    =====> ',CHKPNT.PC.CHANGE,@CR,
                 'LOGIN-CHKPNT        =====> ',LOGIN.CHKPNT,@CR,
                 'LOGIN-LOGOUT        =====> ',LOGIN.LOGOUT,@CR,
                 'LOGIN-PC.CHANGE     =====> ',LOGIN.PC.CHANGE,@CR,
                 'LOGOUT-ONLY         =====> ',LOGOUT.ONLY,@CR,
                 'PC.CHANGE-ONLY      =====> ',PC.CHANGE,@CR,
                 'PC.CHANGE-CHKPNT    =====> ',PC.CHANGE.CHKPNT,@CR,
                 'PC.CHANGE-LOGOUT    =====> ',PC.CHANGE.LOGOUT,@CR,
                 'PC.CHANGE-PC.CHANGE =====> ',PC.CHANGE.PC.CHANGE,@CR,@CR,
                 'ERRORS              =====> ',ERR.CT,@CR,@CR,
                 'RECS IN X.SUSPENSE  =====>',COUNT(X.SUSPENSE),@CR,@CR,
                 'CHARGE SESSIONS     =====> ',SESS.CHG.CNT, @CR,
                 'NON-CHARGE SESSIONS =====> ',NON.SESS.CHG.CNT, @CR, @CR,
                 'FIRST.SESSION: ',FIRST.SESS,@CR,
                 'LAST.SESSION:  ',LAST.SESS,@CR

IF SESS.CT # CHKPNT.CHKPNT + CHKPNT.LOGOUT + CHKPNT.ONLY + CHKPNT.PC.CHANGE +
             LOGIN.CHKPNT + LOGIN.LOGOUT + LOGIN.PC.CHANGE + LOGOUT.ONLY +
             PC.CHANGE + PC.CHANGE.CHKPNT + PC.CHANGE.LOGOUT + 
             PC.CHANGE.PC.CHANGE THEN

TYPE @CR,@CR,'WARNING=====> SESSIONS ON FILE NOT EQUAL TO ABOVE SUMMARY',@CR

IF HOST.L NE BILLING.HOST.L THEN
   TYPE @CR, "Please move the files ", OUT.FNAM AS '10C', " and ",
        STG.FNAM, @CR, @CR, "to the Central Accounting System - Host",
        BILLING.HOST.L, " (After ROYALTY is run)", @CR

TYPE @CR, "End DAILY SESSION UPDATE", RUN.DATE.TIME

END % 1 - %
Q *