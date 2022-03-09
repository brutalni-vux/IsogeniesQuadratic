P2<x,j> := PolynomialRing(Rationals(),2);
f:=P2!ClassicalModularPolynomial(49);

g := Evaluate(f, j, 2268945/128);
factors := Factorization(g);

"Irreducible factors of FI(X, 2268945/128) are of degrees:";
"";

for i in [1..#factors] do
    Degree(factors[i][1]);
end for;
"";

"No degree is at most 2, hence j=2268945/128 can't give us a cyclic 49-isogeny over at most quadratic field.";
"------------------------------------------------------------------------------------";
"------------------------------------------------------------------------------------";
"";

Z49 := Integers(49);
Z7 := Integers(7);

r := PrimitiveRoot(7);

//Ns(7)
G7Ns:=sub<GL(2,Z7) | {[1,0,0,r], [r,0,0,1], [0,1,1,0]}>;

Im_rho := G7Ns;

//subgroups of GL(2, Z49) reducing to Ns(7) modulo 7, up to conjugation
Imm7Ns := [H`subgroup: H in Subgroups(GL(2,Z49)) | IsConjugate(GL(2,Z7),sub<GL(2,Z7) | {GL(2,Z7)!m : m in Generators(H`subgroup)}>,Im_rho)];

//This will count scalars == 1 mod 7
ScalarsCnt := 0;

for i in [1..8] do
    ScalarsCnt := 0;

    for g in Imm7Ns[i] do
        if Z49!g[1][2] eq 0 and Z49!g[2][1] eq 0 and Z7!g[1][1] eq 1 and Z49!g[1][1] eq Z49!g[2][2] then
            ScalarsCnt := ScalarsCnt + 1;
        end if;
    end for;

    "Array index of group:", i;
    Imm7Ns[i];
    "Number of scalars == 1 mod 7:", ScalarsCnt;
    "";
    
    Gt := sub<GL(2, Z49)|[Transpose(g) : g in Imm7Ns[i]]>;
    S := LineOrbits(Gt);
    "Orbit lengths of cyclic subgroups of order 49 of E[49]: ", [#o : o in S];

    "Going to next subgroup...";
    "------------------------------------------------------------";
    "";
end for;

"All images are impossible, except H3 and H5, as mentioned in the paper.";
"";

"Is H3 conjugate to a subgroup of N_s(49): ";

SubNs49 := sub<GL(2,Z49) | {[0, 2, 23, 0], [43, 0, 0, 39], [36, 0, 0, 13], [48, 0, 0, 48], [4, 0, 0, 4], [8, 0, 0, 8]}>;

IsConjugate(GL(2, Z49), SubNs49, Imm7Ns[3]);

"";

"Is G5 conjugate to N_s(49): ";
s := PrimitiveRoot(49);
Ns49 := sub<GL(2,Z49) | {[1,0,0,s], [s,0,0,1], [0,1,1,0]}>;

IsConjugate(GL(2, Z49), Ns49, Imm7Ns[5]);
