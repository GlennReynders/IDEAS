within IDEAS.DistrictHeating.Production.BaseClasses;
partial model PartialHeatPump
  "A partial for a heat pump component which heats a fluid"

  //Extensions
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true, dp_nominal = 0);
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations(T_start=293.15);

  replaceable package MediumBrine =
    Modelica.Media.Interfaces.PartialMedium "Brine medium at primary side"
    annotation(choicesAllMatching=true);
  replaceable package MediumFluid =
    Modelica.Media.Interfaces.PartialMedium "Fluid medium at secondary side"
    annotation(choicesAllMatching=true);

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
  parameter Modelica.SIunits.Power QNom "Nominal power"
  annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.Time tauHeatLoss=7200
    "Time constant of environmental heat losses";
  parameter Modelica.SIunits.Mass mWater=5 "Mass of water in the condensor";
  parameter Modelica.SIunits.Mass mBrine=5 "Mass of water in the condensor";
  parameter Modelica.SIunits.HeatCapacity cDry=4800
    "Capacity of dry material lumped to condensor";

  final parameter Modelica.SIunits.ThermalConductance UALoss=(cDry + mWater*
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss;

  parameter SI.MassFlowRate m_flow_nominal "Nominal mass flow rate"
  annotation(Dialog(group = "Nominal condition"));

  parameter SI.MassFlowRate m_flow_nominal_brine "Nominal mass flow rate"
  annotation(Dialog(group = "Nominal condition"));

  parameter SI.Pressure dp_nominal=0 "Pressure";
  parameter SI.Pressure dp_nominal_brine=0 "Pressure";

  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)";

  parameter Boolean dynamicBalance=true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Dialog(tab="Flow resistance"));
  parameter Boolean homotopyInitialization=true "= true, use homotopy method"
    annotation (Dialog(tab="Flow resistance"));

  //Variables
  Modelica.Blocks.Interfaces.RealInput TSet
    "Temperature setpoint, acts as on/off signal too" annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,124}),                             iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,120})));
  Modelica.Blocks.Interfaces.RealOutput PEl "Electrical consumption"
      annotation (Placement(transformation(extent={{-252,10},{-232,30}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-74,-100})));

  //Components

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor mDry(C=cDry, T(start=
          T_start)) "Lumped dry mass subject to heat exchange/accumulation"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-36,-30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLosses(G=
        UALoss) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-20,-70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort for thermal losses to environment" annotation (Placement(
        transformation(extent={{-30,-110},{-10,-90}}), iconTransformation(
          extent={{-30,-110},{-10,-90}})));

  IDEAS.Fluid.FixedResistances.Pipe_HeatPort pipe_HeatPort(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    m=mWater,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    dynamicBalance=dynamicBalance,
    from_dp=from_dp,
    linearizeFlowResistance=linearizeFlowResistance,
    deltaM=deltaM,
    homotopyInitialization=homotopyInitialization)
         annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={4,-10})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Fluid inlet"
    annotation (Placement(transformation(extent={{92,30},{112,50}}),
        iconTransformation(extent={{92,30},{112,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) "Fluid outlet"
    annotation (Placement(transformation(extent={{92,-50},{112,-30}}),
        iconTransformation(extent={{92,-50},{112,-30}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort Tin(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal) "Inlet temperature"
    annotation (Placement(transformation(extent={{90,30},{70,50}})));

  Fluid.Sensors.MassFlowRate MassFlow(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{62,30},{42,50}})));
  Fluid.Sensors.SpecificEnthalpyTwoPort Enthalpy(
    redeclare package Medium=Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{36,30},{16,50}})));
  Fluid.Sensors.TemperatureTwoPort       T_in_evap(
    redeclare package Medium = MediumBrine,
    allowFlowReversal=allowFlowReversal,
    tau=10,
    m_flow_nominal=m_flow_nominal)
            annotation (Placement(transformation(extent={{-92,30},{-72,50}})));
  Fluid.FixedResistances.Pipe_HeatPort
                                 evaporator(
    redeclare package Medium = MediumBrine,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    from_dp=from_dp,
    linearizeFlowResistance=linearizeFlowResistance,
    deltaM=deltaM,
    m=mBrine,
    dp_nominal=dp_nominal_brine,
    m_flow_nominal=m_flow_nominal_brine)
              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-60,10})));
  Modelica.Fluid.Interfaces.FluidPort_a brineIn(redeclare package Medium =
        MediumBrine)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b brineOut(redeclare package Medium =
        MediumBrine)
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  replaceable PartialHeatSourceHP heatSource annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={8,78})));
equation

  connect(mDry.port, thermalLosses.port_a) annotation (Line(
      points={{-26,-30},{-20,-30},{-20,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLosses.port_b, heatPort) annotation (Line(
      points={{-20,-80},{-20,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(mDry.port, pipe_HeatPort.heatPort) annotation (Line(
      points={{-26,-30},{-20,-30},{-20,-10},{-6,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_a, Tin.port_a) annotation (Line(
      points={{102,40},{90,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tin.port_b, MassFlow.port_a) annotation (Line(
      points={{70,40},{62,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MassFlow.port_b, Enthalpy.port_a) annotation (Line(
      points={{42,40},{36,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Enthalpy.port_b, pipe_HeatPort.port_b) annotation (Line(
      points={{16,40},{4,40},{4,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_HeatPort.port_a, port_b) annotation (Line(
      points={{4,-20},{4,-40},{102,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(brineIn,T_in_evap. port_a) annotation (Line(
      points={{-100,40},{-92,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(evaporator.port_a,T_in_evap. port_b) annotation (Line(
      points={{-60,20},{-60,40},{-72,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(evaporator.port_b,brineOut)  annotation (Line(
      points={{-60,0},{-60,-40},{-100,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(partialHeatSourceHP.hIn, Enthalpy.h_out) annotation (Line(
      points={{18.8,72},{26,72},{26,51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHeatSourceHP.m_flow, MassFlow.m_flow) annotation (Line(
      points={{18.8,75},{52,75},{52,51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHeatSourceHP.TCondensor, Tin.T) annotation (Line(
      points={{18.8,81},{80,81},{80,51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(partialHeatSourceHP.TSet, TSet) annotation (Line(
      points={{18.8,84},{60,84},{60,124}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_in_evap.T, partialHeatSourceHP.TEvaporator) annotation (Line(
      points={{-82,51},{-82,102},{28,102},{28,78},{18.8,78}},
      color={0,0,127},
      smooth=Smooth.None));
      annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,120}},
          preserveAspectRatio=false), graphics),
    Icon(coordinateSystem(extent={{-100,-100},{100,120}}, preserveAspectRatio=false),
                    graphics={
        Rectangle(extent={{-100,60},{60,-60}},lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{102,40},{22,40},{42,20},{22,0},{42,-20},{22,-40},{102,-40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{40,40},{-40,40},{-20,20},{-40,0},{-20,-20},{-40,-40},{40,-40}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={-64,0},
          rotation=180),
      Polygon(
        origin={49.533,-20.062},
        lineColor = {255,0,0},
        fillColor = {255,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-40,-90},{-20,-70},{0,-90},{0,-50},{-20,-30},{-40,-50},{-40,-90}},
          rotation=270)}),
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>This is a partial model from which most heaters (boilers, heat pumps) will extend. This model is <u>dynamic</u> (there is a water content in the heater and a dry mass lumped to it) and it has <u>thermal losses to the environment</u>. To complete this model and turn it into a heater, a <u>heatSource</u> has to be added, specifying how much heat is injected in the heatedFluid pipe, at which efficiency, if there is a maximum power, etc. HeatSource models are grouped in <a href=\"modelica://IDEAS.Thermal.Components.Production.BaseClasses\">IDEAS.Thermal.Components.Production.BaseClasses.</a></p>
<p>The set temperature of the model is passed as a realInput.The model has a realOutput PEl for the electricity consumption.</p>
<p>See the extensions of this model for more details.</p>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>the temperature of the dry mass is identical as the outlet temperature of the heater </li>
<li>no pressure drop</li>
</ol></p>
<p><h4>Model use</h4></p>
<p>Depending on the extended model, different parameters will have to be set. Common to all these extensions are the following:</p>
<p><ol>
<li>the environmental heat losses are specified by a <u>time constant</u>. Based on the water content, dry capacity and this time constant, the UA value of the heat transfer to the environment will be set</li>
<li>set the heaterType (useful in post-processing)</li>
<li>connect the set temperature to the TSet realInput connector</li>
<li>connect the flowPorts (flowPort_b is the outlet) </li>
<li>if heat losses to environment are to be considered, connect heatPort to the environment.  If this port is not connected, the dry capacity and water content will still make this a dynamic model, but without heat losses to environment,.  IN that case, the time constant is not used.</li>
</ol></p>
<p><h4>Validation </h4></p>
<p>This partial model is based on physical principles and is not validated. Extensions may be validated.</p>
<p><h4>Examples</h4></p>
<p>See the extensions, like the <a href=\"modelica://IDEAS.Thermal.Components.Production.IdealHeater\">IdealHeater</a>, the <a href=\"modelica://IDEAS.Thermal.Components.Production.Boiler\">Boiler</a> or <a href=\"modelica://IDEAS.Thermal.Components.Production.HP_AWMod_Losses\">air-water heat pump</a></p>
</html>", revisions="<html>
<ul>
<li>2014 March, Filip Jorissen, Annex60 compatibility</li>
</ul>
</html>"));
end PartialHeatPump;
