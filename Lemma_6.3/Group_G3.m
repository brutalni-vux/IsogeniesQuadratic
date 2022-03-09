Z25 := Integers(25);
Z5 := Integers(5);

//G3 from Zywina
G3 := sub<GL(2,Z5) | {[2,0,0,2], [1,0,0,4], [0,1,3,0]}>;

Im_rho := G3;

//subgroups H of GL(2, Z25) reducing to G3 modulo 5, up to conjugation
Imm5Ns := [H`subgroup: H in Subgroups(GL(2,Z25)) | IsConjugate(GL(2, Z5), sub<GL(2, Z5) | {GL(2, Z5)!m : m in Generators(H`subgroup)}>, Im_rho)];

//This will count scalars == 1 mod 5
ScalarsCnt := 0;

for i in [1..12] do
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
    
    Gt := sub<GL(2, Z25)|[Transpose(g) : g in Imm5Ns[i]]>;
    S := LineOrbits(Gt);
    "Orbit lengths of cyclic subgroups of order 25 of E[25]: ", [#o : o in S];

    "Going to next subgroup...";
    "------------------------------------------------------------";
    "";
end for;

"All images are impossible, except H4 and H7, as mentioned in the paper.";
"";

"Is H4 conjugate to a subgroup of N_s(25): ";

SubNs25 := sub<GL(2,Z25) | {[0, 2, 1, 0], [14, 0, 0, 11], [21, 0, 0, 21], [7, 0, 0, 18], [24, 0, 0, 24]}>;

IsConjugate(GL(2, Z25), SubNs25, Imm5Ns[4]);

"";

"Is H7 conjugate to a subgroup of N_s(25): ";

SubNs25 := sub<GL(2,Z25) | {[0, 2, 24, 0], [4, 0, 0, 1], [12, 0, 0, 12], [19, 0, 0, 19], [16, 0, 0, 1], [11, 0, 0, 11]}>;

IsConjugate(GL(2, Z25), SubNs25, Imm5Ns[7]);
