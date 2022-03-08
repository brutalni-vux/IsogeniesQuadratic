_<t>:=RationalFunctionField(Rationals());

//Form of j-invariant allowing a rational 13-isogeny
f1:=(t^2 + 5*t + 13) * (t^4 + 7*t^3 + 20*t^2 + 19*t + 1)^3/t;

//For of j-invariant if there is no rational 3-isogeny
f2:=t^3;

R<x,y>:=PolynomialRing(Rationals(),2);
C:=ProjectiveClosure(Curve(AffineSpace(R),Numerator(Evaluate(f1,x)-Evaluate(f2,y))));

"We need to find rational points on C:";
C;
"";

"Genus is:", Genus(C);
"";

tr, x:=IsHyperelliptic(C);

"Is C hyperelliptic?", tr;
"";

x1,f:=SimplifiedModel(x);
f2:=Inverse(f);

"Simplified model is X1:";
x1;
"";

J:=Jacobian(x1);
"Rank of the Jacobian is at most", RankBound(J);
"";

tr,g:=IsIsomorphic(C, x);
assert tr;

tr,g2:=IsInvertible(g);
assert tr;

g2:=Inverse(g);

pts:=Chabauty0(J);
"All points on X1 are:";
pts;
"";

"All points on C are:";

for i:=1 to #pts do
g2(f2(pts[i]));
end for;
"";

"All have Z coordinate 0, so the j-invariants can't match and this combination is impossible.";
