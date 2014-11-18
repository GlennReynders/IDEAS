within IDEAS.DistrictHeating.Production.HeatSources;
function Combination

  input Integer n;
  input Integer k;

  output Real z;

algorithm
  z :=Factorial(n)/(Factorial(k)*Factorial(n - k));

end Combination;
