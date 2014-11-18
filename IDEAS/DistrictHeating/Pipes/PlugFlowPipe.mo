within IDEAS.DistrictHeating.Pipes;
model PlugFlowPipe
  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  extends IDEAS.Fluid.Interfaces.TwoPortFlowResistanceParameters(
    final computeFlowResistance=true, dp_nominal = 0);

  //Parameters
  parameter Modelica.SIunits.Length pipeLength;
  parameter Modelica.SIunits.Length pipeDiameter;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Modelica.SIunits.PressureDifference dp_nominal=0;

  //Components
  DistrictHeating.Pipes.PlugFlowLosslessPipe plug(
    L=pipeLength,
    D=pipeDiameter,
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Fluid.FixedResistances.FixedResistanceDpM res(m_flow_nominal=m_flow_nominal,
      dp_nominal=dp_nominal,
      redeclare package Medium=Medium)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

equation
  connect(port_a, res.port_a) annotation (Line(
      points={{-100,0},{-60,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(res.port_b, plug.port_a) annotation (Line(
      points={{-40,0},{40,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(plug.port_b, port_b) annotation (Line(
      points={{60,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={
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
        Line(
          points={{55,-85},{-60,-85}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=showDesignFlowDirection),
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
          fillPattern=FillPattern.HorizontalCylinder)}));
end PlugFlowPipe;
