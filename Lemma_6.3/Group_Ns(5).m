Z25 := Integers(25);
Z5 := Integers(5);

r := PrimitiveRoot(5);

//Ns(5)
G5Ns:=sub<GL(2,Z5) | {[1,0,0,r], [r,0,0,1], [0,1,1,0]}>;

Im_rho := G5Ns;

//subgroups H of GL(2, Z25) reducing to Ns(5) modulo 5, up to conjugation
Imm5Ns := [H`subgroup: H in Subgroups(GL(2, Z25)) | IsConjugate(GL(2, Z5), sub<GL(2, Z5) | {GL(2, Z5)!m : m in Generators(H`subgroup)}>, Im_rho)];

//This will count scalars == 1 mod 5
ScalarsCnt := 0;

for i in [1..8] do
    ScalarsCnt := 0;

    for g in Imm5Ns[i] do
        if Z25!g[1][2] eq 0 and Z25!g[2][1] eq 0 and Z5!g[1][1] eq 1 and Z25!g[1][1] eq Z25!g[2][2] then
            ScalarsCnt := ScalarsCnt + 1;
        end if;
    end for;

    "Array index of group:", i;
    Imm5Ns[i];
    "No. of scalars == 1 mod 5:", ScalarsCnt;
    "";
    
    Gt:=sub<GL(2, Z25)|[Transpose(g) : g in Imm5Ns[i]]>;
    S:=LineOrbits(Gt);
    "Orbit lengths of rank 1 submodules of E[25]: ", [#o : o in S];

    "Going to next subgroup...";
    "------------------------------------------------------------";
    "";
end for;

"All images are impossible, except H3 and H5, as mentioned in the paper.";
"";

"Is H3 conjugate to a subgroup of N_s(25): ";

SubNs25:=sub<GL(2,Z25) | {[0, 2, 24, 0], [24, 0, 0, 1], [0, 4, 14, 0], [48, 0, 0, 48], [18, 0, 0, 18], [24, 0, 0, 24], [21, 0, 0, 21]}>;

IsConjugate(GL(2, Z25), SubNs25, Imm5Ns[3]);

"";

"Is H5 conjugate to N_s(25): ";
s := PrimitiveRoot(25);
Ns25:=sub<GL(2,Z25) | {[1,0,0,s], [s,0,0,1], [0,1,1,0]}>;

IsConjugate(GL(2, Z25), Ns25, Imm5Ns[5]);
