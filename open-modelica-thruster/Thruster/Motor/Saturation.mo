within Thruster.Motor ;

function Saturation

  input Modelica.SIunits.AngularVelocity omega;
  input Modelica.SIunits.Torque torque_d;
  input Modelica.SIunits.Power power_d;
  input ThrusterData thrusterData;
  input Modelica.SIunits.Power powerAvailable;
  input Boolean connected;
  
  output Modelica.SIunits.Torque torque;
  output Modelica.SIunits.Power power;

protected 

  parameter Integer k = 4;
  parameter Integer p = 1;
  parameter Integer r = 2;

  Real alpha;
  Real PMax;

algorithm

  if powerAvailable <= 0.1 or connected == false then
    power := 0;
    torque := 0;
    return;
  end if;
  
  alpha := Modelica.Math.exp(-k * abs(p * omega / (2 * Modelica.Constants.pi))^r);

  if omega <> 0 then 
    torque := power_d / omega * (1 - alpha) + alpha * torque_d;
   else
    torque := torque_d;
  end if; 
  
  if omega * torque < -thrusterData.motorData.maxReversePower then
  
    torque := -thrusterData.motorData.maxReversePower / omega;
    power := -thrusterData.motorData.maxReversePower;
    return;
  
  end if;
  
  torque := sign(torque) * min(thrusterData.Qmax, abs(torque));
  
  PMax := min(thrusterData.Pmax, powerAvailable);
  
  if omega * torque > PMax then
    
    torque := torque * (PMax / (omega * torque));
  
  end if;
  
  power := torque * omega;
  
end Saturation;
