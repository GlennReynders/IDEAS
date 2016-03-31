within IDEAS.Buildings.Components.ThermalBridges;
record LineLosses "Line loss caused by thermal bridges "

  extends IDEAS.Buildings.Components.Interfaces.ThermalBridge(final G=psi*len, final present=true);

  parameter Real psi = 0.15 "Linear heat loss coefficient";
  parameter Real len = 1 "Perimeter of the thermal bridge";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LineLosses;
