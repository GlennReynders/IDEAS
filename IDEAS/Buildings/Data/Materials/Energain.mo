within IDEAS.Buildings.Data.Materials;
record Energain =   IDEAS.Buildings.Data.Interfaces.Material (
    PCM=true,
    k=0.2,
    cl=2820,
    c=4000,
    cs=4000,
    T1=23+273.15,
    T0=19+273.15,
    hlat= 140000,
    rho=870,
    epsLw=0.86,
    epsSw=0.44) "Energain panels of Dupont";
