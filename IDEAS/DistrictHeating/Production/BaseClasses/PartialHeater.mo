within IDEAS.DistrictHeating.Production.BaseClasses;
partial model PartialHeater
  "A partial for a production component which heats a fluid"

  //Extensions
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true, dp_nominal = 0);
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations(T_start=293.15);

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
  parameter Modelica.SIunits.HeatCapacity cDry=4800
    "Capacity of dry material lumped to condensor";

  final parameter Modelica.SIunits.ThermalConductance UALoss=(cDry + mWater*
      Medium.specificHeatCapacityCp(Medium.setState_pTX(Medium.p_default, Medium.T_default,Medium.X_default)))/tauHeatLoss;

  parameter SI.MassFlowRate m_flow_nominal "Nominal mass flow rate"
  annotation(Dialog(group = "Nominal condition"));
  parameter SI.Pressure dp_nominal=0 "Pressure";

  parameter Boolean dynamicBalance=true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Dialog(tab="Flow resistance"));
  parameter Boolean homotopyInitialization=true "= true, use homotopy method"
    annotation (Dialog(tab="Flow resistance"));

  //Variables
  Modelica.SIunits.Power PFuel "Fuel consumption in watt";
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
  replaceable PartialHeatSource heatSource(
    QNomRef=QNomRef,
    etaRef=etaRef,
    TMax=TMax,
    TMin=TMin,
    modulationMin=modulationMin,
    modulationStart=modulationStart,
    UALoss=UALoss,
    QNom=QNom)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-12,80})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor mDry(C=cDry, T(start=
          T_start)) "Lumped dry mass subject to heat exchange/accumulation"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-78,-30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalLosses(G=
        UALoss) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "heatPort for thermal losses to environment" annotation (Placement(
        transformation(extent={{-50,-110},{-30,-90}}), iconTransformation(
          extent={{-50,-110},{-30,-90}})));

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
        origin={-10,-10})));
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
    annotation (Placement(transformation(extent={{80,30},{60,50}})));

  Fluid.Sensors.MassFlowRate MassFlow(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{50,30},{30,50}})));
  Fluid.Sensors.SpecificEnthalpyTwoPort Enthalpy(
    redeclare package Medium=Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{20,30},{0,50}})));
equation

  connect(mDry.port, thermalLosses.port_a) annotation (Line(
      points={{-68,-30},{-40,-30},{-40,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalLosses.port_b, heatPort) annotation (Line(
      points={{-40,-80},{-40,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(mDry.port, pipe_HeatPort.heatPort) annotation (Line(
      points={{-68,-30},{-40,-30},{-40,-10},{-20,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_a, Tin.port_a) annotation (Line(
      points={{102,40},{80,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tin.port_b, MassFlow.port_a) annotation (Line(
      points={{60,40},{50,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MassFlow.port_b, Enthalpy.port_a) annotation (Line(
      points={{30,40},{20,40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Enthalpy.port_b, pipe_HeatPort.port_b) annotation (Line(
      points={{0,40},{-10,40},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe_HeatPort.port_a, port_b) annotation (Line(
      points={{-10,-20},{-10,-40},{102,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatSource.heatPort, pipe_HeatPort.heatPort) annotation (Line(
      points={{-22,80},{-40,80},{-40,-10},{-20,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TSet, heatSource.TSet) annotation (Line(
      points={{60,124},{60,86},{-1.2,86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatSource.THxIn, Tin.T) annotation (Line(
      points={{-1.2,82},{70,82},{70,51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(MassFlow.m_flow, heatSource.m_flow) annotation (Line(
      points={{40,51},{40,78},{-1.2,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Enthalpy.h_out, heatSource.hIn) annotation (Line(
      points={{10,51},{10,74},{-1.2,74}},
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
          points={{98,40},{18,40},{38,20},{18,0},{38,-20},{18,-40},{98,-40}},
          color={0,0,255},
          smooth=Smooth.None),
      Polygon(
        origin={47.533,-20.062},
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
end PartialHeater;
