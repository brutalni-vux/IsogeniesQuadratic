load "quadptssieve.m";
load "ozmansiksek.m";
load "X091_NiceModel.m";

//We find models for X091 and X091/w91

C := CuspForms(91);
assert Dimension(C) eq 7;

w91 := AtkinLehnerOperator(C, 91);
N91 := Nullspace(Matrix(w91 - 1));
N91c := Nullspace(Matrix(w91 + 1));
B91 := [&+[(Integers()!(2 * Eltseq(Basis(N91)[i])[j])) * C.j : j in [1..Dimension(C)]] : i in [1..Dimension(N91)]];
B91c:=[&+[(Integers()!(2 * Eltseq(Basis(N91c)[i])[j])) * C.j : j in [1..Dimension(C)]] : i in [1..Dimension(N91c)]];

X091 := modformeqns(B91c cat B91, 91, 500, 13);
"Nice model for X0(91) is:";
X091;
"";

pts:=PointSearch(X091, 10);
pts;

//we bound and determine torsion of J0(91)(Q), rank is 2
torsElems := 0;

for p in [3,5,19] do
	if IsPrime(p) and p ne 7 and p ne 13 then
		Xp := ChangeRing(X091, GF(p));
		C, phi, psi := ClassGroup(Xp);
		Z := FreeAbelianGroup(1);
		degr := hom<C->Z | [ Degree(phi(a)) * Z.1 : a in OrderedGenerators(C)]>;
		JFp := Kernel(degr); // This is isomorphic to J_X91(\F_p).
		torsElems := GCD(torsElems, #JFp);
		"J(Fp) is iso to:";
		JFp, torsElems, p;
	end if;
end for;

D1 := Divisor(pts[2]) - Divisor(pts[1]);
D2 := Divisor(pts[3]) - Divisor(pts[1]);
D3 := Divisor(pts[4]) - Divisor(pts[1]);

G1 := 2*D1 + D2;
G2 := 21*D3;

"Is G1 of order exactly 168?";
IsPrincipal(168*G1) and (not IsPrincipal(84*G1)) and (not IsPrincipal(56*G1)) and (not IsPrincipal(24*G1));
"";

"Is G2 of order 2?";
IsPrincipal(2*G2) and (not IsPrincipal(G2));
"";

"Is G2 independent of G1?";
not IsPrincipal(84*G1 - G2);

"Hence, G1, G2 generate the torsion Z/2Z + Z/168Z which is the whole torsion by the above reductions";
"";

RR<[u]> := CoordinateRing(AmbientSpace(X091));
n := Dimension(AmbientSpace(X091));

//now we determine the quotient X0(91)+

H := Matrix(RationalField(), 7, 7, [1,0,0,0,0,0,0, 0,1,0,0,0,0,0, 0,0,1,0,0,0,0, 0,0,0,1,0,0,0, 0,0,0,0,1,0,0, 0,0,0,0,0,-1,0, 0,0,0,0,0,0,-1]);
rows := [[&+[RowSequence(H)[i][j] * u[j] : j in [1..n + 1]] : i in [1..n + 1]]];
w91 := iso<X091 -> X091 | rows, rows>;
"w91 on X0(91) is given by:";
w91;
"";

C, projC := CurveQuotient(AutomorphismGroup(X091, [w91]));
CSimp, mpSimp := SimplifiedModel(C);
X91_to_CSimp := Expand(projC*mpSimp);

J:=Jacobian(CSimp);
RankBounds(J); //rank of J0(91)+(Q) is 2, same as of J0(91)(Q), that is needed

PointsCSimp := Points(CSimp: Bound := 20);

Q1 := PointsCSimp[1] - PointsCSimp[2];
Q2 := PointsCSimp[4] - PointsCSimp[2];

bas, Mat := ReducedBasis([Q1, Q2]);
assert #bas eq 2;

//We will show that Q1, Q2 are a basis using Stoll's algorithm, similar to Box
NMat := Orthogonalize(Mat);
absbd := Ceiling(Exp((NMat[1, 1]^2 + NMat[1, 2]^2 + NMat[2, 1]^2 + NMat[2, 2]^2)/4 + HeightConstant(J)));

//J(C)(\Q) is generated by Q1, Q2 and all points of height up to absbd.
"";
PtsUpToAbsBound := Points(J : Bound := absbd);
"";
assert ReducedBasis([pt : pt in PtsUpToAbsBound]) eq [Q1, Q2];

//We use these generators to find the free generators of J_0(91)(\Q)
R1 := Pullback(X91_to_CSimp, Place(PointsCSimp[1]) - Place(PointsCSimp[2]));
R2 := Pullback(X91_to_CSimp, Place(PointsCSimp[4]) - Place(PointsCSimp[2]));
//R1, R2 generate free part of J0(91)(Q) up to mult by I:=2

bp := Pullback(X91_to_CSimp, Place(PointsCSimp[2]));

//known degree 1 places
pls1 := [Place(pts[1]), Place(pts[2]), Place(pts[3]), Place(pts[4])];

deg2 := [];
deg2pb := [];

//a non-pullback quadratic point
K13<rt13> := QuadraticField(13);
alpha := 17/18 + 5*rt13/18;
P13 := X091(K13)![-8/5*alpha + 7/5, 3/5*alpha - 7/5, -1/5*alpha + 9/5, alpha, 1, 0, 0];

//P13 is not a pullback of a rational since it is fixed by w91 and not by Galois conjugate
deg2 := Append(deg2, 1*Place(P13));

//add degree 2 divisors coming from rational pts on X091
for i in [1..#pls1] do
	for j in [i..#pls1] do
		deg2 := Append(deg2, 1*pls1[i] + 1*pls1[j]);
		if w91(RepresentativePoint(pls1[i])) eq RepresentativePoint(pls1[j]) then
			deg2pb := Append(deg2pb, 1*pls1[i] + 1*pls1[j]);
		end if;
	end for;
end for;

//add non-rational pullbacks of rationals (indices 1 and 5 give rational pullbacks, already added above)
for i in [2..#PointsCSimp] do
	if i ne 5 then
		deg2 := Append(deg2, Decomposition(Pullback(X91_to_CSimp, Place(PointsCSimp[i])))[1][1]);
		deg2pb := Append(deg2pb, Decomposition(Pullback(X91_to_CSimp, Place(PointsCSimp[i])))[1][1]);
	end if;
end for;

deg2npb := [DD : DD in deg2 | not DD in deg2pb];

"We have found ", #deg2, " points on X_0(91)^2(Q).";
#deg2pb, "of them are pullbacks of rationals from X0(91)/w91.";
#deg2npb, "of them are non-pullbacks";

//Finally, we do the sieve.
A := AbelianGroup([0, 0, 2, 168]);
divs := [R1, R2, G2, G1];
genusC := Genus(CSimp);
auts := [H];

//index of subgroup of J(X) generated by divs is at most 2, see prop 3.1. of Box paper
I := 2;

primes := [3, 5, 11, 17, 19, 23, 29, 31, 37, 41];

"Succeeded in proving that we have all exceptional quadratic pts? (true /false)";
MWSieve(deg2, primes, X091, A, divs, auts, genusC, deg2pb, deg2npb, I, bp);
"";


//////////////////////////
//////////////////////////
//////////////////////////


//we can explicitly determine the quadratic points arising as pullbacks from rationals on X0(91)+
hyppts := Points(CSimp : Bound := 10);

//it is known that X0(91)+ has 10 rational points
assert #hyppts eq 10;

Cpts := [hyppts[i]@@mpSimp : i in [1..#hyppts]];
assert #Cpts eq 10;

"The discriminants of quadratic fields over which quadratic pullbacks are defined are, in order:";

for i in [1..#Cpts] do
	CurrDiv := Pullback(projC, Place(Cpts[i]));
	CurrDeg := 2 / #Decomposition(Pullback(projC, Place(Cpts[i])));
	K := ResidueClassField(Decomposition(Pullback(projC, Place(Cpts[i])))[1][1]);
	discK := SquareFreeFactorization(Discriminant(Integers(K)));
	discK;
end for;

"Hence, 8 of them are quadratic pairs of conjugates and 2 are rationals";

//these are all the quadratic points on X0(91) arising as pullbacks of rationals on X0(91)+
//up to galois conjugates

_<x>:=PolynomialRing(Rationals());
K3<rt3> := QuadraticField(-3);
P1 := X091(K3)![1/rt3, 0, -1/rt3, -1/rt3, 0, 1, 1];
P2 := X091(K3)![1/rt3, 0, -1/rt3, 0, -1/rt3, 0, 1];
P3 := X091(K3)![1/rt3, 0, -1/rt3, -2/rt3, -1/rt3, 0, 1];
P4 := X091(K3)![2/rt3, -1/rt3, -1/rt3, -1/rt3, -1/rt3, 1, 0];
P5 := X091(K3)![1/(3*rt3), -1/(2*rt3), -5/(6*rt3), -1/(2*rt3), 1/(6*rt3), 3/2, 1];
P6 := X091(K3)![7/(3*rt3), -2/rt3, -7/(3*rt3), -5/(3*rt3), -4/(3*rt3), 3, 1];

K87<rt87> := QuadraticField(-87);
P7 := X091(K87)![31/(2*rt87), 3/(rt87), -2/(rt87), -4/(rt87), -8/(rt87), 3/2, 1];
P8 := X091(K87)![14/(rt87), 12/(rt87), 7/(rt87), 3/(rt87), 1/(rt87), 3, 1];
