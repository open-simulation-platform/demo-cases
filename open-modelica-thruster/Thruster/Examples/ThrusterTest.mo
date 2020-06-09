within Thruster.Examples ;

model ThrusterTest "Description"

    Thruster thruster;
    
    Modelica.SIunits.Power power;
    Real tau_estimated;
    Modelica.SIunits.Force tau_actual;
  
equation


    thruster.alpha = 0;
    thruster.power_available = Modelica.Constants.inf;
    thruster.thrusterOn = true;
    thruster.u = 0.5;
    thruster.nu_r = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
    
    power = thruster.power;
    tau_estimated = thruster.tau_estimated;
    tau_actual = thruster.tau_actual;
    
end ThrusterTest;
