P<x> := PolynomialRing(Integers());

"Matching forms of j-invariant allowing 7-isogeny with fixed valued allowing 17-isogeny:";
"";

f := P! 2*(x^2 + 13 * x + 49) * (x^2 + 5 * x + 1)^3 + x * 17^2 * 101^3;
f;
"";
Factorization(f);
"";

f := P! 2^17*(x^2 + 13 * x + 49) * (x^2 + 5 * x + 1)^3 + x * 17 * 373^3;
f;
"";
Factorization(f);
"";

"We never get a quadratic or linear factor, so simultaneous 17 and 7 isogeny over quadratic field is impossible.";
