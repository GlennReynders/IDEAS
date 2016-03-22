within IDEAS.Buildings.Components.BaseClasses;
model MultiLayer "multiple material layers in series"

  parameter Modelica.SIunits.Area A "total multilayer area";
  parameter Modelica.SIunits.Angle inc
    "Inclinination angle of the multilayer at port_a";
  parameter Integer nLay(min=1) "number of layers";
  parameter IDEAS.Buildings.Data.Interfaces.Material[nLay] mats
    "array of layer materials";
  parameter Integer nGain = 0 "Number of gains";
  parameter Boolean linIntCon=false
    "Linearise interior convection inside air layers / cavities in walls";
  parameter Boolean lumped = false
    "Boolean to use control volume method or lumped capacity model"                                 annotation (Dialog(tab="Dynamics"));
  parameter Modelica.SIunits.Temperature T_start[nLay]=ones(nLay)*293.15
    "Start temperature for each of the layers";
  parameter Boolean placeCapacityAtSurf_b=true
    "Set to true to place last capacity at the surface b of the layer."
    annotation (Dialog(tab="Dynamics"));
  final parameter Modelica.SIunits.ThermalInsulance R=sum(mats.R)
    "total specific thermal resistance";
  parameter Modelica.SIunits.HeatCapacity C = sum(mats.d.*mats.rho.*mats.c*A)
    "Total heat capacity of the layers"
    annotation(Evaluate=true);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Static (steady state) or transient (dynamic) thermal conduction model"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter SI.TemperatureDifference dT_nom_air=1
    "Nominal temperature difference for air layers, used for linearising Rayleigh number";

  Modelica.SIunits.Energy E=Einternal;

  IDEAS.Buildings.Components.BaseClasses.MonoLayer[nLay] monLay(
    each final A=A,
    each final inc=inc,
    final T_start=T_start,
    final mat=mats,
    each linIntCon=linIntCon,
    epsLw_a=cat(
        1,
        {0.85},
        mats[1:nLay - 1].epsLw_b),
    epsLw_b=cat(
        1,
        mats[2:nLay].epsLw_a,
        {0.85}),
    each placeCapacityAtSurf_b=placeCapacityAtSurf_b,
    each final energyDynamics=energyDynamics,
    each dT_nom_air=dT_nom_air) if not lumped "Individual layers"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_gain[nLay]
    "port for gains by embedded active layers"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a(T(start=289.15))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b(T(start=289.15))
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsLw_b
    "output of the interior emissivity for radiative heat losses"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsSw_b
    "output of the interior emissivity for radiative heat losses"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsLw_a
    "output of the interior emissivity for radiative heat losses"
    annotation (Placement(transformation(extent={{-90,70},{-110,90}})));
  Modelica.Blocks.Interfaces.RealOutput iEpsSw_a
    "output of the interior emissivity for radiative heat losses"
    annotation (Placement(transformation(extent={{-90,30},{-110,50}})));
  Modelica.Blocks.Interfaces.RealOutput area=A
    "output of the interior emissivity for radiative heat losses" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,100})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C1(C=sum(mats.d.*mats.rho.*mats.c*A)) if lumped
    "Total heat capacity of the layers"
       annotation (Evaluate=true,Placement(transformation(extent={{-10,46},{10,66}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Ros(R=Ros0) if lumped
    annotation (Placement(transformation(extent={{-60,36},{-40,56}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor Ris(R=Ris0) if lumped
    annotation (Placement(transformation(extent={{28,36},{48,56}})));

protected
  parameter Modelica.SIunits.ThermalResistance Ris0( fixed=false)
    "temporary parameter for calculation of Ris";
  parameter Modelica.SIunits.ThermalResistance Ros0( fixed = false)
    "temporary parameter for calculation of Ros";
  parameter Modelica.SIunits.Time TCis0( fixed = false)
    "temporary parameter for calculation Ris";
  parameter Modelica.SIunits.Time TCos0( fixed = false)
    "temporary parameter for calculation Ros";
  parameter Modelica.SIunits.ThermalResistance Rj( fixed = false)
    "temporary parameter for calculation of Ris and Ros";
  Modelica.Blocks.Sources.RealExpression Elumped(y=C1.C*C1.T) if lumped;
  Modelica.Blocks.Sources.RealExpression Ecvm(y= sum(monLay.E)) if not lumped;
  Modelica.Blocks.Interfaces.RealInput Einternal;
initial algorithm
      Ris0 :=0;
      Ros0 :=R/A;
      TCis0 :=0;
      TCos0 :=0;
      for j in 1:nLay loop
        Rj :=mats[j].R/A;
        Ris0 :=Ris0 + Rj/2;
        Ros0 :=Ros0 - Rj/2;
        TCis0 :=TCis0 + Ris0*mats[j].d*mats[j].c*mats[j].rho*A;
        TCos0 :=TCos0 + Ros0*mats[j].d*mats[j].c*mats[j].rho*A;
        Ris0 :=Ris0 + Rj/2;
        Ros0 :=Ros0 - Rj/2;
      end for;
      Ros0 :=R/A*TCos0/(TCos0 + TCis0);
      Ris0 :=R/A*TCis0/(TCos0 + TCis0);

equation
  connect(Einternal,Elumped.y);
  connect(Einternal,Ecvm.y);
  // Last layer of monLay is connected to port_a
  connect(port_a, monLay[nLay].port_a)
    annotation (Line(points={{-100,0},{-100,0},{-10,0}}, color={191,0,0}));
  for j in 1:nLay - 1 loop
    connect(monLay[nLay - j + 1].port_b, monLay[nLay - j].port_a);
  end for;
  connect(port_b, monLay[1].port_b)
    annotation (Line(points={{100,0},{10,0}}, color={191,0,0}));

  connect(monLay.port_gain, port_gain) annotation (Line(points={{0,-10},{0,-10},
          {0,-60},{0,-100}}, color={191,0,0}));

  iEpsLw_a = mats[1].epsLw_a;
  iEpsSw_a = mats[1].epsSw_a;
  iEpsLw_b = mats[nLay].epsLw_b;
  iEpsSw_b = mats[nLay].epsSw_b;

  connect(port_a,Ros. port_a)
    annotation (Line(points={{-100,0},{-60,0},{-60,46}},color={191,0,0}));
  connect(Ros.port_b, C1.port)
    annotation (Line(points={{-40,46},{-20,46},{0,46}}, color={191,0,0}));
  connect(C1.port, Ris.port_a)
    annotation (Line(points={{0,46},{14,46},{28,46}}, color={191,0,0}));
  connect(Ris.port_b, port_b)
    annotation (Line(points={{48,46},{58,46},{58,0},{68,0},{100,0}},
                                                     color={191,0,0}));
  if nGain > 0 then
    for i in 1:nGain loop
  connect(port_gain[i], C1.port)
    annotation (Line(points={{0,-100},{0,-100},{0,46}}, color={191,0,0}));
    end for;
  end if;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(graphics={
        Rectangle(
          extent={{-90,80},{20,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Text(
          extent={{-150,113},{150,73}},
          textString="%name",
          lineColor={0,0,255}),
        Rectangle(
          extent={{20,80},{40,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{40,80},{80,-80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          pattern=LinePattern.None),
        Line(
          points={{20,80},{20,-80}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Line(
          points={{40,80},{40,-80}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Ellipse(
          extent={{-40,-42},{40,38}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-39,40},{39,-40}},
          lineColor={127,0,0},
          fontName="Calibri",
          origin={0,-1},
          rotation=90,
          textString="S")}),
    Documentation(info="<html>
<p>For the purpose of dynamic building simulation, the partial differential equation of the continuous time and space model of heat transport through a solid is most often simplified into ordinary differential equations with a finite number of parameters representing only one-dimensional heat transport through a construction layer. Within this context, the wall is modeled with lumped elements, i.e. a model where temperatures and heat fluxes are determined from a system composed of a sequence of discrete resistances and capacitances R_{n+1}, C_{n}. The number of capacitive elements $n$ used in modeling the transient thermal response of the wall denotes the order of the lumped capacitance model.</p>
<p align=\"center\"><img src=\"modelica://IDEAS/Images/equations/equation-pqp0E04K.png\"/></p>
<p>where <img src=\"modelica://IDEAS/Images/equations/equation-I7KXJhSH.png\"/> is the added energy to the lumped capacity, <img src=\"modelica://IDEAS/Images/equations/equation-B0HPmGTu.png\"/> is the temperature of the lumped capacity, <img src=\"modelica://IDEAS/Images/equations/equation-t7aqbnLB.png\"/> is the thermal capacity of the lumped capacity equal to<img src=\"modelica://IDEAS/Images/equations/equation-JieDs0oi.png\"/> for which rho denotes the density and <img src=\"modelica://IDEAS/Images/equations/equation-ml5CM4zK.png\"/> is the specific heat capacity of the material and <img src=\"modelica://IDEAS/Images/equations/equation-hOGNA6h5.png\"/> the equivalent thickness of the lumped element, where <img src=\"modelica://IDEAS/Images/equations/equation-1pDREAb7.png\"/> the heat flux through the lumped resistance and <img src=\"modelica://IDEAS/Images/equations/equation-XYf3O3hw.png\"/> is the total thermal resistance of the lumped resistance and where <img src=\"modelica://IDEAS/Images/equations/equation-dgS5sGAN.png\"/> are internal thermal source.</p>
</html>", revisions="<html>
<ul>
<li>
February 10, 2016, by Filip Jorissen and Damien Picard:<br/>
Revised implementation: now only one MultiLayer component exists.
</li>
</ul>
</html>"));
end MultiLayer;
