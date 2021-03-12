:LOGFILE pcoctl.log
:PARAMETERS one="one",two="to",three="3"
; (Beginning: \$Date \$Daytime)
;[Begin PCOCTL.CTL]	PCOM Test CTL file
; Called with: one(\one), two(\two), three(\three)
; % # *
:COM PCO000.CTL "%","#","*"
:DEFINE $NUMERICS=0
; ? * +
:COM PCO000.CTL "?","*","+"
:$NUMERICS=$TRUE
; one(*one), two(*two), three(*three)
:$DELIMITER = '*'
; one(*one), two(*two), three(*three)
;  # % &
:COM PCO000.CTL "#","%","&"
; one(*one), two(*two), three(*three)
;
:DEFINE $MAIL=$FALSE
; (Ending: *$Date *$Daytime)
;[End PCOCTL.CTL]
   