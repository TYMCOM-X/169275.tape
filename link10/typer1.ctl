SYSUNV::.NOERROR
.DIRECT SYSUNV.MAC
.COMPILE /COMPILE/MACRO/CREF SYSUNV.MAC
.CREF SYSUNV
.DIRECT SYSUNV.UNV

TYPER::.NOERROR
.DIRECT TYPER.MAC,TYP7I.T10,TYP7N.T10,TYP7S.T10,IOSEC.*,GETSEC.MAC
.COMPILE /COMPILE/MACRO/CREF TYP7I=TYP7I.T10+TYPER.MAC
.COMPILE /COMPILE/MACRO TYP7N=TYP7N.T10+TYPER.MAC
.COMPILE /COMPILE/MACRO TYP7S=TYP7S.T10+TYPER.MAC
.COMPILE /COMPILE/MACRO TYP7L=TYP7L.T10+TYPER.MAC
.COMPILE /COMPILE/MACRO IOREAL=IOSEC.REA+IOSEC.T10+GETSEC.MAC
.COMPILE /COMPILE/MACRO/CREF IOSEC=IOSEC.DUM+IOSEC.T10+GETSEC.MAC
.LOAD IOREAL,TYP7I/SEARCH
.SAVE IOSEC
.CREF TYP7I,IOSEC
.DELETE IOREAL.REL,0??LNK.EXE
.DIRECT IOSEC.*,TYP7?.REL,*.UNV

      