options solver lpsolve;
# PARAMETRY
param l; # iloœæ lokat
param m; # iloœæ miesiêcy
param F; # wartoœæ funduszu
param Z {1 .. l}; # zysk i-tej lokaty
param R {1 .. l}; # ryzyko i-tek lokaty

# ZMIENNE DECYZYJNE
var x {1..l, 1..m} >= 0; # wartoœæ i-tej lokaty na pocz¹tku j-tego miesi¹ca

# ZMIENNE STANU
var P = Z[1]*x[1,6] + Z[2]*x[2,6] + Z[3]*x[3,6] + Z[4]*x[4,6] - F; # zysk po 6 miesi¹cu
var H {j in 1..m} = sum {i in 1..l} R[i]*x[i,j]; # ryzyko w j-tym miesi¹cu
var M {1..m}; # mobilnoœæ w j-tym miesi¹cu
subject to oM1: M[1] = Z[1]*x[1,1];
subject to oM2: M[2] = Z[1]*x[1,2] + Z[2]*x[2,2];
subject to oM3: M[3] = Z[1]*x[1,3] + Z[3]*x[3,3];
subject to oM4: M[4] = Z[1]*x[1,4] + Z[2]*x[2,4];
subject to oM5: M[5] = Z[1]*x[1,5];
subject to oM6: M[6] = Z[1]*x[1,6] + Z[2]*x[2,6] + Z[3]*x[3,6] + Z[4]*x[4,6];

# OGRANICZENIA
# I
subject to o11: x[1,1] + x[2,1] + x[3,1] + x[4,1] = F;
# II
subject to o21: x[1,2] = Z[1]*x[1,1];
subject to o22: x[2,2] = x[2,1];
subject to o23: x[3,2] = x[3,1];
subject to o24: x[4,2] = x[4,1];
# III
subject to o31: x[1,3] + x[2,3] = Z[1]*x[1,2] + Z[2]*x[2,2];
subject to o32: x[3,3] = x[3,2];
subject to o33: x[4,3] = x[4,2];
# IV
subject to o41: x[1,4] + x[3,4] = Z[1]*x[1,3] + Z[3]*x[3,3];
subject to o42: x[2,4] = x[2,3];
subject to o43: x[4,4] = x[4,3];
# V
subject to o51: x[1,5] + x[2,5] = Z[1]*x[1,4] + Z[2]*x[2,4];
subject to o52: x[3,5] = x[3,4];
subject to o53: x[4,5] = x[4,4];
# VI
subject to o61: x[1,6] = Z[1]*x[1,5];
subject to o62: x[2,6] = x[2,5];
subject to o63: x[3,6] = x[3,5];
subject to o64: x[4,6] = x[4,5];

# FUNKCJE CELU
var ZYSK = P;
var RYZYKO >= 0; #var RYZYKO = max {j in 1..m} H[j];
subject to oRYZYKO{j in 1..m}: RYZYKO >= H[j];
var MOBILNOSC >= 0; #var MOBILNOSC = min {j in 1..m} M[j];
subject to oMOBILNOSC{j in 1..m}: MOBILNOSC <= M[j];

#DATA
data fundusz.dat;
