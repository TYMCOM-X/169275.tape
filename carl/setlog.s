simple procedure SetMyLog;
begin "set log name"
    own string Today;

    Today_ TymDay( GetTDT );
    Today_ Today[8 for 2] &
	   ("0"&cvs( CMonth( Today[4 for 3] ) ))[inf-1 to inf] &
	   Today[1 for 2];
    SetLog( SRADir & Today &".MON", true );

! ***    SetLog( SRADir & "SYSDAT."& TymDay( GetTDT )[4 for 3] );

end "set log name";
require SetMyLog initialization;


 