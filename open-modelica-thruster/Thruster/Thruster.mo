within Thruster ;

model Thruster

parameter ThrusterData thrusterData;

    input Modelica.SIunits.Angle alpha "Thruster Angle";
    input Real[6] nu_r "Vessel velocity relative to current";
    input Boolean thrusterOn "Signal indicating if the thruster is on or off";
    input Modelica.SIunits.Power power_available "Power available to thruster";
    input Real DesiredFractionOfMaxThrust "Desired thrust as a percentage of rated thrust";

    output Modelica.SIunits.Power power "Power used by thruster";
    output Modelica.SIunits.Force tau_estimated "Estimated thrust as a percentage of rated thrust";
    output Modelica.SIunits.Force tau_actual "Actual thrust produced";

protected
    Drive.Drive thrusterDrive(thrusterData = thrusterData);
    RotationDynamics thrusterRotation(thrusterData = thrusterData);
    
    Modelica.SIunits.Angle alphaGenset;
    
    Modelica.SIunits.Angle alpha_d;
    
    Modelica.SIunits.Velocity Va;

equation

    alpha_d = RemapAlpha(alpha, alphaGenset);
    thrusterRotation.alpha_d = alpha_d;
    alphaGenset = thrusterRotation.alpha;
    
    Va = FindAdvanceVelocity(nu_r, thrusterData, alphaGenset);

    thrusterDrive.u = DesiredFractionOfMaxThrust;
    thrusterDrive.connected = thrusterOn;
    thrusterDrive.power_available = power_available;
    thrusterDrive.Va = Va;
    
    
    power = thrusterDrive.power;
    tau_estimated = thrusterDrive.tau_estimated / thrusterData.ratedThrust;
    tau_actual = thrusterDrive.tau_actual;

end Thruster;
