	OPEN(UNIT=1,FILE='TEMP.DDT')
	JPAGE = 0 ; INDEX = "51
10	TYPE 11
11	FORMAT(' CYL,HEAD,REC : ',$)
	ACCEPT 12,ICYL,IHEAD,IREC,KREC
12	FORMAT(4I)
	  IF(ICYL.NE.0)IHEAD=21
	  IF(ICYL.NE.0)IREC=20
	IF(KREC.EQ.0)KREC=IREC
	DO 20 I=IREC,KREC
	IPAGE=(ICYL*187*4 + IHEAD*25 + I-1)/4
	IF(IPAGE.NE.0) IPAGE = IPAGE + "200000000000
	IF(IPAGE.EQ.JPAGE) GOTO 20
	WRITE(1,13)INDEX,IPAGE
13	FORMAT(' D+',O3,'/',O12)
	TYPE 13,INDEX,IPAGE
	INDEX = INDEX+1
20	JPAGE=IPAGE
	IF(IPAGE.NE.0) GOTO 10
30	CLOSE(UNIT=1)
	END
    