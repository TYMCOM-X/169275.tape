 "\ KS.PAT - patches for 2020's only, applied after DMON.PAT   19-Oct-88 \
 "\ Go to BOOTS immediately after KS10>SHUT puts nonzero in 30. \
PICON:
DM30.1+4/JFCL
 "\ Don't save AC blocks 3,4,5,6 (causes PAR ERR sometimes). \
COMMON:
SVSETS+13/JRST SVSETS+32
 "\ Don't get messed up by ANS messages. \
SCNSER:
RCVANS/MOVE T1,DRMTIM
 "\ End of KS.PAT \
     