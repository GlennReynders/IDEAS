within IDEAS.DistrictHeating.Pipes;
model PlugFlowTemperaturePipe
  extends Modelica.Icons.Example;
  import IDEAS;

  inner Modelica.Fluid.System system(p_ambient=101325)
                                   annotation (Placement(transformation(extent={{80,108},
            {100,128}},        rotation=0)));

  IDEAS.Fluid.Sensors.TemperatureTwoPort MSL100T(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,22})));
  IDEAS.Fluid.Movers.Pump pump1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,22})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-46,22})));
  IDEAS.Fluid.Sources.FixedBoundary bou2(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    nPorts=3,
    p=100000,
    T=373.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-134,22})));

  IDEAS.Fluid.Sources.FixedBoundary bou3(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    use_p=true,
    p=100000,
    nPorts=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={102,22})));

  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    nNodes=100,
    diameter=0.1,
    length=32,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=10))
    annotation (Placement(transformation(extent={{-8,12},{12,32}})));

  IDEAS.Fluid.Movers.Pump pump2(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,-56})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-46,-56})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort MSL10T(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-56})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    nNodes=10,
    diameter=0.1,
    length=32,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=10))
    annotation (Placement(transformation(extent={{-8,-66},{12,-46}})));

  IDEAS.Fluid.Movers.Pump pump3(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,86})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem6(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-48,86})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort PlugFlowT(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={52,86})));

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[2] T2(T=293.15)
    annotation (Placement(transformation(extent={{-44,112},{-24,132}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[100] T100(T=293.15)
    annotation (Placement(transformation(extent={{-28,42},{-8,62}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[10] T10(T=293.15)
    annotation (Placement(transformation(extent={{-28,-28},{-8,-8}})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort IDEAST(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={56,-130})));
  IDEAS.Fluid.Movers.Pump pump4(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-130})));
  IDEAS.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,-130})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature[2] T1(T=293.15)
    annotation (Placement(transformation(extent={{-22,-106},{-2,-86}})));
  IDEAS.Fluid.Sources.FixedBoundary bou1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    nPorts=1,
    p=100000,
    T=373.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-128,-130})));
  IDEAS.Fluid.Sources.FixedBoundary bou4(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    use_T=false,
    use_p=true,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={98,-130})));
  IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    m=1000*plug.pipeLength*plug.pipeDiameter*plug.pipeDiameter/4*Modelica.Constants.pi,
    UA=0.08) annotation (Placement(transformation(extent={{0,-126},{20,-134}})));

  IDEAS.DistrictHeating.Pipes.InsulatedPlugFlow plug(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    m_flow_nominal=0.1,
    pipeLength=32,
    pipeDiameter=0.1,
    U=10) annotation (Placement(transformation(extent={{-14,76},{6,96}})));

equation
  connect(pump1.port_b, senTem2.port_a) annotation (Line(
      points={{-76,22},{-56,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem2.port_b, pipe.port_a) annotation (Line(
      points={{-36,22},{-8,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL100T.port_a, pipe.port_b) annotation (Line(
      points={{40,22},{12,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_b,senTem4. port_a) annotation (Line(
      points={{-76,-56},{-56,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem4.port_b, pipe1.port_a) annotation (Line(
      points={{-36,-56},{-8,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL10T.port_a, pipe1.port_b) annotation (Line(
      points={{40,-56},{12,-56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_b,senTem6. port_a) annotation (Line(
      points={{-76,86},{-58,86}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump3.port_a, bou2.ports[1]) annotation (Line(
      points={{-96,86},{-124,86},{-124,24.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump1.port_a, bou2.ports[2]) annotation (Line(
      points={{-96,22},{-124,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump2.port_a, bou2.ports[3]) annotation (Line(
      points={{-96,-56},{-124,-56},{-124,19.3333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(PlugFlowT.port_b, bou3.ports[1]) annotation (Line(
      points={{62,86},{92,86},{92,19.3333}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL100T.port_b, bou3.ports[2]) annotation (Line(
      points={{60,22},{92,22}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MSL10T.port_b, bou3.ports[3]) annotation (Line(
      points={{60,-56},{92,-56},{92,24.6667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T100.port, pipe.heatPorts) annotation (Line(
      points={{-8,52},{2.1,52},{2.1,26.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(T10.port, pipe1.heatPorts) annotation (Line(
      points={{-8,-18},{2.1,-18},{2.1,-51.6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pump4.port_b,senTem1. port_a) annotation (Line(
      points={{-70,-130},{-50,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump4.port_a, bou1.ports[1]) annotation (Line(
      points={{-90,-130},{-118,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(IDEAST.port_b, bou4.ports[1]) annotation (Line(
      points={{66,-130},{88,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem1.port_b, pipe_Insulated.port_a) annotation (Line(
      points={{-30,-130},{0,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(IDEAST.port_a, pipe_Insulated.port_b) annotation (Line(
      points={{46,-130},{20,-130}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T1[1].port, pipe_Insulated.heatPort) annotation (Line(
      points={{-2,-96},{10,-96},{10,-126}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(senTem6.port_b, plug.port_a) annotation (Line(
      points={{-38,86},{-14,86}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(plug.port_b, PlugFlowT.port_a) annotation (Line(
      points={{6,86},{42,86}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T2.port, plug.heatPort1) annotation (Line(
      points={{-24,122},{-4,122},{-4,92.2}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -160},{120,140}}), graphics), Icon(coordinateSystem(extent={{-160,-160},
            {120,140}})),
    experiment(StopTime=1500),
    __Dymola_experimentSetupOutput);
end PlugFlowTemperaturePipe;
