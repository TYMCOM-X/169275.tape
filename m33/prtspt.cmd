0001?	%%PAT+24.<NXTATB:
0002?	%%PAT+31.<NXTFNB:
0003?	%%PAT+35.<NXTDRB:
0004?	%%PAT+42.<PRTFIL:
0005?	%%PAT+64.<SIXOUT:
0006?	%%PAT+71.<DECOUT:
0007?	%%PAT+78.<%%PDL:
 0010?	%%PAT!MOVEI P,%%PDL
  0020?	SETZ P4,
   0030?	%%FET P1,SYSDRB
 0040?	%%END
 0050?	HLRZS P1
   0060?	DODRB:%%FET P2,DRBFNB(P1)
 0070?	%%END
 0080?	HLRZS P2
   0090?	 JUMPE P2,NXTDRB
0100?	DOFNB:%%FET P3,FNBATB(P2)
 0110?	%%END
 0120?	HLRZS P3
   0130?	JUMPE P3,NXTFNB
 0140?	DOATB:SETZ J,
   0150?	%%FET T1,ATBSPT(P3)
  0160?	%%END
 0170?	HLRZS T1
   0180?	JUMPE T1,NXTATB
 0190?	AOS J
                                    0200?	NXTSPT:%%FET T1,SPTLNK(T1)
0210?	%%END
 0220?	HLRZS T1
   0230?	JUMPE T1,NXTATB
 0240?	AOJA J,NXTSPT
   0250?	NXTATB:SKIPE J
  0260?	PUSHJ P,PRTFIL
  0270?	ADD P4,J
   0280?	%%FET P3,ATBLNK(P3)
  0290?	%%END
 0300?	HLRZS P3
   0310?	JUMPN P3,DOATB
  0320?	NXTFNB:%%FET P2,FNBLNK(P2)
0330?	%%END
 0340?	HLRZS P2
   0350?	JUMPN P2,DOFNB
  0360?	NXTDRB:%%FET P1,DRBLNK(P1)
0370?	%%END
 0380?	HLRZS P1
   0390?	JUMPN P1,DODRB
  0400?	MOVE T1,P4
 0410?	PUSHJ P,DECOUT
  0420?	%%END
 0430?	PRTFIL:OUTCHI "(
    0440?	%%FET T1,DRBUNM(P1)
  0450?	%%END
 0460?	PUSHJ P,SIXOUT
            0470?	%%FET T1,DRBUN1(P1)
  0480?	%%END
 0490?	PUSHJ P,SIXOUT
  0500?	OUTCHI ")
 0510?	%%FET T1,FNBNAM(P2)
  0520?	%%END
 0530?	PUSHJ P,SIXOUT
  0540?	OUTCHI ".
 0550?	%%FET T1,FNBEXT(P2)
  0560?	%%END
 0570?	HRLZS T1
   0580?	PUSHJ P,SIXOUT
  0590?	OUTCHI 40
  0600?	MOVE T1,J
  0610?	PUSHJ P,DECOUT
  0620?	OUTCHI 15
  0630?	OUTCHI 12
  0640?	POPJ P,
    0650?	SIXOUT:SKIPA T2,. 1
  0660?	440600,,T1
 0670?	ILDB T3,T2
 0680?	OUTCHI 40(T3)
   0690?	TLNE T2,770000
  0700?	JRST .-3
   0710?	POPJ P,
    0720?	DECOUT:IDIVI T1,10.
  0730?	HRLM T2,(P)
0740?	SKIPE T1
                  0750?	PUSHJ P,DECOUT
  0760?	HLRZ T1,(P)
0770?	OUTCHI 60(T1)
   0780?	POPJ P,
    0790?	%%PDL:
 