within Thruster.Drive ;

function FindDesiredPropellerSpeed

  input Modelica.SIunits.Force Td;
  input ThrusterData thrusterData;
  input Modelica.SIunits.Density rho;
  
  output Modelica.SIunits.Power P_d;
  output Modelica.SIunits.Torque Q_d;

algorithm

  if Td > 0 then 
  
    P_d := thrusterData.KP0 * Td^(1.5);
    Q_d := thrusterData.KQ0 / thrusterData.KT0 * 2 * thrusterData.radius * Td;
    
  else
    
    P_d := thrusterData.KP0r * (-Td)^(1.5);
    Q_d := thrusterData.KQ0r / thrusterData.KT0r * 2 * thrusterData.radius * Td;
  
  end if;


end FindDesiredPropellerSpeed;
