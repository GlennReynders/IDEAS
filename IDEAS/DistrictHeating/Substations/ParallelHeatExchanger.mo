within IDEAS.DistrictHeating.Substations;
model ParallelHeatExchanger
  "Substation with two heat exchangers in a parallel configuration"
  //import Buildings;
  //Extensions
  extends Interfaces.Baseclasses.Substation(
    numberOfConnections = 2,
    flowPort_supply_out(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_return_in(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_sec_in(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_sec_out(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_supply_in(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_return_out(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater));

  //Components
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl1(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{-58,-70},{-78,-90}})));

  Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dpValve_nominal=20)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={72,-10})));

  Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(
                                                        redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Sensor of the return temperature" annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=270,
        origin={20,68})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-98,80},{-78,100}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.25,
    m2_flow_nominal=0.25,
    dp1_nominal=200,
    dp2_nominal=200)
    annotation (Placement(transformation(extent={{-62,8},{-42,28}})));
  Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-20,80})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl3(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{4,-70},{-16,-90}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.25,
    m2_flow_nominal=0.25,
    dp1_nominal=200,
    dp2_nominal=200)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dpValve_nominal=20)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-28,-10})));
  Modelica.Blocks.Interfaces.RealInput controlDHW
    "control signal for DHW valve"
    annotation (Placement(transformation(extent={{-126,-24},{-98,4}})));
  Control.SupplyTControl supplyTControl
    annotation (Placement(transformation(extent={{40,64},{60,84}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl2(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{-38,-30},{-18,-50}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl4(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{62,-30},{82,-50}})));
equation
  //Connections
  connect(flowPort_supply_in, flowPort_supply_in) annotation (Line(
      points={{100,-40},{100,-40}},
      color={0,0,0},
      smooth=Smooth.None));

  connect(spl1.port_2, flowPort_return_in) annotation (Line(
      points={{-78,-80},{-100,-80}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(spl1.port_1, spl3.port_2) annotation (Line(
      points={{-58,-80},{-16,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl3.port_1, flowPort_return_out) annotation (Line(
      points={{4,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val1.y, controlDHW) annotation (Line(
      points={{-40,-10},{-112,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(supplyTControl.y, val.y) annotation (Line(
      points={{60.6,74},{66,74},{66,10},{56,10},{56,-10},{60,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(val1.port_b, hex.port_a2) annotation (Line(
      points={{-28,0},{-28,12},{-42,12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_b2, spl1.port_3) annotation (Line(
      points={{-62,12},{-62,12},{-68,12},{-68,-70},{-68,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex1.port_b2, spl3.port_3) annotation (Line(
      points={{0,24},{-6,24},{-6,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex1.port_a2, val.port_b) annotation (Line(
      points={{20,24},{72,24},{72,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex1.port_b1, temperature1.port_a) annotation (Line(
      points={{20,36},{20,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature1.port_b, flowPort_sec_in[1]) annotation (Line(
      points={{20,76},{20,95}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_sec_out[1], senMasFlo1.port_a) annotation (Line(
      points={{-20,95},{-20,88}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(senMasFlo1.port_b, hex1.port_a1) annotation (Line(
      points={{-20,72},{-20,36},{0,36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.m_flow, supplyTControl.sensFlow) annotation (Line(
      points={{-11.2,80},{38,80},{38,80},{38,80},{38,79.8},{39.6,79.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperature1.T, supplyTControl.sensTemp) annotation (Line(
      points={{28.8,68},{39.4,68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(flowPort_sec_out[2], hex.port_a1) annotation (Line(
      points={{-20,105},{-62,105},{-62,24}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hex.port_b1, flowPort_sec_in[2]) annotation (Line(
      points={{-42,24},{-42,54},{0,54},{0,105},{20,105}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val1.port_a, spl2.port_3) annotation (Line(
      points={{-28,-20},{-28,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_supply_out, spl2.port_1) annotation (Line(
      points={{-100,-40},{-38,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(spl2.port_2, spl4.port_1) annotation (Line(
      points={{-18,-40},{62,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val.port_a, spl4.port_3) annotation (Line(
      points={{72,-20},{72,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl4.port_2, flowPort_supply_in) annotation (Line(
      points={{82,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ParallelHeatExchanger;
