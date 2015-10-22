within IDEAS.Buildings.Data.Constructions;
record CavityWallPCM "Example PCM inner layer"
  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=4,
    locGain=2,
     mats={Materials.BrickMe(d=0.08),insulationType,Materials.BrickMi(d=
        0.14),Materials.Energain(d=0.015)});

end CavityWallPCM;
