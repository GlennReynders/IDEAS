within IDEAS.DistrictHeating.Production.Examples;
model BoilerSpeed
  //Extensions
  extends Modelica.Icons.Example;

  Fluid.Production.Boiler boiler(
    QNom=10000,
    m_flow_nominal=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    modulationMin=10,
    modulationStart=20)
    annotation (Placement(transformation(extent={{-68,10},{-48,-12}})));
  Fluid.Movers.Pump pump2(
                         redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-40,-32},{-20,-12}})));
  Fluid.FixedResistances.Pipe_Insulated pipe2(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20) annotation (Placement(transformation(
        extent={{10,-4},{-10,4}},
        rotation=270,
        origin={24,-6})));
  Fluid.Sources.FixedBoundary bou(
    nPorts=2,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={56,64})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{58,-16},{38,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=sim.Te - 273.15)
    annotation (Placement(transformation(extent={{90,-16},{70,4}})));
  Fluid.Sensors.TemperatureTwoPort senBoiler(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-12,-32},{8,-12}})));
  inner SimInfoManager sim
    annotation (Placement(transformation(extent={{-92,78},{-72,98}})));
  Modelica.Blocks.Sources.Constant TSet(k=273 + 60)
    annotation (Placement(transformation(extent={{-96,-48},{-76,-28}})));
equation
  connect(boiler.port_b,pump2. port_a) annotation (Line(
      points={{-48,-4},{-48,-22},{-40,-22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boiler.port_a,pipe2. port_b) annotation (Line(
      points={{-48,4},{24,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[2],pipe2. port_b) annotation (Line(
      points={{54,54},{54,28},{20,28},{20,4},{24,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(prescribedTemperature1.T,realExpression1. y) annotation (Line(
      points={{60,-6},{69,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature1.port,pipe2. heatPort) annotation (Line(
      points={{38,-6},{32,-6},{32,-28},{10,-28},{10,-6},{20,-6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pump2.port_b,senBoiler. port_a) annotation (Line(
      points={{-20,-22},{-12,-22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senBoiler.port_b,pipe2. port_a) annotation (Line(
      points={{8,-22},{24,-22},{24,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSet.y, boiler.TSet) annotation (Line(
      points={{-75,-38},{-59,-38},{-59,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end BoilerSpeed;
