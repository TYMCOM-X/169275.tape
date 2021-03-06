:---------------------------------------------------------------------
: Patch name:  USEDCB                Product and Version:  CMH 1.07
:     Author:  PHIL SNEDDON                 Organization:  STS/QSATS
:   Customer:  UKNET                        Date Written:  08/03/89
: Description of Problem:  ESC #254651  Ill mem ref. crash at CKAID9+16
:
:---------------------------------------------------------------------

:  PROBLEM - Register 2 was used as the index to the DCB block when it
:            should have been R12.  Since R2 didn't contain this user's
:            DCB index it comes as no surprise that it caused an ill mem
:            ref crash.
:
: SOLUTION - Use R12 as the index.

         IF \PRISM4
PATCH(890803,1013,P/SNEDDON,CKAID9+0A,,6)
         LHL  R2,DCBLKS+DCBSCB,R12,   :USE THE CORRECT DCB INDEX
ENDPATCH(use the correct DCB index register)
         EI (PRISM4)
  