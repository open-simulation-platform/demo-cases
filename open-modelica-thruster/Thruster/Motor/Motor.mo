within Thruster.Motor ;

model Motor

parameter ThrusterData thrusterData;

input Modelica.SIunits.Torque propeller_torque;
input Modelica.SIunits.Power power_available;
input Boolean connected;
input Modelica.SIunits.Power P_d;
input Modelica.SIunits.Torque Q_d;

output Modelica.SIunits.AngularVelocity omega;
output Modelica.SIunits.Power power;

protected 

  PIDController pidController(thrusterData = thrusterData);
  MotorDynamics motorDynamics(thrusterData = thrusterData);

equation
   
   pidController.omega_motor = motorDynamics.omega;
   pidController.Q_d = Q_d;
   pidController.power_available = power_available;
   pidController.connected = connected;
   pidController.P_d = P_d;
  
   motorDynamics.torque = pidController.t_d;
   motorDynamics.propeller_torque = propeller_torque / thrusterData.k_g;
   
   omega = motorDynamics.omega / thrusterData.k_g;
   power = pidController.power;

end Motor;