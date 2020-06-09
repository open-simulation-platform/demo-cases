within Thruster.Motor ;

model PIDController "Description"

    input Modelica.SIunits.AngularVelocity omega_motor;
    input Modelica.SIunits.Torque Q_d;
    input Modelica.SIunits.Power P_d;
    input Boolean connected;
    input Modelica.SIunits.Power power_available;

    output Modelica.SIunits.Torque t_d;
    output Modelica.SIunits.Power power;

    parameter ThrusterData thrusterData;

protected
    
    Modelica.SIunits.Torque torque_d;

equation

    torque_d = Q_d / thrusterData.k_g;
  
    (t_d, power) = Saturation(omega_motor, torque_d, P_d, thrusterData, power_available, connected);


end PIDController;