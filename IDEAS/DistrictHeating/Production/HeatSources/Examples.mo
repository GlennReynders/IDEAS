within IDEAS.DistrictHeating.Production.HeatSources;
package Examples
  //Examples
  extends Modelica.Icons.ExamplesPackage;
  model FunctionModel "Test for the Poly2ndDegree3Inputs function"

    //Parameters
    parameter Real x;
    parameter Real y;
    parameter Real z;

    parameter Real beta[:];
    parameter Integer powers[:,:];

    parameter Integer n = size(powers, 1);
    parameter Integer k = size(powers, 2);

    //Variables
    Real result;

  equation
    result = IDEAS.DistrictHeating.Production.HeatSources.PolynomialDimensions(
      X={x,y,z}, beta=beta, powers=powers, n=n, k=k);

  end FunctionModel;

  model CombinationModel
    //Parameters
    parameter Integer n;
    parameter Integer k;

    //Variables
    Real z;

  equation
    z = Combination(n,k);

  end CombinationModel;

  model FunctionTest "Test using the function model"
    //Extensions
    extends Modelica.Icons.Example;

    FunctionModel functionModel(
      beta={1.10801352268,-0.00139459489796,7.84565873015e-05,-0.00560282142857,
          -4.15816326533e-07,3.93071428571e-07,1.587e-05,-3.8671201814e-08,-4.29261904762e-07,
          2.67019047619e-05},
      powers={{2,0,0,0},{1,1,0,0},{1,0,1,0},{1,0,0,1},{0,2,0,0},{0,1,1,0},{0,1,
          0,1},{0,0,2,0},{0,0,1,1},{0,0,0,2}},
      x=100,
      z=77,
      y=3616) annotation (Placement(transformation(extent={{-10,-6},{10,14}})));
  end FunctionTest;

  model CombinationTest
    extends Modelica.Icons.Example;

    CombinationModel combinationModel(n=5, k=2)
      annotation (Placement(transformation(extent={{-8,-8},{12,12}})));
  end CombinationTest;
end Examples;
