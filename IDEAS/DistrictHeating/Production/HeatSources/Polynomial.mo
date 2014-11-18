within IDEAS.DistrictHeating.Production.HeatSources;
model Polynomial "Heat source based on a polynomial function"
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatSource;

  //Parameters en Constants
  constant Real kgps2lph=3600/Medium.density(Medium.setState_pTX(Medium.p_default, Medium.T_default, Medium.X_default))*1000
    "Conversion from kg/s to l/h";
  final parameter Real beta[:] "Constant parameters of the polynomial function";
  final parameter Integer powers[:,:]
    "Constant powers of the polynomial function";

  final parameter Integer n = size(powers, 1);
  final parameter Integer k = size(powers, 2);

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
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

equation
  //Calculation of the modulation
  release = if noEvent(m_flow > Modelica.Constants.eps) then 1.0 else 0.0;
  hysteresis.u = modulationInit;
  modulationInit = QAsked/QMax*100;
  modulation = if hysteresis.y then min(modulationInit, 100) else 0;

  //Calcualation of the heat powers
  QMax = PolynomialDimensions(beta=beta, powers=powers, X={100, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k)/etaRef*QNom;
  QAsked = IDEAS.Utilities.Math.Functions.smoothMax(0, m_flow*(Medium.specificEnthalpy(Medium.setState_pTX(Medium.p_default, TSet, Medium.X_default)) -hIn), 10);
  QLossesToCompensate = if noEvent(modulation) > 0 then UALoss*(heatPort.T - sim.Te) else 0;

  //Polynomial
  eta = PolynomialDimensions(beta=beta, powers=powers, X={modulation, m_flowHx_scaled*kgps2lph, THxIn-273.15}, n=n, k=k);
  heatPort.Q_flow = -eta/etaRef*modulation/100*QNom - QLossesToCompensate;
  PFuel = if release > 0.5 and noEvent(eta>Modelica.Constants.eps) then -heatPort.Q_flow/eta else 0;

  annotation (Diagram(graphics));
end Polynomial;
