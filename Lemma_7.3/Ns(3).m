Z9:=Integers(9);
Z3:=Integers(3);

r := PrimitiveRoot(3);

//Ns(3)
G3Ns:=sub<GL(2,Z3) | {[1,0,0,r], [r,0,0,1], [0,1,1,0]}>;

Im_rho:=G3Ns;

//subgroups H of GL(2, Z9) reducing to Ns(3) modulo 3, up to conjugation
Imm3Ns := [H`subgroup: H in Subgroups(GL(2, Z9)) | IsConjugate(GL(2, Z3), sub<GL(2, Z3) | {GL(2, Z3)!m : m in Generators(H`subgroup)}>, Im_rho)];

for i in [1..#Imm3Ns] do
    "Array index of group:", i;
    Imm3Ns[i];
    
    Gt := sub<GL(2, Z9)|[Transpose(g) : g in Imm3Ns[i]]>;
    S := LineOrbits(Gt);
    "Orbit lengths of cyclic subgroups of order 9 of E[9]: ", [#o : o in S];

    "Going to next subgroup...";
    "";
end for;

"All images are impossible, except H1, H3, H4 and H8, as mentioned in the paper.";
"";

s := PrimitiveRoot(9);

G9Ns := sub<GL(2, Z9) | {[1,0,0,s], [s,0,0,1], [0,1,1,0]}>;

"H1 is conjugate to this subgroup of Ns(9):";
ConjugSubgroups := [H`subgroup: H in Subgroups(G9Ns) | IsConjugate(GL(2,Z9), H`subgroup, Imm3Ns[1])];
ConjugSubgroups;

"H3 is conjugate to this subgroup of Ns(9):";
ConjugSubgroups := [H`subgroup: H in Subgroups(G9Ns) | IsConjugate(GL(2,Z9), H`subgroup, Imm3Ns[3])];
ConjugSubgroups;

"H4 is conjugate to this subgroup of Ns(9):";
ConjugSubgroups := [H`subgroup: H in Subgroups(G9Ns) | IsConjugate(GL(2,Z9), H`subgroup, Imm3Ns[4])];
ConjugSubgroups;

"H8 is conjugate to this subgroup of Ns(9):";
ConjugSubgroups := [H`subgroup: H in Subgroups(G9Ns) | IsConjugate(GL(2,Z9), H`subgroup, Imm3Ns[8])];
ConjugSubgroups;
