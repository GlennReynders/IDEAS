within IDEAS.Buildings.Components.Examples;
model SimplifiedWalls "Comparison of simplified wall model"
  package Medium = IDEAS.Media.Air;
  inner IDEAS.BoundaryConditions.SimInfoManager sim
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));

  extends Modelica.Icons.Example;
  IDEAS.Fluid.Sources.Boundary_pT bou(redeclare package Medium = Medium,
      nPorts=1)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));

  IDEAS.Buildings.Components.Zone zone1(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    V=20,
    nSurf=3)
         annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  IDEAS.Buildings.Components.OuterWall outerWall(
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    insulationThickness=0.1,
    AWall=10,
    redeclare Data.Constructions.CavityWall constructionType)
    "Vertical wall with partially filled cavity"
    annotation (Placement(transformation(extent={{-54,-32},{-44,-12}})));

  IDEAS.Buildings.Components.OuterWall Lumped1(
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    insulationThickness=0.1,
    AWall=10,
    redeclare Data.Constructions.CavityWall constructionType,
    layMul(lumpingType=1)) "Vertical wall with partially filled cavity"
    annotation (Placement(transformation(extent={{-54,-68},{-44,-48}})));
  IDEAS.Buildings.Components.OuterWall Lumped2(
    inc=IDEAS.Types.Tilt.Wall,
    azi=IDEAS.Types.Azimuth.S,
    insulationThickness=0.1,
    AWall=10,
    redeclare Data.Constructions.CavityWall constructionType,
    layMul(lumpingType=2)) "Vertical wall with partially filled cavity"
    annotation (Placement(transformation(extent={{-54,-96},{-44,-76}})));
equation
  connect(zone1.flowPort_In, bou.ports[1])
    annotation (Line(points={{32,-50},{32,90},{-40,90}}, color={0,0,0}));
  connect(Lumped1.propsBus_a, zone1.propsBus[2]) annotation (Line(
      points={{-44,-54},{-14,-54},{-14,-58},{20,-58},{20,-56}},
      color={255,204,51},
      thickness=0.5));
  connect(outerWall.propsBus_a, zone1.propsBus[1]) annotation (Line(
      points={{-44,-18},{-12,-18},{-12,-54.6667},{20,-54.6667}},
      color={255,204,51},
      thickness=0.5));
  connect(Lumped2.propsBus_a, zone1.propsBus[3]) annotation (Line(
      points={{-44,-82},{-12,-82},{-12,-57.3333},{20,-57.3333}},
      color={255,204,51},
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Buildings/Components/Examples/CavityWalls.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
February 16, 2016, by Glenn Reynders:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StopTime=5e+006,
      Interval=300,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput);
end SimplifiedWalls;
