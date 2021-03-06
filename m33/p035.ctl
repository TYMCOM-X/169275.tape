:LOGFILE (OSP)P035.LOG
:TIME 999
WATCH DAY
GFD OSP
PSP
DIRECT P034.*,P035.*

;Create all the REL files

COMPILE @MONF3
DELETE CMNF3F.REL,CMDF3F.REL,CMTF3F.REL,SETF3F.REL
COMPILE @MONKI
DELETE CMNKII.REL,CMDKII.REL,CMTKII.REL,SETKII.REL
COMPILE @MONKL
DELETE CMNKLL.REL,CMDKLL.REL,CMTKLL.REL,SETKLL.REL
COMPILE @MONKS
DELETE CMNKSS.REL,CMDKSS.REL,CMTKSS.REL,SETKSS.REL
UNDELETE/PURGE
;Now build the individual monitors

LOAD/SAVE:22035 @MON22
R CKSUM
22035.SAV,MON22.CMD,CNFN22.MAC,(M33)CONF22.MAC

LOAD/SAVE:23035 @MON23
R CKSUM
23035.SAV,MON23.CMD,CNFN23.MAC,(M33)CONF23.MAC

LOAD/SAVE:24035 @MON24
R CKSUM
24035.SAV,MON24.CMD,CNFN24.MAC,(M33)CONF24.MAC

LOAD/SAVE:25035 @MON25
R CKSUM
25035.SAV,MON25.CMD,CNFN25.MAC,(M33)CONF25.MAC

LOAD/SAVE:26035 @MON26
R CKSUM
26035.SAV,MON26.CMD,CNFN26.MAC,(M33)CONF26.MAC

LOAD/SAVE:27035 @MON27
R CKSUM
27035.SAV,MON27.CMD,CNFN27.MAC,(M33)CONF27.MAC

LOAD/SAVE:28035 @MON28
R CKSUM
28035.SAV,MON28.CMD,CNFN28.MAC,(M33)CONF28.MAC

LOAD/SAVE:29035 @MON29
R CKSUM
29035.SAV,MON29.CMD,CNFN29.MAC,(M33)CONF29.MAC

LOAD/SAVE:30035 @MON30
R CKSUM
30035.SAV,MON30.CMD,CNFN30.MAC,(M33)CONF30.MAC

LOAD/SAVE:31035 @MON31
R CKSUM
31035.SAV,MON31.CMD,CNFN31.MAC,(M33)CONF31.MAC

LOAD/SAVE:32035 @MON32
R CKSUM
32035.SAV,MON32.CMD,CNFN32.MAC,(M33)CONF32.MAC

LOAD/SAVE:33035 @MON33
R CKSUM
33035.SAV,MON33.CMD,CNFN33.MAC,(M33)CONF33.MAC

LOAD/SAVE:34035 @MON34
R CKSUM
34035.SAV,MON34.CMD,CNFN34.MAC,(M33)CONF34.MAC

LOAD/SAVE:35035 @MON35
R CKSUM
35035.SAV,MON35.CMD,CNFN35.MAC,(M33)CONF35.MAC

LOAD/SAVE:36035 @MON36
R CKSUM
36035.SAV,MON36.CMD,CNFN36.MAC,(M33)CONF36.MAC

LOAD/SAVE:37035 @MON37
R CKSUM
37035.SAV,MON37.CMD,CNFN37.MAC,(M33)CONF37.MAC

LOAD/SAVE:38035 @MON38
R CKSUM
38035.SAV,MON38.CMD,CNFN38.MAC,(M33)CONF38.MAC

LOAD/SAVE:39035 @MON39
R CKSUM
39035.SAV,MON39.CMD,CNFN39.MAC,(M33)CONF39.MAC

LOAD/SAVE:54035 @MON54
R CKSUM
54035.SAV,MON54.CMD,CNFN54.MAC,(M33)CONF54.MAC

LOAD/SAVE:55035 @MON55
R CKSUM
55035.SAV,MON55.CMD,CNFN55.MAC,(M33)CONF55.MAC

LOAD/SAVE:56035 @MON56
R CKSUM
56035.SAV,MON56.CMD,CNFN56.MAC,(M33)CONF56.MAC

