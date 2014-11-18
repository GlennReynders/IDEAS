within IDEAS.DistrictHeating.Production.BaseClasses;
partial model PartialHeatSource
  "Partial for a heat source production component"

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component";

  //Data parameters
  parameter Real QNomRef;
  parameter Real etaRef
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin(max=29) "Minimal modulation percentage";
  parameter Real modulationStart(min=min(30, modulationMin + 5))
    "Min estimated modulation level required for start of the heat source";
  parameter Modelica.SIunits.Temperature TMax "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin "Minimum set point temperature";

  //Scalable parameters
  parameter Modelica.SIunits.Power QNom "The power at nominal conditions";
  parameter Real scaler = QNom/QNomRef;
  parameter Modelica.SIunits.ThermalConductance UALoss
    "UA of heat losses of the heat source to environment";

  //Components
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort connection to water in condensor"  annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-38,78},{-18,98}})));

  //Inputs
  Modelica.Blocks.Interfaces.RealInput hIn "Specific enthalpy at the inlet" annotation (Placement(transformation(
          extent={{-128,60},{-88,100}}), iconTransformation(extent={{-120,48},{-96,
            72}})));
  Modelica.Blocks.Interfaces.RealInput m_flow "Condensor mass flow rate" annotation (Placement(transformation(
          extent={{-128,20},{-88,60}}), iconTransformation(extent={{-120,8},{-96,
            32}})));
  Modelica.Blocks.Interfaces.RealInput THxIn "Condensor temperature" annotation (Placement(transformation(
          extent={{-128,-60},{-88,-20}}), iconTransformation(extent={{-120,-32},
            {-96,-8}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set point temperature"
                                                                   annotation (Placement(transformation(
          extent={{-126,-102},{-86,-62}}),iconTransformation(extent={{-120,-72},
            {-96,-48}})));

    annotation (Placement(transformation(extent={{66,74},{86,94}})),
              Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false),
                   graphics={
        Line(
          points={{-98,60},{-66,60},{-40,60},{0,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,-60},{-68,-60},{-40,-60},{0,0}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,20},{-38,20},{-6,20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-100,-20},{-40,-20},{-2,-20}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{28,0},{90,0},{98,0},{100,0}},
          color={0,0,255},
          smooth=Smooth.None),
      Polygon(
        origin={65.533,-20.062},
        lineColor = {255,0,0},
        fillColor = {255,0,0},
        fillPattern = FillPattern.Solid,
        points={{-60.062,-105.533},{-20.062,-65.533},{19.938,-105.533},{19.938,-45.533},
              {-20.062,-5.533},{-60.062,-45.533},{-60.062,-105.533}},
          rotation=270)}),       Diagram(coordinateSystem(extent={{-100,-100},{100,
            100}}, preserveAspectRatio=false), graphics));
end PartialHeatSource;
