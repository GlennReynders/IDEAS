within IDEAS.Fluid.BaseCircuits.BaseClasses;
partial model FourPort

  FluidTwoPort fluidTwoPort_a(redeclare package Medium = Medium) annotation (
      Placement(transformation(extent={{10,90},{-10,110}}), iconTransformation(
          extent={{-10,90},{10,110}})));
  FluidTwoPort fluidTwoPort_b(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
    annotation (__Dymola_choicesAllMatching=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(m_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end FourPort;
