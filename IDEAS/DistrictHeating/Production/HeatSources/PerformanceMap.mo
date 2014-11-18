within IDEAS.DistrictHeating.Production.HeatSources;
model PerformanceMap "Heat source based on data from a 3D performance map"
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatSource;

  //Parameters en Constants
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";
  parameter IDEAS.Utilities.Tables.Space space;

  //Variables
  Real modulationInit "Initial modulation, decides on start/stop of the HP";
  Real modulation(min=0, max=100) "Current modulation percentage";
  Real eta "Final efficiency of the heat source";
  Real release "Stop heat production when the mass flow is zero";

  Modelica.SIunits.Power QMax
    "Maximum thermal power at 100% modulation for the given input conditions";
  Modelica.SIunits.Power QAsked(start=0) "Desired power of the heatsource";
  Modelica.SIunits.Power QLossesToCompensate
    "Artificial heat losses to correct the heat balance";
  Modelica.SIunits.Power PFuel "Resulting fuel consumption";

  Real m_flowHx_scaled = IDEAS.Utilities.Math.Functions.smoothMax(x1=m_flow, x2=0,deltaX=0.001) * QNomRef/QNom
    "mass flow rate, scaled with the original and the actual nominal power of the boiler";

  //Components
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=modulationMin,
    uHigh=modulationStart)
    annotation (Placement(transformation(extent={{-42,40},{-22,60}})));
  Utilities.Tables.InterpolationTable3D interpolationTable(space=space)
    "Interpolation table to determine the efficiency at a modulation grade"
    annotation (Placement(transformation(extent={{-10,12},{10,32}})));
  Utilities.Tables.InterpolationTable3D interpolationTableQMax(space=space)
    "Interpolation table to determine the maximum possible power output at 100% modulation"
    annotation (Placement(transformation(extent={{-10,-24},{10,-4}})));
equation
  //Calculation of the efficiency at 100% modulation
  interpolationTableQMax.u1 = THxIn - 273.15;
  interpolationTableQMax.u2 = m_flowHx_scaled*kgps2lph;
  interpolationTableQMax.u3 = 100;

  //Calculation of the efficiency at the required modulation grade
  interpolationTable.u1 = THxIn - 273.15;
  interpolationTable.u2 = m_flowHx_scaled*kgps2lph;
  interpolationTable.u3 = modulation;

  //Calculation of the modulation
  release = if noEvent(m_flow > Modelica.Constants.eps) then 1.0 else 0.0;
  hysteresis.u = modulationInit;
  modulationInit = QAsked/QMax*100;
  modulation = if hysteresis.y then min(modulationInit, 100) else 0;

  //Calcualation of the heat powers
  QMax = interpolationTableQMax.y/etaRef*QNom;
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), 10);
  QLossesToCompensate = if noEvent(modulation) > 0 then UALoss*(heatPort.T - sim.Te) else 0;

  //Final heat power of the heat source
  eta = interpolationTable.y;
  heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
  PFuel = if release > 0.5 and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PerformanceMap;
