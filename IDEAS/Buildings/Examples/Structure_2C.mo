within IDEAS.Buildings.Examples;
model Structure_2C "Example detailed building structure model"
  extends Modelica.Icons.Example;
  BaseClasses.structure structure(redeclare package Medium = IDEAS.Media.Air,
    sF_roof(linearise_a=true, layMul(lumpingType=2)),
    sF_floor(linearise_a=true, linearise_b=true, layMul(lumpingType=0)),
    sF_ext(linearise_a=true, layMul(lumpingType=2)),
    sF_win(linearise_a=true),
    fF_floor(linearise_a=true, linearise_b=true, layMul(lumpingType=0)),
    fF_ext(linearise_a=true, layMul(lumpingType=2)),
    gF_floor(linearise_a=true, linearise=true, layMul(lumpingType=0)),
    fF_win(linearise_a=true),
    gF_ext(linearise_a=true, layMul(lumpingType=2)),
    gF_win(linearise_a=true))
    annotation (Placement(transformation(extent={{-36,-20},{-6,0}})));
  Circuits.Ventilation.None none(
    nLoads=0,
    nZones=structure.nZones,
    VZones=structure.VZones,
    redeclare package Medium = IDEAS.Media.Air)
    annotation (Placement(transformation(extent={{18,0},{38,20}})));
  inner IDEAS.BoundaryConditions.SimInfoManager       sim
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo[3]
    annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
  Modelica.Blocks.Sources.Cosine cosine[3](
    each amplitude=300,
    each offset = 100,
    each freqHz=1/864000,
    phase={0,261.79938779915,523.5987755983})
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation
  connect(structure.flowPort_Out, none.flowPort_In) annotation (Line(
      points={{-28.1739,0},{-24,0},{-24,12},{18,12}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(structure.flowPort_In, none.flowPort_Out) annotation (Line(
      points={{-22.9565,0},{-20,0},{-20,8},{18,8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(structure.TSensor, none.TSensor) annotation (Line(
      points={{-5.21739,-16},{8,-16},{8,4},{17.8,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cosine.y, preHeaFlo.Q_flow) annotation (Line(points={{-19,-40},{-13.5,
          -40},{-8,-40}}, color={0,0,127}));
  connect(preHeaFlo.port, structure.heatPortEmb) annotation (Line(points={{12,-40},
          {14,-40},{14,-4},{-6,-4}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=5e+006,
      Interval=3600,
      Tolerance=1e-006,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput);
end Structure_2C;
