within IDEAS.DistrictHeating.Production.Examples;
model TestBoiler "Simple test example for boiler"

  extends Modelica.Icons.Example;

  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated(
    UA=10,
    m_flow_nominal=0.1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    m=1,
    dp_nominal=20)
         annotation (Placement(transformation(extent={{-10,-4},{10,4}},
        rotation=270,
        origin={44,32})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{-50,-36},{-30,-16}})));
  Modelica.Blocks.Sources.Constant const(k=300)
    annotation (Placement(transformation(extent={{-82,44},{-62,64}})));
  Production.ModulatingProduction modulatingProduction(
    dp_nominal=20,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    QNom=1000,
    redeclare IDEAS.DistrictHeating.Production.Data.Boiler productionData,
    m_flow_nominal=0.01)
    annotation (Placement(transformation(extent={{-50,22},{-30,44}})));

  Fluid.Movers.Pump pump(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.01)
    annotation (Placement(transformation(extent={{2,32},{22,52}})));
  Fluid.Sources.FixedBoundary bou(nPorts=1, redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-12,76})));
equation
  connect(fixedTemperature.port, pipe_Insulated.heatPort) annotation (Line(
      points={{-30,-26},{2,-26},{2,32},{40,32}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(const.y, modulatingProduction.TSet) annotation (Line(
      points={{-61,54},{-41,54},{-41,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(modulatingProduction.port_a, pipe_Insulated.port_b) annotation (Line(
      points={{-29.8,36},{-22,36},{-22,8},{44,8},{44,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(modulatingProduction.heatPort, pipe_Insulated.heatPort) annotation (
      Line(
      points={{-44,22},{-44,22},{-44,-4},{-4,-4},{-4,-28},{2,-28},{2,32},{40,32}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(modulatingProduction.port_b, pump.port_a) annotation (Line(
      points={{-29.8,28},{-14,28},{-14,42},{2,42}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_Insulated.port_a, pump.port_b) annotation (Line(
      points={{44,42},{22,42}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], pump.port_a) annotation (Line(
      points={{-12,66},{-12,42},{2,42}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics));
end TestBoiler;
