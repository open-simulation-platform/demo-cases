within Thruster.Drive ;

function EstimatedThrusterForce

  input Modelica.SIunits.AngularVelocity w;
  input ThrusterData thrusterData;
  input Modelica.SIunits.Density rho;

  output Modelica.SIunits.Force T_est;

algorithm

  T_est := sign(w) * (w / (2 * Modelica.Constants.pi))^2 * (rho * (2 * thrusterData.radius)^4 * thrusterData.KT0);

end EstimatedThrusterForce;
