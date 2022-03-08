_<t>:=RationalFunctionField(Rationals());

//Form of j-invariant allowing a rational 13-isogeny
f1:=(t^2 + 5*t + 13) * (t^4 + 7*t^3 + 20*t^2 + 19*t + 1)^3/t;

//For of j-invariant if there is no rational 2-isogeny
f2:=t^2 + 1728;

R<x,y>:=PolynomialRing(Rationals(),2);
C:=ProjectiveClosure(Curve(AffineSpace(R),Numerator(Evaluate(f1,x)-Evaluate(f2,y))));

"We need to find rational points on C:";
C;
"";

"Genus is:", Genus(C);
"";

bound:=10^3;
Pts := PointSearch(C,bound);
Pt := Pts[1];

E, mp1 := EllipticCurve(C, Pt);

"C is isomorphic to this elliptic curve E:", CremonaReference(E);
"";

EE, mm := MinimalModel(E);
mm := mm^-1;

"Minimal model is: ", EE;
"";

rk, tr := Rank(EE);
assert tr;

"Rank of E is:", rk;
"";

T,mp2 := TorsionSubgroup(EE);
"Torsion of E is:", T;
"";

PtsC := { };
for p in T do
	PtsC := PtsC join RationalPoints(mm(mp2(p)) @@ mp1);
end for;

"All points on C are:";
PtsC;
"";

"All have Z coordinate 0, so the j-invariants can't match and this combination is impossible.";
