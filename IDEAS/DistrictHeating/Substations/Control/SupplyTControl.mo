within IDEAS.DistrictHeating.Substations.Control;
model SupplyTControl

  Controls.Continuous.LimPID       conPID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=100,
    Ti=30)
    annotation (Placement(transformation(extent={{-18,-14},{2,6}})));
  Controls.ControlHeating.HeatingCurve heatingCurve(
    dTOutHeaBal=0,
    TSup_nominal=343.15,
    TSupMin=318.15,
    TRet_nominal=293.15,
    TOut_nominal=273.15)
    annotation (Placement(transformation(extent={{-80,-34},{-60,-14}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.0001)
    annotation (Placement(transformation(extent={{-56,48},{-36,68}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-8,48},{12,68}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{48,14},{68,34}})));
  Modelica.Blocks.Interfaces.RealInput sensFlow "Measured flow"
    annotation (Placement(transformation(extent={{-124,38},{-84,78}})));
  Modelica.Blocks.Interfaces.RealInput sensTemp "Measured temperature"
    annotation (Placement(transformation(extent={{-126,-80},{-86,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  outer SimInfoManager sim
    annotation (Placement(transformation(extent={{-94,78},{-74,98}})));
equation
  connect(conPID.u_s,heatingCurve. TSup) annotation (Line(
      points={{-20,-4},{-36,-4},{-36,-18},{-59,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.y, product.u2) annotation (Line(
      points={{3,-4},{20,-4},{20,18},{46,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanToReal.y, product.u1) annotation (Line(
      points={{13,58},{34,58},{34,30},{46,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sensFlow, greaterThreshold.u) annotation (Line(
      points={{-104,58},{-58,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(greaterThreshold.y, booleanToReal.u) annotation (Line(
      points={{-35,58},{-10,58}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sensTemp, conPID.u_m) annotation (Line(
      points={{-106,-60},{-8,-60},{-8,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, y) annotation (Line(
      points={{69,24},{76,24},{76,0},{106,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.None));

  sim.Te = heatingCurve.TOut;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-62,32},{58,-30}},
          lineColor={0,0,255},
          textString="Control")}));
end SupplyTControl;
