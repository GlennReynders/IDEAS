within IDEAS.Examples;
model Example

  extends Modelica.Icons.Example;

  inner SimInfoManager sim(
    occBeh=false)
    annotation (Placement(transformation(extent={{-90,74},{-70,94}})));
   // redeclare IDEAS.Climate.Meteo.Files.min15 detail,
    //redeclare IDEAS.Climate.Meteo.Locations.Uccle city,
  Interfaces.Examples.building building
    annotation (Placement(transformation(extent={{-38,12},{-18,32}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
end Example;
