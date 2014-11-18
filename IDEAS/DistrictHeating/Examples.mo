within IDEAS.DistrictHeating;
package Examples
  extends Modelica.Icons.ExamplesPackage;

  model SeriesGrid "District heating grid with buildings connected in series"

    extends Modelica.Icons.Example;

    Interfaces.Network network(
      redeclare Substations.SingleHeatExchanger endStation,
      redeclare Substations.SingleHeatExchanger substations,
      redeclare Production.Boiler production(boiler(from_dp=true)))
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  end SeriesGrid;

  model Example
    extends Modelica.Icons.Example;

    inner IDEAS.SimInfoManager sim(occBeh=false, DHW=false)
      annotation (Placement(transformation(extent={{-92,74},{-72,94}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
    IDEAS.Interfaces.Building building(
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
      redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
          dTSupRetNom=20, TSupNom=318.15),
      numberOfConnections=1)
               annotation (Placement(transformation(extent={{-18,22},{2,42}})));
    IDEAS.DistrictHeating.Substations.SingleHeatExchanger hXWithBypass
      annotation (Placement(transformation(extent={{-18,-26},{2,-6}})));

    Fluid.Movers.FlowMachine_dp fan1(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      motorCooledByFluid=false,
      m_flow_nominal=0.5)            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={62,2})));

    IDEAS.Interfaces.Building building1(
      redeclare Occupants.Standards.None                             occupant(TSet_val=
            296.15),
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
          dTSupRetNom=20, TSupNom=318.15),
      numberOfConnections=1)
               annotation (Placement(transformation(extent={{-78,22},{-58,42}})));
    IDEAS.DistrictHeating.Substations.SingleHeatExchanger hXWithBypass1
      annotation (Placement(transformation(extent={{-78,-26},{-58,-6}})));

    Modelica.Blocks.Sources.Constant const(k=10000)
      annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
    Fluid.Sources.FixedBoundary bou(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      use_T=false,
      nPorts=1,
      p=100000)
      annotation (Placement(transformation(extent={{-20,-68},{0,-48}})));

    Production.PolynomialProduction boiler(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      QNom=30000,
      m_flow_nominal=0.1,
      redeclare
        IDEAS.DistrictHeating.Production.Data.Polynomials.Boiler2ndDegree data)
                        annotation (Placement(transformation(
          extent={{-10,-11},{10,11}},
          rotation=180,
          origin={88,-13})));

    Modelica.Blocks.Sources.Constant const1(k=343)
      annotation (Placement(transformation(extent={{64,-92},{84,-72}})));
    Pipes.InsulatedPipeM insulatedPipeM(
      m_flow_nominal=0.1,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      dp_nominal=2000000)
      annotation (Placement(transformation(extent={{-30,4},{-50,24}})));
    Pipes.InsulatedPipeM insulatedPipeM1(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{-50,-34},{-30,-14}})));
    Pipes.InsulatedPipeM insulatedPipeM2(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{40,-8},{20,12}})));
    Pipes.InsulatedPipeM insulatedPipeM3(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{20,-34},{40,-14}})));
  equation
    connect(fan1.dp_in, const.y) annotation (Line(
        points={{62.2,-10},{62,-10},{62,-60},{51,-60}},
        color={0,0,127},
        smooth=Smooth.None));

    //BoilerViaPartials.TSet = sim.Te;
    connect(const1.y, boiler.TSet) annotation (Line(
        points={{85,-82},{89,-82},{89,-26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(hXWithBypass1.flowPort_return_out, insulatedPipeM1.port_a)
      annotation (Line(
        points={{-58,-24},{-50,-24}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_return_in, insulatedPipeM1.port_b)
      annotation (Line(
        points={{-18,-24},{-30,-24}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_out, insulatedPipeM.port_a)
      annotation (Line(
        points={{-18,-20},{-24,-20},{-24,14},{-30,14}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(insulatedPipeM.port_b, hXWithBypass1.flowPort_supply_in)
      annotation (Line(
        points={{-50,14},{-58,14},{-58,-20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(fan1.port_b, insulatedPipeM2.port_a) annotation (Line(
        points={{52,2},{40,2}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_in, insulatedPipeM2.port_b)
      annotation (Line(
        points={{2,-20},{12,-20},{12,2},{20,2}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fan1.port_a, boiler.port_b) annotation (Line(
        points={{72,2},{77.8,2},{77.8,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_return_out, insulatedPipeM3.port_a)
      annotation (Line(
        points={{2,-24},{20,-24}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(boiler.port_a, insulatedPipeM3.port_b) annotation (Line(
        points={{77.8,-18},{60,-18},{60,-24},{40,-24}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(bou.ports[1], insulatedPipeM3.port_a) annotation (Line(
        points={{0,-58},{12,-58},{12,-24},{20,-24}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building1.port_in, hXWithBypass1.flowPort_sec_out) annotation (Line(
        points={{-69.6,22},{-70,22},{-70,-6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building1.port_out, hXWithBypass1.flowPort_sec_in) annotation (Line(
        points={{-66.4,22},{-66,22},{-66,-6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building.port_in, hXWithBypass.flowPort_sec_out) annotation (Line(
        points={{-9.6,22},{-10,22},{-10,-6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building.port_out, hXWithBypass.flowPort_sec_in) annotation (Line(
        points={{-6.4,22},{-6,22},{-6,-6}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={{-100,
              -100},{100,100}})),
      experiment(StopTime=1e+006, Interval=3600),
      __Dymola_experimentSetupOutput);
  end Example;

  model Example2 "Extension of example 1, including distribution heat losses"
    extends Examples.Example(
      fan1(addPowerToMedium=false),
      pipe_Insulated(m=100),
      pipe_Insulated1(m=100),
      pipe_Insulated3(m=100),
      pipe_Insulated2(m=100),
      pipe_Insulated4(m=100));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{-106,-84},{-86,-64}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Tground)
      annotation (Placement(transformation(extent={{-136,-86},{-116,-66}})));
  equation
    connect(realExpression.y, prescribedTemperature.T) annotation (Line(
        points={{-115,-76},{-112,-76},{-112,-74},{-108,-74}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
              -100},{100,100}}), graphics));
  end Example2;
end Examples;
