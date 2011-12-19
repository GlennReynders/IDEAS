within IDEAS.Data.Glazing;
record Ins2_Ar_gold =
              IDEAS.Data.Interfaces.Glazing (
    nLay=3,
    mats={Materials.Glass(d=0.006),Materials.Argon(d=0.016),Materials.Glass(d=
        0.006)},
    SwTrans=[0,0.138; 10,0.139; 20,0.136; 30,0.133; 40,0.129; 50,0.121; 60,
        0.106; 70,0.077; 80,0.034; 90,0.000],
    SwAbs=[0,0.714,0.0,0.028; 10,0.720,0.0,0.028; 20,0.724,0.0,0.028; 30,0.724,
        0.0,0.029; 40,0.717,0.0,0.029; 50,0.708,0.0,0.029; 60,0.691,0.0,0.028;
        70,0.638,0.0,0.025; 80,0.461,0.0,0.017; 90,0.000,0.0,0.000],
    U_value=1.3,
    g_value=0.212) "Double pane window (U = 1.3 W/m2K, g = 0.212)";