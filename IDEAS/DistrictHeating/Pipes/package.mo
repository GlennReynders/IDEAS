within IDEAS.DistrictHeating;
package Pipes "Pipes for the modelling of district heating"
annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
          {100,100}}), graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          fillPattern=FillPattern.None,
          extent={{-100,-100},{100,100}},
          radius=25.0),
      Ellipse(
        extent={{-62,40},{-42,-40}},
        lineColor={0,0,0},
        fillPattern=FillPattern.Solid,
        fillColor={175,175,175}),
      Line(
        points={{-52,40},{60,40}},
        color={0,0,0},
        smooth=Smooth.None),
      Ellipse(
        extent={{50,40},{70,-40}},
        lineColor={0,0,0},
        fillPattern=FillPattern.Solid,
        fillColor={0,0,255}),
      Line(
        points={{-52,-40},{60,-40}},
        color={0,0,0},
        smooth=Smooth.None)}));
end Pipes;
