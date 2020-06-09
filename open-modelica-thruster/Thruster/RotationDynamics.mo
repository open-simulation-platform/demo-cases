within Thruster ;


model RotationDynamics "Description"

parameter ThrusterData thrusterData;
  
  input Modelica.SIunits.Angle alpha_d(min = thrusterData.alpha_min, max = thrusterData.alpha_max);
  
  output Modelica.SIunits.Angle alpha;
  
protected 
  
  Real rate_limited_alpha;
  
  Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(Rising = 2 * Modelica.Constants.pi / thrusterData.turn_time);

equation
  
  slewRateLimiter.u = alpha_d;
  rate_limited_alpha = slewRateLimiter.y;


  thrusterData.Talpha * der(alpha) = rate_limited_alpha - alpha; 

    
end RotationDynamics;