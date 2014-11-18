within IDEAS.DistrictHeating.Production.HeatSources;
function Factorial
  input Integer x;
  output Integer xFactorial;

algorithm
  xFactorial := 1;

  for i in 2:x loop
    xFactorial := xFactorial * i;
  end for;

end Factorial;
