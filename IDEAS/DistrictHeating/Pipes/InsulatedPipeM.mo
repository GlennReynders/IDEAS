within IDEAS.DistrictHeating.Pipes;
model InsulatedPipeM "Insulated pipe model with /meter parameters"

  //Extensions
  extends IDEAS.Fluid.FixedResistances.Pipe_Insulated(
    UA=G,
    m=V*rho,
    dp_nominal=pressureDrop*pipeLength);

  //Parameters
  parameter Modelica.SIunits.Length pipeLength=10;
  parameter Modelica.SIunits.Length pipeDiameter=0.1;
  parameter Modelica.SIunits.Density rho = 1000;
  parameter PressureLength pressureDrop = 20;

  parameter Modelica.SIunits.CoefficientOfHeatTransfer U=0.2
    "Heat transfer coefficient";
  final parameter Modelica.SIunits.ThermalConductance G=U*Modelica.Constants.pi*(pipeDiameter/2)^2
    "Thermal conductance";
  final parameter Modelica.SIunits.Volume V=pipeLength*Modelica.Constants.pi*(pipeDiameter/2)^2;
  parameter Boolean dynamicBalance = true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

    annotation (Placement(transformation(extent={{10,-4},{-10,4}})), Icon(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,60}}),
        graphics={
        Line(
          points={{-68,20},{-68,-20}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{68,20},{68,-20}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{-68,0},{-100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Line(
          points={{68,0},{100,0}},
          color={0,0,127},
          smooth=Smooth.None),
        Rectangle(
          extent={{-60,20},{60,-20}},
          lineColor={100,100,100},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,60},{60,45},{20,30},{20,60}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Polygon(
          points={{20,55},{50,45},{20,35},{20,55}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{55,45},{-60,45}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=showDesignFlowDirection),
        Polygon(
          points={{20,55},{50,45},{20,35},{20,55}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Polygon(
          points={{20,55},{50,45},{20,35},{20,55}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{55,45},{-60,45}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=showDesignFlowDirection)}),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end InsulatedPipeM;
