within IDEAS.Utilities;
package Tables
  model InterpolationTable3D "A 3D Interpolation table"

    //Inputs
    Modelica.Blocks.Interfaces.RealInput u1
      annotation (Placement(transformation(extent={{-128,40},{-88,80}})));
    Modelica.Blocks.Interfaces.RealInput u2
      annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
    Modelica.Blocks.Interfaces.RealInput u3
      annotation (Placement(transformation(extent={{-128,-80},{-88,-40}})));

    //Outputs
    Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signals" annotation (Placement(
          transformation(extent={{100,-10},{120,10}}, rotation=0),
          iconTransformation(extent={{100,-8},{120,12}})));

    //Parameters
    parameter Boolean includeZero = true
      "Wether or not to automatically include zero as a height and a plane with zero output";
    parameter Integer n(min=2) = space.n "Number of 2D tables";
    final parameter Real heights[n]= {space.planes[i].height for i in 1:n};

    //Data
    parameter Space space;

    //Tables
    Modelica.Blocks.Tables.CombiTable2D Table[n](
      table={space.planes[i].curve for i in 1:n})
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  equation
    for i in 1:n loop
      Table[i].u1=u1;
      Table[i].u2=u2;
    end for;

    y = Modelica.Math.Vectors.interpolate(
      heights,
      {Table[i].y for i in 1:n},
      u3);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={
                                  Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},
                {-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},
                {60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
      Line(points={{0,40},{0,-40}}),
      Line(points={{-60,40},{-30,20}}),
      Line(points={{-30,40},{-60,20}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,0.0},{-32.3077,20.0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-20.0},{-32.3077,0.0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-30,20},{0,40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{0,20},{30,40}}),
      Rectangle(origin={-2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{32.3077,20.0},{62.3077,40.0}}),
                                  Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},
                {-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},
                {60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
      Line(points={{0,40},{0,-40}}),
      Line(points={{-60,40},{-30,20}}),
      Line(points={{-30,40},{-60,20}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,0.0},{-32.3077,20.0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-20.0},{-32.3077,0.0}}),
      Rectangle(origin={2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-30,20},{0,40}}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{0,20},{30,40}}),
      Rectangle(origin={-2.3077,0},
        fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{32.3077,20.0},{62.3077,40.0}})}));
  end InterpolationTable3D;

  record Space

    parameter Integer n(min=2)=2 "Number of planes";
    parameter Plane planes[n] "Array of planes"
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  end Space;

  record Plane

    parameter Real height "The height of the plane";
    parameter Real curve[:,:];

  end Plane;

  package Examples
    model Interpolation3D
      extends Modelica.Icons.Example;

      InterpolationTable3D interpolationTable3D(
        space=exampleData)
        annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
      Modelica.Blocks.Sources.Constant const(k=3)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica.Blocks.Sources.Constant const1(k=1.5)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.Blocks.Sources.Constant const2(k=3)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      ExampleData exampleData(n=3)
        annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
    equation
      connect(const.y, interpolationTable3D.u1) annotation (Line(
          points={{-39,30},{-28,30},{-28,4},{-10.8,4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const2.y, interpolationTable3D.u2) annotation (Line(
          points={{-39,-10},{-28,-10},{-28,-2},{-10.8,-2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const1.y, interpolationTable3D.u3) annotation (Line(
          points={{-39,-50},{-20,-50},{-20,-8},{-10.8,-8}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end Interpolation3D;

    record ExampleData
      extends IDEAS.Utilities.Tables.Space(planes=
       {Plane(height=1, curve=[1,2,3; 2,1,2; 3,3,4]),
        Plane(height=2, curve=[1,2,3; 2,5,7; 3,6,8]),
        Plane(height=3, curve=[1,2,3; 2,9,11; 3,10,12])})
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    end ExampleData;
  end Examples;
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
        Rectangle(
          extent={{-76,-26},{80,-76}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,24},{80,-26}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,74},{80,24}},
          lineColor={95,95,95},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-28,74},{-28,-76}},
          color={95,95,95}),
        Line(
          points={{24,74},{24,-76}},
          color={95,95,95})}));
end Tables;
