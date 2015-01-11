# BASE MODEL
model fundusz.mod;

# PARAMETRY
param MAX_RYZYKO; # sztywne ograniczenie steruj�ce

param ASPIRACJA_ZYSK;
param ASPIRACJA_MOBILNOSC;

param WM_ZYSK;
param WP_ZYSK;

param WM_MOBILNOSC;
param WP_MOBILNOSC;

# OGRANICZENIA STERUJACE
subject to oMAX_RYZYKO: RYZYKO <= MAX_RYZYKO;

# ROWNANIA CELOWE
var DM_ZYSK >= 0;
var DP_ZYSK >= 0;
subject to oDMP_ZYSK: ASPIRACJA_ZYSK = ZYSK + DM_ZYSK - DP_ZYSK;

var DM_MOBILNOSC >= 0;
var DP_MOBILNOSC >= 0;
subject to oDMP_MOBILNOSC: ASPIRACJA_MOBILNOSC = MOBILNOSC + DM_MOBILNOSC - DP_MOBILNOSC;

# MINIMALIZACJA ODCHYLEN
var D_ZYSK;
subject to oD_ZYSK: D_ZYSK >= WM_ZYSK*DM_ZYSK + WP_ZYSK*DP_ZYSK;
 
var D_MOBILNOSC;
subject to oD_MOBILNOSC: D_MOBILNOSC >= WM_MOBILNOSC*DM_MOBILNOSC + WP_MOBILNOSC*DP_MOBILNOSC;

#PC ARCHIMEDESOWE
var g = D_ZYSK + D_MOBILNOSC;
minimize PC: g;

# DATA
data funduszCel.dat;
# SOLVE
solve;
# DISPLAY
display MAX_RYZYKO;
display ASPIRACJA_ZYSK;
display ASPIRACJA_MOBILNOSC;
display RYZYKO;
display ZYSK;
display MOBILNOSC;

display x;