LOAD/SAVE:57035 @MON57
R CKSUM
57035.SAV,MON57.CMD,CNFN57.MAC,(M33)CONF57.MAC

LOAD/SAVE:58035 @MON58
R CKSUM
58035.SAV,MON58.CMD,CNFN58.MAC,(M33)CONF58.MAC

LOAD/SAVE:59035 @MON59
R CKSUM
59035.SAV,MON59.CMD,CNFN59.MAC,(M33)CONF59.MAC

LOAD/SAVE:60035 @MON60
R CKSUM
60035.SAV,MON60.CMD,CNFN60.MAC,(M33)CONF60.MAC

LOAD/SAVE:62035 @MON62
R CKSUM
62035.SAV,MON62.CMD,CNFN62.MAC,(M33)CONF62.MAC

LOAD/SAVE:65035 @MON65
R CKSUM
65035.SAV,MON65.CMD,CNFN65.MAC,(M33)CONF65.MAC

LOAD/SAVE:70035 @MON70
R CKSUM
70035.SAV,MON70.CMD,CNFN70.MAC,(M33)CONF70.MAC

LOAD/SAVE:72035 @MON72
R CKSUM
72035.SAV,MON72.CMD,CNFN72.MAC,(M33)CONF72.MAC

LOAD/SAVE:74035 @MON74
R CKSUM
74035.SAV,MON74.CMD,CNFN74.MAC,(M33)CONF74.MAC

LOAD/SAVE:79035 @MON79
R CKSUM
79035.SAV,MON79.CMD,CNFN79.MAC,(M33)CONF79.MAC

LOAD/SAVE:83035 @MON83
R CKSUM
83035.SAV,MON83.CMD,CNFN83.MAC,(M33)CONF83.MAC

LOAD/SAVE:92035 @MON92
R CKSUM
92035.SAV,MON92.CMD,CNFN92.MAC,(M33)CONF92.MAC

LOAD/SAVE:95035 @MON95
R CKSUM
95035.SAV,MON95.CMD,CNFN95.MAC,(M33)CONF95.MAC

LOAD/SAVE:F3035 @MONF3
R CKSUM
F3035.SAV,MONF3.CMD,CNFNF3.MAC,(M33)CONFF3.MAC

LOAD/SAVE:FZ035 @MONFZ
R CKSUM
FZ035.SAV,MONFZ.CMD,CNFNFZ.MAC,(M33)CONFFZ.MAC

LOAD/SAVE:MA035 @MONMA
R CKSUM
MA035.SAV,MONMA.CMD,CNFNMA.MAC,(M33)CONFMA.MAC

LOAD/SAVE:RB035 @MONRB
R CKSUM
RB035.SAV,MONRB.CMD,CNFNRB.MAC,(M33)CONFRB.MAC

LOAD/SAVE:S1035 @MONS1
R CKSUM
S1035.SAV,MONS1.CMD,CNFNS1.MAC,(M33)CONFS1.MAC

LOAD/SAVE:S2035 @MONS2
R CKSUM
S2035.SAV,MONS2.CMD,CNFNS2.MAC,(M33)CONFS2.MAC

LOAD/SAVE:S3035 @MONS3
R CKSUM
S3035.SAV,MONS3.CMD,CNFNS3.MAC,(M33)CONFS3.MAC

LOAD/SAVE:S4035 @MONS4
R CKSUM
S4035.SAV,MONS4.CMD,CNFNS4.MAC,(M33)CONFS4.MAC

LOAD/SAVE:S5035 @MONS5
R CKSUM
S5035.SAV,MONS5.CMD,CNFNS5.MAC,(M33)CONFS5.MAC

LOAD/SAVE:TW035 @MONTW
R CKSUM
TW035.SAV,MONTW.CMD,CNFNTW.MAC,(M33)CONFTW.MAC

R CKSUM
@MONED.DIR

R QUOLST
DIRECT *.MAC/TOTAL/NOPRINT
DIRECT *.CMD/TOTAL/NOPRINT
DIRECT *.REL/TOTAL/NOPRINT
DIRECT *.SAV/TOTAL/NOPRINT
DIRECT *.*-*.MAC-*.CMD-*.REL-*.SAV/TOTAL
      