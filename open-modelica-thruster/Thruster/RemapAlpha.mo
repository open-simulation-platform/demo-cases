within Thruster ;

function RemapAlpha

  input Modelica.SIunits.Angle alpha;
  input Modelica.SIunits.Angle alpha_old;
  
  output Modelica.SIunits.Angle alpha_d;

protected
  
  Modelica.SIunits.Angle dalpha; 

algorithm
  
  dalpha := mod(alpha - alpha_old, 2 * Modelica.Constants.pi);
  
  if dalpha > Modelica.Constants.pi then
      dalpha := ( -2 * Modelica.Constants.pi) + dalpha;
  else 
      dalpha := 0;
  end if;
  
  alpha_d := alpha_old + dalpha;

end RemapAlpha;
