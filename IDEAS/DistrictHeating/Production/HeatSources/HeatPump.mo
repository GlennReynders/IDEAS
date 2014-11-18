within IDEAS.DistrictHeating.Production.HeatSources;
model HeatPump
  //Extensions
  extends BaseClasses.PartialHeatSourceHP;

  //Parameters
  parameter Real[:,:] copData;
  parameter Real[:,:] powerData;

  //Variables
  Modelica.SIunits.Power PEl;
  Real cop;

  //Components
  Modelica.Blocks.Tables.CombiTable2D copTable(
    table=copData)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Tables.CombiTable2D powerTable(
    table=powerData)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Modelica.Blocks.Interfaces.BooleanInput on annotation (Placement(
        transformation(extent={{-28,66},{12,106}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-2,88})));

equation
  //Calculation of the heat provided by the heatpump
  cop = if on then  copTable.y else 1;
  PEl = if on then  powerTable.y * scaler else 0;
  heatPortCondensor.Q_flow=-PEl*cop;
  heatPortEvaporator.Q_flow=PEl*(cop-1);

  //Approximation!!
  powerTable.u2 = sim.Te;
  copTable.u2 = sim.Te;

  //Tin
  connect(TCondensor, powerTable.u1) annotation (Line(
      points={{-108,-40},{-40,-40},{-40,-14},{-12,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(copTable.u1, powerTable.u1) annotation (Line(
      points={{-12,26},{-26,26},{-26,26},{-40,26},{-40,-14},{-12,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TEvaporator, copTable.u2) annotation (Line(
      points={{-108,0},{-26,0},{-26,14},{-12,14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(powerTable.u2, copTable.u2) annotation (Line(
      points={{-12,-26},{-32,-26},{-32,0},{-26,0},{-26,14},{-12,14}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end HeatPump;
