within IDEAS.DistrictHeating.Production;
package HeatSources 


annotation (Icon(graphics={
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
    Line(
    origin={-47.5,11.6667},
    points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
      smooth=Smooth.Bezier),
    Polygon(
    origin={-50,68.333},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
      points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}}),
    Line(
    origin={2.5,11.6667},
    points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
      smooth=Smooth.Bezier),
    Polygon(
    origin={0,68.333},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
      points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}}),
    Line(
    origin={52.5,11.6667},
    points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
      smooth=Smooth.Bezier),
    Polygon(
    origin={50,68.333},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
      points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}})}));
end HeatSources;
