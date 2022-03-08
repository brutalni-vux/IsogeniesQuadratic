P<x> := PolynomialRing(Integers());

"Matching forms of j-invariant allowing 7-isogeny with fixed values allowing 11-isogeny:";
"";

f := P! (x^2 + 13*x + 49) * (x^2 + 5*x + 1)^3 + x * 11*131^3;
f;
"";
Factorization(f);
"";

f := P! (x^2 + 13*x + 49) * (x^2 + 5*x + 1)^3 + x * 11^2;
f;
"";
Factorization(f);
"";

"We never get a quadratic or linear factor, so simultaneous 11 and 7 isogeny over quadratic field is impossible.";
