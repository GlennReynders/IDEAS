within IDEAS.DistrictHeating.Pipes;
model PlugFlowHeatPort
  "Pipe model with a temperature plug flow, pressure losses and heat exchange to the environment"

  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;

  //Parameters
  parameter Modelica.SIunits.Length pipeLength;
  parameter Modelica.SIunits.Length pipeDiameter;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Modelica.SIunits.PressureDifference dp_nominal=0;

  parameter Modelica.SIunits.Volume V=pipeLength*Modelica.Constants.pi*(pipeDiameter/2)^2;
  parameter Boolean dynamicBalance = true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  //Interface
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[2] heatPort1
    "Port for heat exchange with mixing volume" annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
            {10,110}})));

  //Components
  DistrictHeating.Pipes.PlugFlowPipe plugFlowPipe1(
    pipeLength=pipeLength,
    pipeDiameter=pipeDiameter,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    energyDynamics=if dynamicBalance then energyDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=if dynamicBalance then massDynamics else Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    m_flow_nominal=m_flow_nominal,
    p_start=p_start,
    allowFlowReversal=allowFlowReversal,
    final V=V/2,
    nPorts=2) annotation (Placement(transformation(extent={{52,0},{32,20}})));

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
    annotation (Placement(transformation(extent={{-44,0},{-64,20}})));

equation
  connect(port_a, vol1.ports[1]) annotation (Line(
      points={{-100,0},{-52,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol1.ports[2], plugFlowPipe1.port_a) annotation (Line(
      points={{-56,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(plugFlowPipe1.port_b, vol.ports[1]) annotation (Line(
      points={{10,0},{44,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.ports[2], port_b) annotation (Line(
      points={{40,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol1.heatPort, heatPort1[1]) annotation (Line(
      points={{-44,10},{-20,10},{-20,80},{0,80},{0,95}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(vol.heatPort, heatPort1[2]) annotation (Line(
      points={{52,10},{56,10},{56,80},{14,80},{14,105},{0,105}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Icon(graphics={
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
          visible=showDesignFlowDirection),                                                                                                    Polygon(          points={{
              -10,-35},{-10,15},{0,35},{10,15},{10,-35},{-10,-35}},                                                                                                    lineColor={255,0,0},
            fillPattern =                                                                                                   FillPattern.Forward,          fillColor={255,255,255},
          origin={0,59},
          rotation=180)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end PlugFlowHeatPort;
