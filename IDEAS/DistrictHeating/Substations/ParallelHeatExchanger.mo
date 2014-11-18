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
    annotation (Placement(transformation(extent={{-52,-70},{-72,-90}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl2(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{82,-30},{62,-50}})));

  Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dpValve_nominal=20)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={72,-4})));

  Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(
                                                        redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Sensor of the return temperature" annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-33,67})));
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
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(
        extent={{6,-7},{-6,7}},
        rotation=270,
        origin={-65,48})));
  Control.SupplyTControl supplyTControl
    annotation (Placement(transformation(extent={{-2,42},{16,50}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl3(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{-14,-70},{-34,-90}})));
  IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl4(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal={0.25,-0.25,-0.25},
    dp_nominal={20,-20,-20}) "Splitter for bypass"
    annotation (Placement(transformation(extent={{50,-30},{30,-50}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.25,
    m2_flow_nominal=0.25,
    dp1_nominal=200,
    dp2_nominal=200)
    annotation (Placement(transformation(extent={{-4,8},{16,28}})));
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    dpValve_nominal=20)                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-14})));
  Modelica.Blocks.Interfaces.RealInput controlDHW
    "control signal for DHW valve"
    annotation (Placement(transformation(extent={{-124,-24},{-94,6}})));
equation
  //Connections
  connect(flowPort_supply_in, flowPort_supply_in) annotation (Line(
      points={{100,-40},{100,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(spl2.port_1, flowPort_supply_in) annotation (Line(
      points={{82,-40},{100,-40}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(spl1.port_2, flowPort_return_in) annotation (Line(
      points={{-72,-80},{-100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_3, val.port_a) annotation (Line(
      points={{72,-30},{72,-14}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(hex.port_b2, spl1.port_3) annotation (Line(
      points={{-60,4},{-60,-34},{-62,-34},{-62,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_a2, val.port_b) annotation (Line(
      points={{-40,4},{72,4},{72,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature1.T, supplyTControl.sensTemp) annotation (Line(
      points={{-25.3,67},{-10,67},{-10,43.6},{-2.54,43.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(supplyTControl.y, val.y) annotation (Line(
      points={{16.54,46},{50,46},{50,-4},{60,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(spl1.port_1, spl3.port_2) annotation (Line(
      points={{-52,-80},{-34,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_2, spl4.port_1) annotation (Line(
      points={{62,-40},{62,-40},{58,-40},{58,-40},{50,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_supply_out, spl4.port_2) annotation (Line(
      points={{-100,-40},{30,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(spl3.port_1, flowPort_return_out) annotation (Line(
      points={{-14,-80},{20,-80},{20,-80},{46,-80},{46,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl3.port_3, hex1.port_b2) annotation (Line(
      points={{-24,-70},{-24,12},{-4,12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val1.port_a, spl4.port_3) annotation (Line(
      points={{40,-24},{40,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex1.port_a2, val1.port_b) annotation (Line(
      points={{16,12},{40,12},{40,-4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.m_flow, supplyTControl.sensFlow) annotation (Line(
      points={{-57.3,48},{-4,48},{-4,48.32},{-2.36,48.32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senMasFlo1.port_b, flowPort_sec_out[1]) annotation (Line(
      points={{-65,54},{-65,90},{-20,90},{-20,95}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.port_a, hex.port_b1) annotation (Line(
      points={{-65,42},{-28,42},{-28,16},{-40,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature1.port_b, hex.port_a1) annotation (Line(
      points={{-33,60},{-33,34},{-40,34},{-40,34},{-74,34},{-74,16},{-60,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_sec_in[2], hex1.port_a1) annotation (Line(
      points={{20,105},{24,105},{24,36},{-16,36},{-16,24},{-4,24}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(flowPort_sec_out[2], hex1.port_b1) annotation (Line(
      points={{-20,105},{-8,105},{-8,72},{34,72},{34,24},{16,24}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(temperature1.port_a, flowPort_sec_in[1]) annotation (Line(
      points={{-33,74},{-8,74},{-8,95},{20,95}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(val1.y, controlDHW) annotation (Line(
      points={{28,-14},{-42,-14},{-42,-9},{-109,-9}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ParallelHeatExchanger;
