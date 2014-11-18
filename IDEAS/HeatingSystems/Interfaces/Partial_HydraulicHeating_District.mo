within IDEAS.HeatingSystems.Interfaces;
model Partial_HydraulicHeating_District
  "Partial for hydraulic heating system coupled to substation of district heating system"
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater;
  extends IDEAS.Interfaces.BaseClasses.HeatingSystem(
    isHea = true,
    isCoo = false,
    nConvPorts = nZones,
    nRadPorts = nZones,
    nTemSen = nZones,
    nEmbPorts=nZones,
    nLoads=1,
    nZones=1);
  // --- Paramter: General parameters for the design (nominal) conditions and heat curve
  parameter Modelica.SIunits.Power[nZones] QNom(each min=0) = ones(nZones)*5000
    "Nominal power, can be seen as the max power of the emission system per zone";
  parameter Boolean minSup=true
    "true to limit the supply temperature on the lower side";
    parameter Modelica.SIunits.Temperature TSupMin=273.15 + 30
    "Minimum supply temperature if enabled";
  parameter Modelica.SIunits.Temperature TSupNom=273.15 + 45
    "Nominal supply temperature";
  parameter Modelica.SIunits.TemperatureDifference dTSupRetNom=10
    "Nominal DT in the heating system";
  parameter Modelica.SIunits.Temperature[nZones] TRoomNom={294.15 for i in 1:
      nZones} "Nominal room temperature";
  parameter Modelica.SIunits.TemperatureDifference corFac_val = 0
    "correction term for TSet of the heating curve";
  parameter Modelica.SIunits.Time timeFilter=43200
    "Time constant for the filter of ambient temperature for computation of heating curve";
  final parameter Modelica.SIunits.MassFlowRate[nZones] m_flow_nominal = QNom/(4180.6*dTSupRetNom)
    "Nominal mass flow rates";
  // --- production components of hydraulic circuit
  // --- distribution components of hydraulic circuit
  IDEAS.Fluid.Movers.Pump[nZones] pumpRad(
    each useInput=true,
    each m=1,
    m_flow_nominal=m_flow_nominal,
    redeclare each package Medium = Medium,
    filteredMassFlowRate=true,
    riseTime=60)
              annotation (Placement(transformation(extent={{88,64},{112,40}})));
  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipeReturn(
    redeclare package Medium = Medium,
    m=1,
    UA=10,
    m_flow_nominal=sum(m_flow_nominal))
           annotation (Placement(transformation(extent={{2,-88},{-18,-96}})));
  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipeSupply(
    redeclare package Medium = Medium,
    m=1,
    UA=10,
    m_flow_nominal=sum(m_flow_nominal))
           annotation (Placement(transformation(extent={{-16,54},{4,62}})));
  IDEAS.Fluid.FixedResistances.Pipe_Insulated[nZones] pipeReturnEmission(
    redeclare each package Medium = Medium,
    each m=1,
    each UA=10,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{148,-88},{128,-96}})));
  // --- emission components of hydraulic circuit
  replaceable IDEAS.Fluid.HeatExchangers.Radiators.Radiator[
                                                nZones] emission(
      each TInNom=TSupNom,
      each TOutNom=TSupNom - dTSupRetNom,
      TZoneNom=TRoomNom,
      QNom=QNom,
      each powerFactor=3.37,
    redeclare each package Medium = Medium) constrainedby
    IDEAS.Fluid.HeatExchangers.Interfaces.EmissionTwoPort
    annotation (Placement(transformation(extent={{120,24},{150,44}})));
  // --- boudaries
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    "fixed temperature to simulate heat losses of hydraulic components"
    annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=-90,
        origin={-127,-21})));
  // --- controllers
  replaceable IDEAS.Controls.Control_fixme.Hyst_NoEvent_Var[
                                                nZones] heatingControl(each uLow_val=
        22, each uHigh_val=20)
    "onoff controller for the pumps of the emission circuits"
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Modelica.Blocks.Sources.RealExpression THigh_val[nZones](y=0.5*ones(nZones))
    "Higher boudary for set point temperature"
    annotation (Placement(transformation(extent={{-174,-62},{-162,-42}})));
  Modelica.Blocks.Sources.RealExpression TLow_val[nZones](y=-0.5*ones(nZones))
    "Lower boundary for set point temperature"
    annotation (Placement(transformation(extent={{-174,-102},{-160,-82}})));
  Modelica.Blocks.Math.Add add[nZones](each k1=-1, each k2=+1)
    annotation (Placement(transformation(extent={{-174,-78},{-160,-64}})));
  // --- Interface
  Modelica.Blocks.Interfaces.RealInput TSet[nZones](    final quantity="ThermodynamicTemperature",unit="K",displayUnit="degC")
    "Set point temperature for the zones" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-190,-108}),
                          iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=90,
        origin={-2,-104})));
  // --- Sensors
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemEm_in(redeclare package Medium
      = Medium, m_flow_nominal=sum(m_flow_nominal))
    "Inlet temperature of the emission system"
    annotation (Placement(transformation(extent={{62,42},{82,62}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTemEm_out(redeclare package Medium
      = Medium, m_flow_nominal=sum(m_flow_nominal))
    "Outlet temperature of the emission system" annotation (Placement(
        transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={90,-92})));

  IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=sum(m_flow_nominal),
    V=sum(m_flow_nominal)*30/1000,
    nPorts=1+nZones)
    annotation (Placement(transformation(extent={{108,-56},{128,-36}})));
  IDEAS.Fluid.Sources.FixedBoundary absolutePressure(redeclare package Medium
      = Medium, use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={18,86})));
