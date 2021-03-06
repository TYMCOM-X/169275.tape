:LOGFILE RPG.LOG
;[RPG BUILD INSTRUCTIONS]
;
;	Setup proper mode and tty characteristics
PDP
TTY WIDTH 80
TTY FORM
;
;	Use the latest MACRO-10 and LINK-10
;
CTEST SETPROC MACRO=(FTSYS)MACRO,LOADER=(SPL)LINKER
;
LOAD/COMPILE @RPG.CMD
SSAVE RPG
;
DELETE RPG.REL,RPGUNV.REL,RPGINI.REL,RPGMAI.REL
;
CROSS
;
R CKSUM
@RPG.FIL

;
;
TYPE RPG.INF
;	This line changes - per transmittal
;
TYPE RPG.SCM
TYPE RPGMAI.SCM
;
GET RPG
VERSION
;
;  Archive:
;	RPG.CMD, RPG.CTL, RPG.INF, RPG.MAC, RPGUNV.MAC
;	RPGINI.MAC, RPGMAI.MAC, RPGUNV.UNV, RPG.LOG
;  Old source versions to archive:
;	RPG.154, RPGMAI.154
;  Transmit:
;	RPG.SHR to (SYS) with protection RUN RUN RUN
;			 with license    HF
;
;[END of RPG.CTL]
    