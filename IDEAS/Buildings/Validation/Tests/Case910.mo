within IDEAS.Buildings.Validation.Tests;
model Case910 "Case 910"

  extends Modelica.Icons.Example;

  /*

Simulation of all so far modeled BESTEST cases in a single simulation.

*/

  inner IDEAS.SimInfoManager sim(
    occBeh=false,
    PV=false,
    filNam="BESTEST.TMY",
    lat=0.69464104229374,
    lon=-1.8308503853421,
    timZonSta=-28800)
              annotation (Placement(transformation(extent={{-92,68},{-82,78}})));

  // BESTEST 600 Series

  // BESTEST 900 Series

  replaceable Cases.Case910 Case910 constrainedby Interfaces.BesTestCase
    annotation (Placement(transformation(extent={{-36,4},{-24,16}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,70},{-92,78}})));
  annotation (
    experiment(
      StopTime=3.1536e+007,
      Interval=3600,
      Tolerance=1e-007),
    __Dymola_experimentSetupOutput,
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={         Text(
          extent={{-78,28},{-40,20}},
          lineColor={85,0,0},
          fontName="Calibri",
          textStyle={TextStyle.Bold},
          textString="BESTEST 900 Series")}));
end Case910;