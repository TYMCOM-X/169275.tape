R (MPL)AUXIO
OUT AUX915.TMP
C RAMMON:6915
WAIT 40

FORCE ST
TIME 3
FORCE EXIT
Q
TYP AUX915.TMP
DA
EXEC WAIT10.MAC
RU COM;RAMMON.915


 