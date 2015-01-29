within IDEAS.Utilities.Math.Functions.Examples;
model SpliceFunctionDerivativeCheck
  extends Modelica.Icons.Example;

  Real x;
  Real y;
initial equation
   y=x;
equation
  x=IDEAS.Utilities.Math.Functions.spliceFunction(
                                            10, -10, time+0.1, 0.2);
  der(y)=der(x);
  assert(abs(x-y) < 1E-2, "Model has an error");

<<<<<<< HEAD
 annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                    graphics),
experiment(StartTime=-1, StopTime=1.0),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Utilities/Math/Functions/Examples/SpliceFunctionDerivativeCheck.mos"
        "Simulate and plot"),
=======
 annotation(experiment(StartTime=-1, StopTime=1.0),
__Dymola_Commands(file="modelica://IDEAS/Resources/Scripts/Dymola/Utilities/Math/Functions/Examples/SpliceFunctionDerivativeCheck.mos" "Simulate and plot"),
>>>>>>> 3a3ad755c4e719df755a0cefcde2982c8c92c6f0
    Documentation(info="<html>
<p>
This example checks whether the function derivative
is implemented correctly. If the derivative implementation
is not correct, the model will stop with an assert statement.
</p>
</html>", revisions="<html>
<ul>
<li>
May 20, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end SpliceFunctionDerivativeCheck;
