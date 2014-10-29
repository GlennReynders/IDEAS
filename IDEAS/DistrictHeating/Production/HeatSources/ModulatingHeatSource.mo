within IDEAS.DistrictHeating.Production.HeatSources;
model ModulatingHeatSource
  "A modulating heat source based on performance tables"
  import IDEAS;

  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatSource;

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium;

  //Parameters
  final parameter Real[6] modVector = {0,20,40,60,80,100}
    "Vector of the modulation steps";

protected
  parameter Modelica.SIunits.ThermalConductance UALoss = productionData.UALoss
    "UA of heat losses of the heat source to environment";
  final parameter Modelica.SIunits.Power QNom0 = productionData.QNom0
    "Nominal power of the boiler from which the power data are used in this model";
  constant Real etaNom = productionData.etaNom
    "Nominal efficiency (higher heating value)of the xxx boiler at 50/30degC.  See datafile";
  parameter Real modulationMin = productionData.modulationMin
    "Minimal modulation percentage";
  parameter Real modulationStart = productionData.modulationStart
    "Min estimated modulation level required for start of the heat source";
  parameter Modelica.SIunits.Temperature TMax=productionData.TMax
    "Maximum set point temperature";
  parameter Modelica.SIunits.Temperature TMin=productionData.TMin
    "Minimum set point temperature";

  //Variables
public
  Real[6] etaVector "Thermal efficiency for the modulation steps";
  Real eta "Instantaneous efficiency of the boiler (higher heating value)";
  Real[6] QVector "Thermal power for the 6 modulation steps";
  Modelica.SIunits.Power QMax
    "Maximum thermal power at specified evap and condr temperatures, in W";
  Modelica.SIunits.Power QAsked(start=0) "Output of the heatSource";
  Real modulationInit "Initial modulation, decides on start/stop of the boiler";
  Real modulation(min=0, max=1) "Current modulation percentage";
  Modelica.SIunits.Power PFuel "Resulting fuel consumption";

  //Components
  replaceable IDEAS.Controls.Control_fixme.Hyst_NoEvent_Var Control(
    use_input=false,
    enableRelease=true,
    uLow_val=modulationMin,
    uHigh_val=modulationStart,
    y(start=0),
    release(start=0)) "Standard control of the production unit"
    annotation (Placement(transformation(extent={{32,0},{52,20}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=modulationInit)
    annotation (Placement(transformation(extent={{-6,0},{14,20}})));

  Modelica.Blocks.Tables.CombiTable2D eta100(table=productionData.eta100,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Blocks.Tables.CombiTable2D eta80(table=productionData.eta80,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Tables.CombiTable2D eta60(table=productionData.eta60,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Tables.CombiTable2D eta40(table=productionData.eta40,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Tables.CombiTable2D eta20(table=productionData.eta20,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));

protected
  Real m_flowHx_scaled = IDEAS.Utilities.Math.Functions.smoothMax(x1=m_flowHx, x2=0,deltaX=0.001) * QNom0/QNom
    "mass flow rate, scaled with the original and the actual nominal power of the boiler";

  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";

  Modelica.SIunits.HeatFlowRate QLossesToCompensate "Environment losses";
  Integer i "Integer to select data interval";

public
  replaceable
    IDEAS.DistrictHeating.Production.BaseClasses.PartialModulatingData
    productionData constrainedby
    IDEAS.DistrictHeating.Production.BaseClasses.PartialModulatingData
    annotation (Placement(transformation(extent={{-98,-8},{-78,12}})),
      choicesAllMatching=true);
algorithm
  // efficiency coefficients
  eta100.u1 :=THxIn - 273.15;
  eta100.u2 :=m_flowHx_scaled*kgps2lph;
  eta80.u1 :=THxIn - 273.15;
  eta80.u2 :=m_flowHx_scaled*kgps2lph;
  eta60.u1 :=THxIn - 273.15;
  eta60.u2 :=m_flowHx_scaled*kgps2lph;
  eta40.u1 :=THxIn - 273.15;
  eta40.u2 :=m_flowHx_scaled*kgps2lph;
  eta20.u1 :=THxIn - 273.15;
  eta20.u2 :=m_flowHx_scaled*kgps2lph;

  // all these are in kW
  etaVector[1] :=0;
  etaVector[2] :=eta20.y;
  etaVector[3] :=eta40.y;
  etaVector[4] :=eta60.y;
  etaVector[5] :=eta80.y;
  etaVector[6] :=eta100.y;
  QVector :=etaVector/etaNom .* modVector/100*QNom;
  // in W
  QMax :=QVector[6];

  // Interpolation if  QVector[1]<QAsked<QVector[6], other wise extrapolation with slope = 0
  i := 1;
  for j in 1:6-1 loop
    if QAsked > QVector[j] then
      i := j;
    end if;
  end for;

  modulationInit :=
    IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=QAsked,
    x1=QVector[i],
    x2=QVector[i + 1],
    y1=modVector[i],
    y2=modVector[i + 1],
    y1d=0,
    y2d=0);
  modulation :=Control.y*min(modulationInit, 100);
  eta :=IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=modulation,
    x1=modVector[i],
    x2=modVector[i + 1],
    y1=etaVector[i],
    y2=etaVector[i + 1],
    y1d=0,
    y2d=0);

  heatPort.Q_flow :=-
    IDEAS.Utilities.Math.Functions.cubicHermiteLinearExtrapolation(
    x=modulation,
    x1=modVector[i],
    x2=modVector[i + 1],
    y1=QVector[i],
    y2=QVector[i + 1],
    y1d=0,
    y2d=0) - Control.y*QLossesToCompensate;

equation
  assert(TSet < TMax and TSet > TMin, "The given set point temperature is not inside the covered range (20 -> 80 degC)");
  assert(m_flowHx_scaled*kgps2lph < 1300, "The given mass flow rate is outside the allowed range. Make sure that the mass flow
  is positive and not too high. The current mass flow equals " + String(m_flowHx) + " [kg/s] but its maximum value is for the chosen QNom is " + String(1300*QNom/QNom0/kgps2lph));

  Control.release = if noEvent(m_flowHx > Modelica.Constants.eps) then 1.0 else 0.0;

  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flowHx*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default,TSet, Medium.X_default)) -hIn), 10);

  // compensation of heat losses (only when the hp is operating)
  QLossesToCompensate = if noEvent(modulation > 0) then UALoss*(heatPort.T -
    TEnvironment) else 0;

  PFuel = if Control.release > 0.5 and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  connect(realExpression.y, Control.u) annotation (Line(
      points={{15,10},{30,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics),                         Icon(
        coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false),
        graphics));
end ModulatingHeatSource;
