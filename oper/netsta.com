DIR 51016#.*
DEL 51016#.DMI
REN 51016.CTL,A51016.CTL
FI DIR.TMP=A#####.CTL
MAG
RUN NETSTATS.DLY
9510.16 
Q
COPY SZ9510.16,SIZE10.16
    