(* Udu drum family Helmholtz notebook starter *)

ClearAll["Global`*"];

c = 13510; (* in/s at about 68 F *)

areaCircle[d_] := Pi*(d/2)^2;
leff[wall_, area_] := wall + 0.6*Sqrt[area/Pi];
volumeOvoid[diam_, height_, shapeFactor_] := Pi/6*diam^2*height*shapeFactor;
helmholtzHz[area_, volume_, neckLength_] :=
  (c/(2*Pi))*Sqrt[area/(volume*neckLength)];
centsError[measured_, target_] := 1200*Log[2, measured/target];

uduModel[name_, diam_, height_, wall_, mouthDiam_, sideDiam_, shapeFactor_] :=
 Module[{v, aMouth, aSide, lMouth, lSide},
  v = volumeOvoid[diam, height, shapeFactor];
  aMouth = areaCircle[mouthDiam];
  aSide = areaCircle[sideDiam];
  lMouth = leff[wall, aMouth];
  lSide = leff[wall, aSide];
  <|
   "Name" -> name,
   "VolumeIn3" -> v,
   "MouthHz" -> helmholtzHz[aMouth, v, lMouth],
   "SideHz" -> helmholtzHz[aSide, v, lSide],
   "IntervalSemitones" -> 12*Log[2, helmholtzHz[aMouth, v, lMouth]/helmholtzHz[aSide, v, lSide]]
  |>
 ];

models = {
  uduModel["Small", 8, 10, 0.3, 3, 2, 0.7],
  uduModel["Medium", 10, 12, 0.3, 3, 2, 0.7],
  uduModel["Large", 12, 14, 0.3, 3, 2, 0.7],
  uduModel["XL", 14, 16, 0.3, 3, 2, 0.7]
};

Dataset[models]

(* First coupled-mode placeholder: replace kCouple with measured fit. *)
coupledFrequencies[f1_, f2_, kCouple_] :=
 Sqrt[Eigenvalues[{{f1^2, kCouple}, {kCouple, f2^2}}]];

