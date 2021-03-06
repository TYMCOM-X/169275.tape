:Logfile PCOKWD.LOG
;[Begin PCOM Keyword test]
:$Substitution=1
;[Time:\$Timelimit, TRUs:\$Trulimit]
:REMARK	:$Timelimit=30,$TRUlimit=100
:
:
;
; $Date $Daytime, ($Weekday, $Month $Day, $Year)
; Today is \$Date \$Daytime, (\$Weekday, \$Month \$Day, \$Year)
DIR/TOTAL
;
; $True  is always = \$True  (TRUE)
; $False is always = \$False (FALSE)
;
; Delimiter (\$Delimiter), Mail at completion (\$Mail)
; Logging is set to \$Logging
:Rem	Save the state of the log variable
:Def Saveit=$LOGGING, $LOGGING = "False"
; Logging is now \$Logging (OFF=0)
:$LOGGING = $TRUE
; Logging is now \$Logging (ON=1)
:Rem	Restore it!
:$Logging = Saveit
; Logging restored to \$Logging
;
; There is \$TimeLimit time left and \$TRUlimit TRUs left
;[End PCOM Keyword test]
  