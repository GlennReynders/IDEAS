within IDEAS.DistrictHeating.Production.BaseClasses.DataPartials;
partial record PartialModulatingData
  "Partial for a heat source data record which holds data of 6 modulation steps"
  extends Modelica.Icons.Record;

  parameter Real[:,:] eta100;
  parameter Real[:,:] eta80;
  parameter Real[:,:] eta60;
  parameter Real[:,:] eta40;
  parameter Real[:,:] eta20;

end PartialModulatingData;
