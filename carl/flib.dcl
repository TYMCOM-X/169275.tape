external string fErrMsg;
external record!class FILE (
    string	Name;
    integer	Chan;
    integer	OSMode;
    integer	NBuf;
    integer	Count;
    integer	Break;
    integer	EOF;
    string	Mode;
    integer	Mode1;
    integer	Mode2;
    integer	ErrMode;
    integer	Timeout;
    integer array LKB    );
external integer fLKB;	comment size of longest meaningful lookup block;
external procedure fError( r!p(FILE) F; string MSG; integer ERR(-1) );
external integer procedure fAlloc( integer NPGS(1) );
external procedure fClear( integer PG, NPGS(1) );
external procedure fFree( integer PG, NPGS(1) );
external boolean procedure fSelect( r!p(FILE) F; integer OP, M2(0) );
external string procedure fScan(
    string Name;
    integer array LKB  );
external r!p(FILE) procedure fOpen( string Name, Mode );
external procedure fRename( r!p(FILE) F; string Name(").(") );
external procedure fClose( reference r!p(FILE) F; integer bits(0) );
external procedure fMap( r!p(FILE) F; integer VP, FP, CNT, PROT(0) );
comment
	Map the specified file pages into virtual memory.  The default
	protection is COW if file is mode "r" otherwise, R/W.  Valid
	protections are "r", "c" and "w".
;
   