within Thruster.Drive ;

function Propeller

input Modelica.SIunits.Velocity Va;
input Modelica.SIunits.AngularVelocity omega;
input ThrusterData thrusterData;
input Modelica.SIunits.Density rho;


output Modelica.SIunits.Torque Q;
output Modelica.SIunits.Force T;

protected 
  Real Ct "Thrust Coefficient";
  Real Cq "Torque Coefficient";
  Real V07_2;
  Real beta;
  
algorithm

  beta := atan2(Va, 0.7 * Modelica.Constants.pi * omega * thrusterData.radius);
  Ct := 0;
  Cq := 0;

  for i in 1:size(thrusterData.AT, 1) loop
    Ct := Ct + thrusterData.AT[i] * cos(beta * (i-1)) + thrusterData.BT[i] * sin(beta * (i-1));
    Cq := Cq + thrusterData.AQ[i] * cos(beta * (i-1)) + thrusterData.BQ[i] * sin(beta * (i-1));
    
  end for;
  
  V07_2 := Va^2 + (0.7 * omega * thrusterData.radius)^2;
  
  T := Ct * 0.5 * rho * V07_2 * Modelica.Constants.pi * thrusterData.radius^2;
  Q := Cq * 0.5 * rho * V07_2 * Modelica.Constants.pi * 2 * thrusterData.radius^3;
  


end Propeller;
