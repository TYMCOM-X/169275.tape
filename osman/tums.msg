Received: from F26.Tymnet.COM by F74.Tymnet.COM; Sat, 3 Mar 90 4:02:26 PST
Received: from EMSTXS.Ontyme.Tymnet by F26.Tymnet.COM; Sat, 3 Mar 90 12:00:39
	UT
Return-path: <NSC.H/MATTHEWS@EMSTXS.Ontyme.Tymnet> 
From: NSC.H/MATTHEWS@EMSTXS.Ontyme.Tymnet 
Date: 02 MAR 90 17:14:56 
To: TXS.O/GUVEN@EMSTXS.Ontyme.Tymnet 
Message-id: M18169@Ontyme.Tymnet 
Subject: System 31 Shutdown 
System31Shutdown: 

                           BT Tymnet Inc. 
                         Network Operations 
                         Technical Services 
 
 
 
DATE>           2 March 1990
 
TO>             ** Unixdist
 
FROM>           Harry Matthews 
 
SUBJECT>        System 31 Shutdown
 
------------------------------------------------------------------------------
 
I am pleased to announce that PDP system D31 shutdown yesterday as scheduled. 
This means we've shutdown three PDP code gen systems and have over 90% of the 
Public Network converted to Unix, congratulations everyone, you've all played 
an important, constructive part in this project and I extend my gratitude to 
you all. In fact, the place where the efforts of all our work on this project 
will be seen is on the bottom line. Closing down PDP's represent significant 
cost reductions even after the costs to install, operate and support the Sun 
equipment is factored in. 
 
Once again, congratulations!
 
The next near term goal is to condense the three remaining code gen PDP's 
(D37, F33 and F26) into two. This shall occur before June 1.
From: Joe Smith <JMS@F74.Tymnet.COM> (NSC.J/SMITH@Ontyme) 
Date: Tue, 13 Mar 90 10:51:16 PST 
To: Monitor Group <JMS>, Carl, Osman, Craig Fletcher <Fletcher@gemini> 
Cc: Harry Matthews <NSC.H/Matthews@Ontyme> 
Subject: LOADII error 14 for TMP file. 

I got a call from Ken Lumm saying that he could not run LOADII as user
FORDSUB - it died with 1022 error 14 while trying to create a TMP file.
Error 14 from the Monitor means "disk full or quota exceeded".  I had
him "R QUOTA" (which is a copy of SYS:QUOLST.SHR) which showed him as
being 60 pages over quota.  It went OK after he deleted some files.

Note to Craig: Anytime you get a call from a PDP-10 user being unable
to create a file, have them "R QUOTA" and check if reports any
negative numbers.

	-Joe
Received: from F26.Tymnet.COM by F74.Tymnet.COM; Sat, 17 Mar 90 4:03:07 PST
Received: from EMSTXS.Ontyme.Tymnet by F26.Tymnet.COM; Sat, 17 Mar 90 12:00:38
	UT
Return-path: <NSC.P/MACDONALD@EMSTXS.Ontyme.Tymnet> 
From: NSC.P/MACDONALD@EMSTXS.Ontyme.Tymnet 
Date: 16 MAR 90 16:53:44 
To: TXS.O/GUVEN@EMSTXS.Ontyme.Tymnet 
Message-id: M21766@Ontyme.Tymnet 
Subject: PDP10 

                               B T   T Y M N E T

                              M E M O R A N D U M





   DATE:  16 MARCH 1990

     TO:  ** UNIXDIST

   FROM:  HARRY MATTHEWS

SUBJECT:  PDP 10 CODE GEN SYSTEM PERFORMANCE

==============================================================================

RESULTING FROM OUR EFFORTS TO CLOSE DOWN THE PDP 10 CODE GEN SYSTEMS, THERE
ARE REPORTS OF POOR PERFORMANCE ON THE ABOVE MENTIONED SYSTEMS.  THESE REPORTS
HAVE NOT GONE UN-NOTICED AND ACTION IS UNDERWAY TO IMPROVE THE SITUATION.

