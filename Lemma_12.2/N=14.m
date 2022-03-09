_<t>:=RationalFunctionField(Rationals());

//form of j-invariant giving Ns(7) as image of Galois
f1 := t*(t+1)^3*(t^2-5*t+1)^3*(t^2-5*t+8)^3*(t^4-5*t^3+8*t^2-7*t+7)^3/(t^3-4*t^2+3*t+1)^7;

//form of j-invariant allowing rational 2-isogeny
f2 := (t+16)^3/t;

R<x,y> := PolynomialRing(Rationals(), 2);
C := ProjectiveClosure(Curve(AffineSpace(R),Numerator(Evaluate(f1,x)-Evaluate(f2,y))));

"We need to find rational points on C:";
C;
"";

"Genus is:", Genus(C);
"";

Phi := CanonicalMap(C);
CQ<X,Y,Z> := CanonicalImage(C, Phi);

"Canonical image is CQ:";
CQ;
"";

aut := AutomorphismGroup(CQ);
CC, c := CurveQuotient(aut);
"";
"CQ has a degree ", Degree(c), " quotient of genus ", Genus(CC);
"";

pts := PointSearch(CQ, 1000);

E, mE := EllipticCurve(CC, c(pts[1]));
"That quotient is E:", E;
"";

rk, tr := Rank(E);
assert tr;

"Rank of E is", rk;
"";

g, m := TorsionSubgroup(E);
"Torsion of E is:", g;
"";

P1 := m(g.1);
mp:=c*mE;

ptsCQ:={@@};

for i in [1..6] do
    ptsCQ := ptsCQ join Points((i*P1)@@mp);
end for;

"All rational points on CQ are:";
ptsCQ;
"";

ptsC := {@@};

for i in [1..4] do
    ptsC := ptsC join Points(ptsCQ[i]@@Phi);
end for;

"Taking preimage again, all rational points on C are:";
ptsC;
"";
"It is easy to check that they only give us j-invariants 0 or 54000 (CM)";
