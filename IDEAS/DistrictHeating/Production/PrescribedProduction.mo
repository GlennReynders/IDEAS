within IDEAS.DistrictHeating.Production;
model PrescribedProduction
  "Production with a prescribed heat transfer to the fluid"

  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeater(redeclare
      HeatSources.PrescribedHeatSource heatSource);

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-126,20},{-86,60}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics));
end PrescribedProduction;
