within IDEAS.Buildings.Components.BaseClasses;
model DominantLayer "Find the dominant layer based on Ramallo-Gonzalez 2103"
  parameter Modelica.SIunits.AngularVelocity w_lb(  fixed=false);
  parameter Modelica.SIunits.AngularVelocity w_ub=1/0.5/3600;
  parameter Integer nSteps= 25;
  parameter Modelica.SIunits.AngularVelocity dw = (w_ub - w_lb)/nSteps;

  parameter Integer nLay(min=1);
  parameter IDEAS.Buildings.Data.Interfaces.Material[nLay] mats
    "array of layer materials";

  parameter Real[nLay] Ck( fixed=false);

  // intermediate pars for finding dominant layer
  parameter Real[nLay] Ri(  fixed=false);
  parameter Real[nLay] infk(  fixed=false);
  parameter Modelica.SIunits.AngularVelocity w(  fixed=false);
  parameter Real R(  fixed=false);
  parameter Integer[nLay] layorder(  fixed=false);
  parameter Real[nLay] infsorted(  fixed=false);

  // dominant layer
  parameter Integer layDom( fixed=false);

  // parameters of equivalent wall
  parameter Real C1( fixed= false);
  parameter Real R1( fixed = false);
  parameter Real R2( fixed = false);
  parameter Real C2 = Ck[layDom];
  parameter Real R3 = Ri[layDom];

  // intermediate pars for RC
    parameter Modelica.SIunits.Time TCis( fixed = false)
    "temporary parameter for calculation Ris";
  parameter Modelica.SIunits.Time TCos( fixed = false)
    "temporary parameter for calculation Ros";
initial algorithm

  // Part 1: find dominant layer
  Ck :=mats.rho.*mats.c.*mats.d;
  w_lb:=1/(sum(Ck)*sum(mats.R));
  R :=sum(mats.R);
  for i in 1:nLay loop
     R :=R - mats[i].R/2;
     Ri[i] :=R;
     R := R - mats[i].R/2;
     infk[i] :=0;
     w:=w_lb + dw/2;
     for wstep in 1:nSteps loop
       infk[i] :=infk[i] + 1/Modelica.ComplexMath.'abs'((1/(Modelica.ComplexMath.j*w*
        Ck[i])) + Ri[i])*dw;
       w:=w + dw;
     end for;
  end for;

  (infsorted,layorder):=Modelica.Math.Vectors.sort(infk);
  layDom :=Modelica.Math.Vectors.find(nLay,layorder);

  // Part 2: find TCis and TcOS
  TCis :=0;
  TCos :=0;
  for j in 1:(nLay-layDom) loop
    TCis :=TCis + Ck[j]*(mats[j].R/2 + Ri[j] - Ri[layDom]);
    TCos :=TCos + Ck[j]*(mats[j].R/2 + sum(mats.R) - Ri[j]);
  end for;
  R1 :=(sum(mats.R) - R3)*TCos/(TCis + TCos);
  R2 :=(sum(mats.R) - R3)*TCis/(TCis + TCos);
  C1 :=TCos/R1;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DominantLayer;
