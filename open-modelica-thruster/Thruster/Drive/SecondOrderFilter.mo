within Thruster.Drive ;

model SecondOrderFilter

  parameter Real w0;
  parameter Real xi;
  parameter Real initialCondition;

  input Real x(start = initialCondition);
  
  output Real x_filter;

  
protected 

  Real dxfilter;

equation

  der(x_filter) = dxfilter;
  
  der(dxfilter) = (x - x_filter) * w0^2 - dxfilter * 2 * w0 * xi; 

end SecondOrderFilter;
