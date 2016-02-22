within IDEAS.Utilities.Psychrometrics.Functions.BaseClasses;
function der_sublimationPressureIce
  "Derivative of function sublimationPressureIce"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature TSat(displayUnit="degC",
                                            nominal=300)
    "Saturation temperature";
    input Real dTsat(unit="K/s") "Sublimation temperature derivative";
    output Real psat_der(unit="Pa/s") "Sublimation pressure derivative";
protected
    Modelica.SIunits.Temperature TTriple=273.16 "Triple point temperature";
    Modelica.SIunits.AbsolutePressure pTriple=611.657 "Triple point pressure";
    Real r1=TSat/TTriple "Common subexpression 1";
    Real r1_der=dTsat/TTriple "Derivative of common subexpression 1";
    Real a[2]={-13.9281690,34.7078238} "Coefficients a[:]";
    Real n[2]={-1.5,-1.25} "Coefficients n[:]";
algorithm
    psat_der := exp(a[1] - a[1]*r1^n[1] + a[2] - a[2]*r1^n[2])*pTriple*(-(a[1]
      *(r1^(n[1] - 1)*n[1]*r1_der)) - (a[2]*(r1^(n[2] - 1)*n[2]*r1_der)));
    annotation (
      Inline=false,
      smoothOrder=5,
      Documentation(info="<html>
<p>
Derivative of function
<a href=\"modelica://IDEAS.Utilities.Psychrometrics.Functions.sublimationPressureIce\">
IDEAS.Utilities.Psychrometrics.Functions.sublimationPressureIce</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
November 20, 2013 by Michael Wetter:<br/>
First implementation, moved from <code>IDEAS.Media</code>.
</li>
</ul>
</html>"));
end der_sublimationPressureIce;
