within IDEAS.DistrictHeating.Interfaces.Baseclasses;
partial model Substation "Interface for a local substation"

  //Parameters
  parameter Integer numberOfConnections = 1;

  //Connectors
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_sec_out[numberOfConnections](
      redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Flowport supply to to the building"
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_sec_in[numberOfConnections](
      redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Flowport return from the building"
    annotation (Placement(transformation(extent={{10,90},{30,110}})));

  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_supply_out(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Supply line out connection"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_supply_in(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Supply line in connection"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_return_in(redeclare package Medium
      = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Return line in connection"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_return_out(redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Return line out connection"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                               graphics={
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={-82,-80},
          rotation=90),
        Rectangle(
          extent={{-58,60},{62,-88}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-58,72},{62,48}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-58,-76},{62,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,62},{-20,98}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{20,62},{20,98}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={-82,-40},
          rotation=90),
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={74,-40},
          rotation=90),
        Line(
          points={{0,12},{7.3479e-016,-24}},
          color={0,0,255},
          smooth=Smooth.None,
          origin={74,-80},
          rotation=90),
        Line(
          points={{50,-40},{-40,-40},{-32,-32},{-40,-40},{-32,-48}},
          color={0,0,255},
          smooth=Smooth.None),
        Rectangle(
          extent={{-58,-76},{62,-88}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-58,-76},{-58,-88}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{62,-76},{62,-88}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-38,-80},{52,-80},{44,-72},{52,-80},{44,-88}},
          color={0,0,255},
          smooth=Smooth.None)}));
end Substation;
