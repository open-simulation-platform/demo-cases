within Thruster ;

function FindAdvanceVelocity

  input Real[6] nu_r;
  input ThrusterData thrusterData;
  input Modelica.SIunits.Angle alpha;
  
  output Modelica.SIunits.Velocity Va;

protected
  Real[2] r;
  Real[2] v;

algorithm

  r[1] := thrusterData.positionX;
  r[2] := thrusterData.positionY;
  
  v := nu_r[1:2] + nu_r[6] * r;
  
  Va := v[1] * cos(alpha) + v[2] * sin(alpha);


end FindAdvanceVelocity;
