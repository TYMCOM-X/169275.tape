init
sendma dencoff
Run the SPPOPER job to repair the data base:
	mhx
	@splist
	@month.spl
	y
	repair.rpt
	n
Watch it, in case it hangs up.

Get the list of hosts with repair not done:
	.record
	. . . :  need.rpr
	.spmhx
	. . . :  repair.rpt
	.exi

any host with repair not done:
	<log in as SPPOPER;  set lic>
	.spfix
	*fixfdf
	*repair		
	*quit
	.spool		;to test that SPOOL restored.
	*quit		
	<if SPOOL can't run:	.ren(sys)spool.sav, (sppoper)fakspo.sav
				.ren(sppoper)spool.sav, (sys)spool.sav >

  