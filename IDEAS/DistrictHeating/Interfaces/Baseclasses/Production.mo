within IDEAS.DistrictHeating.Interfaces.Baseclasses;
partial model Production "Interface for a district heating production unit"

  IDEAS.Fluid.Interfaces.FlowPort_b flowPort_return(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Return side of the production (cold water)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  IDEAS.Fluid.Interfaces.FlowPort_a flowPort_supply(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Supply flow port (hot water)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={Line(
          points={{-100,0},{-80,0},{-60,40},{-40,-40},{-20,40},{0,-40},{20,40},
              {40,-40},{60,40},{80,0},{100,0},{98,0}},
          color={0,0,255},
          smooth=Smooth.None)}));
end Production;
