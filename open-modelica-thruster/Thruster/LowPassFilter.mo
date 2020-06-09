within Thruster ;

model LowPassFilter

    input Real v;
    output Real v_filtered;
    
    parameter ThrusterData thrusterData;
    
protected

    Real v_unlimited;
    Modelica.Blocks.Nonlinear.SlewRateLimiter rateLimiter(Rising = thrusterData.rated_power/  thrusterData.power_available_positive_ramp_time);

equation


    der(v_unlimited) * thrusterData.power_available_tau = v - v_unlimited;
    rateLimiter.u = v_filtered;
    v_filtered = rateLimiter.y;
  
end LowPassFilter;
