within Thruster.Drive ;

model Drive

  input Boolean connected;
  input Real u;
  input Modelica.SIunits.Power power_available;
  input Modelica.SIunits.Velocity Va;
  
  output Modelica.SIunits.Power power;
  output Modelica.SIunits.Force tau_estimated;
  output Modelica.SIunits.Force tau_actual;

  parameter ThrusterData thrusterData; 

protected

  Motor.Motor motor(thrusterData = thrusterData);
  SecondOrderFilter secondOrderFilter(w0 = 2 * Modelica.Constants.pi / thrusterData.omega_ref_tau, xi = 1, initialCondition = thrusterData.initialThrust);
  
  Real tau_d;
  
  Modelica.SIunits.Force Td;
  Modelica.SIunits.Power P_d;
  Modelica.SIunits.Torque Q_d;
  Modelica.SIunits.Torque propeller_torque;
  
  Modelica.SIunits.Force T_est;
  Modelica.SIunits.AngularVelocity omega;
  
  Real T;
  Modelica.SIunits.Torque Q;
  

equation
  
  tau_d = u * thrusterData.ratedThrust;
  secondOrderFilter.x = tau_d;
  Td = secondOrderFilter.x_filter;
  
  (P_d, Q_d) = FindDesiredPropellerSpeed(Td, thrusterData, thrusterData.rho);

  motor.propeller_torque = propeller_torque;
  motor.power_available = power_available;
  motor.connected = connected;
  motor.P_d = P_d;
  motor.Q_d = Q_d;
 
  omega = motor.omega;
  T_est = EstimatedThrusterForce(omega, thrusterData, thrusterData.rho);
  
  (Q, T) = Propeller(Va, omega, thrusterData, thrusterData.rho);
  propeller_torque = Q;
  
  power = motor.power;
  tau_actual = T;
  tau_estimated = T_est;

end Drive;
