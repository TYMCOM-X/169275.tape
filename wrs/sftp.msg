From: William R. Soley <WRS@B39.Tymnet> 
Date: Wed, 10 Dec 86 20:23:29 PST 
To: jennys@tymix.Tymnet (Jenny Shen) 
Subject: Re: sftp 
In-reply-to: <8612102236.AA07157@tymix.Tymnet> of Wed, 10 Dec 86 14:36:37 PST

Jenny,
Thanks for letting me know about the problems in (SPL)SFTP.  I have made a
number of changes which should correct the problems you were seeing as well
as clean up a number of other error conditions that were not being handled
properly.  In summary the changes are:

	1. changed the way block IO is terminated so base won't send data
	    twice.  Appearently, the old base code didn't care that I was
	    doing this wrong.

	2. added the following error messages:
		452 Disk full or quota exceeded
	    which may appear after a WRIT, or:
		451 Black ball received - data lost
		451 IO.DER Device error for device DSK:
		451 IO.DTE Data error for device DSK:
		451 IO.ERR Unknown error for device DSK:
		552 IO.BKT Disk full or quota exceeded
	    which may appear after an end-of-file on a WRIT command.

	3. any error which occurs in a WRIT command will now prevent the
	    creation of a directory entry for the file allowing an older
	    version of a file with the same name to remain intact.

It is important to check for error codes as some of them are quite likely
to occur from time to time.  A good way to test the error recovery portion
of your code is to send the READ or WRIT command specifying one of the
following special file names which will simulate the indicated errors:
	filename	simulated error
	.0		illegal file name
	.1		no such user
	.2		protection error
	.3		file being modified
	.4		unknown lookup/enter error
	.12		disk full or quota exceeded
	.18		unknown IO error
	.19		device IO error
	.20		data IO error
	.21		disk full or quota exceeded
~~w sftp.msg
    