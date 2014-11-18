within IDEAS.DistrictHeating.Production.Examples;
model TestHeatpump
  extends Modelica.Icons.Example;

  Fluid.FixedResistances.Pipe_Insulated       pipe_Insulated(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20)
         annotation (Placement(transformation(extent={{-10,-4},{10,4}},
        rotation=270,
        origin={50,40})));
  Modelica.Blocks.Sources.Constant const(k=300)
    annotation (Placement(transformation(extent={{-96,54},{-76,74}})));
  Fluid.Movers.Pump pump(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{8,40},{28,60}})));
  Fluid.Sources.FixedBoundary bou(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={48,-10})));
  Fluid.Sensors.TemperatureTwoPort genericT(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-28,40},{-8,60}})));
  HeatPump heatPump(
    dp_nominal=20,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    QNom=4000,
    m_flow_nominal=0.1,
    redeclare
      IDEAS.DistrictHeating.Production.Data.HeatPumps.VitoCal300GBWS301dotA29
      data)
    annotation (Placement(transformation(extent={{-66,12},{-46,34}})));

  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-98,12},{-78,32}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-72,-70},{-52,-50}})));
equation
  connect(pipe_Insulated.port_a,pump. port_b) annotation (Line(
      points={{50,50},{28,50}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(bou.ports[1],pipe_Insulated. port_b) annotation (Line(
      points={{50,0},{50,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(genericT.port_b,pump. port_a) annotation (Line(
      points={{-8,50},{8,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.port_b, genericT.port_a) annotation (Line(
      points={{-45.8,18},{-40,18},{-40,50},{-28,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.port_a, pipe_Insulated.port_b) annotation (Line(
      points={{-45.8,26},{-20,26},{-20,10},{40,10},{40,18},{50,18},{50,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(const.y, heatPump.TSet) annotation (Line(
      points={{-75,64},{-58,64},{-58,34},{-57,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanExpression.y, heatPump.on) annotation (Line(
      points={{-77,22},{-67.2,22}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pump.port_b, pipe_Insulated.port_a) annotation (Line(
      points={{28,50},{50,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatPump.heatPort, fixedTemperature.port) annotation (Line(
      points={{-60,12},{-60,-24},{-40,-24},{-40,-60},{-52,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TestHeatpump;
