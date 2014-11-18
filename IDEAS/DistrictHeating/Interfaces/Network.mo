within IDEAS.DistrictHeating.Interfaces;
model Network "Interface for a district heating network"
  import IDEAS;

  parameter Integer nSeries=4
    "Number of substations/buildings connected in series";

  replaceable Baseclasses.Substation endStation
    annotation (Placement(transformation(extent={{-88,-22},{-68,-2}})));
  replaceable Baseclasses.Substation[nSeries] substations(numberOfConnections=1,
    flowPort_supply_in(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater),
    flowPort_return_out(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater))
    annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
  replaceable Baseclasses.Production production annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,-10})));

    inner IDEAS.SimInfoManager sim
    annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
  Fluid.Movers.FlowMachine_dp fan1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    motorCooledByFluid=false,
    m_flow_nominal=0.5)            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,22})));
  IDEAS.Interfaces.Building[nSeries] buildings(
    redeclare Occupants.Standards.None                             occupant(TSet_val=
          296.15),
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    DH=true,
    redeclare Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
        dTSupRetNom=20, TSupNom=318.15))
             annotation (Placement(transformation(extent={{-40,12},{-20,32}})));
  IDEAS.Interfaces.Building building1(
    redeclare Occupants.Standards.None                             occupant(TSet_val=
          296.15),
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.VentilationSystems.None ventilationSystem,
    DH=true,
    redeclare Buildings.Examples.BaseClasses.structure building,
    redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
        dTSupRetNom=20, TSupNom=318.15))
             annotation (Placement(transformation(extent={{-88,10},{-68,30}})));
  Modelica.Blocks.Sources.Constant const(k=100000)
    annotation (Placement(transformation(extent={{8,-20},{28,0}})));
  IDEAS.Fluid.Sources.FixedBoundary
                              bou(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-44,-70},{-24,-50}})));
equation
  connect(fan1.port_a, production.flowPort_supply) annotation (Line(
      points={{50,22},{80,22},{80,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(endStation.flowPort_b1[1], building1.port_return) annotation (Line(
      points={{-80,-2},{-80,10},{-79.6,10}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(building1.port_supply, endStation.flowPort_a1[1]) annotation (Line(
      points={{-76.7,10.1},{-76.7,0},{-76,0},{-76,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(substations[1].flowPort_return_out, production.flowPort_return)
    annotation (Line(
      points={{-20,-20},{0,-20},{0,-40},{80,-40},{80,-20}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(substations[1].flowPort_supply_in, fan1.port_b) annotation (Line(
      points={{-20,-16},{0,-16},{0,22},{30,22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(endStation.flowPort_supply_in, substations[1].flowPort_supply_out)
    annotation (Line(
      points={{-68,-16},{-40,-16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(endStation.flowPort_return_out, substations[1].flowPort_return_in)
    annotation (Line(
      points={{-68,-20},{-40,-20}},
      color={0,0,0},
      smooth=Smooth.None));

  if nSeries > 1 then
    for i in 1:nSeries-1 loop
      connect(substations[i+1].flowPort_supply_in, substations[i].flowPort_supply_out);
      connect(substations[i+1].flowPort_return_out, substations[i].flowPort_return_in);
    end for;
  end if;

  connect(buildings.port_return, substations.flowPort_b1[1]) annotation (Line(
      points={{-31.6,12},{-32,12},{-32,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(buildings.port_supply, substations.flowPort_a1[1]) annotation (Line(
      points={{-28.7,12.1},{-28.7,-2},{-28,-2}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bou.ports[1], production.flowPort_return) annotation (Line(
      points={{-24,-60},{-10,-60},{-10,-20},{0,-20},{0,-40},{80,-40},{80,-20}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(const.y, fan1.dp_in) annotation (Line(
      points={{29,-10},{40.2,-10},{40.2,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-60,80},{-40,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,80},{60,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,50},
          rotation=90),
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,5.32907e-015},
          rotation=90),
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,-50},
          rotation=90)}));
end Network;
