:---------------------------------------------------------------------
: Patch name:  BPHOST                Product and Version:  CMH 1.07
:     Author:  PHIL SNEDDON                 Organization:  QSATS/STS
:   Customer:  UKNET                        Date Written:  03/10/89
: Description of Problem:  Out-of-buffers crash due to huge quantities of
: data from the host.   ESC #224259
:---------------------------------------------------------------------

: PROBLEM  - The host is sending several 1920 character screens to the
:            terminals to stress-test the CMH interface.  CMH was written to
:            backpressure the host if it has 1 screen buffered to go to
:            the terminal.  The backpressure routine is located in OSCAN
:            but due to the rate at which the host is sending the data,
:            CMH is never able to get out of INPUT and consequently is
:            not able to send backpressure to the host.
:
: SOLUTION - This patch puts the flow control routine in INPUT so the
:            host can be stopped before it blows CMH away.

         LO OSCAN
         LO SSUB
         LO FRNTND
         LO GBLDEF
PATCH(890310,1104,P/SNEDDON,V.INF9+0D8,,6)
         J     V.IF10,,               :JUST QUEUED DATA TO THE TERMINAL
CONPATCH(S.AICP+60,,6)
         J     S.AICX,,               :JUST QUEUED DATA TO THE TERMINAL
CONPATCH(S.RD95+7E,,6)
         J     S.RD99,,               :JUST QUEUED DATA TO THE TERMINAL
CONPATCH(S.DSM6+6A,,6)
         J     S.DSM9,,               :JUST QUEUED DATA TO THE TERMINAL
CONPATCH(PA1PTR,,52)
V.IF10   LA    R6,V.INF9+0DE,,        :RETURN ADDRESS FOR STPHST
         J     STPHST                 :GO SEND BACKPRESSURE TO THE HOST
S.AICX   LA    R6,S.AICG,,            :RETURN ADDRESS FOR STPHST
         J     STPHST                 :GO SEND BACKPRESSURE TO THE HOST
S.RD99   LA    R6,S.RD95+84,,         :RETURN ADDRESS FOR STPHST
         J     STPHST                 :GO SEND BACKPRESSURE TO THE HOST
S.DSM9   LA    R6,S.DSM6+70,,          :RETURN ADDRESS FOR STPHST

STPHST   LHL   RDCB,DCBLKS+DCBHCB,RDCB,  :RESTORE ORIGINAL INSTRUCTION
         LHL   R1,DCBLKS+DCBIPR,RDCB,    :GET THE HOST RPORT
         RBT   R1,FRISIS,,               :IS IT ALREADY BACKPRESSURED?
         JER   R6                        :YES, DON'T DO IT AGAIN
         LHI   R2,NOSMSG                 :ISIS BP MESSAGE
         LIS   R0,3                      :3 BYTES
         JAL   R4,SLOR,,                 :SEND BACKPRESSURE
         JAL   R4,ELOR,,                 :EVERYONE KNOWS WHAT THIS DOES
         ST    R6,LASGUY,,
         JR    R6                        :USE THAT RETURN ADDRESS NOW
CONPATCH(PA0PTR,,6)
LASGUY   WC    0                      :
ENDPATCH(fix CMH-to-host backpressuring)
  