:LOGFILE (M33)MONED1.LOG
:PARAMETERS SYSNAME SYSVERS
:$MAIL=$FALSE
;  This builds a new monitor for a particular host.
;  If license is set, it will copy the monitor to the destination host.
CTEST SETPROC MACRO=(SYS)MACRO,LOADER=(SYS)LOADER
RUN MONED1
\SYSNAME\
\SYSVERS\
DIRECT \SYSNAME\####.*,####\SYSNAME\.*
RUN (SPL)CPY;\SYSNAME\####.SAV/HOST:\SYSNAME\
DAYTIME
   