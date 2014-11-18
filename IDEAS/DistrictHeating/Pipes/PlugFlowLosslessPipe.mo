within IDEAS.DistrictHeating.Pipes;
model PlugFlowLosslessPipe
  "Pipe with a temperature plug flow without pressure losses"
   //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  final parameter Boolean from_dp=true "Used to satisfy replaceable models";

  //Parameters
  parameter Modelica.SIunits.Length L "Pipe length";
  parameter Modelica.SIunits.Length D "Pipe diameter";
  final parameter Modelica.SIunits.CrossSection A = Modelica.Constants.pi*(D/2)^2;

  //Variables
  Real u "Normalized speed";
  Real x "Normalized transport quantity";

equation
  dp=0;

  // Mass balance (no storage)
  port_a.m_flow + port_b.m_flow = 0;

  // Transport of substances
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);

  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);

  //Normalized speed of the fluid [1/s]
  u = port_a.m_flow/(1000*A*L);
  der(x) = u;

  //Spatial distribution of the enthalpy
  (port_a.h_outflow, port_b.h_outflow) =
    spatialDistribution(
      inStream(port_a.h_outflow),
      inStream(port_b.h_outflow),
      x,
      true,
      {0.0, 1},
      {inStream(port_a.h_outflow),
      inStream(port_b.h_outflow)});

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,50},{100,-48}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={217,236,256}),
        Text(
          extent={{-104,-50},{18,-116}},
          lineColor={0,0,255},
          textString="dp_nominal=0"),
        Rectangle(
          extent={{-20,50},{20,-48}},
          lineColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175})}));
end PlugFlowLosslessPipe;