equation
    // connections that are function of the number of circuits
  for i in 1:nZones loop
    connect(pipeReturnEmission[i].heatPort, fixedTemperature.port) annotation (
        Line(
        points={{138,-88},{138,-68},{-102,-68},{-102,-12},{-127,-12},{-127,-14}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(senTemEm_in.port_b, pumpRad[i].port_a) annotation (Line(
        points={{82,52},{88,52}},
        color={0,127,255},
        smooth=Smooth.None));
  end for;
  // general connections for any configuration
  connect(heatingControl.y, pumpRad.m_flowSet) annotation (Line(
      points={{-119,-70},{100,-70},{100,39.52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipeSupply.heatPort, fixedTemperature.port) annotation (Line(
      points={{-6,54},{-6,42},{-102,42},{-102,6},{-127,6},{-127,-14}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(emission.port_b, pipeReturnEmission.port_a) annotation (Line(
      points={{150,34},{156,34},{156,-92},{148,-92}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pumpRad.port_b, emission.port_a) annotation (Line(
      points={{112,52},{116,52},{116,34},{120,34}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TSet, add.u2) annotation (Line(
      points={{-190,-108},{-190,-75.2},{-175.4,-75.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, heatingControl.u) annotation (Line(
      points={{-159.3,-71},{-146,-71},{-146,-70},{-142,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TSensor, add.u1) annotation (Line(
      points={{-204,-60},{-190,-60},{-190,-66.8},{-175.4,-66.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(THigh_val.y, heatingControl.uHigh) annotation (Line(
      points={{-161.4,-52},{-152,-52},{-152,-63.2},{-142,-63.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TLow_val.y, heatingControl.uLow) annotation (Line(
      points={{-159.3,-92},{-152,-92},{-152,-77},{-142,-77}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pipeReturnEmission.port_b, vol.ports[1:nZones]) annotation (Line(
      points={{128,-92},{122,-92},{122,-56},{118,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.ports[end], senTemEm_out.port_a) annotation (Line(
      points={{118,-56},{108,-56},{108,-92},{98,-92}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeReturn.heatPort, fixedTemperature.port) annotation (Line(
      points={{-8,-88},{-10,-88},{-10,-68},{-102,-68},{-102,-12},{-127,-12},{-127,
          -14}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatPortRad, emission.heatPortRad) annotation (Line(
      points={{-200,-20},{-150,-20},{-150,72},{148,72},{148,44},{148.5,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatPortCon, emission.heatPortCon) annotation (Line(
      points={{-200,20},{-156,20},{-156,80},{142.5,80},{142.5,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeSupply.port_b, senTemEm_in.port_a) annotation (Line(
      points={{4,58},{20,58},{20,54},{62,54},{62,52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemEm_out.port_b, pipeReturn.port_a) annotation (Line(
      points={{82,-92},{2,-92}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(absolutePressure.ports[1], senTemEm_in.port_a) annotation (Line(
      points={{18,76},{18,58},{20,58},{20,54},{62,54},{62,52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeSupply.port_a, port_supply[1]) annotation (Line(
      points={{-16,58},{-60,58},{-60,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipeReturn.port_b, port_return[1]) annotation (Line(
      points={{-18,-92},{-108,-92},{-108,58},{-120,58},{-120,100}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics={Rectangle(
          extent={{-98,30},{88,-64}},
          lineColor={135,135,135},
          lineThickness=1), Text(
          extent={{36,30},{86,20}},
          lineColor={135,135,135},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Thermal Energy Storage")}));
end Partial_HydraulicHeating_District;