LET ME SAY THAT THIS OR ANY IMPROVEMENT WILL NOT EVER RETURN PDP PERFORMANCE
TO EQUAL THAT OF THEIR HEYDAY.  THE REASON IS BECAUSE PDP'S RESOURCES ARE
SHRINKING AND (WE ARE ACTIVELY PURSUING THEIR ELIMINATION).  FURTHERMORE, WE
MUST MOVE OUR SYSTEMS FROM THE DALLAS DATA CENTER AND THERE ISN'T MUCH ROOM 
TO PLACE MORE COMPUTERS IN FREMONT.

AN ACTION PLAN BY ED ROOP WILL SHIFT COMMERCIAL USERS FROM SYSTEM F34 TO F74.
CODE GEN USERS FROM F33, F26 AND D37 WILL BE DISTRIBUTED ACROSS SYSTEMS F33, 
F26 AND F34, AND D37 WILL BE PERMANENTLY SHUTDOWN IN MAY.  ON THE SURFACE THIS
DOESN'T APPEAR TO HELP SINCE WE HAVE THREE CODE GEN SYSTEMS NOW AND WE'LL HAVE
THREE AFTER THE SHIFT, HOWEVER, IT WILL WHEN YOU CONSIDER:  A) EUROPEAN PUBLIC
NET USERS WILL MIGRATE TO UNIX AT THE END OF MARCH, B) TYMOUT:33 WILL BE
REMOVED BY 15 APRIL AND, C) ALL PSC AND ACS WILL BE ON UNIX BY END OF MARCH.
REMOVING THESE USERS FROM THE PDP'S WILL REMOVE A FAIR
DEGREE OF LOAD.  THE NET RESULT IS ONE MORE PDP SHUTDOWN REMOVING HUGE COSTS
FROM OUR EXPENSE LINE.

THIS PLAN WILL IMPROVE THINGS MARGINALLY BUT FOR FURTHER IMPROVEMENT, YOUR
COOPERATION IS REQUIRED.  YOU CAN HELP BY:  1) TAKE A HARD LOOK AT WHAT YOU
ARE USING THE SYSTEM FOR, CAN THIS WORK BE DONE BY A PC OR THE UNIX SYSTEM?
DOES IT NEED TO BE DONE AT ALL?, 2) DELETING ANY UNNECESSARY, OLD, OUT OF
DATE AND NO LONGER NEEDED FILES, 3) NOMINATE YOUR USER NAME AND DIRECTORY FOR
DELETION, 4) REPORT UNUSED DIRECTORIES FOR DELETION, 5) MOVE PERSONAL FILES
INTO A GROUP DIRECTORY, NOMINATE PERSONAL DIRECTORY FOR DELETION, AND 6) DON'T
LOG INTO THE SYSTEM UNLESS OU MUST DO YOUR WORK, THEN LOG OUT AFTERWORDS.

I'VE RUN OUT OF SUGGESTIONS BUT I'M SURE THERE ARE OTHERS.

PLEASE TAKE ACTION ON THIS REQUEST, BECAUSE THE POWER TO IMPROVE SYSTEM
PERFORMANCE IS IN YOUR HANDS.
Received: from F33.Tymnet.COM by F74.Tymnet.COM; Fri, 26 Apr 90 15:52:15 PDT
Return-path: <JMS@F74.Tymnet.COM> 
From: Joe Smith <JMS@F74.Tymnet.COM> (NSC.J/SMITH@Ontyme) 
Date: Fri, 26 Apr 90 15:51:47 PDT 
To: <!osman@F74> 
Subject: Hotline call 

26-Apr-90 02:55 /Joe  (2.5 hours)
Contact: Alicia Williams (EDINET, RAILTRACK) (800)228-3164
Symptom: Railtrack reports are late because MAGNUM jobs are disappearing
	out from under PCOM.  Alicia says that failure to produce these
	reports may cost the company a million dollars.
Cause:	The stream accounting shows that just before the MAGNUM job
	terminated, someone else logged into DCSOPEN and killed it.
	Further investigation shows that BUELNAJ had logged in from F38,
	set AC license, created an aux circuit as DCSOPEN:74, and typed
	"LOGOUT 18".  Why is this person from MIS killing Railtrack jobs?
Fix:	The INIT program from (BUELNAJ:74) has been set to (SYS)LOGOUT
	and a HOLD put on OPER password BUELNA.  Voicemail has been sent
	to Dick Kovach, Jim Buelna's manager.
    