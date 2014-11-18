within IDEAS.DistrictHeating.Pipes;
model InsulatedPlugFlow
  "Pipe model with a temperature plug flow, pressure losses and heat exchange to the environment through insulation"

  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;

  //Parameters
  parameter Modelica.SIunits.Length pipeLength;
  parameter Modelica.SIunits.Length pipeDiameter;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Modelica.SIunits.PressureDifference dp_nominal=0;

  parameter Modelica.SIunits.CoefficientOfHeatTransfer U
    "Heat transfer coefficient";
  final parameter Modelica.SIunits.ThermalConductance G=U*Modelica.Constants.pi*(pipeDiameter/2)^2
    "Thermal conductance";
  final parameter Modelica.SIunits.Volume V=pipeLength*Modelica.Constants.pi*(pipeDiameter/2)^2;
  parameter Boolean dynamicBalance = true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  //Interface
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[2] heatPort1
    "Port for heat exchange with mixing volume" annotation (Placement(
        transformation(extent={{-10,52},{10,72}}),  iconTransformation(extent={{-10,52},
            {10,72}})));

  //Components
  DistrictHeating.Pipes.PlugFlowPipe plugFlowPipe1(
    pipeLength=pipeLength,
    pipeDiameter=pipeDiameter,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium,
    energyDynamics=if dynamicBalance then energyDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=if dynamicBalance then massDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    m_flow_nominal=m_flow_nominal,
    p_start=p_start,
    allowFlowReversal=allowFlowReversal,
    nPorts=2,
    final V=V/2)
    annotation (Placement(transformation(extent={{-40,0},{-60,20}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=G/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,50})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=G/2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,50})));
  Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = Medium,
    energyDynamics=if dynamicBalance then energyDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=if dynamicBalance then massDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    m_flow_nominal=m_flow_nominal,
    p_start=p_start,
    allowFlowReversal=allowFlowReversal,
    nPorts=2,
    final V=V/2)
    annotation (Placement(transformation(extent={{42,0},{62,20}})));
equation
  connect(port_a, vol1.ports[1]) annotation (Line(
      points={{-100,0},{-48,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol1.ports[2], plugFlowPipe1.port_a) annotation (Line(
      points={{-52,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol1.heatPort, thermalConductor1.port_a) annotation (Line(
      points={{-40,10},{-32,10},{-32,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(plugFlowPipe1.port_b, vol2.ports[1]) annotation (Line(
      points={{10,0},{50,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol2.ports[2], port_b) annotation (Line(
      points={{54,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol2.heatPort, thermalConductor.port_a) annotation (Line(
      points={{42,10},{32,10},{32,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalConductor1.port_b, heatPort1[1]) annotation (Line(
      points={{-32,60},{-32,57},{0,57}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalConductor.port_b, heatPort1[2]) annotation (Line(
      points={{32,60},{32,84},{0,84},{0,67}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={
        Polygon(
          points={{20,-70},{60,-85},{20,-100},{20,-70}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Polygon(
          points={{20,-75},{50,-85},{20,-95},{20,-75}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Polygon(
          points={{20,-75},{50,-85},{20,-95},{20,-75}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Rectangle(
          extent={{-100,42},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,24},{100,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-26,24},{30,-22}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(
          points={{55,-85},{-60,-85}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=showDesignFlowDirection),
        Rectangle(
          extent={{-100,52},{100,42}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-40},{100,-50}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward)}),
                           Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end InsulatedPlugFlow;
