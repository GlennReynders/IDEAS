within IDEAS.DistrictHeating.Pipes;
model InsulatedPipeM "Insulated pipe model with /meter parameters"

  //Extensions
  extends IDEAS.Fluid.Interfaces.PartialTwoPortInterface;
  extends IDEAS.Fluid.Interfaces.LumpedVolumeDeclarations;

  //Parameters
  parameter Modelica.SIunits.Length pipeLength=10;
  parameter Modelica.SIunits.Length pipeDiameter=0.1;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Modelica.SIunits.PressureDifference dp_nominal=0;

  parameter Modelica.SIunits.CoefficientOfHeatTransfer U=0.2
    "Heat transfer coefficient";
  final parameter Modelica.SIunits.ThermalConductance G=U*Modelica.Constants.pi*(pipeDiameter/2)^2
    "Thermal conductance";
  final parameter Modelica.SIunits.Volume V=pipeLength*Modelica.Constants.pi*(pipeDiameter/2)^2;
  parameter Boolean dynamicBalance = true
    "Set to true to use a dynamic balance, which often leads to smaller systems of equations"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  //Components
  Fluid.FixedResistances.Pipe_Insulated pipe(
    redeclare package Medium = Medium,
    UA=G,
    m=V*1000,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{10,-4},{-10,4}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Port for heat exchange with mixing volume" annotation (Placement(
        transformation(extent={{-10,-108},{10,-88}}), iconTransformation(extent=
           {{-10,52},{10,72}})));
equation
  connect(port_a, pipe.port_b) annotation (Line(
      points={{-100,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.port_a, port_b) annotation (Line(
      points={{10,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.heatPort, heatPort) annotation (Line(
      points={{0,-4},{0,-98}},
      color={191,0,0},
      smooth=Smooth.None));
    annotation (Placement(transformation(extent={{10,-4},{-10,4}})), Icon(
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
          fillPattern=FillPattern.Solid)}),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end InsulatedPipeM;
