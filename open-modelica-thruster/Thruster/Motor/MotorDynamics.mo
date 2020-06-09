within Thruster.Motor ;

model MotorDynamics "Description"
    
    input Modelica.SIunits.Torque torque;
    input Modelica.SIunits.Torque propeller_torque;

    output Modelica.SIunits.AngularVelocity omega;

    parameter ThrusterData thrusterData;

equation

    thrusterData.motorData.J * der(omega) = torque - propeller_torque - omega * thrusterData.K_omega / (2 * Modelica.Constants.pi) - tanh(100 * omega) * thrusterData.Qfriction;

end MotorDynamics;