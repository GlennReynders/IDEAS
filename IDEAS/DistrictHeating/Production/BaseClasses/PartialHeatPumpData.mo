within IDEAS.DistrictHeating.Production.BaseClasses;
partial record PartialHeatPumpData "Partial data record for heat pump data"
  extends Modelica.Icons.Record;
  extends PartialData;

  //Zeros in powerData and copData indicate that this data is not available or that the working point is outside of the working range of the device
  parameter Modelica.SIunits.Power[:,:] powerData "Power map for the heat pump";
  parameter Real[:,:] copData "Cop map for the heat pump";

end PartialHeatPumpData;
