within IDEAS.Buildings.Data.Interfaces;
record Material "Properties of building materials"

  extends Modelica.Icons.MaterialProperty;
 parameter Boolean PCM = false "Boolean whether the material is a PCM";
  parameter Modelica.SIunits.Length d=0 "Layer thickness";
  parameter Modelica.SIunits.ThermalConductivity k "Thermal conductivity";
  parameter Modelica.SIunits.SpecificHeatCapacity c "Specific thermal capacity";
  parameter Modelica.SIunits.SpecificHeatCapacity cs=0
    "if PCM Specific thermal capacity solid phase";
  parameter Modelica.SIunits.SpecificHeatCapacity cl=0
    "if PCM Specific thermal capacity liquid phase";

  parameter Modelica.SIunits.Density rho "Density";
  parameter Modelica.SIunits.Emissivity epsLw = 0.85 "Longwave emisivity";
  parameter Modelica.SIunits.Emissivity epsSw = 0.85 "Shortwave emissivity";
  parameter Boolean gas=false "Boolean whether the material is a gas"
    annotation(Evaluate=true);

  parameter Modelica.SIunits.KinematicViscosity mhu = 0
    "Viscosity, i.e. if the material is a fluid";

  parameter Modelica.SIunits.Emissivity epsLw_a = epsLw
    "Longwave emisivity for surface a if different";
  parameter Modelica.SIunits.Emissivity epsLw_b = epsLw
    "Longwave emisivity for surface a if different";

  parameter Modelica.SIunits.Emissivity epsSw_a = epsSw
    "Shortwave emisivity for surface a if different";
  parameter Modelica.SIunits.Emissivity epsSw_b = epsSw
    "Shortwave emisivity for surface a if different";

  final parameter Modelica.SIunits.ThermalInsulance R=d/k;

  final parameter Modelica.SIunits.ThermalDiffusivity alpha=k/(c*rho)
    "Thermal diffusivity";
  final parameter Integer nStaRef=3
    "Number of states of a reference case, ie. 20 cm dense concrete";
  final parameter Real piRef=224
    "d/sqrt(mat.alpha) of a reference case, ie. 20 cm dense concrete";
  final parameter Real piLay=d/sqrt(alpha)
    "d/sqrt(mat.alpha) of the depicted layer";
  final parameter Integer nSta(min=1) = max(1, integer(ceil(nStaRef*piLay/piRef)))
    "Actual number of state variables in material";

    parameter Modelica.SIunits.Temperature     T1= 0 "upper melt temperature";
  parameter Modelica.SIunits.Temperature T0=0 "lower melt temperature";
   parameter Modelica.SIunits.SpecificEnthalpy hlat=0 "latent heat [J/kg]";
  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">General description</font></h4></p>
<p><h5>Goal</h5></p>
<p>The <code>Material.mo</code> partial describes the material data required for building construction modelling.</p>
<p><h5>Assumptions and limitations</h5></p>
<p><ol>
<li>Current number of states in the material layer is determined by a reference number of states in a 20cm concrete slab.</li>
</ol></p>
<p><h4><font color=\"#008000\">Validation </font></h4></p>
<p>No validation required.</p>
</html>"));
end Material;
