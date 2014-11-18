within IDEAS.DistrictHeating.Production.HeatSources;
function Poly2ndDegree3Inputs

  //Constants
  input Real beta[10];

  //Powers
  input Integer powers[10,4];

  //Inputs
  input Real X;
  input Real Y;
  input Real Z;

  //Variables
  Real variables[4];
  Real term;

  //Output
  output Real result;

algorithm
  variables :={1,X,Y,Z};

  result := 0;

  for i in 1:10 loop
    term := beta[i];
    for j in 1:4 loop

      if variables[j]<=0 and powers[i,j] <=0 then
        term := term;
      else
        term := term * variables[j]^powers[i,j];
      end if;

    end for;
    result := result + term;
  end for;

end Poly2ndDegree3Inputs;
