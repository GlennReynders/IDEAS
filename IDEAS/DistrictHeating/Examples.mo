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
      annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{20,60},{40,80}})));
    IDEAS.Interfaces.Building building(
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
      redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
          dTSupRetNom=20, TSupNom=318.15),
      numberOfConnections=1)
               annotation (Placement(transformation(extent={{-20,42},{0,62}})));
    IDEAS.DistrictHeating.Substations.SingleHeatExchanger hXWithBypass
      annotation (Placement(transformation(extent={{-20,-4},{0,16}})));

    Fluid.Movers.FlowMachine_dp fan1(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      motorCooledByFluid=false,
      m_flow_nominal=0.5)            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={60,20})));

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
               annotation (Placement(transformation(extent={{-80,42},{-60,62}})));
    IDEAS.DistrictHeating.Substations.SingleHeatExchanger hXWithBypass1
      annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));

    Modelica.Blocks.Sources.Constant const(k=1e5)
      annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
    Fluid.Sources.FixedBoundary bou(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      use_T=false,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,40})));

    Production.PolynomialProduction boiler(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      QNom=30000,
      m_flow_nominal=0.1,
      redeclare
        IDEAS.DistrictHeating.Production.Data.Polynomials.Boiler2ndDegree data,
      dp_nominal=200)   annotation (Placement(transformation(
          extent={{-10,-11},{10,11}},
          rotation=180,
          origin={90,1})));

    Modelica.Blocks.Sources.Constant const1(k=343)
      annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
    Pipes.InsulatedPipeM insulatedPipeM(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{-50,-24},{-30,-14}})));
    Pipes.InsulatedPipeM insulatedPipeM1(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{20,-24},{40,-14}})));
    Pipes.InsulatedPipeM insulatedPipeM2(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{-30,24},{-50,14}})));
    Pipes.InsulatedPipeM insulatedPipeM3(redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{40,24},{20,14}})));
  equation
    connect(fan1.dp_in, const.y) annotation (Line(
        points={{60.2,8},{60,8},{60,-50},{41,-50}},
        color={0,0,127},
        smooth=Smooth.None));

    //BoilerViaPartials.TSet = sim.Te;
    connect(const1.y, boiler.TSet) annotation (Line(
        points={{81,-70},{91,-70},{91,-12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fan1.port_a, boiler.port_b) annotation (Line(
        points={{70,20},{79.8,20},{79.8,4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building1.port_in, hXWithBypass1.flowPort_sec_out) annotation (Line(
        points={{-71.6,42},{-72,42},{-72,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building1.port_out, hXWithBypass1.flowPort_sec_in) annotation (Line(
        points={{-68.4,42},{-68,42},{-68,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building.port_in, hXWithBypass.flowPort_sec_out) annotation (Line(
        points={{-11.6,42},{-12,42},{-12,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(building.port_out, hXWithBypass.flowPort_sec_in) annotation (Line(
        points={{-8.4,42},{-8,42},{-8,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(bou.ports[1], boiler.port_b) annotation (Line(
        points={{80,30},{80,20},{79.8,20},{79.8,4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hXWithBypass1.flowPort_return_out, insulatedPipeM.port_a)
      annotation (Line(
        points={{-60,-2},{-56,-2},{-56,-20},{-50,-20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_return_in, insulatedPipeM.port_b) annotation
      (Line(
        points={{-20,-2},{-26,-2},{-26,-20},{-30,-20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_return_out, insulatedPipeM1.port_a)
      annotation (Line(
        points={{0,-2},{10,-2},{10,-20},{20,-20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(boiler.port_a, insulatedPipeM1.port_b) annotation (Line(
        points={{79.8,-4},{80,-4},{80,-20},{40,-20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hXWithBypass1.flowPort_supply_in, insulatedPipeM2.port_b)
      annotation (Line(
        points={{-60,2},{-56,2},{-56,20},{-50,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_out, insulatedPipeM2.port_a)
      annotation (Line(
        points={{-20,2},{-26,2},{-26,20},{-30,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_in, insulatedPipeM3.port_b)
      annotation (Line(
        points={{0,2},{10,2},{10,20},{20,20}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fan1.port_b, insulatedPipeM3.port_a) annotation (Line(
        points={{50,20},{40,20}},
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
