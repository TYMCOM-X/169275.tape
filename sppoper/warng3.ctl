init
sendma dencoff
Run the SPPOPER job for accounting, this morning:
	mhx
	@splist
	@spool.act
	y
	unproc.rpt
	n
Watch it, in case it hangs up.

Then run SPMHX on the output (UNPROC.RPT).  Get host list.
	<Log in to each host listed; set lic>
	.rcharg
	* list unproc
	ALL? y
	OUTPUT TO:  term
	* charge all
	. . .  <info about an uncharged req>
	OK?  y
	ENTER POSTAGE OR TRANSPORTATION CHARGE:  .05
	. . .
	POSTAGE CHARGE CORRECT?  y
	. . . <repeats, info about another uncharged req, or gives '*'>
	* q


    