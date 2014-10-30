within IDEAS.DistrictHeating;
package Examples
  model SeriesGrid "District heating grid with buildings connected in series"
    Interfaces.Network network(
      redeclare Substations.SingleHeatExchanger endStation,
      redeclare Substations.SingleHeatExchanger substations,
      redeclare Production.Boiler production(boiler(from_dp=true)))
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  end SeriesGrid;

  model TestBoiler "Simple test example for boiler"
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
      annotation (Placement(transformation(extent={{-32,-38},{-12,-18}})));
    Modelica.Blocks.Sources.Constant const(k=300)
      annotation (Placement(transformation(extent={{-82,44},{-62,64}})));
    Production.ModulatingProduction modulatingProduction(
      dp_nominal=20,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      QNom=1000,
      m_flow_nominal=0.1,
      redeclare IDEAS.DistrictHeating.Production.Data.Boiler productionData)
      annotation (Placement(transformation(extent={{-50,22},{-30,44}})));
  equation
    connect(fixedTemperature.port, pipe_Insulated.heatPort) annotation (Line(
        points={{-12,-28},{2,-28},{2,32},{40,32}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(const.y, modulatingProduction.TSet) annotation (Line(
        points={{-61,54},{-41,54},{-41,44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(modulatingProduction.port_a, pipe_Insulated.port_b) annotation (
        Line(
        points={{-30,28},{-22,28},{-22,8},{44,8},{44,22}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(modulatingProduction.heatPort, pipe_Insulated.heatPort) annotation
      (Line(
        points={{-43,22},{-44,22},{-44,-4},{-4,-4},{-4,-28},{2,-28},{2,32},{40,
            32}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics));
  end TestBoiler;
end Examples;
