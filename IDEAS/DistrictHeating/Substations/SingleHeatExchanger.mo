within IDEAS.DistrictHeating.Substations;
model SingleHeatExchanger "Substation with a single heat exchanger"
  //Extensions
  extends Interfaces.Baseclasses.Substation(
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
    annotation (Placement(transformation(extent={{-16,-70},{-36,-90}})));
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
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,64})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-98,80},{-78,100}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Tsupply(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Sensor of the return temperature" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-2,-40})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Sensor of the return temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={14,-80})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    redeclare package Medium2 =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m1_flow_nominal=0.25,
    m2_flow_nominal=0.25,
    dp1_nominal=200,
    dp2_nominal=200)
    annotation (Placement(transformation(extent={{-16,10},{4,30}})));
  Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-20,76})));
  Control.SupplyTControl supplyTControl
    annotation (Placement(transformation(extent={{42,74},{62,94}})));
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
      points={{-36,-80},{-100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(spl2.port_3, val.port_a) annotation (Line(
      points={{72,-30},{72,-14}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(spl1.port_1, TReturn.port_a) annotation (Line(
      points={{-16,-80},{4,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn.port_b, flowPort_return_out) annotation (Line(
      points={{24,-80},{100,-80}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_b2, spl1.port_3) annotation (Line(
      points={{-16,14},{-26,14},{-26,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_a2, val.port_b) annotation (Line(
      points={{4,14},{72,14},{72,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.m_flow, supplyTControl.sensFlow) annotation (Line(
      points={{-9,76},{-4,76},{-4,89.8},{41.6,89.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperature1.T, supplyTControl.sensTemp) annotation (Line(
      points={{31,64},{36,64},{36,78},{41.4,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(supplyTControl.y, val.y) annotation (Line(
      points={{62.6,84},{66,84},{66,66},{48,66},{48,-4},{60,-4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tsupply.port_a, spl2.port_2) annotation (Line(
      points={{8,-40},{62,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tsupply.port_b, flowPort_supply_out) annotation (Line(
      points={{-12,-40},{-100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperature1.port_b, hex.port_a1) annotation (Line(
      points={{20,54},{20,40},{-34,40},{-34,26},{-16,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_b1, senMasFlo1.port_a) annotation (Line(
      points={{4,26},{8,26},{8,52},{-20,52},{-20,66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senMasFlo1.port_b, flowPort_sec_out[1]) annotation (Line(
      points={{-20,86},{-20,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowPort_sec_in[1], temperature1.port_a) annotation (Line(
      points={{20,100},{20,74}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end SingleHeatExchanger;
