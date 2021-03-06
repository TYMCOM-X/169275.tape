File 1)	DSK:SED.MAN[14,10,DECUS0,SED]     	created: 1604 04-Apr-80
File 2)	DSKA:SED.MAN[14,10,DECUS0,SED,CSM]	created: 1400 14-Jun-83

1)4	        .R SED;FILE.EXT         or
1)	        .R SED;FILE.EXT=
1)	     Either form will find the given file (in this  case,  FILE.EXT)
****
2)4	        .SED FILE.EXT         or
2)	        .SED FILE.EXT=
2)	     Either form will find the given file (in this  case,  FILE.EXT)
**************
1)4	In any case, the syntax is "R SED;FILE.EXT/SWITCH/SWITCH".
1)	2.2  EXITING THE EDITOR
****
2)4	In any case, the syntax is ".SED FILE.EXT/SWITCH/SWITCH".
2)	2.2  EXITING THE EDITOR
********** ****
1)6	(ESCAPE).   By doing so you tell SED that what you are about to type
1)	is a command parameter, not a piece of text.
1)	     <Parameter> is whatever value you want to give to  the  command
****
2)6	("ENTER" on the numeric keypad).  By doing so you tell SED that what
2)	you are about to type is a command parameter, not a piece of text.
2)	     <Parameter> is whatever value you want to give to  the  command
**************
1)6	out of ENTER mode, type the RESET command (RUBOUT or DELETE).
1)	                               - 6 -
****
2)6	out of ENTER mode, type the RESET command ("." on the keypad).
2)	                               - 6 -
**************
1)7	That is, ESCAPE 4 ^T.  The screen will roll 4 lines.  If you want to
1)	roll another 4 lines, just type
****
2)7	That is, ENTER 4 ^T.   The screen will roll 4 lines.  If you want to
2)	roll another 4 lines, just type
**************
1)7	        .R SED
1)	and you will be back in THING.GIG.  In fact, you will be set  up  at
****
2)7	        .SED
2)	and you will be back in THING.GIG.  In fact, you will be set  up  at
**************
1)7	and ^Q).  A page is defined as one screen-full of lines (about 24).
1)	     So if you type ROLL-FORWARD-PAGES the  entire  screen  will  be
****
2)7	and ^A).  A page is defined as one screen-full of lines (about 24).
2)	     So if you type ROLL-FORWARD-PAGES the  entire  screen  will  be
**************
1)8	     The INSERT-SPACES command is ^A.  It inserts a  space  in  your
1)	file  where  the  cursor  is.  The parameter to INSERT-SPACES is the
1)	number of spaces to insert.
1)	     DELETE-SPACES (^S) deletes characters (not just  spaces)  where
1)	the cursor is.  It shares its parameter with INSERT-SPACES.
****
2)8	     The INSERT-SPACES command is ^K.  It inserts a  space  in  your
2)	file  where  the  cursor  is.  The parameter to INSERT-SPACES is the
2)	number of spaces to insert.
2)	     DELETE-SPACES (^L) deletes characters (not just  spaces)  where
File 1)	DSK:SED.MAN[14,10,DECUS0,SED]     	created: 1604 04-Apr-80
File 2)	DSKA:SED.MAN[14,10,DECUS0,SED,CSM]	created: 1400 14-Jun-83

2)	the cursor is.  It shares its parameter with INSERT-SPACES.
**************
1)14	Then type the RECALL command (terminal dependent), which displays on
1)	the bottom line
1)	        >LABEL1:
****
2)14	Then type the  RECALL  command  ("'" on the numeric  keypad),  which
2)	displays on the bottom line
2)	        >LABEL1:
**************
1)16	     The MARK command thus  changes  the  action  of  the  PICK  and
****
2)16	     The MARK command is the "7" key on the numeric keypad.
2)	     The MARK command thus  changes  the  action  of  the  PICK  and
**************
1)17	     The SLIDE-LEFT (^K) and  SLIDE-RIGHT  (^L)  commands  move  the
1)	viewing window left and right.  Note that you are sliding the window
1)	over the file, so SLIDE-RIGHT shows you higher-numbered columns.
1)	     The parameter to the SLIDE commands is the number of columns to
****
2)17	     The SLIDE-LEFT ("8" on the keypad) and  SLIDE-RIGHT ("9" on the
2)	keypad) commands move the viewing window left and right.   Note that
2)	you are sliding the window over the file,  so SLIDE-RIGHT  shows you
2)	higher-numbered columns.
2)	     The parameter to the SLIDE commands is the number of columns to
**************
1)17	     The REAL-TAB command (terminal dependent) can also be  used  to
1)	put  a  tab in the file.  It acts exactly as if you typed "ENTER-C-C
****
2)17	     The REAL-TAB command ("0" on the keypad)  can also be  used  to
2)	put  a  tab in the file.  It acts exactly as if you typed "ENTER-C-C
**************
1)17	     The INSERT-MODE command (terminal dependent) toggles the editor
1)	between  replace  mode and insert mode.  You are used to the former,
****
2)17	     The INSERT-MODE command ("-" on the keypad)  toggles the editor
2)	between  replace  mode and insert mode.  You are used to the former,
**************
1)18	(terminal dependent).  The character to the left of the cursor  will
1)	be  deleted  from  the line.  If that character is a tab, the entire
****
2)18	(RUBOUT or DELETE key). The character to the left of the cursor will
2)	be  deleted  from  the line.  If that character is a tab, the entire
**************
   