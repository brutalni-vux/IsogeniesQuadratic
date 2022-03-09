Z27 := Integers(27);

//Group of level 27 mentioned in the paper
Im_rho:=sub<GL(2, Z27) | {[1,1,0,1], [2,1,9,5], [1,2,3,2]}>;

Gt := sub<GL(2, Z27)|[Transpose(g) : g in Im_rho]>;
S := LineOrbits(Gt);
"Orbit lengths of cyclic subgroups of order 27 of E[27] when -I is in image: ", [#o : o in S];

"";

"If -I is not in the image, check all options for the image:";

"";

Subs := [H`subgroup: H in Subgroups(Im_rho) | #H`subgroup eq #Im_rho/2];

for i in [1..#Subs] do
    contains := 0;

    for g in Subs[i] do
        if Z27!g[1][2] eq 0 and Z27!g[2][1] eq 0 and Z27!g[1][1] eq -1 and Z27!g[2][2] eq -1 then
            contains := 1;
        end if;
    end for;

    if contains eq 0 then
        Gt := sub<GL(2, Z27)|[Transpose(g) : g in Subs[i]]>;
        S := LineOrbits(Gt);
        "Subgroup", i, ", Orbit lengths of cyclic subgroups of order 27 of E[27]: ", [#o : o in S];
    end if;
        
end for;
