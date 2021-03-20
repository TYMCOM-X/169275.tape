:logfile loginn.log
;---------------------------------------------------------------------
;
;                             Build LOGINN.SHR
;
;                (SYS)LOGINN.SHR has protection ALL RUN RUN.
;                (SYS)LOGINN.SHR has license OP SY ST HF JL RF
;
;
;---------------------------------------------------------------------


daytime

ctest setproc macro=(ftsys)macro
load loginn.mac
ssave loginn

delete loginn.rel

declare all run run loginn.shr

r cksum
^loginn.cks
y
@loginn.fil

direct /ext/alph/prot/lic/time/author/words @loginn.fil
type loginn.cks

daytime


;---------------------------------------------------------------------
 