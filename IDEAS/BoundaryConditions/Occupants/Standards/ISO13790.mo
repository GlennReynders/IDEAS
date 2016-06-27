within IDEAS.BoundaryConditions.Occupants.Standards;
model ISO13790
  extends IDEAS.Templates.Interfaces.BaseClasses.Occupant(
                                                nZones=1, nLoads=1);

  parameter Modelica.SIunits.Area[nZones] AFloor=ones(nZones)*100
    "Floor area of different zones";
  parameter Integer nDayZones = 1 "number of dayzones";
  final parameter Integer nNightZones = nZones - nDayZones
    "number of nightzones";

protected
  final parameter Modelica.SIunits.Time interval=3600 "Time interval";
  final parameter Modelica.SIunits.Time period=86400/interval
    "Number of intervals per repetition";
  final parameter Real[3] QDay(unit="W/m2") = {8,20,2}
    "Specific power for dayzone";
  final parameter Real[3] QNight(unit="W/m2") = {1,1,6}
    "Specific power for dayzone";
  Integer t "Time interval";

algorithm
  when sample(0, interval) then
    t := if pre(t) + 1 <= period then pre(t) + 1 else 1;
  end when;

equation
  heatPortRad.Q_flow = heatPortCon.Q_flow;
  P = {sum(heatPortCon.Q_flow) + sum(heatPortRad.Q_flow)};
  Q = {0};

  if noEvent(t <= 7 or t >= 23) then
    heatPortCon[1:nDayZones].Q_flow = -AFloor[1:nDayZones]*QDay[3]*0.5;
    TSet[1:nDayZones] = ones(nDayZones)*(18 + 273.15);
    heatPortCon[(nDayZones+1):nZones].Q_flow = -AFloor[(nDayZones+1):nZones]*QNight[3]*0.5;
    TSet[(nDayZones+1):nZones] = ones(nNightZones)*(16 + 273.15);
  elseif noEvent(t > 7 and t <= 17) then
    heatPortCon[1:nDayZones].Q_flow = -AFloor[1:nDayZones]*QDay[1]*0.5;
    TSet[1:nDayZones] = ones(nDayZones)*(16 + 273.15);
    heatPortCon[(nDayZones+1):nZones].Q_flow = -AFloor[(nDayZones+1):nZones]*QNight[1]*0.5;
    TSet[(nDayZones+1):nZones] = ones(nNightZones)*(16 + 273.15);
  else
    heatPortCon[1:nDayZones].Q_flow = -AFloor[1:nDayZones]*QDay[2]*0.5;
    TSet[1:nDayZones] = ones(nDayZones)*(21 + 273.15);
    heatPortCon[(nDayZones+1):nZones].Q_flow = -AFloor[(nDayZones+1):nZones]*QNight[2]*0.5;
    TSet[(nDayZones+1):nZones] = ones(nNightZones)*(16 + 273.15);
  end if;

  if ((t >= 7 and t <=8) or (t>=20 and t<=21)) then
    mDHW60C = 2/60*15/60; //shower 2 L/min for 15 min averaged over 1 h

  elseif ( (t>=11 and t<=12) or (t>=17.0 and t<=18) or (t>=19.0 and t<=20)) then
    mDHW60C = 4*5/3660; // tab 4L/min for 5 min
  else
    mDHW60C = 0;
  end if;

  annotation (Diagram(graphics));
end ISO13790;
