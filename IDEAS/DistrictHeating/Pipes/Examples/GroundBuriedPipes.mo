within IDEAS.DistrictHeating.Pipes.Examples;
model GroundBuriedPipes

  //Extensions
  extends Modelica.Icons.Example;

  Modelica.Fluid.Pipes.DynamicPipe supplypipe(
    diameter=0.6,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    length=100,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (k=0.2, alpha0=0.2),
    nNodes=50) annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  Modelica.Fluid.Pipes.DynamicPipe returnpipe(
    diameter=0.6,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    length=100,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (k=0.2, alpha0=0.2),
    nNodes=50)
    annotation (Placement(transformation(extent={{10,-30},{-10,-10}})));

  Modelica.Fluid.Sources.FixedBoundary returnsink(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15)
    annotation (Placement(transformation(extent={{-86,-30},{-66,-10}})));

  Modelica.Fluid.Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=343.15) annotation (Placement(transformation(extent={{-88,30},{-68,50}})));

  Modelica.Fluid.Sources.MassFlowSource_T boundary1(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow=0.2,
    T=318.15) annotation (Placement(transformation(extent={{90,-30},{70,-10}})));

  Modelica.Fluid.Sources.FixedBoundary supplysink(
    nPorts=1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    T=343.15) annotation (Placement(transformation(extent={{90,30},{70,50}})));

equation
  connect(supplypipe.port_a, boundary.ports[1]) annotation (Line(
      points={{-10,40},{-68,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(returnpipe.port_a, boundary1.ports[1]) annotation (Line(
      points={{10,-20},{70,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(returnpipe.port_b, returnsink.ports[1]) annotation (Line(
      points={{-10,-20},{-66,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(supplypipe.port_b, supplysink.ports[1]) annotation (Line(
      points={{10,40},{70,40}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end GroundBuriedPipes;
