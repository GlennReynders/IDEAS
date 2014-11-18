within IDEAS.DistrictHeating.Production;
model HeatPump
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatPump(
      QNomRef=data.QNomRef,
      TMax=data.TMax,
      TMin=data.TMin,
      modulationMin=data.modulationMin,
      modulationStart=data.modulationStart,
      m_flow_nominal=data.m_flow_nominal,
      m_flow_nominal_brine=data.m_flow_nominal_brine,
      mBrine=data.mBrine,
      redeclare HeatSources.HeatPump heatSource(
        redeclare package Medium = Medium,
        copData=data.copData,
        powerData=data.powerData),
    redeclare HeatSources.HeatPump partialHeatSourceHP);

  replaceable BaseClasses.PartialHeatPumpData data
    annotation (Placement(transformation(extent={{-2,96},{18,116}})));
equation
  PEl = heatSource.PEl;
  PFuel = 0;
  connect(partialHeatSourceHP.heatPortEvaporator, evaporator.heatPort)
    annotation (Line(
      points={{-2,80},{-40,80},{-40,10},{-50,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(partialHeatSourceHP.heatPortCondensor, pipe_HeatPort.heatPort)
    annotation (Line(
      points={{-2,76},{-12,76},{-12,76},{-20,76},{-20,-10},{-6,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics));
end HeatPump;
